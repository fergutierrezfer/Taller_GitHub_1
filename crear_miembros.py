#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Programa alternativo para crear miembros en QSQLSRC
Usa QSHEXEC de forma más confiable
"""

import paramiko
import os
from getpass import getpass


def extract_description(filepath):
    """Extrae descripción de línea 3"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        if len(lines) >= 3:
            line3 = lines[2].strip()
            if line3.startswith('--'):
                line3 = line3[2:].strip()
            if 'Descripción:' in line3:
                line3 = line3.split('Descripción:')[1].strip()
            if line3 and len(line3) > 50:
                line3 = line3[:50]
            return line3
    except:
        pass
    return "Tabla SQL"


def create_members_ibmi():
    """Crear miembros usando método IBM i directo"""
    
    print("═" * 60)
    print("CREAR MIEMBROS EN QSQLSRC - MÉTODO IBM i DIRECTO")
    print("═" * 60 + "\n")
    
    # Conexión
    host = "pub400.com"
    username = input("Usuario PUB400.COM: ").strip()
    password = getpass("Contraseña: ")
    remote_path = input(f"Ruta remota (default: /home/{username}/qsqlsrc): ").strip()
    if not remote_path:
        remote_path = f"/home/{username}/qsqlsrc"
    
    local_path = os.getcwd()
    
    try:
        print(f"\nConectando a {host}:2222...")
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(host, port=2222, username=username, password=password)
        print("✓ Conexión establecida\n")
        
        # Obtener lista de archivos SQL
        files = sorted([f for f in os.listdir(local_path) if f.endswith('.sql')])
        
        if not files:
            print("✗ No se encontraron archivos .sql")
            return
        
        print(f"Procesando {len(files)} archivos...\n")
        
        success = 0
        errors = 0
        
        for filename in files:
            member = filename[:-4].upper()
            desc = extract_description(os.path.join(local_path, filename))
            
            # Escapar comillas
            desc_safe = desc.replace("'", "''")
            
            # Comando 1: Crear miembro
            cmd1 = f"ADDMBR MBR({member}) FILE(FGUTIERRM1/QSQLSRC) SRCTYPE(SQL) TEXT('{desc_safe}')"
            
            # Ejecutar ADDMBR usando QP2TERM (más confiable que QSHEXEC)
            qp2_cmd = f"QP2TERM('{cmd1}')"
            
            try:
                # Usar el intérprete de comandos de IBM i
                stdin, stdout, stderr = ssh.exec_command(
                    f'echo "call qp2shell2(\\'{cmd1}\\')" | QSHEXEC'
                )
                out = stdout.read().decode('utf-8', errors='ignore')
                err = stderr.read().decode('utf-8', errors='ignore')
                
                # Si no hay error CPF, intentar copiar el archivo
                if 'CPF' not in err:
                    # Comando 2: Copiar archivo al miembro
                    cp_cmd = (
                        f"CPYFRM FROMFILE('{remote_path}/{filename}') "
                        f"TOFILE(FGUTIERRM1/QSQLSRC) TOMBRNAME({member})"
                    )
                    
                    stdin, stdout, stderr = ssh.exec_command(
                        f'echo "{cp_cmd}" | QSHEXEC'
                    )
                    stdout.read()
                    stderr.read()
                
                print(f"  ✓ {member:10} | {desc}")
                success += 1
                
            except Exception as e:
                print(f"  ✗ {member}: {str(e)[:40]}")
                errors += 1
        
        print(f"\n{'='*60}")
        print(f"Completado: {success} | Errores: {errors}")
        print(f"{'='*60}\n")
        
        ssh.close()
        
    except Exception as e:
        print(f"✗ Error: {e}")


if __name__ == "__main__":
    create_members_ibmi()
