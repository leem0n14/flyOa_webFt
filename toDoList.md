- [ ] 请求加载动画，建议封装成新的axios方法：

  e.g：

  ```js
  import axios from 'axios';
  import { ElLoading } from 'element-plus';
  
  // 定义一个变量用于存储加载动画实例
  let loadingInstance;
  
  // 创建axios实例
  const http = axios.create({
    baseURL: '你的API基础URL', // 根据实际情况设置
    timeout: 10000, // 请求超时时间
  });
  
  // 请求拦截器
  http.interceptors.request.use(
    config => {
      // 在请求发送前显示加载动画
      loadingInstance = ElLoading.service({ fullscreen: true });
      return config;
    },
    error => {
      // 错误处理
      return Promise.reject(error);
    }
  );
  
  // 响应拦截器
  http.interceptors.response.use(
    response => {
      // 请求完成后关闭加载动画
      if (loadingInstance) loadingInstance.close();
      return response;
    },
    error => {
      // 错误处理
      if (loadingInstance) loadingInstance.close();
      return Promise.reject(error);
    }
  );
  
  export default http;
  
  ```

  

- [ ] 页面撸完

- [ ] 减少请求：
  通过判断是否更新了新的信息
  通过判断store中是否为空，如果为空则重新获取！

- [ ] 云服务器请求被挂起

