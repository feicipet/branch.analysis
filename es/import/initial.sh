######## Convert from original file to CUT version ########

awk -F"," '{ print $3 " " $4 "," $5 "," $6 "," $7 "," $3 " " $9 "," $3 " " $13 "," $14 "," $18 "," $19 "," $20 "," $21 "," $22 "," $23 "," $25 "," $26 }'  Manual1001+.csv > Manual1001+_cut.csv

######## Convert from CUT version to Bulk version ########

awk -F"," '{ print "{\42Branch_Code\42:\42" $10 "\42, \42CIS_ID\42:\42" $8 "\42, \42CallingTime\42:\42" $5 "\42, \42Counter_Type\42:\42" $15 "\42, \42Customer_Segment\42:\42" $9 "\42, \42EndTime\42:\42" $6 "\42, \42NoOfWaitingQueue\42:\42" $3 "\42, \42PressQueueTime\42:\42" $1 "\42, \42QueueNo\42:\42" $2 "\42, \42QueueStatus\42:\42" $7 "\42, \42ServiceItem\42:\42" $16 "\42, \42ServiceName\42:\42" $4 "\42, \42Staff_ID\42:\42" $12 "\42, \42Teller_ID\42:\42" $11 "\42, \42Teller_Name\42:\42" $13 "\42}\n{ \42create\42: {\42_index\42:\42bankbranches\42, \42_type\42:\42queue\42}}" }' Manual1-100_cut.csv > Manual1-100_bulk.csv

######## Bulk upload data ########

** Please split source file to 100,000 lines before upload
curl -s -XPOST localhost:9200/_bulk --data-binary "@lot0_aa"
curl -s -XPOST localhost:9200/_bulk --data-binary "@lot0_ab"
curl -s -XPOST localhost:9200/_bulk --data-binary "@lot0_ac"


