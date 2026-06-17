#!/bin/bash
#========================================================================
# Script para procesar archivos SQL y crear miembros en QSQLSRC
# Ubicación: Ejecutar en PUB400.COM desde Qshell
# Uso: ./cargqsql.sh [RUTA_ARCHIVOS] [USUARIO]
#========================================================================

# Parámetros
SRCPATH=${1:-.}
USUARIO=${2:-$(whoami)}
LIBNAME="FGUTIERRM1"
SRCFILE="QSQLSRC"
SRCTYPE="SQL"

# Contadores
COUNT=0
SUCCESS=0
ERRORS=0

echo "=========================================="
echo "Cargador de SQL a QSQLSRC"
echo "=========================================="
echo "Ruta: $SRCPATH"
echo "Usuario: $USUARIO"
echo "Destino: $LIBNAME/$SRCFILE"
echo ""

# Buscar y procesar archivos .sql
for FILEPATH in $(find "$SRCPATH" -maxdepth 1 -name "*.sql" -type f | sort)
do
    ((COUNT++))
    
    # Extraer nombre del miembro (sin extensión, máx 10 caracteres)
    MEMBER=$(basename "$FILEPATH" .sql)
    MEMBER=$(echo "$MEMBER" | tr '[:lower:]' '[:upper:]')
    if [ ${#MEMBER} -gt 10 ]; then
        MEMBER=${MEMBER:0:10}
    fi
    
    # Extraer descripción de la línea 3
    DESC=$(sed -n '3p' "$FILEPATH" | sed 's/^[[:space:]]*--[[:space:]]*//' | sed 's/^[[:space:]]*Descripción[[:space:]]*:[[:space:]]*//' | sed 's/^[[:space:]]*Descripcion[[:space:]]*:[[:space:]]*//' | cut -c1-50)
    
    if [ -z "$DESC" ]; then
        DESC="Tabla SQL"
    fi
    
    # Comando para crear miembro (ejecutar en IBM i)
    CMD1="ADDMBR MBR($MEMBER) FILE($LIBNAME/$SRCFILE) SRCTYPE($SRCTYPE) TEXT('$DESC')"
    CMD2="CPYFRMSAVF DEV(*SAVF) FILE($FILEPATH) TOLIB($LIBNAME)"
    
    # Para ejecutar en IBM i, usar:
    # echo "$CMD1" | qsh
    # echo "$CMD2" | qsh
    
    # Mostrar progreso
    printf "[%3d] %-10s | %-50s" "$COUNT" "$MEMBER" "$DESC"
    echo ""
    
    echo "  -> $CMD1"
    ((SUCCESS++))
done

echo ""
echo "=========================================="
echo "Resumen:"
echo "  Total archivos: $COUNT"
echo "  Miembros creados: $SUCCESS"
echo "  Errores: $ERRORS"
echo "=========================================="
echo ""
echo "Para crear los miembros en QSQLSRC, ejecutar en IBM i:"
echo "  cd $SRCPATH"
echo "  qsh"
