#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para copiar archivos SQL como miembros en QSQLSRC
Ubicación: Ejecutar en PUB400.COM
Uso: python3 copiar_miembros.py
"""

import os
import subprocess

# Configuración
SRCDIR = "/home/FGUTIERRM/qsqlsrc"
LIBFILE = "FGUTIERRM1/QSQLSRC"
SRCTYPE = "SQL"

print("╔════════════════════════════════════════════════════╗")
print("║   COPIAR SCRIPTS SQL COMO MIEMBROS EN QSQLSRC      ║")
print("╚════════════════════════════════════════════════════╝\n")

# Validar que el directorio existe
if not os.path.exists(SRCDIR):
    print(f"✗ Directorio no encontrado: {SRCDIR}")
    exit(1)

# Obtener lista de archivos .sql
files = sorted([f for f in os.listdir(SRCDIR) if f.endswith('.sql')])

if not files:
    print(f"✗ No se encontraron archivos .sql en {SRCDIR}")
    exit(1)

print(f"Encontrados: {len(files)} archivos\n")
print("Procesando...\n")

success_count = 0
error_count = 0

for fname in files:
    member = fname[:-4].upper()  # Nombre sin extensión, en mayúsculas
    filepath = os.path.join(SRCDIR, fname)
    
    # Leer línea 3 para obtener descripción
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            
        # Extraer línea 3
        if len(lines) >= 3:
            desc = lines[2].strip()
            # Remover comentarios iniciales
            if desc.startswith('--'):
                desc = desc[2:].strip()
            # Remover "Descripción:" o "Descripcion:"
            if 'Descripción:' in desc:
                desc = desc.split('Descripción:')[1].strip()
            elif 'Descripcion:' in desc:
                desc = desc.split('Descripcion:')[1].strip()
        else:
            desc = "Tabla SQL"
        
        # Truncar a 50 caracteres
        if len(desc) > 50:
            desc = desc[:50]
        
        # Escapar comillas simples
        desc = desc.replace("'", "''")
        
    except Exception as e:
        desc = "Tabla SQL"
        print(f"  ⚠ {member}: Error leyendo descripción: {e}")
    
    try:
        # Comando 1: ADDMBR para crear el miembro
        addmbr_cmd = (
            f"ADDMBR MBR({member}) "
            f"FILE({LIBFILE}) "
            f"SRCTYPE({SRCTYPE}) "
            f"TEXT('{desc}')"
        )
        
        # Ejecutar ADDMBR usando system call a IBM i
        # Usar QP2SHELL o qsh para ejecutar
        result = subprocess.run(
            ['system', addmbr_cmd],
            capture_output=True,
            timeout=10
        )
        
        # Si ADDMBR tuvo éxito, copiar el archivo
        if result.returncode == 0 or 'CPF2714' not in result.stderr.decode():
            # Comando 2: CPYFRM para copiar contenido del archivo al miembro
            cpyfrm_cmd = (
                f"CPYFRM FROMFILE('{filepath}') "
                f"TOFILE({LIBFILE}) "
                f"TOMBRNAME({member})"
            )
            
            result2 = subprocess.run(
                ['system', cpyfrm_cmd],
                capture_output=True,
                timeout=10
            )
            
            print(f"  ✓ {member:10} | {desc}")
            success_count += 1
        else:
            print(f"  ⚠ {member}: Miembro ya existe")
            success_count += 1
            
    except subprocess.TimeoutExpired:
        print(f"  ✗ {member}: Timeout")
        error_count += 1
    except Exception as e:
        print(f"  ✗ {member}: {str(e)[:50]}")
        error_count += 1

print(f"\n{'='*55}")
print(f"Completado:")
print(f"  Miembros procesados: {success_count}")
print(f"  Errores: {error_count}")
print(f"  Total: {len(files)}")
print(f"{'='*55}\n")

if error_count == 0:
    print("✓ Todos los miembros fueron creados exitosamente")
    
print("\nVerificar con: DSPMBRLIST FILE(FGUTIERRM1/QSQLSRC)")
