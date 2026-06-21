import os
from ftplib import FTP
import io

# =====================================================================
# CONFIGURACIÓN GENERAL
# =====================================================================
HOST = "pub400.com"
USER = "FGUTIERRM"           
PASSWORD = "Hfernand5_"      
BIBLIOTECA = "FGUTIERRM1"    
ARCHIVO_FUENTES = "QSQLSRC"   
CARPETA_LOCAL = "C:/Ruta/Exacta/De/Tu/Disco/tablas_individuales"

def generar_comandos_puros():
    archivos_sql = [f for f in os.listdir(CARPETA_LOCAL) if f.lower().endswith('.sql')]
    
    lineas_cl = []
    # Generamos los comandos CHGPFM puros, uno por línea, sin cabeceras Batch
    for archivo in archivos_sql:
        nombre_miembro, _ = os.path.splitext(archivo)
        nombre_miembro = nombre_miembro.upper()[:10]
        lineas_cl.append(f"CHGPFM FILE({BIBLIOTECA}/{ARCHIVO_FUENTES}) MBR({nombre_miembro}) SRCTYPE(SQL)")
    
    return "\n".join(lineas_cl)

def ejecutar_cambio_tipo():
    print("Generando lista de comandos CL para tus 114 miembros...")
    contenido_cl = generar_comandos_puros()
    
    try:
        ftp = FTP(HOST)
        ftp.login(user=USER, passwd=PASSWORD)
        ftp.voidcmd("SITE NAMEFMT 1")
        
        ruta_ifs = f"/QSYS.LIB/{BIBLIOTECA}.LIB/{ARCHIVO_FUENTES}.FILE"
        ftp.cwd(ruta_ifs)
        
        # Subimos los comandos limpios en un miembro llamado CAMBIOTYP
        flujo_bytes = io.BytesIO(contenido_cl.encode("utf-8"))
        ftp.storlines("STOR CAMBIOTYP.MBR", flujo_bytes)
        print("¡Miembro 'CAMBIOTYP' depositado con éxito!")
        
        ftp.quit()
        
        print("\n" + "="*70)
        print("¡PROCESO LOCAL TERMINADO EXITOSAMENTE!")
        print("="*70)
        print("Fernando, para aplicar el cambio de forma nativa en la pantalla verde:")
        print("Ejecuta esta línea exacta en tu línea de comandos (===>):")
        print(f"\n   CPYFRMMBR FROMFILE({BIBLIOTECA}/{ARCHIVO_FUENTES}) FROMMBR(CAMBIOTYP) TOFILE({BIBLIOTECA}/{ARCHIVO_FUENTES}) TOMBR(EJECUTAR) MBROPT(*REPLACE)")
        print("\nO mejor aún, dado que son comandos puros, puedes llamarlos en un lote simple.")
        print("="*70)
        
    except Exception as e:
        print(f"Error en la operación: {e}")

if __name__ == "__main__":
    ejecutar_cambio_tipo()