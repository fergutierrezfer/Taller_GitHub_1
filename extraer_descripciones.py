#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Extraer descripciones de archivos SQL para carga a PUB400.COM
Validar que no excedan 50 caracteres
"""

import glob
import os

def extract_description(filepath):
    """Extrae la descripción de la línea 3 del archivo."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        if len(lines) >= 3:
            # Línea 3 (índice 2) contiene: -- Descripción: ...
            line3 = lines[2].strip()
            
            # Remover el comentario "--" del inicio
            if line3.startswith('--'):
                desc = line3[2:].strip()
            else:
                desc = line3
            
            # Remover "Descripción:" si existe
            if desc.startswith('Descripción:'):
                desc = desc[12:].strip()
            elif desc.startswith('Descripcion:'):
                desc = desc[12:].strip()
            
            return desc
    except Exception as e:
        return f"ERROR: {e}"
    
    return "NO ENCONTRADA"


def main():
    files = sorted(glob.glob('*.sql'))
    
    print("EXTRACCIÓN DE DESCRIPCIONES PARA QSQLSRC")
    print("=" * 80)
    
    members_info = []
    
    for filepath in files:
        filename = os.path.basename(filepath)
        member_name = filename[:-4].upper()  # Quitar .sql y convertir a mayúsculas
        
        description = extract_description(filepath)
        desc_length = len(description)
        
        status = "OK" if desc_length <= 50 else "LARGO"
        
        members_info.append({
            'member': member_name,
            'description': description,
            'length': desc_length,
            'status': status
        })
        
        print(f"{member_name:10} | {desc_length:2} | {status:5} | {description[:60]}")
    
    print("=" * 80)
    
    # Resumen
    total = len(members_info)
    ok_count = sum(1 for m in members_info if m['status'] == 'OK')
    largo_count = total - ok_count
    
    print(f"\nRESUMEN:")
    print(f"Total de miembros: {total}")
    print(f"Descripciones OK (<=50 chars): {ok_count}")
    print(f"Descripciones LARGAS (>50 chars): {largo_count}")
    
    if largo_count > 0:
        print(f"\nMiembros con descripción LARGA:")
        for m in members_info:
            if m['status'] == 'LARGO':
                print(f"  {m['member']:10} | {m['length']:2} chars | {m['description'][:50]}...")
    
    # Guardar información para scripts de carga
    with open('miembros_qsqlsrc.txt', 'w', encoding='utf-8') as f:
        f.write("MIEMBRO|DESCRIPCION|LONGITUD\n")
        for m in members_info:
            desc_safe = m['description'].replace('|', '/')  # Escapar pipes
            f.write(f"{m['member']}|{desc_safe}|{m['length']}\n")
    
    print(f"\n✓ Información guardada en: miembros_qsqlsrc.txt")


if __name__ == "__main__":
    main()
