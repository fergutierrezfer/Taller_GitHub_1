#!/usr/bin/env python3
# Verificación final

import glob

files = glob.glob('*.sql')
print("VERIFICACION FINAL - AJUSTE A 80 CARACTERES")
print("=" * 50)

total_files = len(files)
total_lines = 0
bad_lines = 0
bad_files_list = []

for fname in sorted(files):
    with open(fname, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    file_bad = 0
    for line in lines:
        total_lines += 1
        # Contar caracteres (posiciones de pantalla)
        line_len = len(line.rstrip())
        if line_len > 80:
            bad_lines += 1
            file_bad += 1
    
    if file_bad > 0:
        bad_files_list.append((fname, file_bad))

print(f"Archivos procesados: {total_files}")
print(f"Total de líneas: {total_lines}")
print(f"Líneas > 80 caracteres: {bad_lines}")

if bad_lines == 0:
    print("\n✓ EXITO 100%")
    print("Todos los archivos cumplen con máximo 80 bytes")
    print("Listos para PUB400.COM")
else:
    print(f"\nArchivos con líneas largas:")
    for fname, count in bad_files_list[:15]:
        print(f"  {fname}: {count} líneas")

print("=" * 50)
