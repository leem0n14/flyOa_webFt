import axios from "axios";
import base from "./base.js";
import service from "../utils/request.js";
const api = {
  //做了跨域处理，所以飞书接口中只要包含/open-apis/会被重定向到https://open.feishu.cn
  flyApi: {
    // 获取AT权限、建议多获取几次啊哈哈哈
    getATAccessToken() {
      return axios({
        url: base.flyATAccessToken,
        method: "POST",
        data: base.appConfig,
        headers: "application/json;charset=UTF-8",
      });
    },
    //获取 用户资源 权限
    getUserAccessToken(parms, appAccessToken) {
      return axios({
        method: "POST",
        url: base.flyUAccessToken,
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + appAccessToken,
        },
        data: parms,
      });
    },
    // 获取 用户信息
    getUserInf(userAccessToken) {
      return axios({
        method: "GET",
        url: base.flyUInf,
        headers: {
          Authorization: "Bearer " + userAccessToken,
        },
      });
    },
    // 获取 企业信息
    getConpanyInf(tenantAccessToken) {
      return axios({
        method: "GET",
        url: base.flyCInf,
        headers: {
          Authorization: "Bearer " + tenantAccessToken,
        },
      });
    },
  },
  bcApi: {
    getEventAll() {
      return service.get(base.baseUrl + base.bcEventAll);
    },
    getEventMy(data) {
      return service.post(base.baseUrl + base.bcEventByMember, data);
    },
    getEventTaskStatusCount(data) {
      return service.post(base.baseUrl + base.bcEventTaskStatusCount, data);
    },
    getEventDetailbyId(data) {
      return service.post(base.baseUrl + base.bcEventDetailbyId, data);
    },
    inputMemberInf(data) {
      return service.post(base.baseUrl + base.bcMemberInf_Input, data);
    },
    inputCompanyInf(data) {
      return service.post(base.baseUrl + base.bcCompanyInf_Input, data);
    },
    addMemberIntoCopmany(data) {
      return service.post(base.baseUrl + base.bcMemberIntoCompany, data);
    },
    inputEventInf(data) {
      return service.post(base.baseUrl + base.bcNewEvent, data);
    },
    addMemberIntoEvent(data) {
      return service.post(base.baseUrl + base.bcMemberIntoEvent, data);
    },
    addTaskIntoEvent(data) {
      return service.post(base.baseUrl + base.bcNewEventTask, data);
    },
    updateTaskLeader(data) {
      return service.post(base.baseUrl + base.bcUpdateTaskLeader, data);
    },
    updateTaskStatu(data) {
      return service.post(base.baseUrl + base.bcUpdateTaskStatu, data);
    },
    getTaskbyId(data) {
      return service.post(base.baseUrl + base.bcTaskById, data);
    },


    getReimbursementbyId(data) {
      return service.post(base.baseUrl + base.bcReimbursementByEventId, data);
    },
    addReimbursementIntoEvent(data) {
      return service.post(base.baseUrl + base.bcNewReimbursement, data);
    },
    updateReimbursementStatu(data) {
      return service.post(base.baseUrl + base.bcUpdateReimbursementStatu, data);
    },
    getReimbursementTotalbyId(data) {
      return service.post(base.baseUrl + base.bcReimbursementTotalByEventId, data);
    },



    getOfficialSealbyId(data) {
      return service.post(base.baseUrl + base.bcEventhOfficialSealRecord, data);
    },
    addOfficialSealIntoEvent(data) {
      return service.post(base.baseUrl + base.bcNewOfficialSealRecord, data);
    },
    updateOfficialSealStatu(data) {
      return service.post(base.baseUrl + base.bcUpdateOfficialSealRecord, data);
    },

    bcNewInvoice(data) {
      return service.post(base.baseUrl + base.bcNewInvoice, data);
    },
    bcUpdateInvoice(data) {
      return service.post(base.baseUrl + base.bcUpdateInvoice, data);
    },



    uploadFile(data) {
      const config = {
        headers: {
          'Content-Type': 'multipart/form-data', // 通常用于文件上传
        },
      };
      return axios.post(base.baseUrl + base.bcupload, data, config);
      // return axios.post("http://172.21.160.227:8082/sys/EveInf/uploadFile", data, config);

    },
    bcdownloadFile(data) {
      return axios.get(base.baseUrl + base.bcdownload);
    },
  },
};

export default api;
