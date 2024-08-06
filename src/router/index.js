import { createRouter, createWebHashHistory } from "vue-router";
import { ref } from "vue";
const routes = [
  {
    path: "/",
    name: "layout",
    component: () => import("../views/layout.vue"),
    redirect: { path: "/personalCenter" },
    children: [
      //needRole: 需要权限的角色
      //project---------------------------------
      {
        path: "/myProject",
        name: "我参与的",
        icon: "Histogram",
        needRole: "user",
        meta: {
          ifSide: true,
          projectNav: true,
        },

        component: () => import("../views/projectviews/myProject.vue"),
      },
      {
        path: "/projectManagement",
        name: "项目管理",
        icon: "DataAnalysis",
        needRole: "user",
        meta: {
          needProject: true,
          ifSide: false,
          projectNav: true,
        },
        component: () => import("../views/projectviews/projectManagement.vue"),
      },
      {
        path: "/taskManagement",
        name: "任务管理",
        icon: "DataAnalysis",
        needRole: "user",
        meta: {
          needProject: true,
          ifSide: false,
          projectNav: true,
        },
        component: () => import("../views/projectviews/taskManagement.vue"),
      },
      {
        path: "/apForReimbursement",
        name: "报销申请",
        icon: "DataAnalysis",
        needRole: "user",
        meta: {
          needProject: true,
          ifSide: false,
          projectNav: true,
        },
        component: () => import("../views/projectviews/apForReimbursement.vue"),
      },
      {
        path: "/apForOfficialSeal",
        name: "公章申请",
        icon: "DataAnalysis",
        needRole: "user",
        meta: {
          needProject: true,
          ifSide: false,
          projectNav: true,
        },
        component: () => import("../views/projectviews/apForOfficialSeal.vue"),
      },
      //  {
      //   path: "/cc",
      //   name: "cc",
      //   icon: "DataAnalysis",
      //   needRole: "user",
      //   meta: {
      //     needProject: true,
      //     ifSide: false,
      //     projectNav: true,
      //   },
      //   component: () => import("../views/projectviews/cc.vue"),
      // },
      //project---------------------------------
      //personal++++++++++++++++++++++++++++++++
      {
        path: "/personalCenter",
        name: "个人中心",
        icon: "avatar",
        needRole: "user",
        meta: {
          ifSide: true,
          projectNav: false,
        },
        component: () => import("../views/personalviews/personalCenter.vue"),
      },
      {
        path: "/CompanyCenter",
        name: "企业管理",
        icon: "SuitcaseLine",
        needRole: "companyLeader",
        meta: {
          ifSide: true,
          projectNav: false,
        },

        component: () => import("../views/personalviews/CompanyCenter.vue"),
      },

      {
        path: "/ContractManagement",
        name: "合同管理",
        icon: "SuitcaseLine",
        needRole: "companyLeader",
        meta: {
          ifSide: true,
          projectNav: false,
        },
        component: () => import("../views/companyviews/ContractManagement.vue"),
      },
    ],
  },
  {
    path: "/:catchAll(.*)",
    redirect: "/personalCenter", // 重定向到个人中心页面
  },
];
const activePage = ref({
  name: "",
  path: "",
  projectNav: "",
  needProject: "",
});

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  activePage,
});
router.beforeEach((to, from, next) => {
  activePage.value.name = to.name;
  activePage.value.path = to.path;
  activePage.value.projectNav = to.meta.projectNav;
  activePage.value.needProject = to.meta.needProject;
  document.title = `M&I_${to.name}`;

  next();
});
export default router;
