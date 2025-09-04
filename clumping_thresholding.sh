#!bin/bash
echo "loading plink"
echo
module load plink/1.9
LDref="/home/c.c2019487/met584/data/gwas/Data_for_Angus/GWA345_LD_reference"
test="/home/c.c2019487/met584/data/gwas/Data_for_Angus/GWA6_test_sample"
sumstat="/home/c.c2019487/met584/data/gwas/Data_for_Angus/Cell_2019_residual_AA$
# Clumping
echo "clumping"
echo
plink \
--bfile $LDref \
--clump-p1 1 \
--clump-r2 0.1 \
--clump-kb 250 \
--clump $sumstat \
--clump-snp-field snp \
--clump-field pval \
--out simuls
# creating simuls.clumped which contains the index snps after clumping
echo "indexing snps"
echo
awk 'NR!=1{print $3}' simuls.clumped > simuls.clumped.snp
# Generate PRS based on a range of P-values
awk '{print $2,$10}' $sumstat > SNP.pval
echo "making 'range_list' file"
echo
echo "1e-8 0 1e-8" > range_list
echo "1e-6 0 1e-6" >> range_list
echo "1e-4 0 1e-4" >> range_list
echo "0.01 0 0.01" >> range_list
echo "0.05 0 0.05" >> range_list
echo "0.1 0 0.1" >> range_list
echo "0.5 0 0.5" >> range_list
echo "1 0 1" >> range_list
plink \
--bfile $test \
--score $sumstat 2 5 8 sum header \
--q-score-range range_list SNP.pval \
--extract simuls.clumped.snp \
--out test
