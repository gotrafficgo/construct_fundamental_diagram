class TrafficState:

    def __init__(self, given_speed, Q, K, V_space, V_time, all_parallelograms):

        self.given_speed = given_speed

        self.all_parallelograms = all_parallelograms

        self.state_q = Q
        self.state_k = K
        self.state_v_space = V_space
        self.state_v_time = V_time


