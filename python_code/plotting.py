import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np

def plot_parallelogram_with_points(parallelogram, box_filtered_data, points_in_parallelogram, plot_or_not = True):

    if plot_or_not == False:
        return None

    fig, ax = plt.subplots(figsize=(8, 8))

    # Draw the four corners and connecting lines of the parallelogram
    corners = parallelogram.corners
    order = [0, 1, 2, 3, 0]
    poly = corners[order]
    ax.plot(poly[:, 0], poly[:, 1], 'b-', lw=2, label='Parallelogram')
    for i, pt in enumerate(corners):
        ax.plot(pt[0], pt[1], 'ro')
        ax.text(pt[0], pt[1], f'Corner {i}\n({pt[0]:.1f}, {pt[1]:.1f})', fontsize=9, color='black', ha='left', va='bottom')

    # Draw the bounding box (AABB)
    x_min, x_max = parallelogram.x_min, parallelogram.x_max
    y_min, y_max = parallelogram.y_min, parallelogram.y_max
    rect_x = [x_min, x_max, x_max, x_min, x_min]
    rect_y = [y_min, y_min, y_max, y_max, y_min]
    ax.plot(rect_x, rect_y, 'g--', lw=2, label='Bounding Box')

    # Plot all coarse filtered points
    if box_filtered_data is not None and box_filtered_data.shape[0] > 0:
        ax.scatter(box_filtered_data[:, 1], box_filtered_data[:, 2], s=10, c='gray', label='Box Filtered', alpha=0.5)

    # Plot the points that finally fall inside the parallelogram
    if points_in_parallelogram is not None and points_in_parallelogram.shape[0] > 0:
        ax.scatter(points_in_parallelogram[:, 1], points_in_parallelogram[:, 2], s=20, c='red', label='In Parallelogram', alpha=0.8)

    ax.set_xlim(x_min-10, x_max+10)
    ax.set_ylim(y_min-10, y_max+10)
    ax.set_xlabel('Time')
    ax.set_ylabel('Position')
    ax.legend()
    ax.set_title('Parallelogram & Points Visualization')
    plt.show()
    return fig


def plot_trajectories(trajectory_data, plot_or_not = False):

    if plot_or_not == False:
        return None

    fig, ax = plt.subplots(figsize=(15, 5))
    # trajectory_data: n×4, column 2 is time, column 3 is position, column 4 is speed
    sc = ax.scatter(trajectory_data.values[:, trajectory_data.columns['time']], trajectory_data.values[:, trajectory_data.columns['position']], 
                    s=10, c=trajectory_data.values[:, trajectory_data.columns['speed']], cmap=plt.cm.jet_r)
    sc.set_clim(0, trajectory_data.information['max_color_bar'])

    # Adjust the colorbar to a narrower area, making the main plot larger
    from mpl_toolkits.axes_grid1 import make_axes_locatable
    divider = make_axes_locatable(ax)
    cax = divider.append_axes('right', size='1.2%', pad=0.05)
    cb = plt.colorbar(sc, cax=cax)
    cb.ax.tick_params(labelsize=10)

    ax.set_xlim([trajectory_data.information['time_start'], trajectory_data.information['time_end']])
    ax.set_ylim([trajectory_data.information['position_start'], trajectory_data.information['position_end']])
    ax.set_xlabel('Time (s)', fontsize=12)
    ax.set_ylabel('Position (m)', fontsize=12)
    ax.tick_params(labelsize=10)
    ax.set_box_aspect(0.33)  # 1500/500

    plt.box(True)
    plt.show()
    
    return fig


def plot_trajectories_parallelograms(trajectory_data, all_traffic_states, plot_or_not = None):

    if plot_or_not == False:
        return None

    fig, ax = plt.subplots(figsize=(15, 5))
    # Plot all trajectory points
    ax.scatter(trajectory_data.values[:, trajectory_data.columns['time']],
               trajectory_data.values[:, trajectory_data.columns['position']],
               s=1, c='gray', alpha=0.5, label='Trajectories')

    # Draw the borders of each group of parallelograms
    colors = cm.rainbow(np.linspace(0, 1, len(all_traffic_states)))
    for idx, ts in enumerate(all_traffic_states):
        color = colors[idx % len(colors)]
        for p in ts.all_parallelograms:
            corners = p.corners
            order = [0, 1, 2, 3, 0]
            poly = corners[order]
            ax.plot(poly[:, 0], poly[:, 1], '-', lw=1, color=color, alpha=0.7)
    
    ax.set_xlim([trajectory_data.information['time_start'], trajectory_data.information['time_end']])
    ax.set_ylim([trajectory_data.information['position_start'], trajectory_data.information['position_end']])
    ax.set_xlabel('Time (s)', fontsize=12)
    ax.set_ylabel('Position (m)', fontsize=12)
    plt.show()
    return fig


def plot_fundamental_diagram(all_traffic_states_by_file, colors, file_ids):
    
    fig, ax = plt.subplots(figsize=(8, 6))

    for i, all_traffic_states in enumerate(all_traffic_states_by_file):
        k_list = [ts.state_k for ts in all_traffic_states]
        q_list = [ts.state_q for ts in all_traffic_states]
        ax.plot(k_list, q_list, marker='o', linestyle='-', color=colors[i], label=file_ids[i])
    
    ax.set_xlabel('Density K (veh/km)', fontsize=14)
    ax.set_ylabel('Flow Q (veh/h)', fontsize=14)
    ax.set_title('Fundamental Diagram (Q-K)', fontsize=16)
    ax.legend()
    ax.grid(True)
    
    plt.show()
    return fig









