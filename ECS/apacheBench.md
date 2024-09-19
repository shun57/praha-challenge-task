# テストパターン

## タスク1の場合

### リクエスト数: 500、同時接続数: 10

```
$ ab -k -n 500 -c 10 http://praha-sakurai-load-1987431591.ap-northeast-1.elb.amazonaws.com/
```

```
Concurrency Level:      10
Time taken for tests:   1.001 seconds
Complete requests:      500
Failed requests:        0
Keep-Alive requests:    500
Total transferred:      426500 bytes
HTML transferred:       307500 bytes
Requests per second:    499.52 [#/sec] (mean)
Time per request:       20.019 [ms] (mean)
Time per request:       2.002 [ms] (mean, across all concurrent requests)
Transfer rate:          416.11 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   9.5      0      71
Processing:     7   17   9.8     15      82
Waiting:        7   17   9.8     15      82
Total:          7   19  13.4     16      88

Percentage of the requests served within a certain time (ms)
  50%     16
  66%     20
  75%     22
  80%     23
  90%     28
  95%     35
  98%     82
  99%     85
 100%     88 (longest request)
```


### リクエスト数: 3000、同時接続数: 10

```
$ ab -k -n 3000 -c 50 http://praha-sakurai-load-1987431591.ap-northeast-1.elb.amazonaws.com/
```

```
Concurrency Level:      50
Time taken for tests:   0.939 seconds
Complete requests:      3000
Failed requests:        0
Keep-Alive requests:    3000
Total transferred:      2559000 bytes
HTML transferred:       1845000 bytes
Requests per second:    3194.95 [#/sec] (mean)
Time per request:       15.650 [ms] (mean)
Time per request:       0.313 [ms] (mean, across all concurrent requests)
Transfer rate:          2661.41 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   1.3      0      25
Processing:     7   15   7.9     12      48
Waiting:        7   15   7.9     12      48
Total:          7   15   8.0     12      48

Percentage of the requests served within a certain time (ms)
  50%     12
  66%     14
  75%     16
  80%     18
  90%     25
  95%     36
  98%     43
  99%     45
 100%     48 (longest request)
```

### リクエスト数: 10000、同時接続数: 100

```
$ ab -k -n 10000 -c 100 http://praha-sakurai-load-1987431591.ap-northeast-1.elb.amazonaws.com/
```

```
Concurrency Level:      100
Time taken for tests:   2.087 seconds
Complete requests:      10000
Failed requests:        0
Keep-Alive requests:    10000
Total transferred:      8530000 bytes
HTML transferred:       6150000 bytes
Requests per second:    4790.83 [#/sec] (mean)
Time per request:       20.873 [ms] (mean)
Time per request:       0.209 [ms] (mean, across all concurrent requests)
Transfer rate:          3990.79 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   1.8      0      30
Processing:     8   20  11.0     17      74
Waiting:        7   20  11.0     17      74
Total:          8   20  11.2     17      74

Percentage of the requests served within a certain time (ms)
  50%     17
  66%     19
  75%     21
  80%     23
  90%     36
  95%     48
  98%     56
  99%     63
 100%     74 (longest request)
```

## タスク4の場合

### リクエスト数: 500、同時接続数: 10

```
$ ab -k -n 500 -c 10 http://praha-sakurai-load-1987431591.ap-northeast-1.elb.amazonaws.com/
```

```
Concurrency Level:      10
Time taken for tests:   0.636 seconds
Complete requests:      500
Failed requests:        0
Keep-Alive requests:    500
Total transferred:      426500 bytes
HTML transferred:       307500 bytes
Requests per second:    785.75 [#/sec] (mean)
Time per request:       12.727 [ms] (mean)
Time per request:       1.273 [ms] (mean, across all concurrent requests)
Transfer rate:          654.53 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   3.4      0      25
Processing:     6   12   5.7      9      43
Waiting:        6   11   5.7      9      43
Total:          6   12   6.7      9      43

Percentage of the requests served within a certain time (ms)
  50%      9
  66%     11
  75%     13
  80%     15
  90%     20
  95%     25
  98%     37
  99%     38
 100%     43 (longest request)
```

### リクエスト数: 3000、同時接続数: 10

```
$ ab -k -n 3000 -c 50 http://praha-sakurai-load-1987431591.ap-northeast-1.elb.amazonaws.com/
```

```
Concurrency Level:      50
Time taken for tests:   1.189 seconds
Complete requests:      3000
Failed requests:        0
Keep-Alive requests:    3000
Total transferred:      2559000 bytes
HTML transferred:       1845000 bytes
Requests per second:    2523.62 [#/sec] (mean)
Time per request:       19.813 [ms] (mean)
Time per request:       0.396 [ms] (mean, across all concurrent requests)
Transfer rate:          2102.19 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   1.8      0      43
Processing:     7   18   7.9     16      55
Waiting:        7   18   7.9     16      55
Total:          7   19   8.2     16      62

Percentage of the requests served within a certain time (ms)
  50%     16
  66%     20
  75%     22
  80%     24
  90%     28
  95%     39
  98%     42
  99%     43
 100%     62 (longest request)
```

### リクエスト数: 10000、同時接続数: 100

```
$ ab -k -n 10000 -c 100 http://praha-sakurai-load-1987431591.ap-northeast-1.elb.amazonaws.com/
```

```
Concurrency Level:      100
Time taken for tests:   2.050 seconds
Complete requests:      10000
Failed requests:        0
Keep-Alive requests:    10000
Total transferred:      8530000 bytes
HTML transferred:       6150000 bytes
Requests per second:    4878.14 [#/sec] (mean)
Time per request:       20.500 [ms] (mean)
Time per request:       0.205 [ms] (mean, across all concurrent requests)
Transfer rate:          4063.53 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   2.1      0      26
Processing:     7   20   8.9     17      57
Waiting:        7   20   8.9     17      57
Total:          7   20   9.2     17      57

Percentage of the requests served within a certain time (ms)
  50%     17
  66%     20
  75%     22
  80%     24
  90%     32
  95%     44
  98%     48
  99%     52
 100%     57 (longest request)
```