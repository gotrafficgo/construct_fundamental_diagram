
import numpy as np
from matplotlib.path import Path


def select_candidate_centers(trajectory_data, given_speed, min_candidates=1000, max_tolerance=5, step=1):
    values = trajectory_data.values
    tolerance_speed = 0
    candidate_centers = np.empty((0, values.shape[1]))

    while tolerance_speed <= max_tolerance:
        selected_rows = np.abs(values[:, trajectory_data.columns['speed']] - given_speed) <= tolerance_speed
        candidate_rows = values[selected_rows, :]
        candidate_centers = candidate_rows[:, [trajectory_data.columns['time'], trajectory_data.columns['position']]]
        num_candidate_centers = candidate_centers.shape[0]
        if num_candidate_centers >= min_candidates:
            break
        tolerance_speed += step

    # Shuffle the order randomly
    if num_candidate_centers > 0:
        random_order = np.random.permutation(num_candidate_centers)
        candidate_centers = candidate_centers[random_order]

    return candidate_centers



def is_outside_all_parallelograms(current_parallelogram, all_parallelogram):
    if not all_parallelogram or len(all_parallelogram) == 0:
        return True

    for parallelogram in all_parallelogram:
        if parallelogram is None:
            continue

        path = Path(parallelogram.corners)
        for j in range(4):
            x, y = current_parallelogram.corners[j, 0], current_parallelogram.corners[j, 1]
            if path.contains_point((x, y)):
                return False  
            
    return True


def match_trajectory_points(parallelogram, trajectory_data):

    # Get coordinates of all points
    all_trajectory_points = trajectory_data.values
    all_xy = all_trajectory_points[:, [trajectory_data.columns['time'], trajectory_data.columns['position']]]

    # Bounding box parameters are directly taken from the parallelogram's properties
    x_min = parallelogram.x_min
    x_max = parallelogram.x_max
    y_min = parallelogram.y_min
    y_max = parallelogram.y_max

    # Preliminary filtering (directly using all_xy)
    box_mask = (all_xy[:, 0] >= x_min) & (all_xy[:, 0] <= x_max) & (all_xy[:, 1] >= y_min) & (all_xy[:, 1] <= y_max)
    box_filtered_points = all_xy[box_mask]
    box_filtered_data = all_trajectory_points[box_mask]

    # Directly use Path to check if points are inside the parallelogram
    polygon_path = Path(parallelogram.corners)
    in_polygon_mask = polygon_path.contains_points(box_filtered_points)
    points_in_parallelogram = box_filtered_data[in_polygon_mask]
    
    # plotting.plot_parallelogram_with_points(parallelogram, box_filtered_data, points_in_parallelogram)

    # Save trajectory points
    if points_in_parallelogram.shape[0] > parallelogram.min_number_of_points:
        parallelogram.trajectory_points = points_in_parallelogram
        parallelogram.trajectory_points_columns = trajectory_data.columns
    else:
        parallelogram = None

    return parallelogram


def get_score_of_parallelogram(parallelogram):
    # parallelogram: object, 'trajectory_points' field is an Nx4 array
    all_speed = parallelogram.trajectory_points[:, parallelogram.trajectory_points_columns['speed']]

    # Metric 1: Coefficient of Variance
    std_speed = np.std(all_speed)
    mean_speed = np.mean(all_speed)
    CV = std_speed / mean_speed if mean_speed != 0 else 0

    # Metric 2: NAE
    epsilon = 1e-3
    numerators = np.abs(all_speed - parallelogram.given_speed)
    denominators = np.maximum.reduce([np.abs(all_speed), np.full_like(all_speed, abs(parallelogram.given_speed)), np.full_like(all_speed, epsilon)])
    NAE = np.mean(numerators / denominators)

    # Metric 3: score
    CV_max = 1
    NAE_max = 1
    CV_norm = CV / CV_max
    NAE_norm = NAE / NAE_max
    SCORE = parallelogram.wCV * CV_norm + parallelogram.wNAE * NAE_norm

    #
    parallelogram.CV = CV
    parallelogram.NAE = NAE
    parallelogram.SCORE = SCORE

    return parallelogram


def select_parallelogram(candidate_parallelograms, number_of_selected_parallelogram):
    # Sort by SCORE in descending order and select the top number_of_selected_parallelogram
    scores = np.array([p.SCORE for p in candidate_parallelograms])
    sorted_idx = np.argsort(-scores) 
    
    topN = min(number_of_selected_parallelogram, len(sorted_idx))
    selected_parallelogram = [candidate_parallelograms[i] for i in sorted_idx[:topN]]
    
    return selected_parallelogram


def calculate_qkv_for_parallelograms(selected_parallelogram):
    # Batch calculation of q, k, v for each parallelogram according to Edie's definition
    for p in selected_parallelogram:

        veh_id_col = p.trajectory_points_columns['veh_id'] 
        veh_ids = p.trajectory_points[:, veh_id_col]
        unique_veh_ids = np.unique(veh_ids)
        num_vehicles = len(unique_veh_ids)  

        total_distance = num_vehicles * p.constant_trajectory_distance
        total_time = num_vehicles * p.constant_trajectory_time

        p.q = 3600 * total_distance / p.area
        p.k = 1000 * total_time / p.area
        p.v_space = p.q / p.k
        p.v_time = 3.6 * np.mean(p.trajectory_points[:, p.trajectory_points_columns['speed']])

    return selected_parallelogram



def is_in_trajectory_range(parallelogram, trajectory_data):
    flag_left   = np.all(trajectory_data.information['time_start'] < parallelogram.corners[:, 0])
    flag_right  = np.all(parallelogram.corners[:, 0] < trajectory_data.information['time_end'])
    flag_bottom = np.all(trajectory_data.information['position_start'] < parallelogram.corners[:, 1])
    flag_top    = np.all(parallelogram.corners[:, 1] < trajectory_data.information['position_end'])

    if not (flag_left and flag_right and flag_bottom and flag_top):
        return False

    return True


def no_overlap_with_any(parallelogram, candidate_parallelograms, selected_parallelograms):    
    flag_no_overlap1 = is_outside_all_parallelograms(parallelogram, candidate_parallelograms)
    flag_no_overlap2 = is_outside_all_parallelograms(parallelogram, selected_parallelograms)

    if not (flag_no_overlap1 and flag_no_overlap2):
        return False

    return True