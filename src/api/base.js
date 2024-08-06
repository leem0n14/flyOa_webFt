const base = {
  // baseUrl: "http://192.168.137.75:8080/sys", //lee热点下慧的服务器
  // baseUrl: "http://127.0.0.1:8080/sys", //本地测试
  //云服务器要把https的s删掉
  baseUrl: "http://47.120.71.204:8080/sys", //我的云

  flyUrl: "https://open.feishu.cn", //飞书开发服务器 
  //Moon&Intelligent appconfig
  headers: {
    "Content-Type": "application/json",
  },
  appConfig: {
    app_id: "cli_a5530a28a3f8d00d",
    app_secret: "xi1m3dkJ1GyQjla9PjCIPeIoBPp0nWgl",
  },

  //飞书后端
  // 自建应用获取 app_access_token和tenant_access_token
  flyATAccessToken: "/open-apis/auth/v3/app_access_token/internal",
  //自建应用获取 user_access_token
  flyUAccessToken: "/open-apis/authen/v1/oidc/access_token",
  //获取飞书用户信息
  flyUInf: "/open-apis/authen/v1/user_info",
  //获取飞书企业信息
  flyCInf: "/open-apis/tenant/v2/tenant/query",

  //云服务器后端
  //获取所有项目
  bcEventAll: "/EveInf/GetEvels",
  // 获取XXX参与的项目、传参user_id
  bcEventByMember: "/EveInf/SearchEventByMember",
  //获取项目下不同状态下的任务数目统计
  bcEventTaskStatusCount: "/EveInf/CountTaskStatusByEventId",

  //删除项目/:eventId(delete)
  deleteEventById: "/EveInf/DeleteEvent",
  //项目详情获取（detail+member)
  bcEventDetailbyId: "/EveInf/SearchEventDetailByEventId",

  //获取项目下所有任务
  bcTaskById: "/EveInf/SearchTasksByEventId",
  //项目内新建任务
  bcNewEventTask: "/EveInf/createTask",
  //修改任务负责人
  bcUpdateTaskLeader: "/EveInf/UpdateTaskLeaderById",
  //修改任务状态
  bcUpdateTaskStatu: "/EveInf/UpdateTaskStatuById",

  //获取项目下所有报销记录
  bcReimbursementByEventId: "/EveInf/SearchOutpayByEventId",
  //新增报销
  bcNewReimbursement: "/EveInf/ApplyReimbursement",
  //修改报销状态
  bcUpdateReimbursementStatu: "/EveInf/UpdateOutpayStatus",
  ///获取项目下报销统计
  bcReimbursementTotalByEventId: "/EveInf/SearchOutpayTotalNumByEventId",

  //获取项目下所有公章记录
  bcEventhOfficialSealRecord: "/EveInf/SearchOfficialSealByEventId",
  //发出公章申请
  bcNewOfficialSealRecord: "/EveInf/ApplyOfficialSeal",
  //修改公章状态
  bcUpdateOfficialSealRecord: "/EveInf/UpdateOfficialSealStatu",

  // 开票
  bcNewInvoice: "/EveInf/ApplyInvoice",
  // 修改开票记录
  bcUpdateInvoice: "/EveInf/UpdateInvoice",


  //企业入库
  bcCompanyInf_Input: "/EveInf/CreateCompany",
  bcCompanyAllMember: "/EveInf/getAllMembers",


  //用户数据入库
  bcMemberInf_Input: "/EveInf/EntryMemberData",
  //用户加入企业
  bcMemberIntoCompany: "/EveInf/AddMemberIntoCompany",

  //新建项目入库
  bcNewEvent: "/EveInf/CreateEvent",
  //用户加入项目
  bcMemberIntoEvent: "/EveInf/AddMemberIntoEvent",
  //上传
  bcupload: "/EveInf/UploadFile",
  bcdownload: "/EveInf/DownloadFile/",
};

export default base;
