# Single-actuator-torque-control
# 介绍 introduce
欢迎使用由鑫拓公司研发的关节执行器,这里将介绍识别和消除执行器的摩擦力矩，获取电流与输出力矩的转换系数的方法，从而实现关节执行器在连接不同质量的负载的情况下，能够有效识别并抵消执行器的摩擦和负载重量的功能，实现执行器的轻松旋转的功能。  
Welcome to use the joint actuator developed by Xintuo Company. Here we will introduce the method of identifying and eliminating the friction torque of the actuator and obtaining the conversion coefficient of current and output torque, so as to realize the joint actuator when connecting loads of different masses. It can effectively identify and offset the friction and load weight of the actuator and realize the easy rotation of the actuator.
# 依赖项 Dependencies
[ROS](https://www.ros.org/) noetic or other Version(not tested yet)  
[Eigen](https://eigen.tuxfamily.org/index.php?title=Main_Page)  
# 构建 Build
install Eigen:
```bash
git clone https://gitlab.com/libeigen/eigen.git
sudo cp -r ./eigen/Eigen /usr/include/
sudo apt update
sudo apt install libeigen3-dev
```
install pyyaml:
```bash
sudo pip install pyyaml
```
install serial:
```bash
sudo apt install ros-noetic-serial
```
# 使用介绍 Instructions
1. single_actuator包中包含3个功能，可以在install/share/single_actuator/config/single_actuator.yaml中查看，
其中speed_riction_detection功能是收集执行器在不同速度下的电流数据，利用这些数据，使用install/lib/single_actuator/speed_friction_fitting文件拟合可以得出执行器克服摩擦的电流（简称摩擦电流）与速度的关系；  
The single_actuator package contains 3 functions, which can be viewed in install/share/single_actuator/config/single_actuator.yaml.The speed_riction_detection function collects the current data of the actuator at different speeds. Using these data, the install/lib/single_actuator/speed_friction_fitting file is used to fit the relationship between the current (friction current for short) and speed of the actuator to overcome friction;  
2. torque_friction_detection功能则需要给执行器加上较大重量的负载，而后收集执行器在不同扭矩的情况下摩擦电流变化，利用torque_friction_fitting文件拟合得到摩擦电流与输出力矩的关系。  
The torque_friction_detection function requires adding a heavy load to the actuator, and then collecting the changes in friction current of the actuator under different torques, and using the torque_friction_fitting file to fit the relationship between friction current and output torque.  
3. torque_identification功能则是验证摩擦参数的最终结果，根据实际情况在较小幅度上更改摩擦参数。  
The torque_identification function verifies the final result of the friction parameters and changes the friction parameters to a smaller extent according to the actual situation.
## 步骤 step：
### 功能1 Feature 1
1. 在上位机中修改执行器的默认参数，将默认加减速度更改为6000，默认电流10000mA。  
Use the host computer to modify the default parameters of the actuator, change the default acceleration and deceleration to 6000 and the default current to 10000mA.  
2. 将single_actuator.yaml文件的feature参数改为speed_riction_detection并根据注释设置好该文件的其他参数，而后运行install/share/single_actuator/launch/torque_control.launch文件：  
Change the feature parameter of the single_actuator.yaml file to speed_riction_detection and set the other parameters of the file according to the comments, and then run the install/share/single_actuator/launch/torque_control.launch file:  
```bash
cd your_path/install
source ./setup.bash
roslaunch single_actuator torque_control.launch
```
需要注意的是，如果record_path路径不存在，则无法生成记录数据的csv文件；此时执行器输出法兰中不能装配任何物品，否则将导致测试结果偏大。  
It should be noted that if the record_path path does not exist, the csv file for recording data cannot be generated; at this time, nothing can be assembled in the actuator output flange, otherwise the test result will be too large.
3. 完成该功能需要10分钟左右，在执行器收集完数据并停止转动后，关闭程序，配置好speed_friction_fitting.yaml文件并运行：  
It takes about 10 minutes to complete this function. After the actuator has collected data and stopped rotating, close the program, configure the speed_friction_fitting.yaml file and run:  
```bash
chmod +x ./lib/single_actuator/speed_friction_fitting
./lib/single_actuator/speed_friction_fitting
```
该文件将会输出执行器的7个关于速度的摩擦参数，将这些数值填入single_actuator.yaml文件的Frict_param参数中  
This file will output the 7 friction parameters of the actuator related to speed, and fill these values ​​into the Frict_param parameter of the single_actuator.yaml file
### 功能2 Feature 2
1. 给执行器加上较大重量的配重，如图所示：  
Add a heavy weight to the actuator, as shown in the figure:  
![配重安装示意图](image1.png)  
修改执行器的零点偏置，零点应该位于连接杆竖直向下的方向；配重的整体重心应该位于连接杆上
2. 将feature参数改为torque_friction_detection并再次运行torque_control.launch文件：  
Change the feature parameter to torque_friction_detection and run the torque_control.launch file again:  
```bash
roslaunch single_actuator torque_control.launch
```
3. 该功能将运行3分钟左右，在执行器停止后关闭程序，计算添加的配重（包括连接杆）理论上的力矩值,配置好torque_friction_fitting.yaml文件，其中target_values默认不需要更改，tor_values的值分别为0，最大力矩的1/9,2/9,...,9/9  
This function will run for about 3 minutes. After the actuator stops, close the program and calculate the theoretical torque value of the added load (including the connecting rod). Configure the torque_friction_fitting.yaml file. The target_values ​​do not need to be changed by default. The values ​​of tor_values ​​are 0, 1/9, 2/9, ..., 9/9 of the maximum torque.  
4. 运行 run：
```bash
chmod +x ./lib/single_actuator/torque_friction_fitting
./lib/single_actuator/torque_friction_fitting
```
该文件将输出摩擦力与输出力矩的关系参数，其中参数分为旋转方向与输出力矩方向相同（助力）和相反（阻力）两个部分，各两个参数，将这些数值分别填入single_actuator.yaml文件的frict_param_assist和frict_param_resistance参数中。  
his file outputs the relationship parameters between the output friction force and the output torque. The parameters are divided into two parts: the rotation direction is the same as the output torque direction (assistance) and the opposite (resistance), with two parameters in each part. These values ​​are filled in the frict_param_assist and frict_param_resistance parameters of the single_actuator.yaml file respectively.  
### 功能3 Feature 3
1. 将feature参数改为torque_identification并再次运行torque_control.launch文件：  
Change the feature parameter to torque_identification and run the torque_control.launch file again:  
```bash
roslaunch single_actuator torque_control.launch
```
2. 配重将被转到水平方向进行力矩识别，将添加的配重理论上的力矩值除以识别输出的电流值得到cur_tor_fastor参数值。  
The counterweight will be turned to the horizontal direction for torque identification, and the cur_tor_fastor parameter value will be obtained by dividing the theoretical torque value of the added counterweight by the current value of the identification output.
3. 如果在执行器的非受力方向（竖直方向）感觉到阻力则小幅度增大Frict_param参数的最后一个值，反之减小。  
If you feel resistance in the non-force direction (vertical direction) of the actuator, increase the last value of the Frict_param parameter slightly, otherwise decrease it.
4. 而后根据实际情况可以适当地调节frict_param_assist或frict_param_resistance参数的第二位，比如，如果在执行器转动过程中，与输出力矩相同方向出现明显加速现象，则减小frict_param_assist参数的绝对值，如果出现明显减速现象，则增大frict_param_assist参数的绝对值，frict_param_resistance则为与输出力矩相反方向，调节方式相同；  
Then, according to the actual situation, the second bit of the frict_param_assist or frict_param_resistance parameter can be appropriately adjusted. For example, if there is an obvious acceleration phenomenon in the same direction as the output torque during the rotation of the actuator, the absolute value of the frict_param_assist parameter should be reduced. If there is an obvious deceleration phenomenon, the absolute value of the frict_param_assist parameter should be increased. The frict_param_resistance is in the opposite direction of the output torque, and the adjustment method is the same.
3. 更改参数后关闭并重新启动程序（注意拖住配重，避免配重快速下坠）  
After changing the parameters, close and restart the program (be careful to hold the counterweight to prevent it from falling quickly)