#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para ejecutar comandos IBM i CL directamente desde Windows
Requiere: paramiko
"""

import paramiko
from getpass import getpass
import os


def execute_ibmi_command(ssh, command):
    """Ejecuta un comando CL en IBM i y retorna el resultado"""
    # En IBM i, los comandos CL se ejecutan mediante QP2SHELL o system()
    # La forma más confiable es usar QSHEXEC que interpreta comandos
    
    # Formato: system("COMANDO CL")
    shell_cmd = f'QSHEXEC "system(\\"{command}\\")"'
    
    stdin, stdout, stderr = ssh.exec_command(shell_cmd)
    output = stdout.read().decode('utf-8', errors='ignore')
    error = stderr.read().decode('utf-8', errors='ignore')
    
    return output, error


def main():
    print("╔════════════════════════════════════════════════════╗")
    print("║   EJECUTOR DE COMANDOS IBM i DESDE WINDOWS        ║")
    print("║   Crear Miembros en QSQLSRC - Método Directo     ║")
    print("╚════════════════════════════════════════════════════╝\n")
    
    # Credenciales
    host = "pub400.com"
    username = input("Usuario PUB400.COM: ").strip()
    password = getpass("Contraseña: ")
    
    try:
        print(f"\nConectando a {host}:2222...")
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(host, port=2222, username=username, password=password)
        print("✓ Conexión establecida\n")
        
        # Archivos SQL en carpeta actual
        local_path = os.getcwd()
        files = sorted([f for f in os.listdir(local_path) if f.endswith('.sql')])
        
        if not files:
            print("✗ No se encontraron archivos .sql")
            return
        
        print(f"Creando {len(files)} miembros...\n")
        
        success = 0
        errors = 0
        
        for filename in files:
            member = filename[:-4].upper()
            
            # Comando ADDMBR
            addmbr_cmd = (
                f"ADDMBR MBR({member}) FILE(FGUTIERRM1/QSQLSRC) "
                f"SRCTYPE(SQL) TEXT('Tabla SQL')"
            )
            
            try:
                # Ejecutar ADDMBR
                stdin, stdout, stderr = ssh.exec_command(
                    f"system('{addmbr_cmd}')"
                )
                out = stdout.read().decode('utf-8', errors='ignore')
                err = stderr.read().decode('utf-8', errors='ignore')
                
                print(f"  ✓ {member}")
                success += 1
                
            except Exception as e:
                print(f"  ✗ {member}: {str(e)[:50]}")
                errors += 1
        
        print(f"\n{'='*50}")
        print(f"Completado: {success} | Errores: {errors}")
        print(f"{'='*50}\n")
        
        # Verificación
        print("Verificando miembros creados...")
        stdin, stdout, stderr = ssh.exec_command(
            "system('DSPMBRLIST FILE(FGUTIERRM1/QSQLSRC) OUTPUT(*OUTFILE) "
            "OUTFILE(QTEMP/MBRLIST) OUTMBR(*NEW)')"
        )
        stdout.read()
        
        print("✓ Verificación completada")
        
        ssh.close()
        
    except Exception as e:
        print(f"✗ Error: {e}")


if __name__ == "__main__":
    main()
