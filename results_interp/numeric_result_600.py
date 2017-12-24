# coding=utf-8

import sys
import re

file_path = sys.argv[1]

input_file = open(file_path).read().splitlines()

all_avg_thr_sorted = []
all_avg_lat_sorted = []
all_avg_thr_ranked_formatted = []
all_avg_lat_ranked_formatted = []

for line in input_file:
    if 'Avg_thr_sorted' in line:
        all_avg_thr_sorted.append(line.split('\t\t')[1][1:-1:])
    if 'Avg_lat_sorted' in line:
        all_avg_lat_sorted.append(line.split('\t\t')[1][1:-1:])
    if 'Avg_thr_ranked_formatted' in line:
        all_avg_thr_ranked_formatted.append(line.split('\t')[1][1:-1:])
    if 'Avg_lat_ranked_formatted' in line:
        all_avg_lat_ranked_formatted.append(line.split('\t')[1][1:-1:])

new_all_avg_thr_ranked_formatted = []
new_all_avg_lat_ranked_formatted = []

for podium_list in all_avg_thr_ranked_formatted:
    new_all_avg_thr_ranked_formatted.append(podium_list.replace("'", ""))

for podium_list in all_avg_lat_ranked_formatted:
    new_all_avg_lat_ranked_formatted.append(podium_list.replace("'", ""))

print('')
print(new_all_avg_thr_ranked_formatted)
print('')
print(all_avg_thr_sorted)
print('')
# print(new_all_avg_lat_ranked_formatted)
# print('')
# print(all_avg_lat_sorted)
# print('')

list_of_dicts_for_thr = []
for i in list(range(0, len(all_avg_thr_sorted))):
    this_dict = {}
    temp_numbers_list = all_avg_thr_sorted[i].split(', ')
    temp_ranking_list = new_all_avg_thr_ranked_formatted[i].split(', ')
    native_index = temp_ranking_list.index('native')
    for j in [0, 1, 2, 3]:
        if j == native_index:
            continue
        result = float(temp_numbers_list[j]) / float(temp_numbers_list[native_index])
        this_dict[temp_ranking_list[j]] = result
    list_of_dicts_for_thr.append(this_dict)

list_of_dicts_for_lat = []
for i in list(range(0, len(all_avg_lat_sorted))):
    this_dict = {}
    temp_numbers_list = all_avg_lat_sorted[i].split(', ')
    temp_ranking_list = new_all_avg_lat_ranked_formatted[i].split(', ')
    native_index = temp_ranking_list.index('native')
    for j in [0, 1, 2, 3]:
        if j == native_index:
            continue
        result = float(temp_numbers_list[j]) / float(temp_numbers_list[native_index])
        this_dict[temp_ranking_list[j]] = result
    list_of_dicts_for_lat.append(this_dict)


print('')
counter = 0
for element in list_of_dicts_for_thr:
    print(str(counter) + ' ' + str(element))
    counter += 1

print('')
counter = 0
for element in list_of_dicts_for_lat:
    print(str(counter) + ' ' + str(element))
    counter += 1
print('')

new_list_of_dicts_for_thr = []
new_list_of_dicts_for_lat = []
# to remove the abominations (11, 17, 18)
abominations = [11,17,18]
for i in list(range(0, len(list_of_dicts_for_thr))):
    if i in abominations:
        continue
    new_list_of_dicts_for_thr.append(list_of_dicts_for_thr[i])
    new_list_of_dicts_for_lat.append(list_of_dicts_for_lat[i])


print('')
counter = 0
for element in new_list_of_dicts_for_thr:
    print(str(counter) + ' ' + str(element))
    counter += 1

print('')
counter = 0
for element in new_list_of_dicts_for_lat:
    print(str(counter) + ' ' + str(element))
    counter += 1


def calc_average(list_of_dicts, which_setup):
    total_sum = 0.0
    for element in list_of_dicts:
        total_sum += element[which_setup]
    return total_sum / len(list_of_dicts)


average_thr_bind = calc_average(new_list_of_dicts_for_thr, 'bind')
average_thr_volume = calc_average(new_list_of_dicts_for_thr, 'volume')
average_thr_container = calc_average(new_list_of_dicts_for_thr, 'container')

print('')
print('Throughput')
print('bind ' + str(average_thr_bind))
print('volume ' + str(average_thr_volume))
print('container ' + str(average_thr_container))
print('')

average_lat_bind = calc_average(new_list_of_dicts_for_lat, 'bind')
average_lat_volume = calc_average(new_list_of_dicts_for_lat, 'volume')
average_lat_container = calc_average(new_list_of_dicts_for_lat, 'container')

print('Latency')
print('bind ' + str(average_lat_bind))
print('volume ' + str(average_lat_volume))
print('container ' + str(average_lat_container))
print('')

