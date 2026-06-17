#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Ajustes manuales finales para las 4 líneas extremas
"""

import os

# Archivo CNOFC.sql - línea 3
with open('CNOFC.sql', 'r', encoding='utf-8') as f:
    lines = f.readlines()

lines[2] = "-- Descripción: Archivo de Referencias del Sistema\n"
lines.insert(3, "-- para gestión de datos comunes\n")

with open('CNOFC.sql', 'w', encoding='utf-8') as f:
    f.writelines(lines)
print("✓ CNOFC.sql ajustado")

# Archivo CNOFT.sql - línea 41
with open('CNOFT.sql', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Buscar la línea con el texto largo
for i, line in enumerate(lines):
    if "'Archivo Maestro de Tablas de Datos Comunes para gestión" in line:
        lines[i] = "'Archivo Maestro de Tablas de Datos Comunes\n"
        lines.insert(i+1, "para gestión centralizada de datos';\n")
        break

with open('CNOFT.sql', 'w', encoding='utf-8') as f:
    f.writelines(lines)
print("✓ CNOFT.sql ajustado")

# Archivo MLNOT.sql - línea 47
with open('MLNOT.sql', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if "Archivo_de_datos_a_imprimir_en_Notificaciones.codigo_banco IS 'Cód" in line:
        lines[i] = "FGUTIERRM1.Archivo_de_datos_a_imprimir_en_Notificaciones.\n"
        lines.insert(i+1, "codigo_banco IS 'Código banco';\n")
        break

with open('MLNOT.sql', 'w', encoding='utf-8') as f:
    f.writelines(lines)
print("✓ MLNOT.sql ajustado")

print("\n✓ Todos los ajustes finales completados")
