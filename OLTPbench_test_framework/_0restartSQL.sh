#!/bin/bash

#arg1 is the port number of the MySQL instance that is being tested

sleep_time=30

echo "Sleeping for ${sleep_time} sec..."
sleep ${sleep_time} 
echo 'Continuing...'
echo ''

if [ ${1} -eq 3306 ]
then 
  ssh -i /root/.ssh/newdijon root@10.0.0.10 'service mysql start'
  ssh -i /root/.ssh/newdijon root@10.0.0.10 'service mysql restart'
  echo '>>> Restarted MySQL server on 3306'
elif [ ${1} -eq 6603 ] 
then
  ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker stop bind_mysql'
  ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker start bind_mysql'
  echo '>>> Restarted MySQL server on 6603'
elif [ ${1} -eq 6605 ] 
then
  ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker stop container_mysql'
  ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker start container_mysql'
  echo '>>> Restarted MySQL server on 6605'
else 
  ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker stop volume_mysql'
  ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker start volume_mysql'
  echo '>>> Restarted MySQL server on 6604'
fi

echo ''
echo "Sleeping for ${sleep_time} sec..."
sleep ${sleep_time};
echo 'Continuing...'
