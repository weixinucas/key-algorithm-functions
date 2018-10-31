function [guide_id_result,match_num,star_num_with_max_counter]=rad_pattern_match(rad_pattern,LookTab,min_mat)
%*********************************************************************************************************
%function:search for the candidates whose radial pattern is most similar to obseved radial pattern rad_pattern.

%input parameters:
%rad_pattern is the observed radial pattern; 
%LookTab is the radial pattern catalog;
%min_mat is the threshold for radial pattern matching;

%output parameters:
%guide_id_result is the candidate stars after comparing radial patterns; 
%match_num is the similar score between rad_pattern and radial patterns of candidates;
%star_num_with_max_counter is the number of candidate stars with maximum similar scores;
%*********************************************************************************************************
guide_id_result=[];
match_num=0;

vote_num=size(rad_pattern,1);             
star_index_in_tab=[];

for i=1:1:vote_num
    tab_index=rad_pattern(i);             
    star_index_set=LookTab(tab_index).guide_star;    
    star_index_num_in_set=size(star_index_set,2);    
    if star_index_num_in_set==0
        continue
    end
    star_index_in_tab=[star_index_in_tab,star_index_set];
end
    star_num_result=tabulate(star_index_in_tab);
%-----------------------------------------------------------------------------------
%search for the candidates whose similar score is equal to or more than min_mat, and
%the number of these candidates is star_num_minma;
%-----------------------------------------------------------------------------------    
    match_result_minmat=star_num_result(find(star_num_result(:,2)>=min_mat),1:2);
    star_num_minmat=size(match_result_minmat,1);
%-----------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------
%case 1£ºthere are no candidates whose similar score is equal to or more than min_mat
if star_num_minmat==0
    guide_id_result=[];
    match_num=0;
    star_num_with_max_counter=0;
end
%-----------------------------------------------------------------------------------
%case 2£ºthere is only one candidates whose similar score is equal to or more than min_mat
if star_num_minmat==1
   guide_id_result=match_result_minmat(1);
   match_num=match_result_minmat(2);
   star_num_with_max_counter=1;
end
%-----------------------------------------------------------------------------------
%case 3£ºthere are more than one candidates whose similar score is equal to or more than min_mat
%choose the candidates with maximum similar scores as the guide_id_result
if star_num_minmat>=2
    max_vote_num=max(match_result_minmat(:,2));
    guide_id_and_num=match_result_minmat(find(match_result_minmat(:,2)==max_vote_num),:);
    
    guide_id_result=guide_id_and_num(:,1);
    match_num=guide_id_and_num(:,2);
    star_num_with_max_counter=size(guide_id_result,1);
end
end

