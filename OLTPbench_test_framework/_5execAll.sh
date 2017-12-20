#!/bin/bash

#========== INFO ============

# this script will run ALL tests

# ARG_1 (runtime)     = in seconds           (ONLY used for result fime name)

# for this script to work, do this in all config files:
#      set the nr. of clients == 'cl_1' 
#      set the port == 3306 
#      set the runtime to what you want

#========== CODE ============

sleep_time=120
#cl_1=10
#cl_2=250
cl_3=250

#----3306----
echo ''
echo '>>> STARTING TESTS FOR TEST SETUP 3306'
echo ''

#ssh -i /root/.ssh/newdijon root@10.0.0.10 'service mysql start'
#ssh -i /root/.ssh/newdijon root@10.0.0.10 'service mysql restart'
#ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker stop bind_mysql'
#ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker stop volume_mysql'
#sleep ${sleep_time}

echo ''
echo ">>> TESTING FOR ${cl_1} CLIENT(s) - 3306"
# no need to termchange here, cause its already (manually) set to 'cl_1' 
#sh _2exectest.sh 3306 ${cl_1} ${1};

echo ''
echo ">>> TESTING FOR ${cl_2} CLIENT(s) - 3306"
#sh _0termchange.sh ${cl_1} ${cl_2};
#sh _2exectest.sh 3306 ${cl_2} ${1};

echo ''
echo ">>> TESTING FOR ${cl_3} CLIENT(s) - 3306"
#sh _0termchange.sh ${cl_2} ${cl_3};
#sh _2exectest.sh 3306 ${cl_3} ${1};


#----6603----
echo ''
echo '>>> STARTING TESTS FOR TEST SETUP 6603'
echo ''
#sh _0portchange.sh 3306 6603;

#sleep ${sleep_time}
#ssh -i /root/.ssh/newdijon root@10.0.0.10 'service mysql stop'
#ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker start bind_mysql'
#ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker stop volume_mysql'
#sleep ${sleep_time}

echo ''
echo ">>> TESTING FOR ${cl_1} CLIENT(s) - 6603"
#sh _0termchange.sh ${cl_3} ${cl_1};
#sh _2exectest.sh 6603 ${cl_1} ${1};

echo ''
echo ">>> TESTING FOR ${cl_2} CLIENT(s) - 6603"
#sh _0termchange.sh ${cl_1} ${cl_2};
#sh _2exectest.sh 6603 ${cl_2} ${1};

echo ''
echo ">>> TESTING FOR ${cl_3} CLIENT(s) - 6603"
#sh _0termchange.sh ${cl_2} ${cl_3};
#sh _2exectest.sh 6603 ${cl_3} ${1};

#----6604----
echo ''
echo ">>> STARTING TESTS FOR TEST SETUP 6604"
echo ''
#sh _0portchange.sh 6603 6604;

#sleep ${sleep_time}
#ssh -i /root/.ssh/newdijon root@10.0.0.10 'service mysql stop'
#ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker stop bind_mysql'
#ssh -i /root/.ssh/newdijon root@10.0.0.10 'docker start volume_mysql'
#sleep ${sleep_time}

echo ''
echo ">>> TESTING FOR ${cl_1} CLIENT(s) - 6604"
#sh _0termchange.sh ${cl_3} ${cl_1};
#sh _2exectest.sh 6604 ${cl_1} ${1};

echo ''
echo ">>> TESTING FOR ${cl_2} CLIENT(s) - 6604"
#sh _0termchange.sh ${cl_1} ${cl_2};
#sh _2exectest.sh 6604 ${cl_2} ${1};

echo ''
echo ">>> TESTING FOR ${cl_3} CLIENT(s) - 6604"
#sh _0termchange.sh ${cl_2} ${cl_3};
#sh _2exectest.sh 6604 ${cl_3} ${1};

echo ''
echo 'JOB FINISHED'
echo ''


#----6605----
#echo ''
echo ">>> STARTING TESTS FOR TEST SETUP 6605"
echo ''
#sh _0portchange.sh 6603 6604;

echo ''
echo ">>> TESTING FOR ${cl_1} CLIENT(s) - 6605"
#sh _0termchange.sh ${cl_3} ${cl_1};
#sh _2exectest.sh 6605 ${cl_1} ${1};

echo ''
echo ">>> TESTING FOR ${cl_2} CLIENT(s) - 6605"
#sh _0termchange.sh ${cl_1} ${cl_2};
#sh _2exectest.sh 6605 ${cl_2} ${1};

echo ''
echo ">>> TESTING FOR ${cl_3} CLIENT(s) - 6605"
#sh _0termchange.sh ${cl_2} ${cl_3};
sh _2exectest.sh 6605 250 ${1};

echo ''
echo 'JOB FINISHED'
echo ''

