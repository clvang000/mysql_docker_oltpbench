from subprocess import check_output

client_list = []
benchmark_list = []
scale_list = []

full_dict = {}
# for each comparison, has a list of averages containing both throughput and latency

all_rankings_list = []
# for each comparison, contains a list with 0,1,2,3 in a certain order, to indicate which setup did the best


''' FUNCTIONS '''


def get_thr_and_lat_averages_list(fn_n, fn_b, fn_v, fn_c):
    n_lines = open(fn_n, 'r').read().splitlines()[1::]
    b_lines = open(fn_b, 'r').read().splitlines()[1::]
    v_lines = open(fn_v, 'r').read().splitlines()[1::]
    c_lines = open(fn_c, 'r').read().splitlines()[1::]

    avg_list = []
    res_lines_list = [n_lines, b_lines, v_lines, c_lines]
    for res_lines in res_lines_list:
        if res_lines[-1].split(',')[0] == duration[2::]:
            del res_lines[-1]
        avg_thr = calc_average(res_lines, 1)
        avg_lat = calc_average(res_lines, 2)
        avg_list.append(avg_thr)
        avg_list.append(avg_lat)

    return avg_list


def calc_average(lines, index):
    total_sum = 0.0
    for line in lines:
        split_line = line.split(',')
        total_sum += float(split_line[index])
    return total_sum / len(lines)


def get_thr_lists(comparison):
    thr_list = []
    result_list = []
    counter = 0

    for avg in full_dict[comparison]:
        if counter % 2 == 0:
            thr_list.append(avg)
        counter += 1

    sorted_thr_list = sorted(thr_list)
    result_list.append(thr_list)
    result_list.append(sorted_thr_list)
    return result_list


def get_lat_lists(comparison):
    lat_list = []
    result_list = []
    counter = 0

    for avg in full_dict[comparison]:
        if counter % 2 != 0:
            lat_list.append(avg)
        counter += 1

    sorted_lat_list = sorted(lat_list, reverse=True)
    result_list.append(lat_list)
    result_list.append(sorted_lat_list)
    return result_list


def get_ranking_list(input_list):
    ranking_list = []
    for sorted_item in input_list[1]:
        counter = 0
        for setup_index in input_list[0]:
            if sorted_item == setup_index:
                ranking_list.append(counter)
            counter += 1
    all_rankings_list.append(ranking_list)
    return ranking_list


def get_nr_of_results(position_x, setup):
    result = 0
    for ranking in all_rankings_list:
        if ranking[position_x] == setup:
            result += 1

    return result


'''PROGRAM '''


raw_output = check_output('ls -l ./res/', shell=True)
output_list = raw_output.strip().splitlines()[1:]
all_files = []
for ls_line in output_list:
    all_files.append(ls_line.split()[-1])


for input_file in all_files:
    split_input_file = input_file.split('_')
    benchmark = split_input_file[0]
    scale_factor = split_input_file[2]
    nr_of_clients = split_input_file[3]
    duration = split_input_file[4].split('.')[0]

    if benchmark not in benchmark_list:
        benchmark_list.append(benchmark)
    if scale_factor not in scale_list:
        scale_list.append(scale_factor)
    if nr_of_clients not in client_list:
        client_list.append(nr_of_clients)


for nr_of_clients in client_list:
    for scale_factor in scale_list:
        for benchmark in benchmark_list:
            fn_n = './res/' + benchmark + '_3306_' + scale_factor + '_' + nr_of_clients + '_' + duration + '.res'
            fn_b = './res/' + benchmark + '_6603_' + scale_factor + '_' + nr_of_clients + '_' + duration + '.res'
            fn_v = './res/' + benchmark + '_6604_' + scale_factor + '_' + nr_of_clients + '_' + duration + '.res'
            fn_c = './res/' + benchmark + '_6605_' + scale_factor + '_' + nr_of_clients + '_' + duration + '.res'
            averages_list = get_thr_and_lat_averages_list(fn_n, fn_b, fn_v, fn_c)
            comparison = benchmark + '_' + scale_factor + '_' + nr_of_clients + '_' + duration
            full_dict[comparison] = averages_list


# 0 = native, 1 = bind, 2 = volume, 3 = container (in thr_list[0] and lat_list[0])
nr_of_comparisons = 1
for comparison in full_dict:
    thr_list = get_thr_lists(comparison)
    lat_list = get_lat_lists(comparison)

    thr_ranked_list = get_ranking_list(thr_list)
    lat_ranked_list = get_ranking_list(lat_list)
    print(nr_of_comparisons)
    print(comparison)
    print('Throughput:')
    print(thr_list[0])
    print(thr_list[1])
    print(thr_ranked_list)
    print('Latency:')
    print(lat_list[0])
    print(lat_list[1])
    print(lat_ranked_list)
    print('')
    nr_of_comparisons += 1

print('')
print(all_rankings_list)


ranking_dict = {0: 'native', 1: 'bind', 2: 'volume', 3: 'container'}
for setup in [0, 1, 2, 3]:
    print('')
    print(ranking_dict[setup])
    for position in [0, 1, 2, 3]:
        print('nr of ' + str(position + 1) + ' positions: ' + str(get_nr_of_results(position, setup)))


