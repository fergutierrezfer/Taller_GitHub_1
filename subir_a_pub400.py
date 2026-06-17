#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Programa para subir archivos SQL a PUB400.COM via SFTP
Usa paramiko para conexión SSH/SFTP
"""

import os
import sys
import glob
from pathlib import Path

try:
    import paramiko
except ImportError:
    print("ERROR: Se requiere instalar paramiko")
    print("Ejecutar: pip install paramiko")
    sys.exit(1)

class SFTPUploader:
    def __init__(self, host, username, password):
        self.host = host
        self.username = username
        self.password = password
        self.ssh = None
        self.sftp = None
        
    def connect(self):
        """Conectar a PUB400.COM via SFTP"""
        try:
            print(f"Conectando a {self.host}...")
            self.ssh = paramiko.SSHClient()
            self.ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            self.ssh.connect(self.host, username=self.username, password=self.password)
            self.sftp = self.ssh.open_sftp()
            print("✓ Conexión establecida")
            return True
        except Exception as e:
            print(f"✗ Error de conexión: {e}")
            return False
    
    def upload_files(self, local_path, remote_path):
        """Subir archivos *.sql a PUB400.COM"""
        if not self.sftp:
            print("✗ No hay conexión SFTP activa")
            return False
        
        try:
            # Crear directorio remoto si no existe
            try:
                self.sftp.stat(remote_path)
                print(f"✓ Directorio remoto existe: {remote_path}")
            except IOError:
                print(f"Creando directorio: {remote_path}")
                self.sftp.mkdir(remote_path)
            
            # Cambiar a directorio remoto
            self.sftp.chdir(remote_path)
            
            # Obtener lista de archivos locales
            files = glob.glob(os.path.join(local_path, '*.sql'))
            
            if not files:
                print("✗ No se encontraron archivos *.sql")
                return False
            
            print(f"\nSubiendo {len(files)} archivos...\n")
            
            success_count = 0
            error_count = 0
            
            for filepath in sorted(files):
                filename = os.path.basename(filepath)
                try:
                    self.sftp.put(filepath, filename)
                    print(f"  ✓ {filename}")
                    success_count += 1
                except Exception as e:
                    print(f"  ✗ {filename}: {e}")
                    error_count += 1
            
            print(f"\n{'='*60}")
            print(f"Exitosos: {success_count}")
            print(f"Errores: {error_count}")
            print(f"{'='*60}")
            
            return error_count == 0
            
        except Exception as e:
            print(f"✗ Error durante carga: {e}")
            return False
    
    def disconnect(self):
        """Cerrar conexión"""
        if self.sftp:
            self.sftp.close()
        if self.ssh:
            self.ssh.close()
        print("Conexión cerrada")


def main():
    print("╔════════════════════════════════════════╗")
    print("║ SUBIDOR DE ARCHIVOS SQL A PUB400.COM  ║")
    print("╚════════════════════════════════════════╝\n")
    
    # Solicitar credenciales
    host = "pub400.com"
    username = input("Usuario PUB400.COM: ").strip()
    if not username:
        print("✗ Usuario requerido")
        return
    
    from getpass import getpass
    password = getpass("Contraseña: ")
    if not password:
        print("✗ Contraseña requerida")
        return
    
    # Ruta remota
    remote_path = input("Ruta remota (default: /home/{usuario}/qsqlsrc): ").strip()
    if not remote_path:
        remote_path = f"/home/{username}/qsqlsrc"
    
    print(f"\nRuta remota: {remote_path}\n")
    
    # Crear uploader y conectar
    uploader = SFTPUploader(host, username, password)
    
    if not uploader.connect():
        return
    
    try:
        # Subir archivos
        local_path = os.getcwd()
        uploader.upload_files(local_path, remote_path)
    finally:
        uploader.disconnect()


if __name__ == "__main__":
    main()
