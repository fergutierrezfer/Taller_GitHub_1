import os
from ftplib import FTP
import io
import re

# =====================================================================
# CONFIGURACIÓN GENERAL
# =====================================================================
HOST = "pub400.com"
USER = "FGUTIERRM"           
PASSWORD = "Hfernand5"      
BIBLIOTECA = "FGUTIERRM1"    
ARCHIVO_FUENTES = "QSQLSRC"   
CARPETA_LOCAL = "C:/Users/ferch/Documents/WS_Novacomp_Taller_IA_1/TallerGitHub/tablas_individuales"

def obtener_descripcion_linea3(ruta_archivo):
    try:
        with open(ruta_archivo, "r", encoding="utf-8") as f:
            lineas = f.readlines()
            if len(lineas) >= 3:
                linea_3 = lineas[2].replace('\n', '').replace('\r', '').strip()
                
                # 1. Limpieza de caracteres de comentario SQL
                linea_limpia = linea_3.lstrip('-').lstrip('/*').rstrip('*/').strip()
                
                # 2. Eliminar la palabra "descripción" y variantes
                linea_limpia = re.sub(r'(?i)\bdescripci[oó]n\b[:\s-]*', '', linea_limpia)
                
                # 3. Limpieza de espacios remanentes
                linea_limpia = linea_limpia.strip()
                
                # 4. Escapar comillas simples duplicándolas para el CL
                linea_limpia = linea_limpia.replace("'", "''")
                
                # 5. RECORTE ULTRA-ESTRICTO: Lo bajamos a 45 para asegurar margen de comillas
                return linea_limpia[:45]
    except Exception:
        pass
    return "Tabla SQL"

def generar_programa_cl():
    archivos_sql = [f for f in os.listdir(CARPETA_LOCAL) if f.lower().endswith('.sql')]
    
    lineas_cl = []
    lineas_cl.append("             PGM")
    lineas_cl.append("             /* Formato vertical estricto sin espacios a la derecha */")
    
    for archivo in archivos_sql:
        nombre_miembro, _ = os.path.splitext(archivo)
        nombre_miembro = nombre_miembro.upper()[:10]
        
        ruta_completa = os.path.join(CARPETA_LOCAL, archivo)
        descripcion = obtener_descripcion_linea3(ruta_completa)
        
        # Quitamos sangrías excesivas en las líneas de continuación para que queden bien a la izquierda
        linea_1 = f"             CHGPFM     FILE({BIBLIOTECA}/{ARCHIVO_FUENTES}) +"
        linea_2 = f"                          MBR({nombre_miembro}) SRCTYPE(SQL) +"
        linea_3 = f"                          TEXT('{descripcion}')"
        
        lineas_cl.append(linea_1)
        lineas_cl.append(linea_2)
        lineas_cl.append(linea_3)
        
    lineas_cl.append("             ENDPGM")
    return "\n".join(lineas_cl)

def subir_actualizador():
    if not os.path.exists(CARPETA_LOCAL):
        print(f"Error: La carpeta local '{CARPETA_LOCAL}' no existe.")
        return

    print("Generando código CL optimizado...")
    codigo_cl_final = generar_programa_cl()
    
    try:
        ftp = FTP(HOST)
        ftp.login(user=USER, passwd=PASSWORD)
        
        # FORZAMOS MODO DE TRANSFERENCIA DE TEXTO LIMPIO SIN RELLENO DE COLUMNAS
        ftp.voidcmd("SITE NAMEFMT 1")
        
        ruta_ifs = f"/QSYS.LIB/{BIBLIOTECA}.LIB/{ARCHIVO_FUENTES}.FILE"
        ftp.cwd(ruta_ifs)
        
        flujo_bytes = io.BytesIO(codigo_cl_final.encode("utf-8"))
        ftp.storlines("STOR CHGTYPTXT.MBR", flujo_bytes)
        print("¡Miembro CL 'CHGTYPTXT' subido con éxito!")
        
        ftp.quit()
        
        print("\n" + "="*75)
        print("¡PROCESO COMPLETADO EN PYTHON!")
        print("="*75)
        print("1. Ve al PDM, busca CHGTYPTXT y ponle Type: CLP (Opción 13)")
        print("2. Compila con Opción 14.")
        print(f"3. Ejecuta con: CALL {BIBLIOTECA}/CHGTYPTXT")
        print("="*75)
        
    except Exception as e:
        print(f"Error en transferencia: {e}")

if __name__ == "__main__":
    subir_actualizador()