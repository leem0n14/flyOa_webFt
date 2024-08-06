import { defineStore } from "pinia";
import { ref, reactive } from "vue";

export const useLoadStore = defineStore(
  "load",
  () => {
    const isLoad = ref(false);
    return { isLoad };
  },
  {
    persist: true,
  }
);
