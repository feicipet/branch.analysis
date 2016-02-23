mkdir -p /home/bofh/var/data/kibana/config
cp ./config/kibana.yml /home/bofh/var/data/kibana/config/
docker pull dockerelk_kibana
docker run -d -p 5601:5601 --link es01:elasticsearch -v /home/bofh/var/data/kibana/config:/opt/kibana/config --name kbn01 dockerelk_kibana
