hadoop fs -rm -r /user/liuhuaping/haifeng.li/FPGrowth/output

spark-submit \
--master yarn-cluster \
--class "FPGrowth" \
--num-executors 120 \
--driver-memory 4g \
--executor-memory 4G \
--executor-cores 2 \
../bin/fpgrowth-project_2.10-1.0.jar \
/user/liuhuaping/haifeng.li/FPGrowth/input/trade.dat \
/user/liuhuaping/haifeng.li/FPGrowth/output \
0.005 0.001

hadoop fs -ls /user/liuhuaping/haifeng.li/FPGrowth/output
