function cyc_match_num=calculate_cyc_plus(cyc_plus_in_sensor,cyc_plus_in_database,erro_plus_theta)
%***********************************************************************************************
%function:calculate the similarity score between cyc_plus_in_sensor and cyc_plus_in_database

%input parameters:
%cyc_plus_in_sensor is the cumulate vectors for the observed dynamic cyclic pattern; 
%cyc_plus_in_database is the cumulate vectors for the catalog dynamic cyclic pattern;
%erro_plus_theta is a threshold for calculating the similarity score;

%output parameters:
%cyc_match_num is the similarity score between cyc_plus_in_sensor and cyc_plus_in_database; 
%***********************************************************************************************
cyc_match_num=0;

sensor_num=size(cyc_plus_in_sensor,2);
databs_num=size(cyc_plus_in_database,2);

for s=1:1:sensor_num
    cyc_plus_value_sensor=cyc_plus_in_sensor(s);
    for d=s:1:databs_num
        cyc_plus_value_databs=cyc_plus_in_database(d);
        error_cyc_plus=abs(cyc_plus_value_databs-cyc_plus_value_sensor);
        if error_cyc_plus<=erro_plus_theta
            cyc_match_num=cyc_match_num+1;
            break
        end
    end
end

end

