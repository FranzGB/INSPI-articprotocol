# INSPI-articprotocol

## Recursos 

- Burrows-Wheeler Aligner (bwa) --> gcc, make, zlib 
- samtools, bcftools, htslib --> """"""

---

## Workflow actual

[secuenciación] --> [bwa-mem] --> [samtools] --> [bcftools] --> [vcfutils] --> [bgzip] --> [tabix] --> [bcftools] --> [renameHeader.py]
