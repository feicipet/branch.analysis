curl -XPUT "http://localhost:9200/bankbranches/_mapping/queue" -d'
{
  "properties": {
    "InstallType": {
        "type": "string",
        "index" : "not_analyzed"
    },
    "InScope": {
        "type": "boolean"
    }
  }
}'
