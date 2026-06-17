#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Generador de script de carga para PUB400.COM QSQLSRC
Crea comandos ADDMBR (Add Member) para cada archivo SQL
"""

import glob
import os

def extract_and_truncate_description(filepath):
    """Extrae y trunca la descripción a 50 caracteres."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        if len(lines) >= 3:
            line3 = lines[2].strip()
            
            if line3.startswith('--'):
                desc = line3[2:].strip()
            else:
                desc = line3
            
            if desc.startswith('Descripción:'):
                desc = desc[12:].strip()
            elif desc.startswith('Descripcion:'):
                desc = desc[12:].strip()
            
            # Truncar a 50 caracteres
            if len(desc) > 50:
                desc = desc[:50]
            
            return desc
    except Exception as e:
        return "ERROR"
    
    return "SIN DESCRIPCION"


def main():
    files = sorted(glob.glob('*.sql'))
    
    # Crear script BASIC para PUB400
    script_lines = []
    script_lines.append("/* Script de carga a QSQLSRC en FGUTIERRM1 */")
    script_lines.append("/* Generado: 2026-06-17 */")
    script_lines.append("")
    
    members_data = []
    
    for filepath in files:
        filename = os.path.basename(filepath)
        member_name = filename[:-4].upper()  # Quitar .sql
        
        description = extract_and_truncate_description(filepath)
        
        # Crear línea de comando ADDMBR
        # ADDMBR MBR(miembro) FILE(FGUTIERRM1/QSQLSRC) SRCTYPE(SQL) TEXT('Descripcion')
        cmd = f"ADDMBR MBR({member_name}) FILE(FGUTIERRM1/QSQLSRC) SRCTYPE(SQL) TEXT('{description}')"
        
        script_lines.append(cmd)
        members_data.append({
            'member': member_name,
            'description': description,
            'length': len(description),
            'command': cmd
        })
    
    # Guardar script en formato de comandos CL
    with open('carga_qsqlsrc.txt', 'w', encoding='utf-8') as f:
        f.write('\n'.join(script_lines))
    
    print("SCRIPT DE CARGA GENERADO")
    print("=" * 80)
    print(f"Total de miembros: {len(members_data)}")
    print(f"\nArchivo generado: carga_qsqlsrc.txt")
    print("\nPrimeros 5 comandos:")
    for i, m in enumerate(members_data[:5]):
        print(f"  {m['command']}")
    
    # Crear CSV para referencia
    with open('miembros_qsqlsrc_truncados.csv', 'w', encoding='utf-8') as f:
        f.write("MIEMBRO,DESCRIPCION,LONGITUD\n")
        for m in members_data:
            desc_safe = m['description'].replace('"', '""')  # Escapar comillas
            f.write(f'"{m["member"]}","{desc_safe}",{m["length"]}\n')
    
    print(f"\nArchivo CSV generado: miembros_qsqlsrc_truncados.csv")
    
    # Contar descripciones truncadas
    long_descs = ['CNOFT', 'DPMST', 'IFMST', 'MLNCT', 'MLNOT']
    truncated_count = sum(1 for m in members_data if m['member'] in long_descs)
    
    print(f"Descripciones truncadas a 50 caracteres: {truncated_count}")
    print("\n✓ Listos para cargar a PUB400.COM QSQLSRC")


if __name__ == "__main__":
    main()
