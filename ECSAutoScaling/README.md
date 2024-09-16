# ECSのAutoScalingを設定して、実際に負荷を与えてスケールするか試してみよう


## AutoScaling設定

- 設定

![AutoScaling CPU over 40](AutoScaling.png)

- CPUが40%を超える

![CPU over 40](cpu-over40.png)


![ECS Scale Out](scale-out.png)

- CPUが36%を下回る

![CPU Under 36](cpu-under36.png)

![ECS Scale In](scale-in.png)

## 備考

オートスケーリングで自動で作られたターゲットポリシーを設定していたが、すぐにスケールイン・アウトしなかった。
デフォルトでは3分間で3回40%を上回らないとスケールアウトしないようになっていた、また15分間で15回36%を下回らないとスケールインしないようになっていた。
実際に設定するときは、この辺りの調整が必要。