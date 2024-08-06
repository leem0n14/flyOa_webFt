<template>
  <div
    class="container"
    v-if="companyInf"
    style="display: flex; flex-direction: column; align-items: center"
  >
    <div class="companyInf">
      <img class="companyAvatar" :src="companyInf.avatar.avatar_640" />
      <div class="companyName">{{ companyInf.name }}</div>
      <div class="companyId">id: {{ companyInf.display_id }}</div>
    </div>
    <div class="companyMember">
      <!-- <span
        style="
          position: absolute;
          top: -32px;
          left: 10px;
          font-size: 30px;
          background-color: #ffffff;
          border: 1px solid #e6e6e6;
          border-radius: 12px;
          padding: 4px;
          box-shadow: 3px 4px 4px rgb(0, 0, 0, 0.1);
        "
        >企业成员</span
      > -->
      <div
        style="max-width: 480px"
        v-for="(item, index) in membersCardLists"
        :key="index"
        class="memberCard"
      >
        <div class="memberCardAvatarMask">
          <img class="memberCardAvatar" :src="item.img" alt="头像加载失败" />
        </div>
        <div class="memberCardMsg">
          <div style="font-size: 30px">{{ item.name }}</div>
          <div style="font-size: 18px">{{ item.position }}</div>
        </div>
      </div>
    </div>
  </div>
  <div class="container" v-else>
    <div class="companyInf"></div>
  </div>

  <!-- <div>{{ ress }}</div> -->
</template>

<style lang="scss" scoped>
.companyInf {
  margin-top: 12px;
  width: 100%;
  height: 200px;
  background-color: rgb(209, 249, 254);
  position: relative;
  display: flex;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12), 0 0 6px rgba(0, 0, 0, 0.04);
  border-radius: 20px;

  .companyAvatar {
    margin-left: 30px;
    margin-top: 20px;
    height: 150px;
    width: 150px;
    border-radius: 100%;
    background-color: #ffffff;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .companyName {
    position: absolute;
    margin-left: 190px;
    margin-top: 50px;
    font-size: 30px;
  }

  .companyId {
    position: absolute;
    bottom: 55px;
    margin-left: 190px;
    color: grey;
  }
}

