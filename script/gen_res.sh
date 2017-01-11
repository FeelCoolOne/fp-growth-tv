awk -F '\t' '{len=split($1,a,",");if(len==1)print $0}'  ../data/res/part* > ../data/result.dat
sort -k2 -nr -t ":" ../data/result.dat > ../data/tmp.dat

awk -F '\t' '{
  if ($1 in a) {
    a[$1]=a[$1]","$2
  }
  else {
    a[$1]=$2
  }
}END{
  for(i in a) {
    print i"\t"a[i]
  }
}' ../data/tmp.dat > ../data/fpg.dat


awk -F '\t' 'FILENAME~"video_iid"{
  iids[$1]=$2
}FILENAME~"fpg"{
  if ($1 in iids) {
    cate_name=iids[$1]
    res_len = split($2,res,",")
    res_iids=""
    for (i=1;i<=res_len;++i) {
      split(res[i],a,":")
      res_iid = a[1]
      res_iid_s = "\""a[1]"\""
      weight = a[2]
      if (iids[res_iid] == cate_name) {
        res_iids = res_iids""res_iid_s":"weight","
      }
    }
    
    if (length(res_iids) > 5) {
      print "Cchiq"":""FPGVAV"":""ITI"":"$1"\t" "{\"Results\":{"substr(res_iids,1,length(res_iids)-1)"},\"V\":\"1.0.0.0\"}"
    }
    
  }
}' ../data/video_iid.dat ../data/fpg.dat > ../data/fpg_res.dat
        #res_iids = res_iids""res[i]","
