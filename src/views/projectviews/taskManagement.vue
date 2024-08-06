<template>
  <div class="container">
    <div class="toolBar">
      <div class="TaskTools">
        <div class="projectTitle">
          <el-icon class="projectTitleIcon"><List /></el-icon>
          <span style="margin-left: 32px"> {{ useProject.project_name }} </span>
          <span
            style="
              color: gray;
              font-size: 20px;
              margin-top: 12px;
              margin-left: 6px;
            "
            >({{ taskTotalNum }})</span
          >
        </div>
        <el-button class="newTaskBtn" @click="PCreateTask = true">
          <el-icon><Plus /></el-icon>
          <span style="margin-left: 5px"> 新建任务 </span>
        </el-button>
      </div>

      <el-dialog
        v-model="PCreateTask"
        title="Tips"
        width="700"
        :before-close="checkClose"
      >
        <template #header>新建任务</template>
        <div class="PopinputContainer">
          <div class="popInputPart">
            <div>任务名称</div>
            <el-input
              v-model="newTask.task_name"
              placeholder="请输入新建的任务名称"
            />
            <div>起始时间</div>

            <el-date-picker
              v-model="taskDateRange"
              type="daterange"
              range-separator="To"
              start-placeholder="开始时间"
              end-placeholder="结束时间"
              placeholder="Pick a Date"
              format="YYYY/MM/DD"
              value-format="YYYY-MM-DD"
              style="width: 400px; margin-left: 25px"
            >
            </el-date-picker>
            <div>任务描述</div>
            <el-input
              type="textarea"
              :autosize="{ minRows: 8, maxRows: 9 }"
              v-model="newTask.task_describe"
              placeholder="请输入新建的任务描述"
            />
            <!-- 做选择 -->

            <div class="PopCheckBtn">
              <el-button @click="PCreateTask = false">取消</el-button>
              <el-button type="primary" @click="CreateTask"> 确定 </el-button>
            </div>
          </div>

          <!-- 11111111111111111111111111111111111111111111111111111111111111111111111111111111111 -->
          <div class="popDisabledPart">
            <span>任务负责人</span>
            <el-input
              v-model="newTask.task_leader"
              placeholder="请输入任务负责人"
              disabled="true"
            />
            <span>任务所属项目</span>
            <el-input
              v-model="newTask.task_belongEvent"
              placeholder="请输入新建的任务名称"
              disabled="true"
            />
            <span>任务状态</span>
            <el-input
              v-model="newTask.task_statu"
              placeholder="请输入新建的任务名称"
              disabled="true"
            />
          </div>
        </div>
      </el-dialog>
    </div>
    <!-- <div class="projectTitle">
      <el-icon class="projectTitleIcon"><List /></el-icon>
      <span style="margin-left: 12px"> {{ useProject.project_name }} </span>
      <span
        style="color: gray; font-size: 20px; margin-top: 12px; margin-left: 6px"
        >({{ taskTotalNum }})</span
      >
    </div> -->
    <div class="taskContainer">
      <el-table :data="TaskList" style="width: 100%">
        <el-table-column prop="task_name" label="任务名称">
          <template #default="{ row }"
            ><div>
              <span class="taskColumnTitle">任务</span>
              <span class="taskColumnContent"> {{ row.task_name }}</span>
            </div></template
          >
        </el-table-column>
        <el-table-column
          show-overflow-tooltip="true"
          prop="task_describe"
          label="任务描述"
        >
        </el-table-column>
        <!-- 如果为任务负责人可以做选择修改状态 -->
        <el-table-column prop="task_statu" label="任务状态" width="150px">
          <template #default="{ row }">
            <div
              style="
                cursor: pointer;
                border: 1px solid rgb(64, 158, 255);
                border-radius: 5px;
                padding: 2px;
                width: 70px;
                text-align: center;
              "
              v-if="!row.taskStatuSelect"
              class="m-2"
              @click="row.taskStatuSelect = true"
            >
              {{ row.task_statu }}
            </div>
            <el-select
              v-else
              v-autofocus="row.taskStatuSelect"
              v-model="row.task_statu"
              value-key="id"
              placeholder="Select"
              style="width: 100px"
              @change="updataTaskStatu(row, $event)"
              @blur="row.taskStatuSelect = false"
            >
              <el-option
                v-for="item in statusList"
                :key="item.id"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
            <!-- <el-button class="taskStatu" @click="row.drawer = true">{{ row.task_statu }}</el-button>
                        <el-drawer style="z-index: 1000 !important;" v-model="row.drawer">
                            <span>Hi, there!</span>
                        </el-drawer> -->
            <!-- <el-select v-model="row.task_statu" value-key="id" placeholder="Select" size="large"
                            style="width: 120px" @change="updataTaskStatu(row, $event)" :disabled="!ifLeader(row)">
                            <el-option v-for="item in statusList" :key="item.id" :label="item.label"
                                :value="item.value" />
                        </el-select> -->
          </template>
        </el-table-column>
        <!-- 如果为任务负责人可以做选择修改负责人 -->
        <el-table-column prop="task_leader" label="任务负责人" width="120px">
          <template #default="{ row }">
            <div
              class="taskLeader"
              @click="inputTaskLeader(row)"
              v-if="!row.task_leaderInput"
            >
              {{ row.task_leader }}
            </div>
            <el-select
              v-else
              v-autofocus="row.task_leaderInput"
              v-model="row.task_leader"
              @blur="row.task_leaderInput = false"
              @change="updataTaskLeader(row, $event)"
            >
              <el-option
                v-for="item in membersList"
                :key="item.id"
                :label="item.userName"
                :value="item.userBcId"
              />
            </el-select>
            <!-- 写个函数，通过返回true或者false去判断:disabled="!ifLeader" -->
            <!-- <el-select v-model="row.task_leader" value-key="id" placeholder="Select" size="large"
                            style="width: 120px" @change="updataTaskLeader(row, $event)" :disabled="!ifLeader(row)">
                            <el-option v-for="item in MembersList" :key="item.id" :label="item.user_name"
                                :value="item" />
                        </el-select> -->
          </template>
        </el-table-column>

        <!-- <el-table-column prop="task_belongEvent" label="所属项目">
                </el-table-column> -->
        <el-table-column prop="task_startTime" label="开始时间" width="130">
        </el-table-column>
        <el-table-column prop="task_endTime" label="结束时间">
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.container {
  min-width: 100%;
  min-height: 100%;
  background-color: rgb(255, 255, 255);

  .toolBar {
    // display: flex;
    // align-items: center;

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
          background-color: #335a98;
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
      padding: 0;
      height: 500px;
      width: 700px;
      display: flex;
      gap: 10px;
      div {
        font-size: 17px;
        padding-bottom: 5px;
      }

      .popInputPart {
        width: 450px;
        position: relative;
        &:before {
          content: "";
          position: absolute;
          height: 100%;
          right: -5px;
          border-right: rgb(228, 231, 237) 1px solid;
        }
        .PopCheckBtn {
          margin-top: 40px;
          display: flex;
          justify-content: center;
        }
      }
      .popDisabledPart {
        width: 200px;
      }
    }
  }

  .taskContainer {
    padding-left: 4px;
    padding-right: 4px;

    padding-top: 12px;

    .taskColumnTitle {
      font-size: 12px;
      background-color: #409eff;
      color: white;
      padding: 3px;
      border-radius: 3px;
    }
    .taskColumnContent {
      font-size: 17px;
      color: #182b50;
      margin-left: 14px;
    }
    .editTaskStatu {
      height: 2100px;
      width: 300px;
      background-color: antiquewhite;
    }

    .taskStatu {
      padding: 13px;
      border-radius: 19px;
    }

    .taskLeader {
      box-sizing: border-box;
      padding: 1px;
      margin-left: 2px;
      height: 30px;
      line-height: 30px;
      display: flex;
      align-items: center;
      color: black !important;
      cursor: pointer;

      &:before {
        content: "\00a0\00a0";
      }

      &:hover {
        box-sizing: border-box;
        border: rgb(64, 158, 255) 1px solid;
      }
    }
  }
}
</style>

