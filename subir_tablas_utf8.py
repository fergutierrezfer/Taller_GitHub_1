import os
from ftplib import FTP
import io

# =====================================================================
# CONFIGURACIÓN GENERAL
# =====================================================================
HOST = "pub400.com"
USER = "FGUTIERRM"           
PASSWORD = "Hfernand5"      
BIBLIOTECA = "FGUTIERRM1"    
ARCHIVO_FUENTES = "QSQLSRC"   

CARPETA_LOCAL = "C:/Users/ferch/Documents/WS_Novacomp_Taller_IA_1/TallerGitHub/tablas_individuales"

def ajustar_lineas_sql(contenido_texto, max_longitud=80):
    lineas_finales = []
    for linea in contenido_texto.splitlines():
        if len(linea) <= max_longitud:
            lineas_finales.append(linea)
            continue
            
        espacios_iniciales = len(linea) - len(linea.lstrip())
        indentacion = linea[:espacios_iniciales]
        linea_actual = linea
        while len(linea_actual) > max_longitud:
            punto_quiebre = linea_actual.rfind(' ', 0, max_longitud)
            if punto_quiebre == -1 or punto_quiebre <= espacios_iniciales:
                punto_quiebre = max_longitud
            pedazo = linea_actual[:punto_quiebre].rstrip()
            lineas_finales.append(pedazo)
            resto = linea_actual[punto_quiebre:].lstrip()
            if resto:
                linea_actual = indentacion + resto
            else:
                linea_actual = ""
                break
        if linea_actual:
            lineas_finales.append(linea_actual)
    return "\n".join(lineas_finales)

def iniciar_transferencia():
    if not os.path.exists(CARPETA_LOCAL):
        print(f"Error: La carpeta local '{CARPETA_LOCAL}' no existe.")
        return

    archivos_sql = [f for f in os.listdir(CARPETA_LOCAL) if f.lower().endswith('.sql')]
    total_archivos = len(archivos_sql)

    if total_archivos == 0:
        print(f"No se encontraron archivos .sql.")
        return

    try:
        ftp = FTP(HOST)
        ftp.login(user=USER, passwd=PASSWORD)
        ftp.voidcmd("SITE NAMEFMT 1")
        ruta_ifs = f"/QSYS.LIB/{BIBLIOTECA}.LIB/{ARCHIVO_FUENTES}.FILE"
        ftp.cwd(ruta_ifs)
        print(f"¡Conectado con éxito! Destino: {ruta_ifs}\n")
    except Exception as e:
        print(f"Error crítico de conexión FTP: {e}")
        return

    for indice, nombre_archivo in enumerate(archivos_sql, start=1):
        ruta_completa = os.path.join(CARPETA_LOCAL, nombre_archivo)
        nombre_miembro, _ = os.path.splitext(nombre_archivo)
        nombre_miembro = nombre_miembro.upper()[:10]
        
        print(f"[{indice}/{total_archivos}] Procesando: {nombre_archivo} -> MBR({nombre_miembro})")
        
        try:
            with open(ruta_completa, "r", encoding="utf-8") as archivo_fuente:
                contenido_original = archivo_fuente.read()
            
            contenido_formateado = ajustar_lineas_sql(contenido_original, max_longitud=80)
            contenido_bytes = contenido_formateado.encode("utf-8")
            flujo_bytes = io.BytesIO(contenido_bytes)
            
            ftp.storlines(f"STOR {nombre_miembro}.MBR", flujo_bytes)
            print(f"      [OK] Transferido a 80 posiciones.")
            
        except Exception as e_envio:
            print(f"      [ERROR] Falló: {e_envio}")
        print("-" * 60)

    try:
        ftp.quit()
        print("\n>>> Carga completada exitosamente sin errores de comandos. <<<")
    except Exception:
        ftp.close()

if __name__ == "__main__":
    iniciar_transferencia()