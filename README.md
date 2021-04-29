l# INSPI-articprotocol

## Recursos 

- Burrows-Wheeler Aligner (bwa) --> gcc, make, zlib 
- samtools, bcftools, htslib --> """"""
- tabix
---

## Workflow actual

[secuenciación] --> [bwa-mem] --> [samtools] --> [bcftools] --> [vcfutils] --> [bgzip] --> [tabix] --> [bcftools] --> [renameHeader.py]

---

El uso de los programas se los debe ejecutar de la siguiente forma:

**Recomendaciones**
- Crear una carpeta donde se va a llamar al paso #1.
- La carpeta principal va a contener una carpeta por cada muestra a procesar. Reproducir los pasos adentro del directorio de cada una de las muestras.

1. Indexar el genoma de referencia

``` shell

./bwa index [genomaRef.fa] 
  samtools faidx [genomaRef.fa]

```

2. Alineamiento

``` shell
./bwa mem [genomaRef.fa][muestraBarcode.fa] > [output.sam]
```

3. Conversión de formato SAM a BAM

``` shell
samtools view -S -b [output.sam] > [output.bam]
```

4. Ordenar los alineamientos

``` shell
samtools sort -o [output_sorted.bam] [output.bam] 
```

5. Calcular la cobertura de las lecturas

``` shell
bcftools mpileup -O b -o [raw.bcf] -f [genomaRef.fa] [output_sorted.bam]
```

6. Detectar el polimorfismo de nucleótido único

``` shell
bcftools call --ploidy 1 -m -v -o [variant.vcf] [raw.bcf]
```

7. Comprimir [variant.vcf] y crear su archivo indexado

``` shell
bgzip -c [variant.vcf] > [variant.vcf.gz]
tabix -p vcf [variant.vcf.gz]
```

8. Crear la secuencia de consenso

``` shell
cat [genomaRef.fa] | bcftools consensus [variant.vcf.gz] > consensus.fa
```

9. Cambiar nombre del encabezado y archivo

``` shell
renameHeader.py [consensus.fa] [nombre archivo y encabezado]
```
