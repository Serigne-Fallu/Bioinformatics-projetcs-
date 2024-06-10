
========================  DESCRIPTION SCRIPT BASH =============================


 `java -jar picard.jar SamToFastq -I IonCode1.bam -F IonCode1.fastq`
   Cette ligne exécute un programme Java appelé Picard, en utilisant le fichier JAR "picard.jar". L'option "-I" spécifie le fichier d'entrée (IonCode1.bam) au format BAM contenant des données alignées, et l'option "-F" spécifie le fichier de sortie (IonCode1.fastq) au format FASTQ qui contiendra les séquences brutes correspondantes.

 `salmon index -t AL123456.3.fasta -i AL123456.3.index`
   Cette ligne exécute le programme Salmon avec l'option "index". Salmon est utilisé pour créer un index à partir du fichier de séquences d'ARNm de référence spécifié avec l'option "-t" (AL123456.3.fasta). L'index sera enregistré dans le répertoire spécifié avec l'option "-i" (AL123456.3.index).

 `mkdir -p salmon_output/`
   Cette ligne crée un répertoire appelé "salmon_output/" s'il n'existe pas déjà. L'option "-p" assure que le répertoire parent est également créé si nécessaire.

 `salmon quant -i AL123456.3.index/ -l A -r IonCode1.fastq -o salmon_output/`
   Cette ligne exécute le programme Salmon avec l'option "quant". Salmon est utilisé pour quantifier l'expression génique à partir du fichier FASTQ (IonCode7.fastq) en utilisant l'index créé précédemment. L'option "-l A" spécifie la bibliothèque de lecture comme étant une bibliothèque de type "A". Les résultats de l'analyse seront enregistrés dans le répertoire "salmon_output/".

 `bwa index AL123456.3.fasta`
   Cette ligne exécute la commande "bwa index" pour créer un index à partir du fichier de séquences de référence AL123456.3.fasta. Cet index permettra une recherche rapide lors de l'alignement ultérieur des données séquentielles.

 `bwa mem AL123456.3.fasta IonCode1.fastq > aln-se.sam`
   Cette ligne utilise l'outil BWA (Burrows-Wheeler Aligner) pour effectuer l'alignement des séquences de lecture du fichier FASTQ (IonCode1.fastq) sur le génome de référence spécifié (AL123456.3.fasta). L'option "mem" est utilisée pour l'alignement de type mem. Le résultat est redirigé vers le fichier aln-se.sam au format SAM (Sequence Alignment/Map).

 `samtools view -S -b aln-se.sam > aln-se.bam`
    Cette ligne utilise l'outil Samtools pour convertir le fichier SAM (aln-se.sam) en un fichier BAM (aln-se.bam) compressé et indexé. L'option "-S" indique que l'entrée est au format SAM.

 `samtools sort aln-se.bam -o aln-se-sort.bam`
    Cette ligne utilise Samtools pour trier le fichier BAM (aln-se.bam) par coordonnées génomiques et enregistre le résultat trié dans le fichier aln-se-sort.bam.

 `samtools index aln-se-sort.bam`
    Cette ligne crée un index pour le fichier BAM trié (aln-se-sort.bam) à l'aide de Samtools. L'index permet d'accéder plus rapidement à des régions spécifiques du fichier BAM.

 `samtools mpileup -uf AL123456.3.fasta aln-se-sort.bam > aln-se-sort.bcf`
    Cette ligne utilise Samtools pour générer un fichier BCF (Binary Call Format) à partir de l'alignement du fichier BAM trié (aln-se-sort.bam) sur le génome de référence (AL123456.3.fasta). L'option "-u" indique la sortie sous forme de BCF non compressé.

 `bcftools call -v -m aln-se-sort.bcf > aln-se-sort.vcf`
    Cette ligne utilise BCFtools pour appeler les variants à partir du fichier BCF (aln-se-sort.bcf) et génère un fichier VCF (Variant Call Format) contenant les variantes détectées. Les options "-v" et "-m" spécifient respectivement les variantes et les sites multialléliques.

 `java -jar SnpSift.jar filter "(DP >= 3)" -f aln-se-sort.vcf > aln-se-sort-filter.vcf`
    Cette ligne exécute SnpSift, un outil Java, pour filtrer le fichier VCF (aln-se-sort.vcf) afin de ne conserver que les variantes ayant une profondeur de séquençage (DP) supérieure ou égale à 3. Le résultat filtré est enregistré dans le fichier aln-se-sort-filter.vcf.





La commande `samtools sort aln-se.bam -o aln-se-sort.bam` est utilisée pour trier un fichier d'alignement au format BAM (`aln-se.bam`) selon les positions de référence. Le fichier de sortie trié est spécifié avec l'option `-o` et est nommé `aln-se-sort.bam`.

Le format BAM est une version compressée du format SAM (Sequence Alignment/Map). Les fichiers SAM et BAM contiennent des informations sur l'alignement des séquences d'ADN ou d'ARN sur un génome de référence. Le tri du fichier d'alignement est utile pour faciliter l'accès et l'analyse des données génomiques.

Une fois que le fichier d'alignement (`aln-se.bam`) est trié en utilisant la commande `samtools sort`, vous pouvez utiliser la commande `samtools view` pour afficher le contenu du fichier ordonné (`aln-se-sort.bam`) au format SAM.

Pour visualiser le fichier brut (non ordonné) au format SAM, vous pouvez exécuter la commande `samtools view aln-se.bam`. Cette commande affiche les alignements des séquences dans le fichier brut, dans l'ordre dans lequel ils apparaissent dans le fichier.

Pour visualiser le fichier ordonné au format SAM, vous pouvez exécuter la commande `samtools view aln-se-sort.bam`. Cette commande affiche les alignements des séquences dans le fichier ordonné, où les alignements sont triés selon les positions de référence.

En comparant les deux fichiers, vous pouvez observer comment les alignements des séquences sont réorganisés dans le fichier ordonné par rapport au fichier brut. Le fichier ordonné est généralement plus pratique pour l'analyse des données génomiques, car les alignements sont regroupés en fonction de leur position de référence, ce qui facilite la recherche et l'extraction d'informations spécifiques.