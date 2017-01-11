hive -e " 
  select model,categorys,youpeng,pp_youpeng,pp_tencent
  from chiq.chiq_video_converge
" > ../data/video.dat

