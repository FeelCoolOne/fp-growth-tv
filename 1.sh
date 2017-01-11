select b.mac,if(length(a.iid)==0 or a.iid is null,b.vid,a.iid),b.time,b.actiontime,b.p_log_date
from
( select vid,iid
  from chiq.vid_iid_duration
  limit 100
  ) a
right outer join
(
 select mac,reportinfo['vid'] as vid,time,actiontime,p_log_date 
 from chiq.standard_actions_video 
 where reportinfo['vid'] is not null
 and p_log_date = '2016-12-20'
  limit 100
 ) b
on ( a.vid = b.vid);



select count(*)
from 
(select b.vid
from
( select vid,iid
  from chiq.vid_iid_duration
  ) a
right outer join
(
 select mac,reportinfo['vid'] as vid,time,actiontime,p_log_date  
 from chiq.standard_actions_video  
 where reportinfo['vid'] is not null
 and p_log_date = '2016-12-20'
 ) b
on ( a.vid == b.vid)
where length(a.iid)==0 or a.iid is null
)
group by b.vid


select c.mac,concat_ws('|', collect_set(c.cover_id))
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
 and p_log_date = '2016-12-20'
 limit 100
 ) b
on ( a.vid == b.vid)
)c
group by c.mac




where length(a.iid)==0 or a.iid is null


SELECT id,
concat_ws('|', collect_set(str)) 
FROM t  
GROUP BY id;
