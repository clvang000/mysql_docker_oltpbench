import subprocess
import sys

abs_path = sys.argv[1]


''' FUNCTIONS '''


def detect_test_setup(split_filename):
    global benchmark_list, scale_list, client_list
    benchmark = split_filename[0]
    scale_factor = split_filename[2]
    nr_of_clients = split_filename[3]

    if benchmark not in benchmark_list:
        benchmark_list.append(benchmark)
    if scale_factor not in scale_list:
        scale_list.append(scale_factor)
    if nr_of_clients not in client_list:
        client_list.append(nr_of_clients)


def calc_and_store_avgthr_avglat(nr_of_clients, scale_factor, benchmark):
    global cmp_avgthr_avglat_dict, duration
    cmp_name = benchmark + '_' + scale_factor + '_' + nr_of_clients + '_' + duration
    fn_native = abs_path + benchmark + '_3306_' + scale_factor + '_' + nr_of_clients + '_' + duration + '.res'
    fn_bind = abs_path + benchmark + '_6603_' + scale_factor + '_' + nr_of_clients + '_' + duration + '.res'
    fn_volume = abs_path + benchmark + '_6604_' + scale_factor + '_' + nr_of_clients + '_' + duration + '.res'
    fn_container = abs_path + benchmark + '_6605_' + scale_factor + '_' + nr_of_clients + '_' + duration + '.res'

    avgthr_avglat_lists = get_avgthr_avglat_lists(fn_native, fn_bind, fn_volume, fn_container)
    cmp_avgthr_avglat_dict[cmp_name] = avgthr_avglat_lists


def get_avgthr_avglat_lists(fn_n, fn_b, fn_v, fn_c):
    result_list = []
    n_lines = open(fn_n).read().splitlines()[1::]
    b_lines = open(fn_b).read().splitlines()[1::]
    v_lines = open(fn_v).read().splitlines()[1::]
    c_lines = open(fn_c).read().splitlines()[1::]
    lines_list = [n_lines, b_lines, v_lines, c_lines]

    avg_thr_list = []
    avg_lat_list = []
    for lines in lines_list:
        if lines[-1].split(',')[0] == duration[2::]:
            del lines[-1]
        avg_thr_list.append(calc_average(lines, 1))
        avg_lat_list.append(calc_average(lines, 2))
    result_list.append(avg_thr_list)
    result_list.append(avg_lat_list)
    return result_list


def calc_average(lines, index):
    total_sum = 0.0
    for line in lines:
        split_line = line.split(',')
        total_sum += float(split_line[index])
    return total_sum / len(lines)


def single_setup__process_and_print_results(cmp, nr_of_comparisons):
    global all_thr_formatted, all_lat_formatted
    avgthr_list = cmp_avgthr_avglat_dict[cmp][0]  # 0 = native, 1 = bind, 2 = volume, 3 = container
    avglat_list = cmp_avgthr_avglat_dict[cmp][1]
    sorted_avgthr_list = sorted(avgthr_list, reverse=True)
    sorted_avglat_list = sorted(avglat_list)
    avgthr_ranked = get_ranked_avg_list(avgthr_list, sorted_avgthr_list)
    avglat_ranked = get_ranked_avg_list(avglat_list, sorted_avglat_list)
    avgthr_ranked_formatted = create_formatted_ranked_list(avgthr_ranked)
    avglat_ranked_formatted = create_formatted_ranked_list(avglat_ranked)

    all_thr_formatted.append(avgthr_ranked_formatted)
    all_lat_formatted.append(avglat_ranked_formatted)

    print('(' + str(nr_of_comparisons) + ') ' + cmp)
    print('Avg_thr: \t\t\t' + str(avgthr_list))
    print('Avg_thr_sorted: \t\t' + str(sorted_avgthr_list))
    print('Avg_thr_ranked: \t\t' + str(avgthr_ranked))
    print('Avg_thr_ranked_formatted: \t' + str(avgthr_ranked_formatted))
    print('Avg_lat: \t\t\t' + str(avglat_list))
    print('Avg_lat_sorted: \t\t' + str(sorted_avglat_list))
    print('Avg_lat_ranked: \t\t' + str(avglat_ranked))
    print('Avg_lat_ranked_formatted: \t' + str(avglat_ranked_formatted))


def get_ranked_avg_list(avg_list, sorted_avg_list):
    ranked_list = []
    for sorted_avg in sorted_avg_list:
        counter = 0
        for avg in avg_list:
            if sorted_avg == avg:
                ranked_list.append(counter)
                break
            counter += 1
    return ranked_list


def create_formatted_ranked_list(ranking_list):
    result_list = []
    index_dict = {0: 'native', 1: 'bind', 2: 'volume', 3: 'container'}
    for rank in ranking_list:
        result_list.append(index_dict[rank])
    return result_list


def print_final_statistics():
    # all_thr_formatted, all_lat_formatted
    print('')
    print('FINAL STATISTICS over ' + str(int(nr_of_test_setups)) + ' test setups')
    print('--------------')
    print_podium_list('native')
    print_podium_list('bind')
    print_podium_list('volume')
    print_podium_list('container')


def print_podium_list(docker_setup):
    print(docker_setup + ': ')
    for podium_spot in [1, 2, 3, 4]:
        nr_of_times_achieved = get_nr_of_times_on_this_spot(podium_spot - 1, docker_setup, all_thr_formatted)
        print('thr_' + str(podium_spot) + ': \t' + str(nr_of_times_achieved))  # / nr_of_test_setups
    for podium_spot in [1, 2, 3, 4]:
        nr_of_times_achieved = get_nr_of_times_on_this_spot(podium_spot - 1, docker_setup, all_lat_formatted)
        print('lat_' + str(podium_spot) + ': \t' + str(nr_of_times_achieved))  # / nr_of_test_setups
    print('--------------')


def get_nr_of_times_on_this_spot(index_to_check, docker_setup, formatted_list):
    result = 0
    for formatted in formatted_list:
        if formatted[index_to_check] == docker_setup:
            result += 1
    return result


'''PROGRAM '''


raw_output = subprocess.check_output('ls -l ' + abs_path, shell=True)
formatted_ls_output = raw_output.strip().splitlines()[1:]
all_filenames = []

# make a list of all filenames
for ls_line in formatted_ls_output:
    all_filenames.append(ls_line.split()[-1])

# extract the parameters to use later (from the filenames)
client_list = []
benchmark_list = []
scale_list = []
duration = None
nr_of_test_setups = 0.0
for filename in all_filenames:
    split_filename = filename.split('_')
    detect_test_setup(split_filename)
    duration = split_filename[4].split('.')[0]

# fill up the dictionary with results
cmp_avgthr_avglat_dict = {}
for nr_of_clients in client_list:
    for scale_factor in scale_list:
        for benchmark in benchmark_list:
            calc_and_store_avgthr_avglat(nr_of_clients, scale_factor, benchmark)
            nr_of_test_setups += 1


# process data and print results for each setup
nr_of_comparisons = 1
all_thr_formatted = []
all_lat_formatted = []
for cmp in cmp_avgthr_avglat_dict:
    single_setup__process_and_print_results(cmp, nr_of_comparisons)
    nr_of_comparisons += 1
    print('')

print_final_statistics()
print('')

