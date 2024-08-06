<template>
  <div class="container">
    <el-dialog v-model="ifPopInvoice" title="Tips" width="500" class="Pop" draggable>
      <template #header>开票记录</template>
      <div class="PopinputContainer">
        <!-- <el-upload v-model="fileList" list-type="picture-card" :on-preview="handlePictureCardPreview"
                        :on-remove="handleRemove" :http-request="uploadFile">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload> -->

        <div class="popInputPart">
          <div style="font-size: 17px; padding-bottom: 7px; margin-top: 10px">
            申请日期
          </div>
          <el-date-picker v-model="newInvoice.invoice_date" type="date" placeholder="选择日期" format="YYYY/MM/DD"
            value-format="YYYY-MM-DD" :disabled-date="disabledDate" />
          <div style="font-size: 17px; padding-bottom: 7px; margin-top: 20px">
            开票款项
          </div>
          <el-input v-model="newInvoice.invoice_num" style="width: 200px" type="number"></el-input>
          <div style="font-size: 17px; padding-bottom: 7px; margin-top: 20px">
            申请人
          </div>
          <el-input v-model="newInvoice.invoice_member" disabled style="width: 200px"></el-input>
          <!-- optiton -->
          <!--  -->
          <!-- <div style="font-size: 17px; padding-bottom: 7px; margin-top: 20px">
            开票种类
          </div>
          <el-select v-model="newInvoice.invoice_type" style="width: 200px">
          </el-select> -->
        </div>
        <div class="popUploadPart">
          <el-upload v-model:file-list="fileList" :on-preview="handlePictureCardPreview" :on-remove="handleRemove"
            :http-request="uploadFile" list-type="picture-card" limit="1">
            <el-button type="primary" :disabled="isUploadDisabled">上传文件</el-button>
            <template #tip>
              <div class="el-upload__tip">上传文件数量最多为1个</div>
            </template>
          </el-upload>
        </div>
      </div>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="ifPopInvoice = false">取消</el-button>
          <el-button type="primary" @click="CreateInvoice"> 确定 </el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog v-model="ifImgPreview">
      <img w-full :src="ImgPreviewUrl" alt="Preview Image" />
    </el-dialog>
    <div class="cardHeader">
      <div class="projectInf">
        <!-- <el-icon class="projectStatu">
            <Histogram />
          </el-icon> -->
        <!-- <div class="projectStatu">
     
        </div> -->
        <div class="projectTitle">
          <div class="projectName"><span>{{ useProject.project_name }}</span></div>
          <div class="projectSecTitle">开始日期：2024-03-21</div>
          <div class="projectMember">
            项目负责人：{{ projectInf.eventData.event_leader }}
          </div>
          <div class="projectMember">
            项目状态：{{ projectInf.eventData.event_status }}
          </div>
          <div class="projectMember">
            项目成员：
            <span v-for="member in memberList" :key="member.id" class="memberItem">
              {{ member.user_name }}
              <span>|</span>
            </span>
          </div>
        </div>
      </div>

      <div class="cardList">
        <div class="projectMsgCard" :style="{ '--Bgcolor': '#409eff' }">
          <div class="MsgCardTitle">款项情况</div>
          <el-icon class="MsgCardIcon">
            <WalletFilled />
          </el-icon>
          <div class="cardProgressMain">
            收取款项进度：{{ projectMsg.event_realIncome }}/{{
              projectMsg.event_expectIncome
            }}
            <!-- projectMsg -->
            <el-progress :text-inside="true" :stroke-width="40" :percentage="cashProgress" status="success"
              color="var(--Bgcolor)" striped striped-flow :duration="20" />
          </div>
          <div class="cardProgress">
            <!-- 收支占比
            <el-progress
              :text-inside="true"
              :stroke-width="24"
              :percentage="outpayIncomeCompare"
              status="success"
              color="var(--Bgcolor)"
            /> -->
            <div style="margin-top: 5px">
              已开票比例：{{ invoiceNum }}/{{ projectMsg.event_realIncome }}
            </div>
            <el-progress :text-inside="true" :stroke-width="40" :percentage="calcInvoiceIncome" status="success"
              color="var(--Bgcolor)" />
          </div>
        </div>
        <div class="projectMsgCard" :style="{ '--Bgcolor': '#20a53a' }">
          <div class="MsgCardTitle">报销申请情况</div>
          <el-icon class="MsgCardIcon">
            <Files />
          </el-icon>
          <div style="
              margin-left: 12px;
              margin-top: 14px;
              display: flex;
              flex-direction: column;
              gap: 10px;
              font-size: 25px;
            ">
            <div>
              待审批款项：
              <div style="margin-left: 20px">{{ outpayTotal.WaitTotal }}</div>
            </div>
            <div>
              已同意款项：
              <div style="margin-left: 20px">{{ outpayTotal.AccessNum }}</div>
            </div>
          </div>
        </div>
        <div class="projectMsgCard" :style="{ '--Bgcolor': '#9352b9' }">
          <div class="MsgCardTitle">公章申请情况</div>
          <el-icon class="MsgCardIcon">
            <List />
          </el-icon>
          <div style="
              margin-left: 12px;
              margin-top: 14px;
              display: flex;
              flex-direction: column;
              gap: 10px;
              font-size: 25px;
            ">
            <div>
              待审批：
              <div style="margin-left: 20px">1</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- ------------------------------------- -->
    <div class="chartsList">
      <div class="taskStatuContainer" ref="taskStatuContainer">
        <div class="taskStatuTitle">任务状态统计</div>
        <div ref="taskStatuChart" class="taskStatuChart"></div>
      </div>
      <div class="projectInvoicesList">
        <div class="InvoicesCardList">
          <el-table :data="invoiceList">
            <el-table-column prop="invoice_num" label="开票款项">
            </el-table-column>

            <el-table-column prop="invoice_date" label="开票时间"></el-table-column>
            <el-table-column prop="invoice_member" label="开票人"></el-table-column>
            <el-table-column prop="invoice_file" label="开票文件">
              <template #default="{ row }">
                <div>
                  <a :href="`${baseUrl}${row.invoice_file}`" target="_blank">
                    {{ row.invoice_file }}
                  </a>
                </div>
              </template></el-table-column>
            <el-table-column align="right">
              <template #header>
                <el-button type="primary" @click="createNewInvoice()">开票</el-button>
              </template>
              <template #default="{ row }">
                <div>{{ row }}</div>
                <!-- <el-button size="middle" @click="handleEdit(row)">
                  修改
                </el-button>
                <el-button
                  size="middle"
                  type="danger"
                  @click="handleDelete(row)"
                >
                  删除
                </el-button> -->
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.PopinputContainer {
  height: 400px;
  width: 650px;
  gap: 15px;
  display: flex;

  .popInputPart {
    width: 250px;
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
    width: 150px;
  }
}