.companyMember {
  position: relative;
  border: #e4e7ed 1px solid;
  border-radius: 12px;
  margin-top: 12px;
  width: 90%;
  padding-top: 20px;
  display: grid; /* 使用grid布局 */
  grid-template-columns: repeat(4, 1fr); /* 创建四列，每列占据等比例空间 */
  gap: 40px; /* 设置卡片之间的间隔 */
  justify-items: center; /* 水平居中显示卡片 */
  align-items: start; /* 垂直方向上卡片靠顶部对齐 */
  .memberCard {
    height: 220px;
    width: 280px;
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #ffffff;
    border: #e4e7ed 1px solid;
    border-radius: 12px;
    transition: 0.3s all;
    cursor: pointer;
    padding: 5px;
    padding-bottom: 12px;
    &:hover {
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12), 0 0 6px rgba(0, 0, 0, 0.04);
    }
    .memberCardAvatarMask {
      width: 100%;
      display: flex;
      justify-content: center;
      background-image: url("data:image/svg+xml,<svg id='patternId' width='100%' height='100%' xmlns='http://www.w3.org/2000/svg'><defs><pattern id='a' patternUnits='userSpaceOnUse' width='35.584' height='30.585' patternTransform='scale(1) rotate(175)'><rect x='0' y='0' width='100%' height='100%' fill='hsla(3, 0%, 100%, 1)'/><path d='M36.908 9.243c-5.014 0-7.266 3.575-7.266 7.117 0 3.376 2.45 5.726 5.959 5.726 1.307 0 2.45-.463 3.244-1.307.744-.811 1.125-1.903 1.042-3.095-.066-.811-.546-1.655-1.274-2.185-.596-.447-1.639-.894-3.162-.546-.48.1-.778.58-.662 1.06.1.48.58.777 1.06.661.695-.149 1.274-.066 1.705.249.364.265.546.645.562.893.05.679-.165 1.308-.579 1.755-.446.48-1.125.744-1.936.744-2.55 0-4.188-1.538-4.188-3.938 0-2.466 1.44-5.347 5.495-5.347 2.897 0 6.008 1.888 6.388 6.058.166 1.804.067 5.147-2.598 7.034a.868.868 0 00-.142.122c-1.311.783-2.87 1.301-4.972 1.301-4.088 0-6.123-1.952-8.275-4.021-2.317-2.218-4.7-4.518-9.517-4.518-4.094 0-6.439 1.676-8.479 3.545.227-1.102.289-2.307.17-3.596-.496-5.263-4.567-7.662-8.159-7.662-5.015 0-7.265 3.574-7.265 7.116 0 3.377 2.45 5.727 5.958 5.727 1.307 0 2.449-.463 3.243-1.308.745-.81 1.126-1.903 1.043-3.095-.066-.81-.546-1.654-1.274-2.184-.596-.447-1.639-.894-3.161-.546-.48.1-.778.58-.662 1.06.099.48.579.777 1.059.66.695-.148 1.275-.065 1.705.25.364.264.546.645.563.893.05.679-.166 1.307-.58 1.754-.447.48-1.125.745-1.936.745-2.549 0-4.188-1.539-4.188-3.939 0-2.466 1.44-5.345 5.495-5.345 2.897 0 6.008 1.87 6.389 6.057.163 1.781.064 5.06-2.504 6.96-1.36.864-2.978 1.447-5.209 1.447-4.088 0-6.124-1.952-8.275-4.021-2.317-2.218-4.7-4.518-9.516-4.518v1.787c4.088 0 6.123 1.953 8.275 4.022 2.317 2.218 4.7 4.518 9.516 4.518 4.8 0 7.2-2.3 9.517-4.518 2.151-2.069 4.187-4.022 8.275-4.022s6.124 1.953 8.275 4.022c2.318 2.218 4.701 4.518 9.517 4.518 4.8 0 7.2-2.3 9.516-4.518 2.152-2.069 4.188-4.022 8.276-4.022s6.123 1.953 8.275 4.022c2.317 2.218 4.7 4.518 9.517 4.518v-1.788c-4.088 0-6.124-1.952-8.275-4.021-2.318-2.218-4.701-4.518-9.517-4.518-4.103 0-6.45 1.683-8.492 3.556.237-1.118.304-2.343.184-3.656-.497-5.263-4.568-7.663-8.16-7.663z'  stroke-width='1' stroke='none' fill='hsla(191, 83%, 56%, 1)'/><path d='M23.42 41.086a.896.896 0 01-.729-.38.883.883 0 01.215-1.242c2.665-1.887 2.764-5.23 2.599-7.034-.38-4.187-3.492-6.058-6.389-6.058-4.055 0-5.495 2.88-5.495 5.346 0 2.4 1.639 3.94 4.188 3.94.81 0 1.49-.265 1.936-.745.414-.447.63-1.076.58-1.755-.017-.248-.2-.629-.547-.893-.43-.315-1.026-.398-1.704-.249a.868.868 0 01-1.06-.662.868.868 0 01.662-1.059c1.523-.348 2.566.1 3.161.546.729.53 1.209 1.374 1.275 2.185.083 1.191-.298 2.284-1.043 3.095-.794.844-1.936 1.307-3.244 1.307-3.508 0-5.958-2.35-5.958-5.726 0-3.542 2.25-7.117 7.266-7.117 3.591 0 7.663 2.4 8.16 7.663.347 3.79-.828 6.868-3.344 8.656a.824.824 0 01-.53.182zm0-30.585a.896.896 0 01-.729-.38.883.883 0 01.215-1.242c2.665-1.887 2.764-5.23 2.599-7.034-.381-4.187-3.493-6.058-6.389-6.058-4.055 0-5.495 2.88-5.495 5.346 0 2.4 1.639 3.94 4.188 3.94.81 0 1.49-.266 1.936-.746.414-.446.629-1.075.58-1.754-.017-.248-.2-.629-.547-.894-.43-.314-1.026-.397-1.705-.248A.868.868 0 0117.014.77a.868.868 0 01.662-1.06c1.523-.347 2.566.1 3.161.547.729.53 1.209 1.374 1.275 2.185.083 1.191-.298 2.284-1.043 3.095-.794.844-1.936 1.307-3.244 1.307-3.508 0-5.958-2.35-5.958-5.726 0-3.542 2.25-7.117 7.266-7.117 3.591 0 7.663 2.4 8.16 7.663.347 3.79-.828 6.868-3.344 8.656a.824.824 0 01-.53.182zm29.956 1.572c-4.8 0-7.2-2.3-9.517-4.518-2.151-2.069-4.187-4.022-8.275-4.022S29.46 5.486 27.31 7.555c-2.317 2.218-4.7 4.518-9.517 4.518-4.8 0-7.2-2.3-9.516-4.518C6.124 5.486 4.088 3.533 0 3.533s-6.124 1.953-8.275 4.022c-2.317 2.218-4.7 4.518-9.517 4.518-4.8 0-7.2-2.3-9.516-4.518-2.152-2.069-4.188-4.022-8.276-4.022V1.746c4.8 0 7.2 2.3 9.517 4.518 2.152 2.069 4.187 4.022 8.275 4.022s6.124-1.953 8.276-4.022C-7.2 4.046-4.816 1.746 0 1.746c4.8 0 7.2 2.3 9.517 4.518 2.151 2.069 4.187 4.022 8.275 4.022s6.124-1.953 8.275-4.022c2.318-2.218 4.7-4.518 9.517-4.518 4.8 0 7.2 2.3 9.517 4.518 2.151 2.069 4.187 4.022 8.275 4.022s6.124-1.953 8.275-4.022c2.317-2.218 4.7-4.518 9.517-4.518v1.787c-4.088 0-6.124 1.953-8.275 4.022-2.317 2.234-4.717 4.518-9.517 4.518z'  stroke-width='1' stroke='none' fill='hsla(186, 100%, 49%, 1)'/></pattern></defs><rect width='800%' height='800%' transform='translate(0,0)' fill='url(%23a)'/></svg>");
      .memberCardAvatar {
        height: 120px;
        width: 120px;
        border: #ffffff 7px solid;
        border-radius: 100%;
      }
    }

    .memberCardMsg {
      z-index: 12;
      margin-top: 12px;
      text-align: center;
    }
  }
}
</style>

