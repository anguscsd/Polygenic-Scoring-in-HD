
# all parameters specfic to cardiff university supercomputer HAWK
#!/bin/bash
#SBATCH --job-name=run001 
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cxxxxxxx@cardiff.ac.uk
#SBATCH -t 10:00:00
#SBATCH --mem=12G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-22 # Runs a separate job for each chromosome (1-22)
# Load Python modules
module load anaconda
source activate
# Define file paths
sumstat=/home/c.cxxxxxxx/met584/data/gwas/Data_for_Angus/sumstats_new_prs
out=/home/c.cxxxxxxx/met584/data/prs_outfiles/
n=10552477
PRSCS=/home/c.cxxxxxxx/met584/PRS-CS/PRScs
bim=/home/c.cxxxxxxx/met584/data/gwas/GWA6_test_sample_RSID_new
ref=/home/c.cxxxxxxx/met584/data/eur_ref/ldblk_ukbb_eur
# Print assigned chromosome for debugging
echo "Processing Chromosome: ${SLURM_ARRAY_TASK_ID}"
# Run PRS-CS for the assigned chromosome
python "$PRSCS"/PRScs.py \
--ref_dir="$ref" \
--bim_prefix="$bim" \
--sst_file="$sumstat" \
--n_gwas="$n" \
--chrom="${SLURM_ARRAY_TASK_ID}" \
--out_dir="$out"
