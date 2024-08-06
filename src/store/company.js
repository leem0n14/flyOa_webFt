import { defineStore } from "pinia";
import { ref, reactive } from "vue";

export const useCompanyStore = defineStore(
  "company",
  () => {
    const company_name = ref("");
    const company_inf = ref({
      avatar: {
        avatar_240: "",
        avatar_640: "",
        avatar_72: "",
        avatar_origin: "",
      },
      display_id: "",
      name: "",
      tenant_key: "",
      tenant_tag: "", //0or2
    });
    return { company_name, company_inf };
  },
  {
    persist: true,
  }
);
