import axios from "axios";
import { useLoadStore } from "../store/load";
import { ElMessage } from "element-plus";
// 创建 axios 实例
const service = axios.create({
  timeout: 5000, // 请求超时时间
});

const useLoad = useLoadStore();
// request 拦截器
service.interceptors.request.use(
  (config) => {
    // 在发送请求之前做些什么
    useLoad.isLoad = true;
    // 例如，可以在这里设置请求头
    config.headers = {
      "Content-Type": "application/json;charset=UTF-8",
        // Authorization: "Bearer " + localStorage.getItem("token"),
    };

    return config;
  },
  (error) => {
    // 对请求错误做些什么
    console.log(error); // for debug
    return Promise.reject(error);
  }
);

// response 拦截器
service.interceptors.response.use(
  (response) => {
    // 对响应数据做点什么
    // ElMessage.success("请求成功");
    useLoad.isLoad = false;
    console.log(useLoad.isLoad, "load");

    // 可以在这里判断请求是否成功
 
    //前后端状态码协议可以在这里放着、后期再说吧
    return response;
  },
  (error) => {
    // 对响应错误做点什么
    console.log(error); // for debug
    ElMessage.error("服务器错误");
    return Promise.reject(error);
  }
);

export default service;
