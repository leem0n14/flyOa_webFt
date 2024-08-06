<template>
  <div class="container">
    <div class="toolBar">
      <div class="TaskTools">
        <div class="projectTitle">
          <el-icon class="projectTitleIcon"><Postcard /></el-icon>
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
        <div class="outpayTotalContainer">
          <div class="outpayTotalCardList">
            <div class="outpayTotalCard">
              <div>已报销金额</div>
              <div style="margin-left: 2px;font-size: 24px;">{{ outpayTotal.AccessNum }}</div>
            </div>
            <div class="outpayTotalCard">
              <div>待审核金额</div>
              <div style="margin-left: 2px;font-size: 24px;">{{ outpayTotal.WaitTotal }}</div>
            </div>
            <div class="outpayTotalCard">
              <div>未通过审核金额</div>
              <div style="margin-left: 2px;font-size: 24px;">
                {{ outpayTotal.DisAccessTotal }}
              </div>
            </div>
          </div>
        </div>
        <el-button class="newTaskBtn" @click="addReimbursement()">
          <el-icon><Plus /></el-icon>
          <span style="margin-left: 5px"> 申请报销 </span>
        </el-button>
      </div>
      <!--报销状态修改-->
      <el-dialog
        v-model="outpayStatuPop"
        width="700"
        class="Pop"
        :close="PopClose"
      >
        <template #header>报销状态修改</template>
        <div class="PopupdateContainer">
          <div class="popMsgPart">
            <div>申请报销金额</div>
            <div class="outpayTotal">
              {{ formatNumber(outpayStatuMsg.outpay_total) }}
            </div>
            <div>申请原因</div>
            <div class="outpayReason">{{ outpayStatuMsg.outpay_reason }}</div>
            <div>申请时间</div>
            <div class="outpayTotal">{{ outpayStatuMsg.outpay_date }}</div>
            <div style="margin-top: 10px">申请人</div>
            <div class="outpayPerson">{{ outpayStatuMsg.outpay_member }}</div>
            <div style="margin-top: 20px">申请文件</div>
            <div class="outpayFiles" v-if="outpayStatuMsg.outpay_files.length">
              <el-image
                v-for="(item, index) in outpayStatuMsg.outpay_files"
                :key="index"
                style="width: 120px; height: 120px"
                :src="item"
                :zoom-rate="1.2"
                :max-scale="7"
                :min-scale="0.2"
                :preview-src-list="outpayStatuMsg.outpay_files"
                :initial-index="index"
                fit="cover"
              />
              <!-- @click="ccccc(index)" -->
            </div>
            <div
              style="
                text-align: center;
                padding: 30px;
                border: 1px dashed rgb(228, 231, 237);
              "
              v-else
            >
              无文件
            </div>
          </div>
          <div class="popStatuSelectPart">
            <div style="font-size: 16px">审批状态</div>
            <el-select
              style="margin-top: 10px"
              v-model="outpayStatuMsg.outpay_status"
            >
              <el-option
                v-for="(item, index) in OutpayStatu"
                :key="index"
                :value="item.value"
              >
              </el-option
            ></el-select>
            <div style="font-size: 16px; margin-top: 10px">报销金额</div>
            <el-input
              style="margin-top: 10px"
              v-model="outpayStatuMsg.outpay_num"
              :disabled="outpayStatuMsg.outpay_status != '已报销'"
              @change="changeOutpayNum"
              :class="{
                isError:
                  outpayStatuMsg.outpay_num > outpayStatuMsg.outpay_total,
              }"
            ></el-input>
            <span style="font-size: 12px; color: gray"
              >当选取已报销后输入此栏</span
            >
            <div class="checkStatuBtn">
              <el-button
                @click="
                  outpayStatuPop = false;
                  outpayStatuMsg.value = null;
                  newReimbursement.value = null;
                "
                >取消</el-button
              >
              <el-button type="primary" @click="UpdateOutpayStatu"
                >确认</el-button
              >
            </div>
          </div>
        </div>
      </el-dialog>
      <el-dialog
        v-model="PCreateReimbursement"
        width="700"
        class="Pop"
        draggable
        :close="PopClose"
      >
        <template #header>报销申请</template>
        <div class="PopinputContainer">
          <!-- <el-upload v-model="fileList" list-type="picture-card" :on-preview="handlePictureCardPreview"
                          :on-remove="handleRemove" :http-request="uploadFile">
                          <el-icon>
                              <Plus />
                          </el-icon>
                      </el-upload> -->
          <div class="popInputPart">
            <div>申请原因</div>
            <el-input
              type="textarea"
              v-model="newReimbursement.outpay_reason"
              placeholder="申请原因"
              :autosize="{ minRows: 8, maxRows: 9 }"
            ></el-input>
            <div class="popSelect">
              <div>报销种类</div>
              <el-input
                v-model="newReimbursement.outpay_type"
                placeholder="报销种类"
              ></el-input>
              <div>申请日期</div>
              <el-date-picker
                v-model="newReimbursement.officialSeal_date"
                type="date"
                placeholder="选择日期"
                format="YYYY/MM/DD"
                value-format="YYYY-MM-DD"
                :disabled-date="disabledDate"
              />
            </div>
            <div>申请总额</div>
            <el-input v-model="newReimbursement.outpay_total" type="number">
            </el-input>
            <!-- <div>申请原因</div>
          <el-input v-model="newReimbursement.outpay_num"></el-input> -->
            <div>申请人</div>
            <el-input
              v-model="newReimbursement.outpay_member"
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
              list-type="picture-card"
            >
              <!-- :before-upload="beforeImgUpload" -->

              <el-button
                v-if="fileList.length < 3"
                type="primary"
                :disabled="isUploadDisabled"
                >上传文件</el-button
              >

              <template #tip>
                <div class="el-upload__tip">上传文件数量最多为3个</div>
              </template>
            </el-upload>
            <el-dialog v-model="ifImgPreview">
              <img w-full :src="ImgPreviewUrl" alt="Preview Image" />
            </el-dialog>
          </div>
        </div>
        <template #footer>
          <div class="dialog-footer">
            <el-button @click="cancelNewReimbursement()">取消</el-button>
            <el-button
              type="primary"
              @click="CreateReimbursement"
              :disabled="checkNewOutpay"
            >
              确定
            </el-button>
          </div>
        </template>
      </el-dialog>
    </div>
    <div>
      <el-table :data="ReimbursementsList" style="width: 100%">
        <el-table-column prop="outpay_reason" label="报销原因">
        </el-table-column>
        <el-table-column prop="outpay_type" label="报销种类"> </el-table-column>

        <el-table-column prop="outpay_total" label="申请金额" sortable>
          <template #default="{ row }">
            {{ row.outpay_total }}
          </template>
        </el-table-column>
        <el-table-column prop="outpay_num" label="已报销金额">
          <template #default="{ row }">
            <!-- style="
                cursor: pointer;
                border: 1px solid rgb(64, 158, 255);
                border-radius: 5px;
                padding: 2px;
                width: 70px;
                text-align: center;
              "
              v-if="!row.outpayNumInput "
              class="m-2"
              @click="row.outpayNumInput = true" -->
            <div>
              {{ row.outpay_num }}
            </div>
          </template>
        </el-table-column>
        <!-- <el-table-column prop="outpay_belongEvent" label="所属项目">
        </el-table-column> -->

        <el-table-column prop="outpay_status" label="审核状态" sortable>
          <template #default="{ row }">
            <el-button
              style="padding: 4px"
              :type="getStatusType(row.outpay_status)"
              plain
              @click="changeOutoayStatu(row)"
            >
              {{ row.outpay_status }}
            </el-button>
          </template>
        </el-table-column>
        <el-table-column prop="outpay_date" label="申请日期" sortable>
        </el-table-column>
        <el-table-column prop="outpay_member" label="申请人"> </el-table-column>
        <el-table-column prop="outpay_files" label="文件目录">
          <template #default="{ row }">
            <div
              v-for="(file, index) in parseFiles(row.outpay_files)"
              :key="index"
            >
              <a :href="`${baseUrl}${file}`" target="_blank">
                {{ file }}
              </a>
              <span v-if="index < parseFiles(row.outpay_files).length - 1"
                >;
              </span>
            </div>
          </template>
          <!-- <template #default="{ row }">
            <div>
              <a
                :href="`${baseUrl}${row.outpay_files}`"
                @click="aaa(row.outpay_files)"
                target="_blank"
              >
                {{ row.outpay_files }}
              </a>
            </div>
          </template> -->
        </el-table-column>
        <template #empty>
          <div>
            <el-button class="btnAddItem" @click="addReimbursement()">
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
.is-error {
  border-color: red; // 输入框边框变为红色
}
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
        background-color: #6841f6;
        // margin-top: 10px;
        margin-bottom: 23px;
        font-size: 16px;
        color: white;
        padding: 5px;
        border-radius: 100%;
      }
    }

    .outpayTotalContainer {
      margin-left: 30px;
      .outpayTotalCardList {
        display: flex;
        gap: 30px;
        .outpayTotalCard {
          display: flex;
          flex-direction: column;

        }
      }
    }
    .newTaskBtn {
      padding: 12px;
      position: absolute;
      right: 0px;
      border: rgb(117, 118, 120) 1px solid;
    }
  }

  .PopupdateContainer {
    width: 650px;
    display: flex;
    padding-bottom: 20px;
    gap: 20px;
    .popMsgPart {
      width: 400px;
      position: relative;
      &:before {
        content: "";
        position: absolute;
        height: 100%;
        right: -5px;
        border-right: rgb(228, 231, 237) 1px solid;
      }

      .outpayReason {
        padding: 3px;
        border: rgb(228, 231, 237) 1px solid;
        font-size: 20px;
        &:before {
          content: "\00a0";
        }
      }
      .outpayTotal {
        font-size: 20px;
        &:before {
          content: "\00a0";
        }
      }
      .outpayPerson {
        font-size: 20px;
        padding: 3px;
        &:before {
          content: "\00a0";
        }
      }
      .outpayFiles {
        height: 140px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 40px;
        border: rgb(228, 231, 237) 1px dashed;
        .el-image {
          border: rgb(64, 158, 255) 1px dashed;
          transition: 0.3s all;
          &:hover {
            // 放大有问题
            // transform: scale(1.3);
            border: rgb(0, 77, 155) 1px dashed;
            box-shadow: 2px 4px 12px rgba(0, 0, 0, 0.4);
          }
        }
      }
    }
    .popStatuSelectPart {
      width: 200px;
      .checkStatuBtn {
        margin-top: 180px;
        display: flex;
        gap: 10px;
        justify-content: center;
        align-items: center;
      }
    }
  }
  .PopinputContainer {
    width: 650px;
    display: flex;
    gap: 20px;
    .popInputPart {
      width: 400px;
      position: relative;
      &:before {
        content: "";
        position: absolute;
        height: 110%;
        right: -5px;
        border-right: rgb(228, 231, 237) 1px solid;
      }
    }
    .popUploadPart {
      width: 200px;
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
import { ref, onMounted, computed, watch } from "vue";
import { useUserStore } from "@/store/user";
const useUser = useUserStore();
import { useProjectStore } from "../../store/project";
const useProject = useProjectStore();

import { ElMessage, ElMessageBox } from "element-plus";
import axios from "axios";
import api from "@/api/index";
const bapi = api.bcApi;
const aaa = (item) => {
  console.log(item);
};

const PCreateReimbursement = ref(false);
const fileList = ref([]);
const fileUrlA = ref();
const fileUrlB = ref();
const fileUrlC = ref();
const ReimbursementsList = ref([]);
const outpayTotal = ref({});
const TotalNum = ref(0);
const getAllReimbursements = () => {
  bapi
    .getReimbursementbyId({
      event_id: useProject.project_detail_id,
    })
    .then((res) => {
      console.log(res);
      ReimbursementsList.value = res.data.OutpayData;
      if (ReimbursementsList.value && ReimbursementsList.value.length > 0) {
        TotalNum.value = ReimbursementsList.value.length;
        bapi
          .getReimbursementTotalbyId({ event_id: useProject.project_detail_id })
          .then((res) => {
            console.log(res);
            outpayTotal.value = res.data.total;
          });
      }
    });
};

const isUploadDisabled = computed(() => fileList.value.length >= 3);

const disabledDate = (date) => {
  //true disabled'false not disabled
  return date.getTime() > new Date();
};

//新建申请对象
const newReimbursement = ref({
  event_id: useProject.project_detail_id,
  outpay_member: useUser.userInf.name,
});
// const ccccc = (index) => {
//   console.log(index);
// };
const addReimbursement = () => {
  PCreateReimbursement.value = true;
};

//状态判定
const OutpayStatu = [
  {
    value: "审核中",
    label: "审核中",
  },
  {
    value: "已报销",
    label: "已报销",
  },
  {
    value: "不通过",
    label: "不通过",
  },
];
const getStatusType = (status) => {
  switch (status) {
    case "审核中":
      return "primary";
    case "已报销":
      return "success";
    case "不通过":
      return "danger";
    default:
      return "info"; // 默认类型，如果需要的话
  }
};

//弹窗关闭前同一动作
const PopClose = () => {
  console.log("guanbi", outpayStatuMsg.value, newReimbursement.value);

  console.log("guanbiiiii", outpayStatuMsg.value, newReimbursement.value);
};

//状态弹窗
// 换算器 1000=>1，000
const formatNumber = (value) => {
  return new Intl.NumberFormat("en-US").format(value);
};

const outpayStatuPop = ref(false);
const outpayStatuMsg = ref("");

let a = 1;
const filesStatuTemp = ref();
const outpayStatuTemp = ref();
const changeOutoayStatu = (row) => {
  console.log(row);
  console.log(outpayStatuPop.value);
  outpayStatuMsg.value = { ...row };

  filesStatuTemp.value = outpayStatuMsg.value.outpay_files;
  outpayStatuTemp.value = outpayStatuMsg.value.outpay_status;
  if (outpayStatuMsg.value.outpay_files) {
    outpayStatuMsg.value.outpay_files = outpayStatuMsg.value.outpay_files
      .split(";")
      .map((file) => baseUrl + file)
      .slice(0, 3); // 限制文件数量为3个
  }
  outpayStatuPop.value = true;
};
//报销限制
const changeOutpayNum = () => {
  watch(
    () => outpayStatuMsg.value.outpay_num,
    (newVal, oldVal) => {
      if (newVal > outpayStatuMsg.value.outpay_total) {
        ElMessage.warning(
          `已报销金额不能大于申请金额 ${outpayStatuMsg.value.outpay_total}`
        );
        // 重置
        outpayStatuMsg.value.outpay_num = oldVal;
      }
    },
    { immediate: true }
  );
};
//上传修改
const UpdateOutpayStatu = () => {
  if (
    outpayStatuMsg.value.outpay_status == "已报销" &&
    outpayStatuMsg.value.outpay_num == null
  ) {
    ElMessage.warning("请输入报销金额");
    return;
  }
  if (outpayStatuMsg.value.outpay_status == outpayStatuTemp.value) {
    // outpayStatuPop.value = false;
    ElMessage.warning("状态未修改");
    return;
  }

  outpayStatuMsg.value.outpay_files = "";
  outpayStatuMsg.value.outpay_files = filesStatuTemp.value;
  console.log(outpayStatuMsg.value.outpay_files);
  outpayStatuMsg.value.event_id = useProject.project_detail_id;
  outpayStatuMsg.value.userBcId = useUser.userBcId;
  bapi.updateReimbursementStatu(outpayStatuMsg.value).then((res) => {
    if (res.data.errcode == "0") {
      ElMessage.success("修改成功");
      getAllReimbursements();
      outpayStatuMsg.value = null;
      filesStatuTemp.value = null;
      outpayStatuTemp.value = null;
      // newReimbursement.value = null;
    }
  });
  outpayStatuPop.value = false;
};
//新建限制不为空
const checkNewOutpay = computed(() => {
  // newReimbursement.value.outpay_num = null;
  console.log(newReimbursement.value);
  if (
    newReimbursement.value.outpay_reason == "" ||
    newReimbursement.value.outpay_type == "" ||
    newReimbursement.value.outpay_total == null
  )
    return true;
  else return false;
});
const cancelNewReimbursement = () => {
  PCreateReimbursement.value = false;
  outpayStatuMsg.value = {};
  newReimbursement.value = {};
};
const CreateReimbursement = () => {
  PCreateReimbursement.value = false;
  console.log(fileList.value);

  const fileNameList = fileList.value
    .map((item) => encodeURIComponent(item.name))
    .join(";");
  newReimbursement.value.outpay_files = fileNameList;
  console.log(newReimbursement.value.outpay_files);

  bapi.addReimbursementIntoEvent(newReimbursement.value).then((res) => {
    console.log(res);
    ElMessage.success("报销申请已发出");
    getAllReimbursements();
  });
  ElMessage.success("申请已发出");
};

//分割
const parseFiles = (filesString) => {
  // 使用分号作为分隔符来分割字符串，并返回结果数组
  console.log(filesString);
  return filesString.split(";");
};

//上传限制
// const beforeImgUpload = (rawFile) => {
//   // 检查文件类型是否为 JPG
//   // console.log(fileList.value);
//   // const rawFile = fileList.value[0].raw;
//   console.log(rawFile);
//   if (rawFile.type != "image/jpg") {
//     ElMessage.warning("请上传jpg图片");
//     return false;
//   }
//   // // 检查文件大小是否超过 2MB
//   // else if (rawFile.size / 1024 / 1024 > 2) {
//   //   ElMessage.error("图片请不要超过2MB!");
//   //   return false;
//   // }
//   // 如果检查通过，则返回 true
//   return true;
// };
//文件上传
const uploadFile = (item) => {
  console.log(item.file.type);
  if (item.file.type != "image/jpeg") {
    // fileList.value.splice(-1, 1, null);
    fileList.value.pop();

    ElMessage.warning("请上传jpg图片");
    return;
  } else {
    console.log(fileList.value, "---", fileList.value.length);
    const formData = new FormData();
    formData.append("image", item.file);
    console.log(formData, "xxx");
    bapi.uploadFile(formData).then((response) => {
      console.log(response);
    });
  }
};
const handleRemove = (file, fileList) => {};

const ifImgPreview = ref(false);
const ImgPreviewUrl = ref();
const handlePictureCardPreview = (uploadFile) => {
  ImgPreviewUrl.value = uploadFile.url;
  ifImgPreview.value = true;
};

onMounted(() => {
  getAllReimbursements();
});
</script>