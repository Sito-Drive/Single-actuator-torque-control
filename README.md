# Single-actuator-torque-control
# 介绍
欢迎使用由鑫拓公司研发的关节执行器,这里将介绍识别和消除执行器的摩擦力矩，获取电流与输出力矩的转换系数的方法，从而实现关节执行器在连接不同质量的负载的情况下，能够有效识别并抵消执行器的摩擦和负载重量的功能，实现执行器的轻松旋转的功能。
# 依赖项
[ROS](https://www.ros.org/) noetic or other Version(not tested yet)  
[Eigen](https://eigen.tuxfamily.org/index.php?title=Main_Page)  
# 构建
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
# 使用介绍
single_actuator包中包含3个功能，可以在install/share/single_actuator/config/single_actuator.yaml中查看，其中speed_riction_detection功能是收集执行器在不同速度下的电流数据，利用这些数据，使用install/lib/single_actuator/speed_friction_fitting文件拟合可以得出执行器克服摩擦的电流（简称摩擦电流）与速度的关系；torque_friction_detection功能则需要给执行器加上较大重量的负载，而后收集执行器在不同扭矩的情况下摩擦电流变化，利用torque_friction_fitting文件拟合得到摩擦电流与输出力矩的关系。torque_identification功能则是验证摩擦参数的最终结果，根据实际情况仍然可以在较小幅度上更改摩擦参数。
## 步骤：
1.在上位机中修改执行器的默认参数，将默认加减速度更改为6000，默认电流10000mA。将single_actuator.yaml文件的feature参数改为speed_riction_detection并根据注释设置好该文件的其他参数，而后运行install/share/single_actuator/launch/torque_control.launch文件：
```bash
cd your_path/install
source ./setup.bash
roslaunch single_actuator torque_control.launch
```
需要注意的是，如果record_path不存在，则无法生成记录数据的csv文件；此时执行器输出法兰中不能装配任何物品，否则将导致测试结果偏大。
完成该功能需要10分钟左右，在执行器收集完数据并停止转动后，关闭程序，配置好speed_friction_fitting.yaml文件并运行：
```bash
chmod +x ./lib/single_actuator/speed_friction_fitting
./lib/single_actuator/speed_friction_fitting
```
该文件将会输出执行器的7个关于速度的摩擦参数，将这些数值填入single_actuator.yaml文件的Frict_param参数中
2.给执行器加上较大重量的负载，如图所示：
![配重安装示意图](image1.png)
修改执行器的零点偏置，零点应该位于连接杆竖直向下的方向；配重的整体重心应该位于连接杆上
将feature参数改为torque_friction_detection并再次运行torque_control.launch文件：
```bash
roslaunch single_actuator torque_control.launch
```
该功能将运行3分钟左右，在执行器停止后关闭程序，计算添加的负重（包括连接杆）理论上的力矩值,配置好torque_friction_fitting.yaml文件，其中target_values默认不需要更改，tor_values的值分别为0，最大力矩的1/9,2/9,...,9/9，并运行：
```bash
chmod +x ./lib/single_actuator/torque_friction_fitting
./lib/single_actuator/torque_friction_fitting
```
该文件将输出执行器摩擦力与输出力矩方向相同（助力）和摩擦力与输出力矩方向相反（阻力）时，摩擦力与输出力矩的关系参数，分别为两个参数，将这些数值分别填入single_actuator.yaml文件的frict_param_assist和frict_param_resistance参数中。
3.将feature参数改为torque_identification并再次运行torque_control.launch文件：
```bash
roslaunch single_actuator torque_control.launch
```
负重将被转到水平方向进行力矩识别，将添加的负重理论上的力矩值除以识别输出的电流值得到cur_tor_fastor参数值。而后根据实际情况可以适当地调节frict_param_assist或frict_param_resistance参数的第二位，比如，如果在执行器转动过程中，与输出力矩相同方向出现明显加速现象，则减小frict_param_assist参数的绝对值，反之减小frict_param_resistance的绝对值；如果在执行器的非受力方向（竖直方向）感觉到阻力则小幅度增大Frict_param参数的最后一位，反之减小。更改参数后关闭并重新启动程序（注意拖住配重，避免配重快速下坠）