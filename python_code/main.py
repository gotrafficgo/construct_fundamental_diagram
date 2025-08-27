from traffic_state import TrafficState
from trajectory_data import TrajectoryData
from parallelogram import Parallelogram
import numpy as np
import plotting
import functions


def main_construct_fundamental_diagram():
   
    root = '/Users/hezhengbing-2023/Library/CloudStorage/OneDrive-Personal/Research/Edie/python/'

    # ======= Selecting Dataset ======= 
    ### Zen Traffic
    whichDataset = 'ZenTrafficData'
    whichSite = 'TRJ_11' # 'TRJ_11', 'TRJ_4'
    whichLane = 'Lane1' # 'Lane1', 'Lane2'

    ### CA
    # whichDataset = 'Simulation_CA'
    # whichSite = 'Seed_0' 
    # whichLane = 'VehNum_16' # 'VehNum_16', 'VehNum_20', 'VehNum_80'

    ### NGSIM
    # whichDataset = 'NGSIM'
    # whichSite = 'I80' # 'I80', 'US101'
    # whichLane = '0515pm-0530pm' # '0400pm-0415pm', '0500pm-0515pm', '0515pm-0530pm', '0750am-0805am', '0805am-0820am', '0820am-0830am'
    
    
    # ======= Processing =======     
    FLAG_PLOT = True
    SEARCH_MODE = 'fast'  # 'fast' or 'full'

    np.random.seed(0)

    all_traffic_states_by_file = []
    dataset_information, colors, file_ids = _get_dataset_information(whichDataset, whichSite, whichLane)    

    for idx in range(len(file_ids)):        
        print()
        trajectory_data = TrajectoryData(root, dataset_information, file_ids[idx])
        all_traffic_states = _get_traffic_state(trajectory_data, search_mode=SEARCH_MODE, FLAG_PLOT=FLAG_PLOT) # search_mode = 'fast' or 'full'
        all_traffic_states_by_file.append(all_traffic_states)

        plotting.plot_trajectories_parallelograms(trajectory_data, all_traffic_states, FLAG_PLOT)

    plotting.plot_fundamental_diagram(all_traffic_states_by_file, colors, file_ids)






def _get_dataset_information(whichDataset, whichSite=None, whichLane=None):
    if whichDataset == 'ZenTrafficData':        
        colors = ['r', 'g', 'b', 'c', 'm']
        file_ids = ['F001', 'F002', 'F003', 'F004', 'F005']        
        dataset_information = {
            'dataset': whichDataset,
            'site': whichSite,
            'lane': whichLane,
            'time_start': 1,
            'time_end': 3500,
            'max_color_bar': 90,
            'max_speed': 90
        }
    
    if whichDataset == 'NGSIM':        
        colors = ['r', 'g', 'b', 'c', 'm', 'k']
        file_ids = ['Lane1', 'Lane2', 'Lane3', 'Lane4', 'Lane5', 'Lane6']        
        dataset_information = {
            'dataset': whichDataset,
            'site': whichSite,
            'lane': whichLane,
            'time_start': 1,
            'time_end': 900,
            'max_color_bar': 60,
            'max_speed': 60
        }

    if whichDataset == 'Simulation_CA':
        colors = ['r', 'g', 'b']
        file_ids = ['Lane1', 'Lane2', 'Lane3']
        dataset_information = {
            'dataset': whichDataset,
            'site': whichSite,
            'lane': whichLane,
            'time_start': 1,
            'time_end': 1000,
            'max_color_bar': 90,
            'max_speed': 90
        }

    return dataset_information, colors, file_ids





def _get_traffic_state(trajectory_data, search_mode = 'fast', FLAG_PLOT = False):

    number_selected_parallelogram = 10

    # Plot trajectory diagram
    plotting.plot_trajectories(trajectory_data, FLAG_PLOT)

    all_selected_parallelograms = []
    all_traffic_states = []

    for given_speed in range(0, int(trajectory_data.information['max_speed'])+1, 5):

        # Select candidate centers
        candidate_centers = functions.select_candidate_centers(trajectory_data, given_speed)
        if search_mode == 'fast':
            # Randomly select 100 center points
            num_centers = candidate_centers.shape[0]
            if num_centers > 200:
                idx = np.random.choice(num_centers, 200, replace=False)
                candidate_centers = candidate_centers[idx]

        if num_centers == 0:
            print(f'    given_speed={given_speed}:  No candidate centers found')
            continue

        # Get all candidate parallelograms
        candidate_parallelograms = []        
        for center in candidate_centers:

            p = Parallelogram(center_x=center[0], center_y=center[1], 
                              given_speed=given_speed, parallelograms_settings=trajectory_data.parallelograms_settings)

            # Condition 1: parallelogram is within trajectory range
            if functions.is_in_trajectory_range(p, trajectory_data):

                # Condition 2: Does not overlap with any existing parallelogram
                if functions.no_overlap_with_any(p, candidate_parallelograms, all_selected_parallelograms):

                    a_candidate_parallelogram = functions.match_trajectory_points(p, trajectory_data)
                    if a_candidate_parallelogram is not None:
                        a_candidate_parallelogram = functions.get_score_of_parallelogram(a_candidate_parallelogram)
                        candidate_parallelograms.append(a_candidate_parallelogram)

        if len(candidate_parallelograms) == 0:
            print(f'    given_speed={given_speed}:  No candidate parallelograms found')
            continue


        # Select the topN parallelograms with the lowest score
        selected_parallelograms = functions.select_parallelogram(candidate_parallelograms, number_selected_parallelogram)

        # Calculate q, k, v_space, v_time for each parallelogram according to Edie's definition
        selected_parallelograms = functions.calculate_qkv_for_parallelograms(selected_parallelograms)

        # Add the selected parallelograms to the list of all parallelograms
        all_selected_parallelograms.extend(selected_parallelograms)

        # Calculate the mean values of q, k, v for each parallelogram in selected_parallelograms
        mean_q = np.mean([p.q for p in selected_parallelograms])
        mean_k = np.mean([p.k for p in selected_parallelograms])
        mean_v_space = np.mean([p.v_space for p in selected_parallelograms])
        mean_v_time = np.mean([p.v_time for p in selected_parallelograms])
        print(f"    given_speed={given_speed} ({len(candidate_parallelograms)}->{len(selected_parallelograms)}):  q={int(mean_q)}, k={int(mean_k)}, v={int(mean_v_space)}")


        ts = TrafficState(given_speed, mean_q, mean_k, mean_v_space, mean_v_time, selected_parallelograms)
        all_traffic_states.append(ts)


    return all_traffic_states





if __name__ == "__main__":
    main_construct_fundamental_diagram()
