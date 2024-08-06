// vite.config.js
import { defineConfig } from "file:///C:/Users/Administrator/Desktop/workTable/flypro/flyoa_web/node_modules/.pnpm/vite@5.1.5_sass@1.71.1/node_modules/vite/dist/node/index.js";
import vue from "file:///C:/Users/Administrator/Desktop/workTable/flypro/flyoa_web/node_modules/.pnpm/@vitejs+plugin-vue@5.0.4_vite@5.1.5_vue@3.4.21/node_modules/@vitejs/plugin-vue/dist/index.mjs";
import { fileURLToPath, URL } from "node:url";
var __vite_injected_original_import_meta_url = "file:///C:/Users/Administrator/Desktop/workTable/flypro/flyoa_web/vite.config.js";
var vite_config_default = defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", __vite_injected_original_import_meta_url))
    }
  },
  server: {
    hmr: {
      overlay: true
      // 在页面上显示热更新的错误信息
    },
    // 配置傻鸟前端跨域
    proxy: {
      "/open-apis": {
        target: "https://open.feishu.cn",
        // 后端接口
        changeOrigin: true,
        // 是否跨域
        rewrite: (path) => path.replace(/^\/open-apis/, "/open-apis")
      }
    }
  }
});
export {
  vite_config_default as default
};
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsidml0ZS5jb25maWcuanMiXSwKICAic291cmNlc0NvbnRlbnQiOiBbImNvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9kaXJuYW1lID0gXCJDOlxcXFxVc2Vyc1xcXFxBZG1pbmlzdHJhdG9yXFxcXERlc2t0b3BcXFxcd29ya1RhYmxlXFxcXGZseXByb1xcXFxmbHlvYV93ZWJcIjtjb25zdCBfX3ZpdGVfaW5qZWN0ZWRfb3JpZ2luYWxfZmlsZW5hbWUgPSBcIkM6XFxcXFVzZXJzXFxcXEFkbWluaXN0cmF0b3JcXFxcRGVza3RvcFxcXFx3b3JrVGFibGVcXFxcZmx5cHJvXFxcXGZseW9hX3dlYlxcXFx2aXRlLmNvbmZpZy5qc1wiO2NvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9pbXBvcnRfbWV0YV91cmwgPSBcImZpbGU6Ly8vQzovVXNlcnMvQWRtaW5pc3RyYXRvci9EZXNrdG9wL3dvcmtUYWJsZS9mbHlwcm8vZmx5b2Ffd2ViL3ZpdGUuY29uZmlnLmpzXCI7aW1wb3J0IHsgZGVmaW5lQ29uZmlnIH0gZnJvbSBcInZpdGVcIjtcbmltcG9ydCB2dWUgZnJvbSBcIkB2aXRlanMvcGx1Z2luLXZ1ZVwiO1xuaW1wb3J0IHsgZmlsZVVSTFRvUGF0aCwgVVJMIH0gZnJvbSBcIm5vZGU6dXJsXCI7XG5cbi8vIGh0dHBzOi8vdml0ZWpzLmRldi9jb25maWcvXG5leHBvcnQgZGVmYXVsdCBkZWZpbmVDb25maWcoe1xuICBwbHVnaW5zOiBbdnVlKCldLFxuICByZXNvbHZlOiB7XG4gICAgYWxpYXM6IHtcbiAgICAgIFwiQFwiOiBmaWxlVVJMVG9QYXRoKG5ldyBVUkwoXCIuL3NyY1wiLCBpbXBvcnQubWV0YS51cmwpKSxcbiAgICB9LFxuICB9LFxuICBzZXJ2ZXI6IHtcbiAgICBobXI6IHtcbiAgICAgIG92ZXJsYXk6IHRydWUsIC8vIFx1NTcyOFx1OTg3NVx1OTc2Mlx1NEUwQVx1NjYzRVx1NzkzQVx1NzBFRFx1NjZGNFx1NjVCMFx1NzY4NFx1OTUxOVx1OEJFRlx1NEZFMVx1NjA2RlxuICAgIH0sXG4gICAgLy8gXHU5MTREXHU3RjZFXHU1MEJCXHU5RTFGXHU1MjREXHU3QUVGXHU4REU4XHU1N0RGXG4gICAgcHJveHk6IHtcbiAgICAgIFwiL29wZW4tYXBpc1wiOiB7XG4gICAgICAgIHRhcmdldDogXCJodHRwczovL29wZW4uZmVpc2h1LmNuXCIsIC8vIFx1NTQwRVx1N0FFRlx1NjNBNVx1NTNFM1xuICAgICAgICBjaGFuZ2VPcmlnaW46IHRydWUsIC8vIFx1NjYyRlx1NTQyNlx1OERFOFx1NTdERlxuICAgICAgICByZXdyaXRlOiAocGF0aCkgPT4gcGF0aC5yZXBsYWNlKC9eXFwvb3Blbi1hcGlzLywgXCIvb3Blbi1hcGlzXCIpLFxuICAgICAgfSxcbiAgICB9LFxuICB9LFxufSk7XG4gICAiXSwKICAibWFwcGluZ3MiOiAiO0FBQTJXLFNBQVMsb0JBQW9CO0FBQ3hZLE9BQU8sU0FBUztBQUNoQixTQUFTLGVBQWUsV0FBVztBQUZvTSxJQUFNLDJDQUEyQztBQUt4UixJQUFPLHNCQUFRLGFBQWE7QUFBQSxFQUMxQixTQUFTLENBQUMsSUFBSSxDQUFDO0FBQUEsRUFDZixTQUFTO0FBQUEsSUFDUCxPQUFPO0FBQUEsTUFDTCxLQUFLLGNBQWMsSUFBSSxJQUFJLFNBQVMsd0NBQWUsQ0FBQztBQUFBLElBQ3REO0FBQUEsRUFDRjtBQUFBLEVBQ0EsUUFBUTtBQUFBLElBQ04sS0FBSztBQUFBLE1BQ0gsU0FBUztBQUFBO0FBQUEsSUFDWDtBQUFBO0FBQUEsSUFFQSxPQUFPO0FBQUEsTUFDTCxjQUFjO0FBQUEsUUFDWixRQUFRO0FBQUE7QUFBQSxRQUNSLGNBQWM7QUFBQTtBQUFBLFFBQ2QsU0FBUyxDQUFDLFNBQVMsS0FBSyxRQUFRLGdCQUFnQixZQUFZO0FBQUEsTUFDOUQ7QUFBQSxJQUNGO0FBQUEsRUFDRjtBQUNGLENBQUM7IiwKICAibmFtZXMiOiBbXQp9Cg==
