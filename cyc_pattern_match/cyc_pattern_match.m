function [match_star_index,match_cyc_num]=cyc_pattern_match(image_star_Cyc_pattern,guide_id_tab_index,cyc_pattern_data_base,min_mat_cyc)
%*****************************************************************************************
%function:calculate the matching scores between the obseversed dynamic cyclic pattern image_star_Cyc_pattern and catalog dynamic cyclic patterns
%of candidates star in the guide_id_tab_index;the matching score between them is acquired by the max cumulate comparison method.Find the candidates star
%in the guide_id_tab_index whose dynamic cyclic pattern is most similar to image_star_Cyc_pattern. 
%******************************************************************************************
%input parameters:
%image_star_Cyc_pattern is the observed dynamic cyclic pattern; 
%guide_id_tab_index is the candidate set obtained after comparing radial pattern;
%cyc_pattern_data_base is the dynamic cyclic pattern catalog;
%min_mat_cyc is the threshold for dynamic cyclic pattern matching;

%output parameters:
%match_star_index is the unique candidate star after comparing dynamic cyclic patterns; 
%match_cyc_num is the 
%********************************************************************************************
erro_theta=4;erro_plus_theta=4;
cyc_comp_num=size(guide_id_tab_index,2);
cyc_match_tab=zeros(cyc_comp_num,1);

match_star_index=0;
match_cyc_num=0;
for k=1:1:cyc_comp_num

cyc_match_num_set=[];

%cyc_pattern_data is dynamic cyclic pattern of the candidate star(guide_id_tab_index(k))
cyc_pattern_data=cyc_pattern_data_base(guide_id_tab_index(k)).cyc_pattern_code;

Cyc_num=size(image_star_Cyc_pattern,1);
Cyc_num_in_base=size(cyc_pattern_data,1);
cyc_pattern_in_sensor=[image_star_Cyc_pattern;image_star_Cyc_pattern];
cyc_pattern_in_databs=[cyc_pattern_data;cyc_pattern_data];
%---------------------------------------------------------------------------------------------
%step1:determine the initial element pairing between image_star_Cyc_pattern and cyc_pattern_data
%---------------------------------------------------------------------------------------------
[start_index_sensor_set_init,start_index_base_set_init]=calculate_start_index(image_star_Cyc_pattern,Cyc_num,cyc_pattern_data,Cyc_num_in_base,erro_theta);
%---------------------------------------------------------------------------------------------
%step2:select the valid initial pairing among all the initial element pairings
%---------------------------------------------------------------------------------------------
[start_index_sensor_set,start_index_base_set,num]=selet_start_index(start_index_sensor_set_init,start_index_base_set_init);

%---------------------------------------------------------------------------------------------
if num==0
    cyc_match_num_value=0;
end
%---------------------------------------------------------------------------------------------
if num>0
    for i=1:1:num
        start_index_sensor=start_index_sensor_set(i);
        start_index_base=start_index_base_set(i);
%---------------------------------------------------------------------------------------------
%step3:generate cumulate vectors cyc_plus_in_sensor and cyc_plus_in_database
%---------------------------------------------------------------------------------------------
        cyc_plus_in_sensor=build_cyc_plus(cyc_pattern_in_sensor,start_index_sensor,Cyc_num);
        cyc_plus_in_database=build_cyc_plus(cyc_pattern_in_databs,start_index_base,Cyc_num_in_base);
%---------------------------------------------------------------------------------------------
%step4:calculate the similarity score between cyc_plus_in_sensor and cyc_plus_in_database
%---------------------------------------------------------------------------------------------
        cyc_match_num=calculate_cyc_plus(cyc_plus_in_sensor,cyc_plus_in_database,erro_plus_theta);
        cyc_match_num_set=[cyc_match_num_set,cyc_match_num];
    end
%---------------------------------------------------------------------------------------------
%step5:the similarity score between cyc_plus_in_sensor and cyc_plus_in_database for each valid initial element pairing is calculated,and
%the maximum value among all similarity scores is defined as the final matching score between image_star_Cyc_pattern and cyc_pattern_data
%---------------------------------------------------------------------------------------------
    cyc_match_num_value=max(cyc_match_num_set);
end
cyc_match_tab(k)=cyc_match_num_value;
end

max_cyc_value=max(cyc_match_tab);
max_match_star_index=find(cyc_match_tab(:)==max_cyc_value);
max_cyc_value_num=size(max_match_star_index,1);

%-----------------------------------------------------------------------------------------------
%if there are matching scores between image_star_Cyc_pattern and cyc_pattern_data are higher than the threshold min_mat_cyc and the number of 
%candidate star of the maximum matching score is one, then the candidate star with the maximum matching score is determined as the unique matching result(match_star_index),
%and match_cyc_num is set to be 1;else match_cyc_num is 0.
%-----------------------------------------------------------------------------------------------
if max_cyc_value>=min_mat_cyc & max_cyc_value_num==1
    match_cyc_num=1;
    cyc_match_num_value=max_cyc_value;
    match_star_index=guide_id_tab_index(max_match_star_index);
end


end

