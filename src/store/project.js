import { defineStore } from "pinia";
import { ref, reactive } from "vue";

export const useProjectStore = defineStore(
  "project",
  () => {
    const project_name = ref("");
    const project_inf = ref({});
    const project_detail_id = ref();
    const project_judgment = ref(false);
    const project_members = ref([]);
    const myProject_list = ref({});
    return {
      project_name,
      project_inf,
      project_detail_id,
      project_judgment,
      project_members,
      myProject_list,
    };
  },
  {
    persist: true,
  }
);
