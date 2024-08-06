
import { defineStore } from "pinia";
import { ref, reactive } from "vue";

export const useFileStore = defineStore(
    "file",
    () => {
        const file = ref();
        return { file };
    }
);
