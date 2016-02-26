curl -XPUT "http://localhost:9200/cfmresponse" -d'
{
   "mappings": {
      "queue": {
        "properties" : {
            "ProcessDatetime" : {
                "type" : "date",
                "format" : "dd/MM/yyyy HH:mm:ss Z"
            },
            "TransactionID" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "KBankTransactionID" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ResponseID" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ResponseCompleted" : {
                "type" : "boolean"
            },
            "ResponseStartTime" : {
                "type" : "date",
                "format" : "dd/MM/yyyy HH:mm:ss Z"
            },
            "ResponseEndTime" : {
                "type" : "date",
                "format" : "dd/MM/yyyy HH:mm:ss Z"
            },
            "ResponseQ1" : {
                "type" : "integer"
            },
            "ResponseQ2" : {
                "type" : "integer"
            },
            "ResponseQ3" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ResponseQ4" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ResponseQ4A" : {
                "type" : "integer"
            },
            "ResponseQ4B" : {
                "type" : "integer"
            },
            "ResponseQ5" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "TransactionDatetime" : {
                "type" : "date",
                "format" : "dd/MM/yyyy HH:mm:ss Z"
            },
            "TransactionFileName" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "CampaignType" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ProcessResult" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ServiceListCode" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "Product" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ReActivityLevel2" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ServiceList" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "CounterType" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ServiceListPriority" : {
                "type" : "integer"
            },
            "CustomerCode" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "BranchCode" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "Region" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "Zone" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "BranchName" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "BranchGrade" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "PotentialGrade" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "ISB" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "SegmentCode" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "SegmentDescription" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "SegmentGroup" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "TellerCode" : {
                "type" : "string",
                "index" : "not_analyzed"
            },
            "InvitationTime" : {
                "type" : "date",
                "format" : "dd/MM/yyyy HH:mm:ss Z"
            }
        }
      }
   }
}'
