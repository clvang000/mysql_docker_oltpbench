# mysql_docker_oltpbench
Large Systems SNE 2017 Project

This gitpage contains the scripting code used to run our tests for the
'Comparative Study of Data Storage Options in Containerization' project.
<br>

-The 'OLTPbench_test_framework' folder contains the test framework we used to test the several MySQL setups.

-The 'results' folder contains the test results of running our test framework (several Bash scripts), for different combinations of parameters. 
We always run four setups (native, bind, volume, and container), of which the results are compared. 

-The 'results_interp' folder contains the Python script(s) used to interpret the .res files and the GNUplot code that we wrote to create graphs from the .res files.
