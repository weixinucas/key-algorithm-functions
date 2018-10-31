function [start_index_sensor,start_index_base]=calculate_start_index(image_star_Cyc_pattern,Cyc_num,cyc_pattern_data_base,Cyc_num_in_base,erro_theta)
%***********************************************************************************************
%function:determine the initial element pairing between image_star_Cyc_pattern and cyc_pattern_data_base

%input parameters:
%image_star_Cyc_pattern is the observed dynamic cyclic pattern; 
%Cyc_num is the number of element in image_star_Cyc_pattern;
%cyc_pattern_data_base is the dynamic cyclic pattern in the catalog;
%Cyc_num_in_base is the number of element in cyc_pattern_data_base;
%erro_theta is the threshold for determining the initial element pairing;

%output parameters:
%start_index_sensor is the element index of image_star_Cyc_pattern in initial element pairing; 
%start_index_base is the the element index of cyc_pattern_data_base in initial element pairing;
%***********************************************************************************************
start_index_sensor=[];
start_index_base=[];

for i=1:1:Cyc_num
    theta_in_sensor=image_star_Cyc_pattern(i);
    for j=1:1:Cyc_num_in_base
        theta_in_databs=cyc_pattern_data_base(j);
        error=abs(theta_in_sensor-theta_in_databs);
        if error<=erro_theta
            start_index_sensor=[start_index_sensor,i];
            start_index_base=[start_index_base,j];
        end
    end
end

end

