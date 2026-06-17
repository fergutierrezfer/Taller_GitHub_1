#!/bin/sh
# Script para PUB400 / QSH.
# Uso: /tmp/subir_qsqlsrc_qsh.sh /tmp/FGUTIERRM1_SQL

set -e

SRC_DIR="${1:-/tmp/FGUTIERRM1_SQL}"

if [ ! -d "$SRC_DIR" ]; then
  echo "Directorio no encontrado: $SRC_DIR" >&2
  exit 1
fi

# Elimina y recrea el archivo fuente QSQLSRC con RCDLEN suficiente para SQL
system "DLTF FILE(FGUTIERRM1/QSQLSRC)" 2>/dev/null
system "CRTSRCPF FILE(FGUTIERRM1/QSQLSRC) RCDLEN(200) TEXT('SQL source members')"

for f in "$SRC_DIR"/*.sql; do
  [ -e "$f" ] || continue

  member=$(basename "$f" .sql | tr '[:lower:]' '[:upper:]')

  # Extrae la descripción del header (busca "Descripción:" o "DESCRIPCIÓN:" sin importar mayúsculas)
  desc=$(sed -n 's/^--[[:space:]]*[Dd]escripci[óo]n:[[:space:]]*//p' "$f" | head -1)
  if [ -z "$desc" ]; then
    desc=$(sed -n 's/^--[[:space:]]*Nombre de la Tabla:[[:space:]]*//p' "$f" | head -1)
  fi
  if [ -z "$desc" ]; then
    desc="$member"
  fi

  # Limita la descripción a 50 caracteres, máximo permitido por CHGPFM TEXT
  desc=$(printf '%s' "$desc" | cut -c1-50)

  # Escapa comillas simples (') para el texto del miembro IBM i
  desc=$(printf '%s' "$desc" | sed "s/'/''/g")

  echo "Procesando $member -> $desc"

  # Prepara archivo temporal con líneas limitadas a 80 caracteres
  tmp_file="/tmp/${member}_tmp.sql"
  fold -w 80 "$f" > "$tmp_file"

  system "CPYFRMSTMF FROMSTMF('$tmp_file') TOMBR('/QSYS.LIB/FGUTIERRM1.LIB/QSQLSRC.FILE/${member}.MBR') MBROPT(*REPLACE) CVTDTA(*AUTO) STMFCCSID(*STMF) DBFCCSID(*FILE)"
  system "CHGPFM FILE(FGUTIERRM1/QSQLSRC) MBR(${member}) SRCTYPE(SQL) TEXT('${desc}')"

  rm -f "$tmp_file"

done

echo "Proceso finalizado."
