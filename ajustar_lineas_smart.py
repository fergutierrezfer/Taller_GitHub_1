#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para ajustar líneas SQL a máximo 80 caracteres
con División inteligente y legible para humanos
"""

import os
import glob
import re

def smart_split_line(line, max_length=80, indent_level=0):
    """Divide una línea SQL inteligentemente en puntos lógicos."""
    if len(line) <= max_length:
        return [line]
    
    result = []
    indent = "  " * indent_level  # Indentación basada en nivel
    
    # Palabras clave de SQL donde es lógico dividir
    sql_keywords = [
        ' AND ', ' OR ', ' WHEN ', ' THEN ',
        ',(', ', ', ',\n'
    ]
    
    # Si contiene comas, dividir por coma (lista de columnas, etc)
    if ',' in line:
        # Separar en partes por coma
        parts = line.split(',')
        current = ""
        
        for i, part in enumerate(parts):
            part = part.strip()
            is_last = i == len(parts) - 1
            
            if not is_last:
                part = part + ","
            
            # Si esta parte sola es muy larga
            if len(current) + len(part) + 1 > max_length and current:
                result.append(current.strip())
                current = part
            else:
                current += (" " if current else "") + part
        
        if current:
            result.append(current.strip())
    else:
        # Dividir por palabras clave SQL
        keywords_to_split = [' FOR ', ' ON ', ' PRIMARY ', ' NOT NULL', ' DEFAULT ']
        
        best_keyword = None
        best_pos = -1
        
        for keyword in keywords_to_split:
            pos = line.rfind(keyword, 0, max_length)
            if pos > max_length * 0.6 and pos > best_pos:
                best_pos = pos
                best_keyword = keyword
        
        if best_keyword and best_pos > 0:
            # Dividir en el keyword
            cut_pos = best_pos + len(best_keyword)
            part1 = line[:cut_pos].rstrip()
            part2 = line[cut_pos:].lstrip()
            result.append(part1)
            if part2:
                result.extend(smart_split_line(part2, max_length, indent_level))
        else:
            # Dividir por espacios
            words = line.split()
            current = ""
            
            for word in words:
                if len(current) + len(word) + 1 > max_length and current:
                    result.append(current.strip())
                    current = word
                else:
                    current += (" " if current else "") + word
            
            if current:
                result.append(current.strip())
    
    return result if result else [line]


def adjust_sql_file(filepath, max_length=80):
    """Ajusta un archivo SQL a máximo 80 caracteres por línea con legibilidad."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Dividir por líneas reales (mantener estructura)
        lines = content.split('\n')
        adjusted_lines = []
        lines_modified = 0
        
        for line in lines:
            # No modificar líneas vacías ni comentarios muy cortos
            if not line.strip() or len(line.rstrip()) <= max_length:
                adjusted_lines.append(line)
            else:
                # Determinar nivel de indentación actual
                indent_count = len(line) - len(line.lstrip())
                indent_level = indent_count // 2 if indent_count > 0 else 0
                
                # Dividir línea larga
                split_result = smart_split_line(line.rstrip(), max_length, indent_level)
                
                if len(split_result) > 1:
                    lines_modified += 1
                    adjusted_lines.extend(split_result)
                else:
                    adjusted_lines.append(line)
        
        # Guardar archivo
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write('\n'.join(adjusted_lines))
        
        if lines_modified > 0:
            print(f"  - Modificadas {lines_modified} líneas")
        print(f"  ✓ Guardado ({len(adjusted_lines)} líneas totales)")
        return True
        
    except Exception as e:
        print(f"  ✗ Error: {e}")
        return False


def main():
    folder = os.getcwd()
    sql_files = glob.glob(os.path.join(folder, "*.sql"))
    
    if not sql_files:
        print(f"No se encontraron archivos .sql")
        return
    
    print(f"Ajustando {len(sql_files)} archivos SQL a máximo 80 caracteres")
    print("Con división inteligente y legibilidad")
    print("-" * 60)
    
    success_count = 0
    
    for filepath in sorted(sql_files):
        filename = os.path.basename(filepath)
        print(f"Procesando: {filename}")
        
        if adjust_sql_file(filepath, 80):
            success_count += 1
    
    print("-" * 60)
    print(f"✓ {success_count}/{len(sql_files)} archivos procesados exitosamente")


if __name__ == "__main__":
    main()