<script setup>
import { ref, onMounted, nextTick } from "vue";
import { ElMessage, ElMessageBox } from "element-plus";
import { useProjectStore } from "../../store/project";
const useProject = useProjectStore();

import { useUserStore } from "../../store/user";
const useUser = useUserStore();

import api from "@/api/index";
const bApi = api.bcApi;

const taskLeaderInputRef = ref(null);

//日期数组1、2分别为开始日期、结束日期
const taskDateRange = ref([]);

const inputTaskLeader = (row) => {
  row.task_leaderInput = true;
};
//状态判定
const getStatusType = (status) => {
  switch (status) {
    case "审核中":
      return "primary";
    case "已通过":
      return "success";
    case "不通过":
      return "danger";
    default:
      return "info"; // 默认类型，如果需要的话
  }
};

//状态弹窗
const outpayStatuPop = ref(false);

const TaskList = ref([]);
const newTask = ref({
  event_id: useProject.project_detail_id,
  task_name: "",
  task_describe: "",
  task_statu: "规划中",
  task_leader: useUser.userInf.name,
  task_belongEvent: useProject.project_inf.event_name,
  task_startTime: "",
  task_endTime: "",
});
//项目下成员列表
const PCreateTask = ref(false);
const CreateTask = () => {
  PCreateTask.value = false;
  newTask.value.task_startTime = taskDateRange.value[0];
  newTask.value.task_endTime = taskDateRange.value[1];
  bApi.addTaskIntoEvent(newTask.value).then((res) => {
    console.log(res);
    if (res.data.errcode == "0") {
      ElMessage.success("创建成功");
    } else if (res.data.errcode == "400001") {
      console.log("400001");
      ElMessage.error("创建失败，请不要重复创建相同名字的任务");
    }
    //重置
    taskDateRange.value = [];
    newTask.value = {
      event_id: useProject.project_detail_id,
      task_name: "",
      task_describe: "",
      task_statu: "规划中",
      task_leader: useUser.userInf.name,
      task_belongEvent: useProject.project_inf.event_name,
      task_startTime: "",
      task_endTime: "",
    };
    getTasksinEvent();
  });
};

