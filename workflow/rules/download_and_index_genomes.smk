


# download the requested genome and rename it as such
rule download_genome:
  params:
    url=genome_url_from_genome
  log:
    wget="resources/logs/download_genome/wget-{genome}.log",
    gunzip="resources/logs/download_genome/gunzip-{genome}.log"
  conda:
    "../envs/wget.yaml"
  output:
    fna="resources/genomes/{genome}/{genome}.fna"
  shell:
    "echo 'wget -O {output.fna}.gz {params.url} 2> {log.wget}; "
    " gunzip {output.fna}.gz' > {output.fna} 2> {log.gunzip}"


rule bwt_index_genome:
  input:
    fna=fna_from_genome
  log:
    "resources/logs/bwt_index_genome/{genome}.log"
  conda:
    "../envs/bwa.yaml"
  output:
    multiext("resources/genomes/{genome}/{genome}.fna", ".amb", ".ann", ".bwt", ".pac", ".sa")
  shell:
    "echo bwa index {input.fna}  2> {log}; touch {output}"