.cardHeader {
  display: flex;
  align-items: center;
  gap: 2vw;
  width: 100%;

  .projectInf {
    height: 20vh;
    width: 30vw;
    min-width: 420px;
    padding-top: 10px;
    padding-bottom: 10px;
    padding-left: 10px;
    border-radius: 12px;
    // display: flex;
    // gap: 20px;
    // align-items: center;
    transition: all 0.6s;
    border: rgb(228, 231, 237) 1px solid;

    &:hover {
      box-shadow: 1px 1px 7px rgba(0, 0, 0, 0.3);
    }

    // .projectStatu {
    //   height: 180px;
    //   width: 180px;
    //   background-color: rgb(64, 158, 255);
    //   color: white;
    //   font-size: 100px;
    //   font-weight: 900;
    //   border-radius: 12px;
    // }

    .projectTitle {
      height: 170px;
      display: flex;
      flex-direction: column;

      .projectName {
        font-size: 24px;
        // left: -20px;
        // top: -10px;
        position: relative;
        // background-color: rgb(64, 158, 255);

        span {
          background: linear-gradient(90deg, #3394FF 2%, #f9f9ff 100%) no-repeat left bottom;
          animation: long 2s ease-in-out forwards;
        }

        @keyframes long {
          0% {
            background-size: 0px 2px;
          }

          100% {
            background-size: 1000px 2px;

          }
        }
      }

      .projectSecTitle {
        // top: -10px;
        position: relative;

        font-size: 14px;
        color: grey;

        &:before {
          content: "\00a0\00a0";
        }
      }

      .projectMember {
        margin-top: 7px;
      }
    }
  }

  .cardList {
    height: 20vh;
    width: 68vw;
    min-width: 900px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    gap: 4%;
    transition: all 0.3s;
    // border: rgb(228, 231, 237) 1px solid;

    .projectMsgCard {
      --Bgcolor: #000000;
      height: 20vh;
      //!
      width: 300px;
      min-width: 200px;
      width: 30%;
      border: rgb(228, 231, 237) 1px solid;
      border-radius: 12px;
      position: relative;
      transition: all 0.3s;
      cursor: pointer;

      &:hover {
        box-shadow: 1px 1px 7px rgba(0, 0, 0, 0.3);
      }

      .MsgCardTitle {
        font-size: 20px;
        font-weight: 500;
        padding-top: 10px;
        padding-bottom: 10px;
        padding-left: 10px;
        position: relative;

        &:before {
          content: "";
          position: absolute;
          bottom: 0px;
          left: 0px;
          border-bottom: 3px solid var(--Bgcolor);
          height: 2px;
          width: 100%;
        }
      }

      .MsgCardIcon {
        position: absolute;
        right: 10px;
        top: 10px;
        height: 100px;
        width: 100px;
        background-color: var(--Bgcolor);
        color: white;
        box-sizing: border-box;
        border: 4px solid white;
        font-size: 50px;
        font-weight: 900;
        border-radius: 12px;
        display: flex;
        justify-content: center;
        align-items: center;
      }

      .cardProgressMain {
        margin-top: 3px;
        margin-left: 10px;
        width: 60%;
      }

      .cardProgress {
        width: 85%;
        margin-top: 10px;
        margin-left: 10px;
        display: flex;
        flex-direction: column;
        gap: 4px;
      }
    }
  }
}

.chartsList {
  height: 550px;
  width: 100%;
  margin-top: 40px;
  // border: 2px solid rgb(228, 231, 237);
  border-radius: 12px;
  display: flex;
  align-items: center;
  gap: 2%;

  .taskStatuContainer {
    height: 100%;
    width: 40vw;
    border: 1px solid rgb(228, 231, 237);
    border-radius: 12px;
    padding: 5px;
    transition: all 0.3s;
    cursor: pointer;

    &:hover {
      box-shadow: 1px 1px 7px rgba(0, 0, 0, 0.3);
    }

    position: relative;

    .taskStatuTitle {
      z-index: 2;
      font-size: 32px;
      margin-top: 20px;
      margin-left: 10px;
      padding-left: 13px;
      position: relative;

      &:before {
        content: "";
        position: absolute;
        height: 110%;
        left: -3px;
        border-left: 12px solid #8ac4ff;
      }
    }

    .taskStatuChart {
      z-index: 2;
      margin-top: 20px;
      width: 100%;
      height: 500px;
      transition: 0.3s;
    }

    // .projectActionItemList {
    //   width: 100%;
    //   border-radius: 12px;

    //   .projectActionItem {
    //     height: 30px;
    //     padding: 6px;
    //     width: 100%;
    //     background-color: rgb(255, 255, 255);
    //     font-size: 20px;
    //     border-bottom: 2px solid rgb(228, 231, 237);

    //     .actionMember {
    //       float: left;
    //     }

    //     .actionDetail {
    //       float: left;
    //       color: grey;
    //       margin-left: 20px;
    //     }

    //     .actionToMember {
    //       float: left;
    //       color: black;
    //       margin-left: 10px;
    //     }

    //     .actionDate {
    //       float: right;
    //     }
    //   }
    // }
  }

  .projectInvoicesList {
    height: 100%;
    min-width: 700px;
    width: 58vw;
    margin-right: 1vw;
    border: 1px solid rgb(228, 231, 237);
    border-radius: 12px;
    padding: 5px;
    transition: all 0.3s;
    cursor: pointer;

    &:hover {
      box-shadow: 1px 1px 7px rgba(0, 0, 0, 0.3);
    }

    .InvoicesCardList {
      height: 100%;
      width: 100%;
    }
  }
}
</style>

<script setup>
import base from "@/api/base";
const baseUrl = `${base.baseUrl}${base.bcdownload}`;
console.log(baseUrl);
import { ref, onMounted, watch, nextTick } from "vue";
import * as echarts from "echarts";
import { useProjectStore } from "../../store/project";
const useProject = useProjectStore();
import { useUserStore } from "../../store/user";
const useUser = useUserStore();
import api from "@/api/index";
import { ElMessage } from "element-plus";
const bapi = api.bcApi;
const outpayTotal = ref({
  WaitTotal: 0,
  AccessNum: 0,
});
const iconColor = ref("#ba2f2b");

const actionsList = ref([
  {
    actionMember: "李月",
    action: "添加了成员",
    member: "刘培金",
    date: "2023-03-23",
  },
  {
    actionMember: "李月",
    action: "添加了成员",
    member: "慧姐",
    date: "2023-03-23",
  },
  {
    actionMember: "李月",
    action: "创建项目",
    member: "",
    date: "2023-03-23",
  },
]);

const projectInf = ref({
  message: "",
  eventData: {
    id: null,
    event_name: null,
    event_status: null,
    event_leader: null,
    event_outlay: null,
    event_realIncome: null,
    event_expectIncome: null,
    event_belongCompany: null,
    event_secret: null,
    event_leader_id: null,
  },
  member: [],
});
const memberList = ref();

//任务状态统计
const taskCategories = ref();
const taskValue = ref();
const taskStatuChart = ref(null);
const taskStatuContainer = ref(null)
let taskChartInstance;
const initTaskStatuChart = () => {
  taskChartInstance = echarts.init(taskStatuChart.value);
  // 设置图表的配置项和数据
  const option = {
    // title: { text: "任务状态统计" },
    responsive: true,
    tooltip: {},
    xAxis: {
      data: taskCategories.value,
      type: "category",
    },
    yAxis: {
      type: "value",
    },
    series: [
      {
        type: "bar",
        data: taskValue.value,
        showBackground: true,
        backgroundStyle: {
          color: "rgba(180, 180, 180, 0.2)",
        },
        itemStyle: {
          barBorderRadius: [2, 2, 0, 0],
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            {
              offset: 0, //offset范围是0~1，用于表示位置，0是指0%处的颜色
              color: "rgba(143,198,255,1)", // 渐变开始的颜色
            }, //柱图渐变色
            {
              offset: 1, //指100%处的颜色
              color: "rgba(13,132,255,1)", // 渐变结束的颜色
            },
          ]),
        },

        label: {
          show: true,
          position: "top",
          valueAnimation: true,
          fontSize: 16,
        },
      },
    ],
  };
  // 使用刚指定的配置项和数据显示图表。
  taskChartInstance.setOption(option);
};

