import os
import numpy as np
import pandas as pd


class TrajectoryData:

    def __init__(self, root, dataset_information, whichData=None):

        self.information = dataset_information.copy()

        whichDataset = self.information["dataset"]
        whichSite = self.information["site"]
        whichLane = self.information["lane"]

        print(f'===== Loading trajectory data: {whichDataset}, {whichSite}, {whichLane}, {whichData} ===== ')
        
        self.root = root
        self.file_path = os.path.join(root, 'trajectory_data', whichDataset, whichSite, whichLane, f'{whichData}.csv')
        self.values = pd.read_csv(self.file_path).values

        self.columns = {
            'veh_id': 0,
            'time': 1,
            'position': 2,
            'speed': 3
        }

        # ========== Parallelogram setting ==========
        self.parallelograms_settings = {
            'Lw': 100,
            'H': 5,
            'wCV': 0.5,
            'wNAE': 0.5
        }


        # ========== Dataset setting ==========
        if whichDataset == 'ZenTrafficData':            
            offset_time_start = 0
            offset_time_end = 400
            offset_position_start = 0
            offset_position_end = 0
            self.parallelograms_settings.update({
                'wave_speed': 15
            })

        elif whichDataset == 'NGSIM':
            offset_time_start = 100
            offset_time_end = 100
            offset_position_start = 20
            offset_position_end = 50
            self.parallelograms_settings.update({
                'wave_speed': 16
            })

        elif whichDataset == 'CA':
            offset_time_start = 100
            offset_time_end = 0
            offset_position_start = 0
            offset_position_end = 0
            self.parallelograms_settings.update({
                'wave_speed': 13
            })

        self.information.update({
            'data': whichData,
            'time_start': int(np.min(self.values[:, self.columns['time']])) + offset_time_start,
            'time_end':   int(np.max(self.values[:, self.columns['time']])) - offset_time_end,
            'position_start': int(np.min(self.values[:, self.columns['position']])) + offset_position_start,
            'position_end':   int(np.max(self.values[:, self.columns['position']])) - offset_position_end,
        })


        

