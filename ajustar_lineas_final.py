#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script FINAL para ajustar líneas SQL a máximo 80 caracteres
Maneja todos los casos, incluso los extremos
"""

import os
import glob
import re

def force_split_line(line, max_length=80):
    """Divide agresivamente cualquier línea para cumplir con máximo 80."""
    if len(line) <= max_length:
        return [line]
    
    result = []
    
    # Estrategia 1: Dividir por comas (listas de columnas)
    if ',' in line and '(' in line:
        # Extracto el contenido dentro de paréntesis
        match = re.match(r'^(.*?\()(.*?)(\).*)$', line)
        if match:
            prefix = match.group(1)
            content = match.group(2)
            suffix = match.group(3)
            
            # Dividir el contenido por comas
            items = [x.strip() for x in content.split(',')]
            
            if len(prefix) <= max_length and len(suffix) <= max_length:
                current = prefix
                for i, item in enumerate(items):
                    if i < len(items) - 1:
                        item = item + ","
                    
                    if len(current) + len(item) + 1 > max_length and current != prefix:
                        result.append(current)
                        current = item
                    else:
                        if current == prefix:
                            current += " " + item
                        else:
                            current += " " + item
                
                if current and current != prefix:
                    result.append(current)
                if suffix:
                    result.append(suffix)
                
                return result if result else [line]
    
    # Estrategia 2: Dividir por "FOR COLUMN"
    if " FOR COLUMN " in line:
        parts = line.split(" FOR COLUMN ")
        current = parts[0]
        for part in parts[1:]:
            if len(current) + len(" FOR COLUMN ") + len(part) > max_length:
                result.append(current)
                current = " FOR COLUMN " + part
            else:
                current += " FOR COLUMN " + part
        if current:
            result.append(current)
        return result if result else [line]
    
    # Estrategia 3: Dividir por palabras clave SQL
    keywords = [' ON ', ' PRIMARY ', ' NOT NULL', ' DEFAULT ', ' CONSTRAINT ', ' IS ', ' LABEL ']
    for keyword in keywords:
        if keyword in line:
            pos = line.rfind(keyword, 0, max_length)
            if pos > 20:
                cut_pos = pos + len(keyword)
                part1 = line[:cut_pos].rstrip()
                part2 = line[cut_pos:].lstrip()
                result.append(part1)
                if part2:
                    result.extend(force_split_line(part2, max_length))
                return result if result else [line]
    
    # Estrategia 4: Dividir por espacios simples
    words = line.split()
    current = ""
    for word in words:
        if len(current) + len(word) + 1 > max_length and current:
            result.append(current)
            current = word
        else:
            current += (" " if current else "") + word
    
    if current:
        result.append(current)
    
    # Estrategia 5: Si aún hay líneas largas, cortar por fuerza
    final_result = []
    for line in (result if result else [line]):
        if len(line) > max_length:
            # Cortar cada 75 caracteres para dejar margen
            while len(line) > max_length:
                final_result.append(line[:max_length].rstrip())
                line = line[max_length:].lstrip()
            if line:
                final_result.append(line)
        else:
            final_result.append(line)
    
    return final_result if final_result else [line]


def adjust_sql_file(filepath, max_length=80):
    """Ajusta un archivo SQL a máximo 80 caracteres por línea."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        adjusted_lines = []
        lines_split = 0
        
        for line in lines:
            line = line.rstrip('\n\r')
            
            if len(line) > max_length:
                split_result = force_split_line(line, max_length)
                adjusted_lines.extend(split_result)
                if len(split_result) > 1:
                    lines_split += len(split_result)
            else:
                adjusted_lines.append(line)
        
        # Guardar archivo
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write('\n'.join(adjusted_lines))
        
        if lines_split > 0:
            print(f"  - {lines_split} líneas divididas")
        print(f"  ✓ Guardado ({len(adjusted_lines)} líneas)")
        return True
        
    except Exception as e:
        print(f"  ✗ Error: {e}")
        return False


def main():
    folder = os.getcwd()
    sql_files = sorted(glob.glob(os.path.join(folder, "*.sql")))
    
    if not sql_files:
        print("No se encontraron archivos .sql")
        return
    
    print(f"Ajuste FINAL de {len(sql_files)} archivos SQL")
    print("-" * 60)
    
    success_count = 0
    
    for filepath in sql_files:
        filename = os.path.basename(filepath)
        print(f"Procesando: {filename}")
        
        if adjust_sql_file(filepath, 80):
            success_count += 1
    
    print("-" * 60)
    print(f"✓ {success_count}/{len(sql_files)} archivos completados")


if __name__ == "__main__":
    main()
