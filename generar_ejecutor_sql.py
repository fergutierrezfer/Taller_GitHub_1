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

def generar_programa_cl():
    archivos_sql = [f for f in os.listdir(CARPETA_LOCAL) if f.lower().endswith('.sql')]
    
    lineas_cl = []
    lineas_cl.append("             PGM")
    lineas_cl.append("             /* Ejecucion masiva de RUNSQLSTM sin truncado de columnas */")
    
    for archivo in archivos_sql:
        nombre_miembro, _ = os.path.splitext(archivo)
        nombre_miembro = nombre_miembro.upper()[:10]
        
        # Ignoramos los programas CL que viven en este mismo archivo físico
        if nombre_miembro in ["CHGTYPTXT", "RUNALLSQL"]:
            continue
            
        # Dividimos el comando RUNSQLSTM en dos líneas cortas (< 80 columnas) usando '+'
        linea_1 = f"             RUNSQLSTM  SRCFILE({BIBLIOTECA}/{ARCHIVO_FUENTES}) +"
        linea_2 = f"                          SRCMBR({nombre_miembro}) COMMIT(*NONE) ERRLVL(30)"
        # Monitoreamos errores: Si una tabla ya existe o falla, pasa a la siguiente sin detenerse
        linea_3 = "             MONMSG     MSGID(CPF0000 SQL0000)"
        
        lineas_cl.append(linea_1)
        lineas_cl.append(linea_2)
        lineas_cl.append(linea_3)
        
    lineas_cl.append("             ENDPGM")
    return "\n".join(lineas_cl)

def subir_ejecutor():
    if not os.path.exists(CARPETA_LOCAL):
        print(f"Error: La ruta '{CARPETA_LOCAL}' no existe.")
        return

    print("Estructurando programa CL para ejecucion en rafaga de SQL...")
    codigo_cl_final = generar_programa_cl()
    
    try:
        ftp = FTP(HOST)
        ftp.login(user=USER, passwd=PASSWORD)
        ftp.voidcmd("SITE NAMEFMT 1")
        
        ruta_ifs = f"/QSYS.LIB/{BIBLIOTECA}.LIB/{ARCHIVO_FUENTES}.FILE"
        ftp.cwd(ruta_ifs)
        
        # Guardamos el miembro como RUNALLSQL.MBR
        flujo_bytes = io.BytesIO(codigo_cl_final.encode("utf-8"))
        ftp.storlines("STOR RUNALLSQL.MBR", flujo_bytes)
        print("¡Miembro CL 'RUNALLSQL' generado y subido con exito!")
        
        ftp.quit()
    except Exception as e:
        print(f"Error en la transferencia FTP: {e}")

if __name__ == "__main__":
    subir_ejecutor()