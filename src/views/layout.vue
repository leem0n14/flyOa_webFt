<template>
  <el-container class="layoutContainer">
    <el-aside :width="isCollapse ? '64px' : '180px'">
      <div class="asideMenuBottom"></div>

      <el-menu
        background-color="#122037"
        active-text-color="#ffd04b"
        text-color="#fff"
        router
        :collapse="isCollapse"
        :default-active="router.options.activePage.value.path"
        class="el-menu-vertical-demo"
      >
        <div></div>
        <!-- <div>商标</div> -->
        <el-menu-item
          v-for="(item, index) in sideMenu"
          :key="index"
          :index="item.path"
          v-side="item.meta.ifSide"
        >
          <el-icon>
            <component :is="item.icon"></component>
          </el-icon>
          <template #title>
            <span>{{ item.name }}</span>
          </template>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header>
        <div class="collapseBtn" @click="collapseChange">
          <el-icon>
            <ArrowLeftBold v-if="isCollapse" />
            <ArrowRightBold v-else />
          </el-icon>
        </div>
        <div class="title">{{ router.options.activePage.value.name }}</div>
        <el-menu
          router
          mode="horizontal"
          :ellipsis="false"
          class="HeaderNav"
          :default-active="$route.path"
          v-if="router.options.activePage.value.projectNav"
        >
          <el-menu-item
            v-for="(item, index) in navProjectMenu"
            :key="index"
            :index="item.path"
            v-projectNav="item.meta"
            :disabled="needProject(item.meta)"
          >
            <el-icon>
              <component :is="item.icon"></component>
            </el-icon>
            <template #title>
              <span>{{ item.name }}</span>
            </template>
          </el-menu-item>
        </el-menu>
      </el-header>
      <el-main>
        <router-view></router-view>
      </el-main>
      <!-- <el-footer>Footer</el-footer> -->
    </el-container>
  </el-container>
</template>
<script setup>
import { ref } from "vue";
import router from "../router";
import { useProjectStore } from "../store/project";
const useProject = useProjectStore();
const routers = ref(null);
//路由配置->菜单配置
routers.value = router.options.routes;
const sideMenu = ref();
sideMenu.value = routers.value[0].children;
const navProjectMenu = ref();
navProjectMenu.value = routers.value[0].children;

const needProject = (meta) => {
  if (meta.needProject == true && useProject.project_judgment == false) {
    return true;
  }
  return false;
};

//折叠
const isCollapse = ref(false);
const collapseChange = () => {
  isCollapse.value = !isCollapse.value;
};
const navActivePage = ref();
navActivePage.value = router.options.activePage.value.path;
</script>

