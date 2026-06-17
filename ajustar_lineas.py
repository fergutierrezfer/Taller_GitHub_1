#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para ajustar líneas SQL a máximo 80 caracteres
Compatible con PUB400.COM
"""

import os
import glob
from pathlib import Path

def split_long_line(line, max_length=80):
    """Divide una línea larga de SQL manteniendo sintaxis válida."""
    if len(line) <= max_length:
        return [line]
    
    result = []
    
    # Estrategia 1: Dividir por comas (para listas de columnas)
    if ',' in line:
        parts = line.split(',')
        current = ""
        for i, part in enumerate(parts):
            part = part.strip()
            if i < len(parts) - 1:
                part = part + ","
            
            # Si la parte sola es muy larga
            if len(part) > max_length:
                if current:
                    result.append(current.strip())
                # Dividir palabra larguísima por punto
                if '.' in part:
                    subparts = part.split('.')
                    sub_current = ""
                    for j, subpart in enumerate(subparts):
                        if j < len(subparts) - 1:
                            subpart = subpart + "."
                        if len(sub_current) + len(subpart) + 1 > max_length and sub_current:
                            result.append(sub_current.strip())
                            sub_current = subpart
                        else:
                            sub_current += subpart
                    if sub_current:
                        result.append(sub_current.strip())
                else:
                    result.append(part)
                current = ""
            elif len(current) + len(part) + 1 > max_length and current:
                result.append(current.strip())
                current = part
            else:
                if current:
                    current += " " + part
                else:
                    current = part
        
        if current:
            result.append(current.strip())
    else:
        # Estrategia 2: Dividir por espacios
        words = line.split()
        current = ""
        for word in words:
            # Dividir palabras muy largas por puntos (nombres calificados)
            if len(word) > max_length - 20:
                if '.' in word:
                    if current:
                        result.append(current.strip())
                    parts = word.split('.')
                    sub_current = ""
                    for i, part in enumerate(parts):
                        if i < len(parts) - 1:
                            part = part + "."
                        if len(sub_current) + len(part) > max_length - 10 and sub_current:
                            result.append(sub_current.strip())
                            sub_current = part
                        else:
                            sub_current += part
                    if sub_current:
                        result.append(sub_current.strip())
                    current = ""
                else:
                    if current:
                        result.append(current.strip())
                    result.append(word)
                    current = ""
            elif len(current) + len(word) + 1 > max_length and current:
                result.append(current.strip())
                current = word
            else:
                if current:
                    current += " " + word
                else:
                    current = word
        
        if current:
            result.append(current.strip())
    
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
                split_result = split_long_line(line, max_length)
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
