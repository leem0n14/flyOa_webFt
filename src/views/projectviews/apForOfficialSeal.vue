<template>
  <div class="container">
    <div class="toolBar">
      <div class="TaskTools">
        <div class="projectTitle">
          <el-icon class="projectTitleIcon"><Checked /></el-icon>
          <span style="margin-left: 32px"> {{ useProject.project_name }} </span>
          <span
            style="
              color: gray;
              font-size: 20px;
              margin-top: 12px;
              margin-left: 6px;
            "
            >({{ TotalNum }})</span
          >
        </div>
        <el-button class="newTaskBtn" @click="addSeal()">
          <el-icon><Plus /></el-icon>
          <span style="margin-left: 5px"> 申请公章 </span>
        </el-button>
      </div>

      <el-dialog
        v-model="PCreateSeal"
        title="Tips"
        width="700"
        class="Pop"
        draggable
      >
        <template #header>公章记录申请</template>
        <div class="PopinputContainer">
          <!-- <el-upload v-model="fileList" list-type="picture-card" :on-preview="handlePictureCardPreview"
                        :on-remove="handleRemove" :http-request="uploadFile">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload> -->

          <div class="popInputPart">
            <div style="font-size: 17px; padding-bottom: 7px">申请原因</div>
            <el-input
              type="textarea"
              v-model="newSeal.officialSeal_describe"
              placeholder="申请原因"
              :autosize="{ minRows: 8, maxRows: 9 }"
            ></el-input>

            <div style="font-size: 17px; padding-bottom: 7px; margin-top: 10px">
              申请日期
            </div>
            <el-date-picker
              v-model="newSeal.officialSeal_date"
              type="date"
              placeholder="选择日期"
              format="YYYY/MM/DD"
              value-format="YYYY-MM-DD"
              :disabled-date="disabledDate"
            />
            <div style="font-size: 17px; padding-bottom: 7px; margin-top: 40px">
              申请人
            </div>
            <el-input
              v-model="newSeal.officialSeal_userName"
              disabled
            ></el-input>
          </div>
          <div class="popUploadPart">
            <el-upload
              v-model:file-list="fileList"
              :on-preview="handlePictureCardPreview"
              :on-remove="handleRemove"
              :http-request="uploadFile"
              limit="3"
            >
              <el-button type="primary" :disabled="isUploadDisabled"
                >上传文件</el-button
              >
              <template #tip>
                <div class="el-upload__tip">上传文件数量最多为3个</div>
              </template>
            </el-upload>
          </div>
        </div>
        <template #footer>
          <div class="dialog-footer">
            <el-button @click="PCreateSeal = false">取消</el-button>
            <el-button type="primary" @click="CreateSeal"> 确定 </el-button>
          </div>
        </template>
      </el-dialog>
    </div>
    <div>
      <el-table :data="SealList" style="width: 100%">
        <el-table-column prop="officialSeal_describe" label="申请原因">
          <template #default="{ row }">
            <span
              style="
                font-size: 12px;
                background-color: #9352b9;
                color: white;
                padding: 1px;
                border-radius: 3px;
              "
            >
              公章记录</span
            >
            <span style="font-size: 17px; color: #182b50; margin-left: 14px">{{
              row.officialSeal_describe
            }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="officialSeal_userId" label="申请人">
        </el-table-column>
        <el-table-column prop="officialSeal_date" label="申请日期">
        </el-table-column>
        <!-- <el-table-column prop="officialSeal_unity" label="企业公章">
        </el-table-column> -->
        <el-table-column prop="officialSeal_statu" label="审核状态">
        </el-table-column>
        <!-- <el-table-column prop="officialSeal_belongEvent" label="所属项目">
        </el-table-column> -->
        <el-table-column prop="officialSeal_fileA" label="文件目录">
          <template #default="{ row }">
            <div>
              <a :href="`${baseUrl}${row.officialSeal_fileA}`" target="_blank">
                {{ row.officialSeal_fileA }}
              </a>
            </div>
            <div>
              <a :href="`${baseUrl}${row.officialSeal_fileB}`" target="_blank">
                {{ row.officialSeal_fileB }}
              </a>
            </div>
            <div>
              <a :href="`${baseUrl}${row.officialSeal_fileB}`" target="_blank">
                {{ row.officialSeal_fileC }}
              </a>
            </div>
          </template>
        </el-table-column>
        <template #empty>
          <div>
            <el-button class="btnAddItem" @click="addSeal()">
              <el-icon>
                <Plus />
              </el-icon>
            </el-button>
          </div>
        </template>
      </el-table>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.toolBar {
  .TaskTools {
    width: 98%;
    padding-top: 3px;
    padding-bottom: 10px;
    margin: 0 auto;
    border-radius: 12px;
    transition: all 0.3s;
    display: flex;
    align-items: center;
    position: relative;
    &:before {
      content: "";
      position: absolute;
      width: 100%;
      height: 50px;
      bottom: 0px;
      border-bottom: rgb(228, 231, 237) 1px solid;
    }
    .projectTitle {
      font-size: 30px;
      padding: 12px;
      font-weight: 400;
      display: flex;
      align-items: center;
      position: relative;
      &:before {
        content: "";
        position: absolute;
        height: 50px;
        right: -20px;
        border-right: rgb(228, 231, 237) 1px solid;
      }
      .projectTitleIcon {
        position: absolute;
        background-color: #9352b9;
        // margin-top: 10px;
        margin-bottom: 23px;
        font-size: 16px;
        color: white;
        padding: 5px;
        border-radius: 100%;
      }
    }
    .newTaskBtn {
      padding: 12px;
      position: absolute;
      right: 0px;
      border: rgb(117, 118, 120) 1px solid;
    }
  }

  .PopinputContainer {
    height: 400px;
    width: 650px;
    gap: 15px;
    display: flex;
    .popInputPart {
      width: 350px;

      position: relative;
      &:before {
        content: "";
        position: absolute;
        height: 100%;
        right: -5px;
        border-right: rgb(228, 231, 237) 1px solid;
      }
    }
    .popUploadPart {
      width: 250px;
    }
  }
}

.btnAddItem {
  height: 40px;
  width: 40px;
}
</style>

<script setup>
import base from "@/api/base";
const baseUrl = `${base.baseUrl}${base.bcdownload}`;
console.log(baseUrl);
import { ref, onMounted, computed } from "vue";
import { useUserStore } from "@/store/user";
const useUser = useUserStore();
import { useProjectStore } from "../../store/project";
const useProject = useProjectStore();

import { ElMessage, ElMessageBox } from "element-plus";
import axios from "axios";
import api from "@/api/index";
const bapi = api.bcApi;

const PCreateSeal = ref(false);
const fileList = ref([]);
const fileUrlA = ref();
const fileUrlB = ref();
const fileUrlC = ref();
const SealList = ref([]);

const TotalNum = ref(0);

const getAllSeals = () => {
  bapi
    .getOfficialSealbyId({
      event_id: useProject.project_detail_id,
    })
    .then((res) => {
      console.log(res);
      SealList.value = res.data.officialSealData;
      console.log(SealList.value, "111");
      if (SealList.value.length > 0) TotalNum.value = SealList.value.length;
    });
};

const isUploadDisabled = computed(() => fileList.value.length >= 3);

const disabledDate = (date) => {
  //true disabled'false not disabled
  return date.getTime() > new Date();
};

//新建申请对象
const newSeal = ref({
  officialSeal_belongEvent: useProject.project_detail_id,
  officialSeal_fileA: "",
  officialSeal_fileB: "",
  officialSeal_fileC: "",
  officialSeal_describe: "",
  officialSeal_date: "",
  officialSeal_unity: "",
  officialSeal_statu: "待审核",
  officialSeal_userId: useUser.userBcId,
  officialSeal_userName: useUser.userInf.name,
});

const addSeal = () => {
  PCreateSeal.value = true;
};

const CreateSeal = () => {
  PCreateSeal.value = false;
  console.log(fileList.value);

  console.log(fileList.value);
  if (fileList.value[0])
    newSeal.value.officialSeal_fileA = fileList.value[0].name || "";
  if (fileList.value[1])
    newSeal.value.officialSeal_fileB = fileList.value[1].name || "";
  if (fileList.value[2])
    newSeal.value.officialSeal_fileC = fileList.value[2].name || "";

  console.log(newSeal.value);

  bapi.addOfficialSealIntoEvent(newSeal.value).then((res) => {
    console.log(res);
    ElMessage.success("申请已发出");
    getAllSeals();
  });
  ElMessage.success("申请已发出");
};

const uploadFile = (item) => {
  console.log(item.file);
  console.log(fileList.value, "---", fileList.value.length);
  const formData = new FormData();
  formData.append("file", item.file);
  console.log(formData, "xxx");
  bapi.uploadFile(formData).then((response) => {
    console.log(response);
  });
};
const handleRemove = (file, fileList) => {};

onMounted(() => {
  getAllSeals();
});
</script>