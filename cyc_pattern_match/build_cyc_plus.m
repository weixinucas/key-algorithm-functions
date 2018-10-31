function cyc_plus_pattern=build_cyc_plus(cyc_pattern_circle,start_index,cyc_num)
%***********************************************************************************************
% function:generate cumulate vectors cyc_plus_in_sensor and cyc_plus_in_database

%input parameters:
%cyc_pattern_circle is the pattern after shifting dynamic cyclic pattern circularly; 
%start_index is the element index in dynamic cyclic pattern which will be shifted to the first bit of the cyc_pattern_circle;
%cyc_num is the number of element in dynamic cyclic pattern;

%output parameters:
%cyc_plus_pattern is the cumulate vector for the dynamic cyclic pattern; 
%***********************************************************************************************
cyc_pattern=cyc_pattern_circle(start_index:start_index+cyc_num-1);
cyc_plus_pattern=zeros(1,cyc_num);

for i=1:1:cyc_num
    
    if i==1
       cyc_plus_pattern(i)=cyc_pattern(1);
    end
    
    if i~=1
       cyc_plus_pattern(i)=cyc_plus_pattern(i-1)+cyc_pattern(i);
    end
    
end

end

