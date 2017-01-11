#sh get_data.sh

awk -F '\t' '{
  print $2
}' ../data/user_action.dat > ../data/action_iid.dat

awk -F '\t' 'FILENAME~"video_iid"{
  vid[$1]=1  
}FILENAME~"action_iid"{
  delete iid
  len=split($1,a,",")
  for(i=1;i<=len;++i) {
    if (a[i] in vid) {
      iid[a[i]]=1
    }
  }
  iid_s = ""
  n=0
  for (i in iid) {
    iid_s = iid_s""i","
  }
  if (length(iid_s) > 5) {
    print substr(iid_s,1,length(iid_s)-1)
  }
}' ../data/video_iid.dat ../data/action_iid.dat > ../data/trade.dat

hadoop fs -rm -f /user/liuhuaping/haifeng.li/FPGrowth/input/*
hadoop fs -put ../data/trade.dat /user/liuhuaping/haifeng.li/FPGrowth/input

