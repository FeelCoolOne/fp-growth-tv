hive -e "
set hive.execution.engine=mr;
select b.vid
from
( select vid,iid
  from chiq.vid_iid_duration
  ) a
right outer join
(
 select mac,reportinfo['vid'] as vid,time,actiontime,p_log_date  
 from chiq.standard_actions_video
 where reportinfo['vid'] is not null
 and reportinfo['action'] in ('Start','Quit')
 and p_log_date = '2016-12-20'
 ) b
on ( a.vid == b.vid)
where a.iid is null
" > /home/liuhuaping/haifeng/1.dat