//款项进度条
const cashProgress = ref();
// const outpayIncomeCompare = ref();
const calcInvoiceIncome = ref();
const calcCashProgress = () => {
  console.log(projectMsg.value.event_realIncome, "1");
  cashProgress.value = Math.floor(
    (projectMsg.value.event_realIncome * 100) /
    projectMsg.value.event_expectIncome
  );
  // invoiceNum
  if (projectMsg.value.event_realIncome != 0)
    calcInvoiceIncome.value = Math.floor(
      (invoiceNum.value * 100) / projectMsg.value.event_realIncome
    );
  else if (invoiceNum.value) {
    calcInvoiceIncome.value = 100;
  } else {
    calcInvoiceIncome.value = 0;
  }
  // outpayIncomeCompare.value = Math.floor(
  //   projectMsg.value.event_realIncome /
  //     (projectMsg.value.event_outlay + projectMsg.value.event_realIncome)
  // );
};

//开票
const newInvoice = ref({
  invoice_num: 0,
  invoice_date: "",
  invoice_member: useUser.userInf.name,
  invoice_file: "",
  // invoice_belongEventId: useProject.project_detail_id,
  eventId: useProject.project_detail_id,
  invoice_belongEvent: useProject.project_inf.event_name,
});
const fileList = ref([]);
const ifPopInvoice = ref(false);
const createNewInvoice = () => {
  ifPopInvoice.value = true;
};
//上传文件
const uploadFile = (item) => {
  console.log(item.file);
  console.log(fileList.value, "---", fileList.value.length);
  const formData = new FormData();
  formData.append("image", item.file);
  console.log(formData, "xxx");
  bapi.uploadFile(formData).then((response) => {
    console.log(response);
  });
};

