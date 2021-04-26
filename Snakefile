
samples = ["binned_barcode05","binned_barcode06","binned_barcode07","binned_barcode08"]

rule all:
    input:
        expand("Alineamiento/{sample}.bam", sample= samples),
        expand("sorted_reads/{sample}.bam", sample= samples),
        expand("cobertura/{sample}_raw.bcf", sample= samples),
        expand("variantes/{sample}_variant.vcf", sample= samples),
        expand("variantes/{sample}_variant.vcf.gz.tbi", sample= samples),
        expand("consensos/{sample}_consensus.fa", sample= samples)
        
rule bwa_map:
    input:
        "data/references.fasta",
        "data/samples/{sample}.fastq"
    output:
        "Alineamiento/{sample}.bam"
    shell:
        "bwa mem {input} | samtools view -Sb - > {output}"
        
rule samtools_sort:
    input:
        rules.bwa_map.output
    output:
        "sorted_reads/{sample}.bam"
    shell:
        "samtools sort -T sorted_reads/{wildcards.sample} "
        "-O bam {input} > {output}"

rule cobertura:
     input:
         "data/references.fasta",
         rules.samtools_sort.output
     output:
     	 "cobertura/{sample}_raw.bcf"
     shell:
     	 "bcftools mpileup -O b -o {output} -f {input}"	 

rule polimorfismo:
     input:
         rules.cobertura.output
     output:
     	 "variantes/{sample}_variant.vcf"
     shell:
     	 "bcftools call --ploidy 1 -m -v -o {output} {input}"
 
rule compress:
	input:
	   rules.polimorfismo.output
	output:
	   "variantes/{sample}_variant.vcf.gz"
	shell:
	   "bgzip -c {input} > {output}"
	
rule indices:
	input:
	   rules.compress.output
	output:
	   "variantes/{sample}_variant.vcf.gz.tbi"
	shell:
	   "tabix -p vcf {input}"

rule consensus:
	input:
	   fasta = "data/references.fasta",
	   gz = expand("variantes/{sample}_variant.vcf.gz", sample = samples)
	output:
	   "consensos/{sample}_consensus.fa"
	shell:
	   "cat {input.fasta} | bcftools consensus {input.gz} > {output}"
  
