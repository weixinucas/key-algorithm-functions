function [start_index_sensor_set,start_index_base_set,num]=selet_start_index(start_index_sensor_set_init,start_index_base_set_init)
%***********************************************************************************************
%function£ºselect the valid initial pairing among all the initial element pairings

%input parameters:
%start_index_sensor_set_init is the element index of observed pattern in initial element pairing; 
%start_index_base_set_init is the the element index of catalog pattern in initial element pairing;

%output parameters:
%start_index_sensor_set is the element index of observed pattern in valid initial pairing; 
%start_index_base_set is the the element index of catalog pattern in valid initial pairing;
%num is the number of valid initial pairing;
%***********************************************************************************************
start_index_sensor_set=start_index_sensor_set_init;
start_index_base_set=start_index_base_set_init;

num_in_sensor=size(start_index_sensor_set_init,2);
num_in_databs=size(start_index_base_set_init,2);

start_flag=ones(1,num_in_sensor);

for i=1:1:num_in_sensor-1
    prev_num_s=start_index_sensor_set_init(i);
    next_num_s=start_index_sensor_set_init(i+1);
    
    prev_num_d=start_index_base_set_init(i);
    next_num_d=start_index_base_set_init(i+1);   
    
    if (prev_num_s+1)==next_num_s & (prev_num_d+1)==next_num_d
        start_flag(i+1)=0;
    end
end

start_index=find(start_flag==1);
start_index_sensor_set=start_index_sensor_set(start_index);
start_index_base_set=start_index_base_set(start_index);

num=size(start_index_base_set,2);
end

