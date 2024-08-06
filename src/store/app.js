import { defineStore } from "pinia";
import { ref, reactive } from "vue";

export const useAppStore = defineStore(
  "app",
  () => {
    const app_access_token = ref("");
    const tenant_access_token = ref("");
    return { app_access_token, tenant_access_token };
  },
  {
    persist: true,
  }
);
