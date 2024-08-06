<template>
  <div class="container">
    <div class="userInf" v-if="userInf">
      <img class="userAvatar" v-if="userInf.avatar_big" :src="userInf.avatar_big" />
      <div class="userAvatar" v-else>
        <el-icon size="100">
          <Avatar />
        </el-icon>
      </div>
      <div class="userName">
        姓名：{{ userInf.name }}<br />
        电话号码：{{ userInf.mobile }}
      </div>
      <div class="userId">id: {{ userInf.union_id }}</div>
    </div>
    <div class="userInf" v-else>
      {{ userCodeTemp }}
    </div>
    {{ userCodeTemp }}1<br />
    {{ resp }}
    {{ resqqq }}
    {{ resxxa }}

  </div>
</template>

<script setup>
import { useRoute } from "vue-router";
import { useUserStore } from "../../store/user";
import { useAppStore } from "../../store/app";

import api from "../../api/index";
import { ref, onMounted } from "vue";
import { ElMessage } from "element-plus";

const fApi = api.flyApi;
const bApi = api.bcApi;

const useUser = useUserStore();
const useApp = useAppStore();

// UserCode 是 飞书中用户的限时登录凭证、利用
// 用于获取网页url传递的参数，(web-view:'http://127.0.0.1:3003/#/personalCenter?userCode=1&&xxx=xxx')
const route = useRoute();
console.log(route.query.userCode);
const userCodeTemp = ref("");
userCodeTemp.value = route.query.userCode;
//
useUser.userCodeTemp = userCodeTemp.value;
const userInfTobc = ref({
  user_name: useUser.userInf.name,
  user_avatorUrl: useUser.userInf.avatar_url,
  union_id: useUser.userInf.union_id,
  user_id: useUser.userInf.open_id,
});
const app_token = ref("");
const tenant_token = ref("");

const userInf = ref();

const getATacc_Uacc_Uinf = () => {
  userInf.value = useUser.userInf;
  console.log(userInf.value, "s");
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
      ElMessage.success("获取A·Taccess成功");
      getFlytokenUser();
    } else {
      console.log(res.data);
      ElMessage.error("获取A·Taccess失败");
    }
  });
};
const ressss = ref();
const resqqq = ref();
const getFlytokenUser = () => {
  resqqq.value = userCodeTemp.value;
  fApi
    .getUserAccessToken(
      {
        grant_type: "authorization_code",
        code: userCodeTemp.value,
      },
      app_token.value
    )
    .then((res) => {
      resp.value = res.data;
      console.log(res.data);
      if (res.data.code == 0) {
        console.log(res.data);
        useUser.user_access_token = res.data.data.access_token;
        useUser.freshUser_access_token = res.data.data.refresh_token;
        console.log(
          useUser.user_access_token,
          useUser.freshUser_access_token,
          "获取Usertoken和freshtoken成功"
        );
        ElMessage.success("获取Usertoken和freshtoken成功");
        getFlyinfUser();
      } else {
        console.log(res.data);
        ElMessage.error("获取Usertoken和freshtoken失败");
        getFlyinfUser();

        //用于网页端测试
        // bApi.inputMemberInf(userInfTobc.value).then(res => {
        //     console.log(res.data);
        //     ElMessage.success("用户信息入库（更新）成功")
        // })
      }
    });
};
const resp = ref();
const getFlyinfUser = () => {
  fApi.getUserInf(useUser.user_access_token).then((res) => {
    ressss.value = res.data;
    if (res.data.code == 0) {
      useUser.userInf = res.data.data;
      console.log(useUser.userInf, "获取用户信息成功");
      userInf.value = useUser.userInf;
      ElMessage.success("获取用户信息成功");
      bApi.inputMemberInf(userInfTobc.value).then((res) => {
        console.log(res);
        ElMessage.success("用户信息入库（更新）成功");
        useUser.userBcId = res.data.data.bcId;
      });
    } else {
      ElMessage.error(res.data.message);
      console.log(useUser.userInf);
      bApi.inputMemberInf(userInfTobc.value).then((res) => {
        console.log(res.data);
        ElMessage.success("入库用户信息获取成功");
      });
    }
  });
};

const InputMemberInftobc = () => { };
import axios from "axios";
const resxxa = ref()

const resxxb = ref()

onMounted(() => {
  userCodeTemp.value = route.query.userCode;
  const data = { code: userCodeTemp.value }
  resxxb.value = axios.post('http://127.0.0.1:8082/sys/user/login', data).then((res) => {
    return res.data
  })
  resxxa.value = resxxb.value.data
  // getATacc_Uacc_Uinf();
  // console.log(useUser.userInf);
});
</script>

<style lang="scss" scoped>
.userInf {
  margin-top: 12px;
  height: 200px;
  background-color: rgb(209, 249, 254);
  position: relative;
  display: flex;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12), 0 0 6px rgba(0, 0, 0, 0.04);
  border-radius: 20px;

  .userAvatar {
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

  .userName {
    position: absolute;
    margin-left: 190px;
    margin-top: 50px;
    font-size: 30px;
  }

  .userId {
    position: absolute;
    bottom: 55px;
    margin-left: 190px;
    color: grey;
  }
}
</style>