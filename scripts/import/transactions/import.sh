START=`date +%s`
if [[ $# -eq 0 ]] ; then
  echo "ERROR: File name to be converted needed. Nothing done, exiting."
  exit 0
fi

if [ ! -f "$1" ] ; then
  echo "ERROR: File specified not found!! Exiting."
  exit 0
fi

CSVFILENAME="`basename \"$1\" .xlsx | sed 's/ /_/g'`.csv"
echo "1) Converting Excel file $1 to $CSVFILENAME; this CSV file will be saved to your directory after the import is done."
xlsx2csv -f "%d/%m/%Y %H:%M:%S +0700" "$1" $CSVFILENAME
echo "2) Generated file $CSVFILENAME with total number of rows: `wc -l $CSVFILENAME | awk -F" " '{print $1}'`"
echo 
echo "3) We will now remove the first line of the CSV file which contains the header"
sed -i -e "1d" $CSVFILENAME
echo "4) Removed headerline from $CSVFILENAME with new total number of rows: `wc -l $CSVFILENAME | awk -F" " '{print $1}'`"
echo 
echo "5) Processing CSV file for import into ElasticSearch database now"
echo "5.1) Removing unnecessary fields and merging in Product Service Listing information"
awk -F"," 'NR==FNR {A[$2] = $2","$3","$4","$5; next} {print $3","$4","$5","$6","$7","$8","$9","A[$11]","$14","$15","$16","$17","$19","$21}' KBankCFMMasterProductService.csv $CSVFILENAME > tmp.a.txt
echo "5.2) Merging in Branch Master information"
awk -F"," 'NR==FNR {A[$1] = $1","$2","$3","$4","$5","$6","$7; next} {$15 = A[$15]}1' FS=, OFS=, KBankCFMMasterBranch.csv tmp.a.txt > tmp.b.txt
echo "5.3) Merging in Customer Segment Master information"
awk -F"," 'NR==FNR {A[$1] = $1","$2","$3; next} {$22 = A[$22]}1' FS=, OFS=, KBankCFMMasterCustSeg.csv tmp.b.txt > tmp.c.txt
echo
echo "6) Completed generating import file with row count: `wc -l tmp.c.txt | awk -F" " '{print $1}'`"
awk -F"," '{print "{ \42create\42: {\42_index\42:\42cfmresponse\42, \42_type\42:\42queue\42, \42_id\42:\42"$3"\42}}\n{\42ProcessDatetime\42:\42"$1"\42, \42TransactionID\42:\42"$2"\42, \42KBankTransactionID\42:\42"$3"\42, \42TransactionDatetime\42:\42"$4"\42, \42TransactionFileName\42:\42"$5"\42, \42CampaignType\42:\42"$6"\42, \42ProcessResult\42:\42"$7"\42, \42ServiceListCode\42:\42"$8"\42, \42Product\42:\42"$9"\42, \42ReActivityLevel2\42:\42"$10"\42, \42ServiceList\42:\42"$11"\42, \42CounterType\42:\42"$12"\42, \42ServiceListPriority\42:\42"$13"\42, \42CustomerCode\42:\42"$14"\42, \42BranchCode\42:\42"$15"\42, \42Region\42:\42"$16"\42, \42Zone\42:\42"$17"\42, \42BranchName\42:\42"$18"\42, \42BranchGrade\42:\42"$19"\42, \42PotentialGrade\42:\42"$20"\42, \42ISB\42:\42"$21"\42, \42SegmentCode\42:\42"$22"\42, \42SegmentDescription\42:\42"$23"\42, \42SegmentGroup\42:\42"$24"\42, \42TellerCode\42:\42"$25"\42}"}' tmp.c.txt > tmp.d.txt
echo "7) Starting to import file now. State of database before import as follows:"
curl 'localhost:9200/_cat/indices/cfmresponse?v'
curl -s -XPOST "http://localhost:9200/_bulk?pretty=true" --data-binary "@tmp.d.txt" >> import.log
echo "8) Completed importing file. State of database as follows:"
curl 'localhost:9200/_cat/indices/cfmresponse?v'
rm tmp*txt

END=`date +%s`
echo "Total execution time: $((END-START)) seconds"
