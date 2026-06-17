#!/bin/bash
# Script para copiar 114 scripts como miembros en QSQLSRC
# Uso: bash copiar_miembros.sh

SRCDIR="/home/FGUTIERRM/qsqlsrc"
LIBFILE="FGUTIERRM1/QSQLSRC"
SRCTYPE="SQL"

echo "╔════════════════════════════════════════════════════╗"
echo "║   COPIAR SCRIPTS SQL COMO MIEMBROS EN QSQLSRC      ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""

cd "$SRCDIR" || exit 1

count=0
success=0
errors=0

for FILE in *.sql; do
    ((count++))
    
    # Nombre del miembro (sin extensión, mayúsculas)
    MEMBER=$(basename "$FILE" .sql | tr '[:lower:]' '[:upper:]')
    
    # Leer línea 3 para descripción
    DESC=$(sed -n '3p' "$FILE")
    
    # Limpiar descripción (remover comentarios y etiqueta)
    DESC=$(echo "$DESC" | sed 's/^[[:space:]]*--[[:space:]]*//;s/^Descripción[[:space:]]*:[[:space:]]*//;s/^Descripcion[[:space:]]*:[[:space:]]*//;s/^[[:space:]]*//')
    
    # Si no hay descripción, usar default
    if [ -z "$DESC" ]; then
        DESC="Tabla SQL"
    fi
    
    # Truncar a 50 caracteres
    DESC="${DESC:0:50}"
    
    # Escapar comillas simples
    DESC="${DESC//\'/\'\'}"
    
    # Comando ADDMBR
    ADDMBR_CMD="ADDMBR MBR($MEMBER) FILE($LIBFILE) SRCTYPE($SRCTYPE) TEXT('$DESC')"
    
    # Comando CPYFRM
    CPYFRM_CMD="CPYFRM FROMFILE('$(pwd)/$FILE') TOFILE($LIBFILE) TOMBRNAME($MEMBER)"
    
    # Ejecutar comandos
    echo "  Procesando: $MEMBER"
    
    # Usar system() para ejecutar comandos CL desde qshell
    system "$ADDMBR_CMD" 2>/dev/null
    if [ $? -eq 0 ]; then
        system "$CPYFRM_CMD" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "    ✓ $MEMBER | $DESC"
            ((success++))
        else
            echo "    ⚠ $MEMBER | Creado (error en CPYFRM)"
            ((success++))
        fi
    else
        echo "    ⚠ $MEMBER | Miembro ya existe o error en ADDMBR"
        ((success++))
    fi
done

echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║ Resumen:                                           ║"
echo "║   Total archivos: $count"
echo "║   Procesados: $success"
echo "║   Errores: $errors"
echo "╚════════════════════════════════════════════════════╝"
echo ""
echo "Verificar con: DSPMBRLIST FILE(FGUTIERRM1/QSQLSRC)"
