import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router";
import piniaPersist from "pinia-plugin-persistedstate";
import naive from "naive-ui";
import ElementPlus from "element-plus";
import "element-plus/dist/index.css";
import * as ElementPlusIconsVue from "@element-plus/icons-vue";
import zhCn from "element-plus/es/locale/lang/zh-cn";

import * as echarts from "echarts";

const app = createApp(App);
const pinia = createPinia();
pinia.use(piniaPersist);

for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component);
}
app.use(pinia);
app.use(naive);

app.use(ElementPlus, {
  locale: zhCn,
});

app.use(router);
app.mount("#app");

app.directive("side", {
  //ifSide是否为侧边菜单栏内容
  mounted(el, binding) {
    if (!binding.value) {
      el.style.display = "none";
    }
  },
});

import { useProjectStore } from "./store/project";
const useProject = useProjectStore();

app.directive("projectNav", {
  mounted(el, binding) {
    if (!binding.value.projectNav) {
      el.style.display = "none";
    }
  },
});

import { nextTick } from "vue";

app.directive("autofocus", {
  mounted: function (el, binding) {
    console.log("1111", binding, el);

    // 使用nextTick以确保元素已经插入到DOM中
    const focus = () => {
      if (binding.value) {
        el.querySelector("input").focus();
      }
    };

    // 可以在这里调用focus函数
    // 但通常我们使用nextTick来确保元素已经完全准备好
    nextTick(focus);
  },
});
