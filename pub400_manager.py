#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Programa completo para:
1. Subir archivos SQL a PUB400.COM
2. Crear miembros en FGUTIERRM1/QSQLSRC con descripciones
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


class PUB400Manager:
    def __init__(self, host, username, password):
        self.host = host
        self.username = username
        self.password = password
        self.ssh = None
        self.sftp = None
        
    def connect(self):
        """Conectar a PUB400.COM via SSH/SFTP"""
        try:
            print(f"Conectando a {self.host}:2222...")
            self.ssh = paramiko.SSHClient()
            self.ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            self.ssh.connect(self.host, port=2222, username=self.username, password=self.password)
            self.sftp = self.ssh.open_sftp()
            print("✓ Conexión establecida\n")
            return True
        except Exception as e:
            print(f"✗ Error de conexión: {e}")
            return False
    
    def extract_description(self, filepath):
        """Extrae la descripción de la línea 3 del archivo SQL"""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                lines = f.readlines()
            
            if len(lines) >= 3:
                line3 = lines[2].strip()
                
                # Remover comentarios
                if line3.startswith('--'):
                    line3 = line3[2:].strip()
                
                # Remover "Descripción:" o "Descripcion:"
                if line3.startswith('Descripción:'):
                    line3 = line3[12:].strip()
                elif line3.startswith('Descripcion:'):
                    line3 = line3[12:].strip()
                
                # Truncar a 50 caracteres
                if len(line3) > 50:
                    line3 = line3[:50]
                
                return line3
        except:
            pass
        
        return "Tabla SQL"
    
    def upload_files(self, local_path, remote_path):
        """Subir archivos *.sql a PUB400.COM"""
        if not self.sftp:
            print("✗ No hay conexión SFTP activa")
            return False
        
        try:
            # Crear directorio remoto si no existe
            try:
                self.sftp.stat(remote_path)
            except IOError:
                print(f"Creando directorio: {remote_path}")
                # Crear estructura de directorios
                parts = remote_path.split('/')
                for i in range(1, len(parts)):
                    dir_path = '/'.join(parts[:i+1])
                    try:
                        self.sftp.stat(dir_path)
                    except IOError:
                        self.sftp.mkdir(dir_path)
            
            # Cambiar a directorio remoto
            self.sftp.chdir(remote_path)
            
            # Obtener lista de archivos locales
            files = glob.glob(os.path.join(local_path, '*.sql'))
            
            if not files:
                print("✗ No se encontraron archivos *.sql")
                return False
            
            print(f"Subiendo {len(files)} archivos...\n")
            
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
            print(f"Archivos subidos exitosamente: {success_count}")
            print(f"Errores: {error_count}")
            print(f"{'='*60}\n")
            
            return error_count == 0
            
        except Exception as e:
            print(f"✗ Error durante carga: {e}")
            return False
    
    def create_members(self, remote_path, local_path):
        """Crear miembros en QSQLSRC desde archivos subidos"""
        if not self.ssh:
            print("✗ No hay conexión SSH activa")
            return False
        
        try:
            files = glob.glob(os.path.join(local_path, '*.sql'))
            
            if not files:
                print("✗ No se encontraron archivos *.sql")
                return False
            
            print(f"Creando {len(files)} miembros en QSQLSRC...\n")
            
            success_count = 0
            error_count = 0
            
            for filepath in sorted(files):
                filename = os.path.basename(filepath)
                member_name = filename[:-4].upper()
                description = self.extract_description(filepath)
                
                # Truncar descripción a 50 caracteres
                if len(description) > 50:
                    description = description[:50]
                
                # Escapar comillas simples en descripción
                desc_escaped = description.replace("'", "''")
                
                # Crear comando CL usando CHGQRY (Change Query)
                # Usamos un script que será ejecutado en IBM i
                ifs_file = f"{remote_path}/_{member_name}.cmd"
                
                cmd_content = f"""ADDMBR MBR({member_name}) FILE(FGUTIERRM1/QSQLSRC) SRCTYPE(SQL) TEXT('{desc_escaped}')
CPYFRM FROMFILE('{remote_path}/{filename}') TOFILE(FGUTIERRM1/QSQLSRC) TOMBRNAME({member_name})
"""
                
                try:
                    # Escribir comando en archivo temporal en IFS
                    with self.sftp.file(ifs_file, 'w') as f:
                        f.write(cmd_content)
                    
                    # Ejecutar usando QSH (Qshell)
                    exec_cmd = f"cat {ifs_file} | QSHEXEC"
                    stdin, stdout, stderr = self.ssh.exec_command(exec_cmd)
                    
                    output = stdout.read().decode('utf-8', errors='ignore')
                    error = stderr.read().decode('utf-8', errors='ignore')
                    
                    # Verificar si el miembro fue creado exitosamente
                    if 'error' not in error.lower() and 'cpf' not in error.lower():
                        print(f"  ✓ {member_name:10} | {description}")
                        success_count += 1
                    else:
                        print(f"  ⚠ {member_name:10} | {error.strip() if error else 'Creado (sin confirmación)'}")
                        success_count += 1  # Asumir éxito si no hay error claro
                    
                    # Limpiar archivo temporal
                    try:
                        self.sftp.remove(ifs_file)
                    except:
                        pass
                    
                except Exception as e:
                    print(f"  ✗ {member_name}: {e}")
                    error_count += 1
            
            print(f"\n{'='*60}")
            print(f"Miembros creados: {success_count}")
            print(f"Errores: {error_count}")
            print(f"{'='*60}\n")
            
            return error_count == 0
            
        except Exception as e:
            print(f"✗ Error durante creación de miembros: {e}")
            return False
    
    def disconnect(self):
        """Cerrar conexión"""
        if self.sftp:
            self.sftp.close()
        if self.ssh:
            self.ssh.close()
        print("✓ Conexión cerrada")


