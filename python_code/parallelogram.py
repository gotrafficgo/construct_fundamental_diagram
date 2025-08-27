import numpy as np

class Parallelogram:

    def __init__(self, center_x=0, center_y=0, given_speed=0, parallelograms_settings=None):

        # ========= settings =========
        Lw = parallelograms_settings['Lw']
        H = parallelograms_settings['H']
        wave_speed = parallelograms_settings['wave_speed']
        wCV = parallelograms_settings['wCV']
        wNAE = parallelograms_settings['wNAE']

        # ========= others =========
        self.min_number_of_points = 10

        self.given_speed = given_speed  # km/h

        # Geometric parameters
        self.Lw = Lw  # Long edge length
        self.H = H    # Height
        self.area = Lw * H  # Area
        self.slope_long = - wave_speed / 3.6  # Long edge slope (unit conversion)
        self.slope_short = self.given_speed / 3.6  # Short edge slope

        # Scoring weights
        self.wCV = wCV
        self.wNAE = wNAE

        # Scoring metrics
        self.NAE = None
        self.CV = None
        self.SCORE = None

        # Traffic flow parameters
        self.q = None  # Flow rate veh/h
        self.k = None  # Density veh/km
        self.v_space = None  # Speed km/h
        self.v_time = None  # Speed km/h

        # Calculate the four corner points (preliminary order)
        center = np.array([center_x, center_y])
        self.corners = self._compute_corners(center, self.Lw, self.H, self.slope_long, self.slope_short)

        corner_bottom_right = self.corners[2]
        corner_bottom_left = self.corners[1]        
        self.constant_trajectory_distance = corner_bottom_right[1] - corner_bottom_left[1]
        self.constant_trajectory_time     = corner_bottom_right[0] - corner_bottom_left[0]


    def _compute_corners(self, center, Lw, H, slope_long, slope_short):
        # Given the center point, long edge length, height, and slopes, return the preliminary four corner points (top left, bottom left, bottom right, top right)
        u_w = np.array([1, slope_long])
        u_w = u_w / np.linalg.norm(u_w)
        u_v = np.array([1, slope_short])
        u_v = u_v / np.linalg.norm(u_v)
        sin_theta = abs(u_w[0] * u_v[1] - u_w[1] * u_v[0])
        vec_w = (Lw / 2) * u_w
        vec_v = (H / (2 * sin_theta)) * u_v
        corners = [
            center - vec_w - vec_v,   # Top left (0)
            center + vec_w - vec_v,   # Bottom left (1)                    
            center + vec_w + vec_v,   # Bottom right (2)
            center - vec_w + vec_v,   # Top right (3)
        ]
        return np.array(corners)


    @property
    def x_min(self):
        return np.min(self.corners[:, 0])

    @property
    def x_max(self):
        return np.max(self.corners[:, 0])

    @property
    def y_min(self):
        return np.min(self.corners[:, 1])

    @property
    def y_max(self):
        return np.max(self.corners[:, 1])

    def _sort_corners(self, corners):
        # The leftmost point is the top left corner, the rightmost is the bottom right corner, and the remaining two are assigned based on their y-coordinates.
        idx_left = np.argmin(corners[:, 0])
        idx_right = np.argmax(corners[:, 0])
        left_point = corners[idx_left]
        right_point = corners[idx_right]
        # The remaining two points
        idx_rest = [i for i in range(4) if i not in [idx_left, idx_right]]
        rest_points = corners[idx_rest]
        # Assign by y-coordinate: the point with the larger y is the top right corner, the smaller y is the bottom left corner
        if rest_points[0, 1] > rest_points[1, 1]:
            right_top = rest_points[0]
            left_bottom = rest_points[1]
        else:
            right_top = rest_points[1]
            left_bottom = rest_points[0]
        # Order: top left, bottom right, top right, bottom left
        return np.array([left_point, right_point, right_top, left_bottom])