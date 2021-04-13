# INSPI-articprotocol

## Recursos 

- Burrows-Wheeler Aligner (bwa) --> gcc, make, zlib 
- samtools, bcftools, htslib --> """"""

---

## Workflow actual

[secuenciación] --> [bwa-mem] --> [samtools] --> [bcftools] --> [vcfutils] --> [bgzip] --> [tabix] --> [bcftools] --> [renameHeader.py]

---

El uso de los programas se los debe ejecutar de la siguiente forma

``` shell

./bwa index [genomaRef.fa] 

```