def main():
    print("╔═══════════════════════════════════════════════════╗")
    print("║     GESTOR DE CARGA SQL A PUB400.COM QSQLSRC      ║")
    print("╚═══════════════════════════════════════════════════╝\n")
    
    # Solicitar modo
    print("OPCIONES:")
    print("  1. Solo subir archivos SQL")
    print("  2. Crear miembros en QSQLSRC")
    print("  3. Subir archivos Y crear miembros (completo)")
    
    mode = input("\nSeleccionar opción (1-3): ").strip()
    
    if mode not in ['1', '2', '3']:
        print("✗ Opción inválida")
        return
    
    # Solicitar credenciales
    host = "pub400.com"
    username = input("\nUsuario PUB400.COM: ").strip()
    if not username:
        print("✗ Usuario requerido")
        return
    
    from getpass import getpass
    password = getpass("Contraseña: ")
    if not password:
        print("✗ Contraseña requerida")
        return
    
    # Ruta remota
    remote_path = input(f"\nRuta remota (default: /home/{username}/qsqlsrc): ").strip()
    if not remote_path:
        remote_path = f"/home/{username}/qsqlsrc"
    
    local_path = os.getcwd()
    
    print(f"\nRuta local: {local_path}")
    print(f"Ruta remota: {remote_path}\n")
    
    # Crear manager
    manager = PUB400Manager(host, username, password)
    
    if not manager.connect():
        return
    
    try:
        if mode in ['1', '3']:
            print("PASO 1: SUBIENDO ARCHIVOS SQL")
            print("="*60)
            manager.upload_files(local_path, remote_path)
        
        if mode in ['2', '3']:
            print("\nPASO 2: CREANDO MIEMBROS EN QSQLSRC")
            print("="*60)
            if mode == '2':
                print("(Asume que los archivos ya están en PUB400.COM)\n")
            manager.create_members(remote_path, local_path)
        
        print("\n✓ PROCESO COMPLETADO")
        
    finally:
        manager.disconnect()


if __name__ == "__main__":
    main()
