awk -F '\t' '{
  delete a
  delete cate
  split($2,a,":");
  split(a[4],cate,"\"");
  cate_name = cate[2]

  delete b
  delete iids
  split($0,b,"cover_id");
  split(b[2],iids,"\"");
  iid = iids[3]
  if (length(iid) > 2) {
    print iid"\t"cate_name
  }
}' ../data/video.dat > ../data/video_iid.dat
