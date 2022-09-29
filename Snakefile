from snakemake.remote.S3 import RemoteProvider as S3RemoteProvider
S3 = S3RemoteProvider(
    access_key_id=config["key"], 
    secret_access_key=config["secret"],
    host=config["host"],
    stay_on_remote=False
)
prefix = config["prefix"]
filename = config["filename"]

rule get_SummarizedExp:
    input:
        S3.remote(prefix + 'data/GSM4150376_sciPlex1_cds.RDS'),
        S3.remote(prefix + 'data/GSM4150377_sciPlex2_cds.RDS'),
        S3.remote(prefix + 'data/GSM4150378_sciPlex3_A549_24hrs.RDS'),
        S3.remote(prefix + 'data/GSM4150378_sciPlex3_K562_24hrs.RDS'),
        S3.remote(prefix + 'data/GSM4150378_sciPlex3_MCF7_24hrs.RDS'),
        S3.remote(prefix + 'data/GSM4150379_sciPlex4_hdaci_cds.RDS')
    output:
        S3.remote(prefix + filename)
    resources:
        mem_mb=6000,
        disk_mb=6000
    shell:
        """
        Rscript scripts/get_GSE139944.R \
        {prefix} \
        {filename}
        """

rule extract_data:
    input:
        S3.remote(prefix + 'GSE139944_RAW.tar')
    output:
        S3.remote(prefix + 'data/GSM4150376_sciPlex1_cds.RDS'),
        S3.remote(prefix + 'data/GSM4150377_sciPlex2_cds.RDS'),
        S3.remote(prefix + 'data/GSM4150378_sciPlex3_A549_24hrs.RDS'),
        S3.remote(prefix + 'data/GSM4150378_sciPlex3_K562_24hrs.RDS'),
        S3.remote(prefix + 'data/GSM4150378_sciPlex3_MCF7_24hrs.RDS'),
        S3.remote(prefix + 'data/GSM4150379_sciPlex4_hdaci_cds.RDS')
    shell:
        """
        Rscript scripts/extract_GSE139944.R \
        {prefix} 
        """

rule download_data:
    output:
        S3.remote(prefix + 'GSE139944_RAW.tar')
    shell:
        """
        Rscript scripts/download_GSE139944.R \
        {prefix} 
        """