const taskTotalNum = ref(0);
const getTasksinEvent = () => {
  bApi.getTaskbyId({ event_id: useProject.project_detail_id }).then((res) => {
    console.log(res.data);
    TaskList.value = res.data.tasksData;
    if (TaskList.value.length > 0) taskTotalNum.value = TaskList.value.length;
  });
};

const statusList = ref([
  {
    value: "规划中",
    label: "规划中",
  },
  {
    value: "进行中",
    label: "进行中",
  },
  {
    value: "停止中",
    label: "停止中",
  },
  {
    value: "已完成",
    label: "已完成",
  },
  {
    value: "检查中",
    label: "检查中",
  },
]);

const drawer = ref();

const checkClose = (done) => {
  ElMessageBox.confirm("确定要退出吗").then(() => {
    done();
  });
};
const membersList = ref([
  {
    id: "",
    userName: "",
    userBcId: "",
  },
]);

const updataTaskLeader = (row, item) => {
  console.log(item);
  console.log(row);
  bApi
    .updateTaskLeader({
      task_id: row.id,
      task_leaderId: item.userBcId,
      task_Leader: item.userName,
    })
    .then((res) => {
      console.log(res);
      ElMessage.success("修改成功");
      getTasksinEvent();
    });
};
const updataTaskStatu = (row, item) => {
  console.log(row, item);
  bApi
    .updateTaskStatu({
      task_id: row.id,
      task_leaderId: row.task_leaderId,
      task_statu: item,
    })
    .then((res) => {
      console.log(res);
      ElMessage.success("修改成功");
      getTasksinEvent();
    });
};

// const ifLeader = ref(true)

const ifLeader = (row) => {
  // console.log(row.task_leaderId, row.task_leader)
  // console.log(useUser.userBcId)
  if (useUser.userBcId == row.task_leaderId) return true;
};

const checkLeader = () => {
  return true;
};

const UpdateTaskStatu = () => {};

onMounted(() => {
  getTasksinEvent();
  membersList.value = useProject.project_members.map((member) => {
    return {
      userName: member.user_name,
      userBcId: member.id,
    };
  });
  console.log(membersList.value);
  // MembersList.value = useProject.project_members.map(item => {
  //     return {
  //         id: item.id,
  //         user_name: item.user_name,
  //         union_id: item.user_id // 假设 union_id 对应于 user_id
  //     };
  // });
});
</script>