
work_runtime = 10
rate_increase = 25
current_rate = rate_increase
total_test_time = 600
nr_of_iterations = total_test_time / work_runtime

for iteration in range(nr_of_iterations):
  current_rate = (iteration + 1) * rate_increase
  work_section = "        <work>\n" + "          <time>10</time>\n" + "          <rate>" + str(current_rate)+ "</rate>\n" \
		  + "          <weights>45,43,4,4,4</weights>\n" + "        </work>"
  print(work_section)

#print(work_section)
#print(nr_of_iterations)
