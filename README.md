# Single-actuator-torque-control

## introduce

Welcome to use the joint actuator developed by Sito Company. It includes two parts: the first is to identify and eliminate the friction torque, and the second is to obtain the conversion coefficient from current to torque. These two parts enable the joint actuator to rotate easily even when connected to a large mass load.

## Dependencies

[ROS](https://www.ros.org/) noetic or other Version(not tested yet)  
[Eigen](https://eigen.tuxfamily.org/index.php?title=Main_Page)  

## Build

install Eigen:

```bash
sudo apt update
sudo apt install git
git clone https://gitlab.com/libeigen/eigen.git
sudo cp -r ./eigen/Eigen /usr/include/
sudo apt install libeigen3-dev
```

install pyyaml:

```bash
sudo apt install python3 pip
sudo pip install pyyaml
```

install serial:

```bash
sudo apt install ros-noetic-serial
```

If you find an error "version `GLIBC_2.34‘ not found", this will be a solution:  
- open /etc/apt/sources.list file  
```bash
sudo gedit /etc/apt/sources.list
```
- Add a higher version source  
```bash
deb http://th.archive.ubuntu.com/ubuntu jammy main  # Add this line to the file
```
- install libc6  
```bash
sudo apt update
sudo apt install libc6
```
- Reopen /etc/apt/sources.list and delete the previously added content, and update the source again  
```bash
sudo gedit /etc/apt/sources.list
deb http://th.archive.ubuntu.com/ubuntu jammy main  # deleted this line
sudo apt update
```

## Instructions

The single_actuator package contains 3 features, which can be viewed in install/share/single_actuator/config/single_actuator.yaml.
### speed_riction_detection： 
- Obtain the relationship between the current output by the actuator to overcome friction (referred to as friction current) and speed when the actuator is unloaded
- This function controls the actuator to rotate at different speeds and saves its continuous feedback data. Then, the install/lib/single_autor/speed_frication_fitting file is used to fit the current and speed data to obtain the relationship between current and speed.
### torque_friction_detection： 
- Get the relationship between friction and output torque
- This function requires installing a heavy load in the output side of the actuator, and then record the change of friction current when the actuator outputs different torques, and then use the torque_friction_fitting file to fit the relationship between friction current and output torque.
### torque_identification： 
- Get the conversion factor from current to torque, verify the final effect of friction parameters
- Change the friction parameters in small increments according to the actual situation

### Steps to use

#### Feature 1

1. Use the debugging software to modify the default parameters of the actuator, change the acceleration and deceleration to **6000**.  
2. Change the **"feature"** parameter of the single_actuator.yaml file to **"speed_riction_detection"** and set the other parameters of the file according to the comments, and then run the file install/share/single_actuator/launch/torque_control.launch:  

> It should be noted that if the **"record_path"** path does not exist, the csv file for recording data cannot be generated;
> At this time, the output side of the actuator cannot be equipped with anything, otherwise the test result will be too large.

```bash
cd your_path/install
source ./setup.bash
roslaunch single_actuator torque_control.launch
```

1. It takes about 16 minutes to complete this function. After the actuator has collected data and stopped rotating, close the program, configure the speed_friction_fitting.yaml file and run:  

```bash
chmod +x ./lib/single_actuator/speed_friction_fitting
./lib/single_actuator/speed_friction_fitting
```

This file will output the 7 friction parameters of the actuator related to speed, and fill these values ​​into the **"Frict_param"** parameter of the single_actuator.yaml file

#### Feature 2

1. Add a heavy weight to the actuator, and modify the zero offset. as shown in the figure:  

> The zero point should be in the vertical downward direction of the connecting rod; the overall center of gravity of the counterweight should be on the connecting rod.  

<img src="image1.png" alt="配重安装示意图" width="400" height="500">   

2. Change the **"feature"** parameter to **"torque_identification"** and run the torque_control.launch file again:  

```bash
roslaunch single_actuator torque_control.launch
```
This function will lift the weight and detect the output current

3. Calculate the torque applied to the actuator by the counterweight (including the connecting rod) due to gravity, divide the output current value by the torque value to get the current to torque conversion coefficient, and fill the coefficient into the **cur_tor_fastor** parameter in the single_actuator.yaml file

4. Change the **"feature"** parameter to **"torque_friction_detection"** and run the torque_control.launch file again:  

```bash
roslaunch single_actuator torque_control.launch
```
This function will run for about 2 minutes

5. After the actuator stops, close the program, configure the torque_friction_fitting.yaml file and run:
```bash
chmod +x ./lib/single_actuator/torque_friction_fitting
./lib/single_actuator/torque_friction_fitting
```

This file outputs the relationship parameters between friction force and output torque. The parameters are divided into two parts: the direction of rotation is the same as the direction of output torque (assistance direction) and the opposite (resistance direction), with two parameters in each part.Fill these values ​​into the **"frict_param_assist"** and **"frict_param_resistance"** parameters in the single_actuator.yaml file respectively.

#### Feature 3

1. Change the **"feature"** parameter to **"torque_identification"** and run the torque_control.launch file again:  

```bash
roslaunch single_actuator torque_control.launch
```

2. If you feel resistance in the non-force direction (vertical direction) of the actuator, increase the last value of the **"Frict_param"** parameter slightly, otherwise decrease it.
3. Then, according to the actual situation, the second bit of the **"frict_param_assist"** or **"frict_param_resistance"** parameter can be appropriately adjusted. If there is no abnormality, no adjustment is required.  

> For example, if the actuator decelerates significantly when the rotation direction is the same as the torque direction, increase the absolute value of the "frict_param_assist" parameter, otherwise decrease it; if the rotation direction is opposite to the torque direction, adjust "frict_param_resistance" in a similar way;

4. After changing the parameters, close and restart the program (Pay attention to support the counterweight to prevent it from falling quickly)



## 介绍

欢迎使用由鑫拓公司研发的关节执行器,这里包含了两部分内容，第一是辨识并消除摩擦力矩，第二是获取电流到力矩的转换系数。这两部分内容使得关节执行器在连接较大质量的负载的情况下也能够轻松地旋转。

## 依赖项

[ROS](https://www.ros.org/) noetic or other Version(not tested yet)  
[Eigen](https://eigen.tuxfamily.org/index.php?title=Main_Page)  

## 构建

install Eigen:

```bash
sudo apt update
sudo apt install git
git clone https://gitlab.com/libeigen/eigen.git
sudo cp -r ./eigen/Eigen /usr/include/
sudo apt install libeigen3-dev
```

install pyyaml:

```bash
sudo apt install python3 pip
sudo pip install pyyaml
```

install serial:

```bash
sudo apt install ros-noetic-serial
```
如果发现错误“version `GLIBC_2.34‘ not found”，这会是一个解决方法：
- 打开 /etc/apt/sources.list 文件
```bash
sudo gedit /etc/apt/sources.list
```
- 添加更高版本的源并保存
```bash
deb http://th.archive.ubuntu.com/ubuntu jammy main  # 添加这行到文件
```
- install libc6
```bash
sudo apt update
sudo apt install libc6
```
- 重新打开 /etc/apt/sources.list 并删除之前添加的源, 重新更新源
```bash
sudo gedit /etc/apt/sources.list
deb http://th.archive.ubuntu.com/ubuntu jammy main  # 删除这行
sudo apt update
```

## 使用介绍

single_actuator功能包中包含了3个功能（可以在install/share/single_actuator/config/single_actuator.yaml文件中查看）：  
### speed_riction_detection：
- 获取空载情况下执行器为克服摩擦力而输出的电流（简称摩擦电流）与速度的关系  
- 该功能控制执行器在不同的速度下进行旋转，并保存其连续反馈的数据，然后使用install/lib/single_autor/speed_frication_fitting文件对电流和速度数据进行拟合，得到电流与速度的关系
### torque_friction_detection：
- 获取摩擦与输出力矩的关系  
- 本功能需要给执行器输出端装上较大重量的负载，而后收集执行器在不同力矩下摩擦电流变化，使用torque_friction_fitting文件拟合出摩擦电流与输出力矩的关系
### torque_identification：
- 获取电流到力矩的转换系数，验证摩擦参数的最终效果  
- 根据实际情况在较小幅度上更改摩擦参数

### 使用步骤

#### 功能1

1. 在上位机中修改执行器的默认参数，将加减速度更改为**6000**。  

2. 将single_actuator.yaml文件的 **feature** 参数改为 **speed_riction_detection** 并根据注释设置好该文件的其他参数，而后运行install/share/single_actuator/launch/torque_control.launch文件：  

> 需要注意的是，如果 **record_path** 路径不存在，则无法生成记录数据的csv文件；
> 此时执行器输出端不能装配任何物品，否则将导致测试结果偏大。  

```bash
cd your_path/install
source ./setup.bash
roslaunch single_actuator torque_control.launch
```

3. 完成该功能需要16分钟左右，在执行器收集完数据并停止转动后，关闭程序，配置好speed_friction_fitting.yaml文件并运行：  

```bash
chmod +x ./lib/single_actuator/speed_friction_fitting
./lib/single_actuator/speed_friction_fitting
```

该文件将会输出执行器的7个关于速度的摩擦参数，将这些数值填入single_actuator.yaml文件的 **Frict_param** 参数中  


#### 功能2

1. 给执行器加上较大重量的配重，并修改零点偏置，如图所示：  

> 零点应该位于连接杆竖直向下的方向；配重的整体重心应该位于连接杆上  

<img src="image1.png" alt="配重安装示意图" width="400" height="500" />  

2. 将 **feature** 参数改为 **torque_identification** 并再次运行torque_control.launch文件：  

```bash
roslaunch single_actuator torque_control.launch
```
该功能会将配重举起并识别输出的电流

3. 计算配重（包括连接杆）由于重力而对执行器施加的力矩大小，将输出的电流值除以力矩值得到电流到力矩的转换系数，将该系数填到single_actuator.yaml文件的**cur_tor_fastor**参数中

4. 将 **feature** 参数改为 **torque_friction_detection** 并再次运行torque_control.launch文件：  

```bash
roslaunch single_actuator torque_control.launch
```
该功能将运行2分钟左右

5. 在执行器停止后关闭程序，配置好torque_friction_fitting.yaml文件并运行：  
```bash
chmod +x ./lib/single_actuator/torque_friction_fitting
./lib/single_actuator/torque_friction_fitting
```

该文件将输出摩擦力与输出力矩的关系参数，其中参数分为旋转方向与输出力矩方向相同（助力方向）和相反（阻力方向）两个部分，各两个参数，将这些数值分别填入single_actuator.yaml文件的 **frict_param_assist** 和 **frict_param_resistance** 参数中。  

#### 功能3

1. 将 **feature** 参数改为 **torque_identification** 并再次运行torque_control.launch文件：  

```bash
roslaunch single_actuator torque_control.launch
```

2. 如果在执行器的非受力方向（竖直方向）感觉到阻力则小幅度增大 **Frict_param** 参数的最后一个值，反之减小。  
3. 而后根据实际情况可以适当地调节 **frict_param_assist** 或 **frict_param_resistance** 参数的第二位,如果无异常情况则无需调节  

> 比如，如果在执行器转动过程中，旋转方向与力矩方向相同时出现明显减速现象，则增大 **frict_param_assist** 参数的绝对值，反之减小；旋转方向与力矩方向相反时则调节 **frict_param_resistance**，方法类似；  

4. 更改参数后关闭并重新启动程序（注意托住配重，避免配重快速下坠）   
