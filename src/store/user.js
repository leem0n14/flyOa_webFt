import { defineStore } from "pinia";
import { ref, reactive } from "vue";

export const useUserStore = defineStore(
  "user",
  () => {
    const userCodeTemp = ref();
    const userInf = ref({
      avatar_big: null,
      avatar_middle: null,
      avatar_thumb: null,
      avatar_url: null,
      email: null,
      employee_no: null,
      en_name: null,
      enterprise_email: null,
      mobile: null,
      name: null,
      open_id: null,
      tenant_key: null,
      union_id: null,
      user_id: null,
    });
    const userBcId = ref();
    const user_access_token = ref();
    const freshUser_access_token = ref();

    return {
      userCodeTemp,
      userInf,
      user_access_token,
      freshUser_access_token,
      userBcId,
    };
  },
  {
    persist: true,
  }
);
