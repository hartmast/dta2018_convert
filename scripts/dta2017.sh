## assuming all tcf files are in a folder 'files'. If not, uncomment
## the lines below and run on tcf.zip folder as downloaded from website
# mkdir files
# unzip dta_komplett_2018-10-17_tcf.zip
# mv dta_komplett_2018-10-17/full files/
# rm -r dta_komplett_2018-10-17

# if short on disc space, uncomment the lines below that remove the files
# created in the process. I left them in so that quality control becomes easier

date +"%T"

## Step 1
# for each DTA file, extract the relevant information and put token
# info as p-attributes in columns, i.e., convert to vrt format
echo 'converting to vrt format...'
for i in files/* ; do perl scripts/dta2vrt_v2017.pl <$i; done > dta2017a.txt

## Step 2
# Switches two columns (corr/word)
# Also, were DTA version does not contain a corrected token, the word-token is used
date +"%T"
echo 'switching columns in corr.pl...'
perl scripts/dta2017_vrtcorr.pl dta2017a.txt > dta2017b.txt
# rm dta2017a.txt

## Step 3
# decodes the entities
date +"%T"
echo 'decoding HTML entities...'
cat dta2017b.txt | perl -C -MHTML::Entities -pe 'decode_entities($_);' > dta2017c.txt
# rm dta2017b.txt

## Step 4
# counts the s-tags and inserts sentence-numbers (counts anew in every file)
date +"%T"
echo 'counting s-tags...'
perl scripts/dta2017_s-count.pl dta2017c.txt > dta2017d.txt
# rm dta2017c.txt

## Step 5
# This fixes unwanted issues. The entities replace routine also changed
# &lgt; at the beginning of *tokens*. This will confuse CWB, so these need
# to be undone...
# While we're at it, it also fixes the file_year tag from "1845[]" to "1845"
# if there is not YCREAT and the brackets are empty.
date +"%T"
echo 'undoing file initial brackets that are not opening file tags...'
perl scripts/dta2017_undo_line-initial.pl dta2017d.txt > dta2017e.txt
# rm dta2017d.txt

## Step 6
# This adds periods and decades
date +"%T"
echo 'adding periods and decades...'
perl scripts/dta2017_addperiods.pl dta2017e.txt > dta2017.vrt
# rm dta2017e.txt

## Step 7
# extracts fileheaders for quality control
date +"%T"
egrep '<file' dta2017.vrt > fileheaders_vrt_final.txt

