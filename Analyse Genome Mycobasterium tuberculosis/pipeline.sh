java -jar picard.jar SamToFastq -I IonCode1.bam -F IonCode1.fastq

salmon index -t AL123456.3.fasta -i AL123456.3.index

mkdir -p salmon_output/

salmon quant -i AL123456.3.index/ -l A -r IonCode1.fastq -o salmon_output/

bwa index AL123456.3.fasta

bwa mem AL123456.3.fasta IonCode1.fastq > aln-se.sam

samtools view -S -b aln-se.sam > aln-se.bam

samtools sort aln-se.bam -o aln-se-sort.bam

samtools index aln-se-sort.bam

samtools mpileup -uf AL123456.3.fasta aln-se-sort.bam > aln-se-sort.bcf

bcftools call -v -m aln-se-sort.bcf > aln-se-sort.vcf

java -jar SnpSift.jar filter "(DP >= 3)" -f aln-se-sort.vcf > aln-se-sort-filter.vcf



