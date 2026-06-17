#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script agresivo para ajustar líneas SQL a máximo 80 caracteres
Compatible con PUB400.COM
"""

import os
import glob
from pathlib import Path

def aggressive_split_line(line, max_length=80):
    """Divide agresivamente una línea larga, cortando incluso palabras si es necesario."""
    if len(line) <= max_length:
        return [line]
    
    result = []
    remaining = line
    
    while len(remaining) > max_length:
        # Intentar encontrar un buen punto de corte (espacio, coma, punto)
        cut_pos = max_length
        
        # Buscar una coma antes del límite
        comma_pos = remaining.rfind(',', 0, max_length)
        if comma_pos > max_length * 0.6:
            cut_pos = comma_pos + 1
        else:
            # Buscar un espacio antes del límite
            space_pos = remaining.rfind(' ', 0, max_length)
            if space_pos > max_length * 0.5:
                cut_pos = space_pos
            else:
                # Buscar un punto (para nombres calificados)
                dot_pos = remaining.rfind('.', 0, max_length)
                if dot_pos > max_length * 0.5:
                    cut_pos = dot_pos + 1
                else:
                    # Si no hay buen punto de corte, cortar en max_length
                    cut_pos = max_length
        
        # Extraer la parte y limpiar espacios
        part = remaining[:cut_pos].rstrip()
        if not part:
            # Si la parte está vacía, cortar al máximo
            part = remaining[:max_length]
        
        result.append(part)
        
        # Actualizar remaining
        remaining = remaining[len(part):].lstrip()
        if not remaining:
            break
    
    if remaining:
        result.append(remaining)
    
    return result if result else [line]


def adjust_sql_file(filepath, max_length=80):
    """Ajusta un archivo SQL a máximo 80 caracteres por línea."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        adjusted_lines = []
        lines_split = 0
        
        for line in lines:
            # Remover salto de línea para procesar
            line = line.rstrip('\n\r')
            
            if len(line) > max_length:
                split_result = aggressive_split_line(line, max_length)
                adjusted_lines.extend(split_result)
                lines_split += len(split_result)
                print(f"  - Línea original ({len(line)} chars) dividida en {len(split_result)} líneas")
            else:
                adjusted_lines.append(line)
        
        # Guardar archivo con saltos de línea correctos
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write('\n'.join(adjusted_lines))
        
        print(f"  ✓ Guardado exitosamente ({len(adjusted_lines)} líneas totales)")
        return True
        
    except Exception as e:
        print(f"  ✗ Error: {e}")
        return False


def main():
    folder = os.getcwd()
    sql_files = glob.glob(os.path.join(folder, "*.sql"))
    
    if not sql_files:
        print(f"No se encontraron archivos .sql en: {folder}")
        return
    
    print(f"Encontrados {len(sql_files)} archivos SQL")
    print(f"Máximo de caracteres por línea: 80")
    print("-" * 60)
    
    success_count = 0
    failure_count = 0
    
    for filepath in sorted(sql_files):
        filename = os.path.basename(filepath)
        print(f"Procesando: {filename}")
        
        if adjust_sql_file(filepath, 80):
            success_count += 1
        else:
            failure_count += 1
    
    print("-" * 60)
    print(f"RESUMEN: Exitosos={success_count}, Errores={failure_count}")


if __name__ == "__main__":
    main()