//开票
const CreateInvoice = () => {
  if (newInvoice.value.invoice_file)
    newInvoice.value.invoice_file = fileList.value[0].name;
  bapi.bcNewInvoice(newInvoice.value).then((res) => {
    console.log(res);
    ElMessage.success("开票成功");
    getProjectInf();
  });
  ifPopInvoice.value = false;
};
const projectMsg = ref({
  event_belongCompany: "",
  event_expectIncome: 0,
  event_leader: "",
  event_leader_id: "",
  event_name: "",
  event_outlay: 0,
  event_realIncome: 0,
  event_secret: "",
  event_status: "",
  id: 0,
});
const invoiceList = ref();
const invoiceNum = ref();

const getProjectInf = async () => {
  console.log(useProject.project_detail_id, "1");
  bapi
    .getEventDetailbyId({ event_id: useProject.project_detail_id })
    .then((res) => {
      projectInf.value = res.data;
      projectMsg.value = res.data.eventData;
      memberList.value = projectInf.value.member;
      useProject.project_members = memberList.value;
      invoiceList.value = res.data.invoice.invoices;
      invoiceNum.value = res.data.invoice.invoice_totalNum;
      console.log(memberList.value);
      calcCashProgress();
    });
  //任务状态统计
  bapi
    .getEventTaskStatusCount({ event_id: useProject.project_detail_id })
    .then((res) => {
      console.log(res.data);
      taskCategories.value = res.data.counts2.categories;
      taskValue.value = res.data.counts2.values;
      initTaskStatuChart();
    });
  //报销
  bapi
    .getReimbursementTotalbyId({ event_id: useProject.project_detail_id })
    .then((res) => {
      console.log(res);
      if (res.data.total) outpayTotal.value = res.data.total;
      console.log(outpayTotal.value);
    });
};
const ifImgPreview = ref(false);
const ImgPreviewUrl = ref();
const handlePictureCardPreview = (uploadFile) => {
  ImgPreviewUrl.value = uploadFile.url;
  ifImgPreview.value = true;
};

onMounted(() => {
  getProjectInf();
  let timer;
  window.onresize = function () {
    timer = null;
    console.log('resize')
    // taskStatuContainer.resize();
    console.log(
    )
    // nextTick(() => {
    // })

    //做个 防抖
    timer = setTimeout(() => {
      taskChartInstance.resize()
    }, 700);


    // console.log(taskChartInstance.value.echarts);
  };
});
</script>
