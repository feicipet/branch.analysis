mkdir -p /home/bofh/var/data/elasticsearch/data
mkdir -p /home/bofh/var/data/elasticsearch/config
cp ./config/*.yml /home/bofh/var/data/elasticsearch/config
sudo chown -R 105 /home/bofh/var/data/elasticsearch/data
sudo chown -R 105 /home/bofh/var/data/elasticsearch/config
docker pull elasticsearch
docker run -d -p 9200:9200 -p 9300:9300 -v /home/bofh/var/data/elasticsearch/data:/usr/share/elasticsearch/data -v /home/bofh/var/data/elasticsearch/config:/usr/share/elasticsearch/config --name es01 elasticsearch
