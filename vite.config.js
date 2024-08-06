import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import { fileURLToPath, URL } from "node:url";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
  server: {
    hmr: {
      overlay: true, // 在页面上显示热更新的错误信息
    },
    // 配置傻鸟前端跨域
    proxy: {
      "/open-apis": {
        target: "https://open.feishu.cn", // 后端接口
        changeOrigin: true, // 是否跨域
        rewrite: (path) => path.replace(/^\/open-apis/, "/open-apis"),
      },
    },
  },
});
   