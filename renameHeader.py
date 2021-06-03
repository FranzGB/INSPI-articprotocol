#!/usr/bin/python3

import sys

### Algoritmo para editar encabezado de cada archivo consensus.fa
# 1. Obtener argumentos del terminal
# 2. Llamar a la funcion con ambos argumentos
# 3. La funcion crea un archivo temporal al cual escribir
# 4. Se abren ambos archivos, el original en modo lectura
# y la copia en modo de escritura
# 5. Se escribe en el archivo copia el encabezado
# 6. Se crea una lista de lineas del archivo original
# 7. Se recorre la lista de lineas a partir de la segunda línea
# 8. Se agrega cada linea al archivo copia

def update_file(file_name,new_name):

    updated_file = new_name + ".fa"
    with open(file_name,"r") as read_f, open(updated_file,"w") as write_f:

        write_f.write(">"+new_name + "\n")

        list_of_chars = read_f.readlines()
        for line in list_of_chars[1:]:
            write_f.write(line)




# main

file_name = sys.argv[1]
new_name = sys.argv[2]

update_file(file_name,new_name)
