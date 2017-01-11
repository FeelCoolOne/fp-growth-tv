###获取原始数据
DATE=`date +%Y-%m-%d --date="-1 day"`
START_DATE=`date +%Y-%m-%d --date="-90 day"`
END_DATE=`date +%Y-%m-%d --date="-1 day"`

hive -e "
set hive.execution.engine=mr;
select c.mac,concat_ws(',', collect_set(c.cover_id))
from
(select b.mac,if(length(a.iid)==0 or a.iid is null,b.vid,a.iid) as cover_id,b.time,b.actiontime,b.p_log_date
from
( select vid,iid
  from chiq.vid_iid_duration
  ) a
right outer join
(
 select mac,reportinfo['vid'] as vid,time,actiontime,p_log_date
 from chiq.standard_actions_video
 where reportinfo['vid'] is not null
 and p_log_date between '$START_DATE' and '$END_DATE'
 ) b
on ( a.vid == b.vid)
)c
group by c.mac
" > ../data/user_action.dat