<script setup>
import api from "../../api/index";
import { ref, onMounted, onBeforeMount } from "vue";
import { ElMessage } from "element-plus";
import { useUserStore } from "../../store/user";
import { useAppStore } from "../../store/app";
import { useCompanyStore } from "../../store/company";

const fApi = api.flyApi;
const bApi = api.bcApi;
const companyName = ref("测试企业一");
const companyInf = ref();
const useUser = useUserStore();
const useApp = useAppStore();
const useCompany = useCompanyStore();

const app_token = ref("");
const tenant_token = ref("");

const getAT_CInf = () => {
  companyInf.value = useCompany.company_inf;
  fApi.getATAccessToken().then((res) => {
    // console.log(res.data)
    if (res.data.app_access_token && res.data.tenant_access_token) {
      app_token.value = res.data.app_access_token;
      tenant_token.value = res.data.tenant_access_token;
      // console.log(app_token.value, tenant_token.value)
      useApp.app_access_token = app_token.value;
      useApp.tenant_access_token = tenant_token.value;
      console.log(
        useApp.app_access_token,
        useApp.tenant_access_token,
        "获取A·Taccess成功"
      );
      // ElMessage.success("获取A·Taccess成功")
      //做个访问钩子限制访问
      if (companyInf.value) {
        getFlyinfCompany();
      }
    } else {
      ElMessage.error("获取A·Taccess失败");
    }
  });
};

// 转载在前台的console ress
const ress = ref(1111111);

const getFlyinfCompany = () => {
  fApi.getConpanyInf(tenant_token.value).then((res) => {
    if (res.data.code == 0) {
      ress.value = res.data.data.tenant;
      console.log(ress.value, "ress");
      useCompany.company_inf = res.data.data.tenant;
      companyInf.value = useCompany.company_inf;
      ElMessage.success("获取公司信息成功");
      bApi
        .inputCompanyInf({
          company_tenantKey: useCompany.company_inf.tenant_key,
          company_displayId: useCompany.company_inf.display_id,
          company_name: useCompany.company_inf.name,
          //--------------------------------------------------------------------------------------------记得改后端400 重新判断
        })
        .then((res) => {
          if (res.status == 200) {
            ElMessage.success("公司信息入库成功");
          }
        })
        .catch((err) => {
          console.log(err, "err");
          if (err.response.data.message == "企业名称重复,请更换后重试！") {
            ElMessage("公司信息已存在");
          }
        });
    } else {
      ElMessage.success("获取公司信息失败");
    }
  });
};

onMounted(() => {
  getAT_CInf();
});

const membersCardLists = ref([
  {
    name: "张三",
    position: "前端开发",
    img: "../../../public/avaters/Agent Smith.png",
  },
  {
    name: "张三",
    position: "前端开发",
    img: "../../../public/avaters/Agent Smith.png",
  },
  {
    name: "张三",
    position: "前端开发",
    img: "../../../public/avaters/Agent Smith.png",
  },
  {
    name: "张三",
    position: "前端开发",
    img: "../../../public/avaters/Agent Smith.png",
  },
  {
    name: "张三",
    position: "前端开发",
    img: "../../../public/avaters/Agent Smith.png",
  },
  {
    name: "张三",
    position: "前端开发",
    img: "../../../public/avaters/Agent Smith.png",
  },
  {
    name: "张三",
    position: "前端开发",
    img: "../../../public/avaters/Agent Smith.png",
  },
  {
    name: "张三",
    position: "前端开发",
    img: "../../../public/avaters/Agent Smith.png",
  },
  {
    name: "张三",
    position: "前端开发",
    img: "../../../public/avaters/Agent Smith.png",
  },
]);
</script>