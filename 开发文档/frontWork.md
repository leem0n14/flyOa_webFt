

# 飞书·1

## echarts配置

```js

<script type="text/javascript">
        // 模拟从 API 返回的数据
        var responseData = {"message":"成功找到该项目任务!","counts":{"规划中":4,"进行中":1,"检查中":0,"停止中":1,"已完成":1}};

        // 从数据中提取任务进度统计数据
        var counts = responseData.counts;
        var categories = Object.keys(counts);
        var data = Object.values(counts);

        // 初始化 ECharts 实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '任务进度统计'
            },
            tooltip: {},
            xAxis: {
                data: categories
            },
            yAxis: {},
            series: [{
                name: '数量',
                type: 'bar',
                data: data
            }]
        };

        // 使用刚指定的配置项和数据显示图表
        myChart.setOption(option);
    </script>

```

![image-20240326203816080](C:\Users\Administrator\Desktop\workTable\flypro\flyoa_web\开发文档\frontWork.assets\image-20240326203816080.png)

前端Echarts的数据导入，图示柱状图LineA用于做项目状态数量统计





## 项目创建

![image-20240325175429663](C:\Users\Administrator\Desktop\workTable\flypro\flyoa_web\开发文档\frontWork.assets\image-20240325175429663.png)

禁止空







## userInf

```json
{"userCodeTemp":"65755f6e63-08eie956b2694e9e8d849c690b5361dd",
 "userInf":{"avatar_big":"https://s1-imfile.feishucdn.com/static-resource/v1/v3_007b_261f08da-80dd-4ce5-9d41-c6f56945e26g~?image_size=640x640&cut_type=&quality=&format=image&sticker_format=.webp",
            "avatar_middle":"https://s1-imfile.feishucdn.com/static-resource/v1/v3_007b_261f08da-80dd-4ce5-9d41-c6f56945e26g~?image_size=240x240&cut_type=&quality=&format=image&sticker_format=.webp",
            "avatar_thumb":"https://s1-imfile.feishucdn.com/static-resource/v1/v3_007b_261f08da-80dd-4ce5-9d41-c6f56945e26g~?image_size=72x72&cut_type=&quality=&format=image&sticker_format=.webp",
            "avatar_url":"https://s1-imfile.feishucdn.com/static-resource/v1/v3_007b_261f08da-80dd-4ce5-9d41-c6f56945e26g~?image_size=72x72&cut_type=&quality=&format=image&sticker_format=.webp",
            "email":"",
            "employee_no":"",
            "en_name":"王志承",
            "enterprise_email":"",
            "mobile":"+8618503056132",
            "name":"王志承",
            "open_id":"ou_1b3b96f6191d01e0e983eecc00d220d4",
            "tenant_key":"16c3bbc0005ed75d",
            "union_id":"on_44a9a8124cbbb66c2087df1eb9862a97",
            "user_id":"4b7e42d2"},
            "user_access_token":"u-fjvjfSNrJ25bIb7SeOdVb8gl5N7A00L1Oa0005gE046w",
            "freshUser_access_token":"ur-fwSz7roll4S84c70i4Y.lAgl5PD4007FMG00hl4E006B"}
```





userWang

`{"userCodeTemp":"65755f6e63-08eie956b2694e9e8d849c690b5361dd","userInf":{"avatar_big":"https://s1-imfile.feishucdn.com/static-resource/v1/v3_007b_261f08da-80dd-4ce5-9d41-c6f56945e26g~?image_size=640x640&cut_type=&quality=&format=image&sticker_format=.webp","avatar_middle":"https://s1-imfile.feishucdn.com/static-resource/v1/v3_007b_261f08da-80dd-4ce5-9d41-c6f56945e26g~?image_size=240x240&cut_type=&quality=&format=image&sticker_format=.webp","avatar_thumb":"https://s1-imfile.feishucdn.com/static-resource/v1/v3_007b_261f08da-80dd-4ce5-9d41-c6f56945e26g~?image_size=72x72&cut_type=&quality=&format=image&sticker_format=.webp","avatar_url":"https://s1-imfile.feishucdn.com/static-resource/v1/v3_007b_261f08da-80dd-4ce5-9d41-c6f56945e26g~?image_size=72x72&cut_type=&quality=&format=image&sticker_format=.webp","email":"","employee_no":"","en_name":"王志承","enterprise_email":"","mobile":"+8618503056132","name":"王志承","open_id":"ou_1b3b96f6191d01e0e983eecc00d220d4","tenant_key":"16c3bbc0005ed75d","union_id":"on_44a9a8124cbbb66c2087df1eb9862a97","user_id":"4b7e42d2"},"user_access_token":"u-fjvjfSNrJ25bIb7SeOdVb8gl5N7A00L1Oa0005gE046w","freshUser_access_token":"ur-fwSz7roll4S84c70i4Y.lAgl5PD4007FMG00hl4E006B"}`















# 源来微信小程序

## uniapp 微信小程序->传参到web-view;通信方式

![image-20240331112337883](C:\Users\Administrator\Desktop\workTable\flypro\flyoa_web\开发文档\frontWork.assets\image-20240331112337883.png)