<style lang="scss">
.layoutContainer {
  height: 100vh;
  width: 100vw;

  .el-aside {
    transition: 0.3s ease all;
    border-right: 1px rgba(128, 128, 128, 0.264) solid !important;
    overflow: hidden !important;
    position: relative;
    background-color: #122037;
    //智慧
    .asideMenuBottom {
      z-index: 10;
      position: absolute;
      bottom: 0px;
      height: 300px;
      width: 100%;
      background-image: url("data:image/svg+xml,<svg id='patternId' width='100%' height='100%' xmlns='http://www.w3.org/2000/svg'><defs><pattern id='a' patternUnits='userSpaceOnUse' width='20' height='20' patternTransform='scale(4) rotate(180)'><rect x='0' y='0' width='100%' height='100%' fill='hsla(44, 72%, 58%, 1)'/><path d='M-10-10A10 10 0 00-20 0a10 10 0 0010 10A10 10 0 010 0a10 10 0 00-10-10zM10-10A10 10 0 000 0a10 10 0 0110 10A10 10 0 0120 0a10 10 0 00-10-10zM30-10A10 10 0 0020 0a10 10 0 0110 10A10 10 0 0140 0a10 10 0 00-10-10zM-10 10a10 10 0 00-10 10 10 10 0 0010 10A10 10 0 010 20a10 10 0 00-10-10zM10 10A10 10 0 000 20a10 10 0 0110 10 10 10 0 0110-10 10 10 0 00-10-10zM30 10a10 10 0 00-10 10 10 10 0 0110 10 10 10 0 0110-10 10 10 0 00-10-10z'  stroke-width='1' stroke='none' fill='hsla(217, 51%, 14%, 1)'/></pattern></defs><rect width='800%' height='800%' transform='translate(-84,-80)' fill='url(%23a)'/></svg>");
    }
    .el-menu {
      padding-top: 200px;
      transition: 0.3s ease all !important;
      height: 100% !important;
      border-right: none !important;
    }
  }

  .el-container {
    // background-color: #f0f0f0;
    background-image: url("data:image/svg+xml,<svg id='patternId' width='100%' height='100%' xmlns='http://www.w3.org/2000/svg'><defs><pattern id='a' patternUnits='userSpaceOnUse' width='160' height='160' patternTransform='scale(2) rotate(0)'><rect x='0' y='0' width='100%' height='100%' fill='hsla(0, 0%, 94%, 1)'/><path d='M121.5 39.5V9.169c0-2.827 1.724-4.707 3.473-5.602l.707-.362c2.086-1.068 4.702-.631 6.359 1.026l1.985 1.985c1.349 1.349 3.235 2.018 5.14 2.128 12.336 0 12.336-18.505 0-18.505M40.75 39.499V9.17c0-2.827-1.724-4.707-3.473-5.602l-.707-.362c-2.086-1.068-4.702-.631-6.359 1.026l-1.985 1.985c-1.349 1.349-3.236 2.018-5.14 2.128-12.336 0-12.336-18.505 0-18.505m146.575 111.248c0-12.337-18.505-12.337-18.505 0 .11 1.904.78 3.79 2.128 5.139l1.985 1.985c1.657 1.657 2.094 4.273 1.026 6.36l-.362.706c-.895 1.75-2.775 3.474-5.602 3.474l-30.33-.001m49.66-63.086c0 12.336-18.505 12.336-18.505 0 .11-1.904.78-3.791 2.128-5.14l1.985-1.985c1.657-1.657 2.094-4.273 1.026-6.359l-.362-.707c-.895-1.749-2.775-3.474-5.602-3.473h-30.33m19.162 130.344c12.337 0 12.337-18.505 0-18.505-1.631 0-3.99.98-5.139 2.128l-1.985 1.985c-1.656 1.656-4.274 2.094-6.36 1.027l-.706-.362c-2.086-1.069-3.474-3.258-3.474-5.602v-34.302l.001-26.228c0-2.344-1.427-4.458-3.473-5.602l-.707-.361a5.83 5.83 0 00-6.36 1.026l-1.984 1.985c-1.144 1.152-3.508 2.128-5.14 2.128-12.336 0-12.336-18.505 0-18.505 1.904.11 3.715.86 5.14 2.128l1.985 1.985a5.812 5.812 0 006.359 1.026l.707-.362c1.287-1.485 3.473-2.775 3.473-5.602v-30.33M23.086 168.343c-12.336 0-12.336-18.505 0-18.505 1.632 0 3.992.98 5.14 2.128l1.985 1.985c1.656 1.656 4.274 2.094 6.359 1.027l.707-.362c2.086-1.069 3.474-3.258 3.474-5.602l-.001-34.302V88.485c0-2.344 1.387-4.533 3.473-5.602l.707-.361c2.085-1.068 4.703-.63 6.359 1.026l1.985 1.985c1.148 1.148 3.508 2.128 5.14 2.128 12.336 0 12.336-18.505 0-18.505-1.905.11-3.791.78-5.14 2.128l-1.985 1.985c-1.657 1.657-4.273 2.094-6.36 1.026l-.706-.362c-1.75-.895-3.474-2.775-3.474-5.602v-30.33m80.75 80.749H91.17c-2.827 0-4.707 1.724-5.602 3.473l-.362.707c-1.068 2.086-.631 4.702 1.026 6.359l1.985 1.985c1.349 1.349 2.018 3.236 2.128 5.14 0 12.336-18.505 12.336-18.505 0 0-1.632.98-3.992 2.128-5.14l1.985-1.985c1.656-1.656 2.094-4.274 1.026-6.359l-.361-.707c-1.069-2.086-3.258-3.474-5.602-3.473h-60.53c-2.344 0-4.533-1.387-5.602-3.473l-.362-.707c-1.067-2.085-.63-4.703 1.027-6.359l1.985-1.985c1.148-1.148 2.128-3.508 2.128-5.14 0-12.336-18.505-12.336-18.505 0M121.5 38H91.169c-2.827 0-4.707-1.724-5.602-3.473l-.362-.707c-1.068-2.086-.631-4.702 1.026-6.359l1.985-1.985c1.349-1.349 2.018-3.235 2.128-5.14C90.344 8 71.84 8 71.84 20.337c0 1.632.977 3.994 2.128 5.14.663.66 1.343 1.305 1.985 1.985 1.608 1.703 2.003 4.23 1.026 6.36-.11.24-.233.474-.361.706C75.48 36.577 73.359 38 71.015 38H36.712L10.485 38c-2.344 0-4.533 1.387-5.602 3.473-.12.236-.24.471-.362.707-1.067 2.085-.63 4.703 1.027 6.36l1.985 1.984c1.148 1.148 2.128 3.508 2.128 5.14C9.66 68-8.844 68-8.844 55.664'  stroke-width='1' stroke='hsla(217, 51%, 14%, 1)' fill='none'/></pattern></defs><rect width='800%' height='800%' transform='translate(0,0)' fill='url(%23a)'/></svg>");
    .el-header {
      padding: 10px;
      height: 80px;
      background-color: white;
      display: flex;
      align-items: center;
      gap: 20px;

      .collapseBtn {
        height: 50px;
        width: 50px;
        border-right: 7px solid #477bce;
        font-size: 30px;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
      }

      .title {
        font-size: 35px;
        height: 50px;
        vertical-align: bottom;
      }

      .HeaderNav {
        height: 80px;
      }
    }

    .el-main {
      .container {
        background-color: white;
        border-radius: 5px;
        min-width: 100%;
        min-height: 100%;
        padding: 10px;
        box-sizing: border-box;
        box-shadow: 4px 1px 12px rgba(0, 0, 0, 0.311);
      }
    }

    .el-footer {
      height: 3vh;
      background-color: white;
      display: flex;
    }
  }
}
</style>
