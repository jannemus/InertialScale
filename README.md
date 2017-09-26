# 1. INTRODUCTION

Matlab implementation of the scale estimation method presented in:

Mustaniemi J., Kannala J., Särkkä S., Matas J., Heikkilä J.
"Inertial-Based Scale Estimation for Structure from Motion
on Mobile Devices", International Conference on Intelligent 
Robots and Systems (IROS), 2017

Algorithm recovers the metric scale of the visual reconstruction
given the camera poses and inertial measurements. Temporal and 
spatial alignment of the camera and IMU is also performed in the
process.


# 2. INPUTS

  ## 2.1. Camera poses and timestamps

  Camera poses and timestamps are read from a text file 'poses.txt'.
  Place the file to the folder '/data/dataset_name/poses.txt'. The
  file should have the following format:

  10158706658000 2.3115 -0.7212 2.0553 0.9054 0.4168 -0.0635 -0.0480
		
  10158739989000 2.3282 -0.7229 2.0687 0.9049 0.4180 -0.0631 -0.0482
		
  10158773320000 2.3859 -0.7232 2.0309 0.9027 0.4222 -0.0675 -0.0464

  The first column contains the timestamps in nanoseconds. Columns 2-4
  contain the camera positions (x,y,z). Columns 5-8 contain the
  camera orientations in quaternions (qw,qx,qy,qz).

  ## 2.2. Inertial measurements and timestamps

  Angular velocities and accelerations are read from text files
  'gyroscope.txt' and 'accelerometer.txt'. Place files to the folder 
  '/data/dataset_name/gyroscope.txt', etc. The files should have the 
  following format:

  10158731787661 7.92720 0.53151 4.84108
		
  10158741791911 7.92720 0.49799 4.90811
		
  10158751780744 7.87932 0.49081 4.97755

  The first column contains the timestamps in nanoseconds. Last three
  colums contain the measurements (x,y,z). Units should be [rad/s] and
  [m/s^2]. Note: inertial and visual timestamp sources can be different.

  ## 2.3. Additional

  If the ground truth scale correction factor is known in advance 
  (testing purposes), one can place a text file 'groundtruth.txt' to the 
  folder '/data/dataset_name/groundtruth.txt'. The algorithm will then 
  report the error of the scale estimate in percents. The file should
  have a single line containing the scale factor (e.g. 0.02571850).


# 3. OUTPUTS

  The algorithm will output the estimated scale correction factor,
  gravity vector and bias of the accelerometer. The code will also 
  output the estimated time offset between the camera and IMU (td), 
  as well as the relative rotation between them (R).

