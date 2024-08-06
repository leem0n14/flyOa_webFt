<template>
  <div class="container">
    <div class="tableContainer">
      <div class="toolContainer">
        <div class="searchContainer">
          <el-input
            v-model="MyProjectName"
            class="searchInputMyProject"
            placeholder="搜索已加入的项目"
          />
          <el-button :icon="Search" style="margin-left: 10px" circle />
        </div>
        <el-button
          class="joinBtn"
          type="primary"
          plain
          @click="PjoinProject = true"
          >参加项目</el-button
        >
        <!-- 加入项目的pop  -->
        <el-dialog
          v-model="PjoinProject"
          title="Tips"
          width="500"
          :before-close="checkClose"
          class="Pop"
        >
          <template #header>搜索项目</template>
          <div class="PopinputContainer">
            <div style="margin-top: 30px">
              <span>项目名称</span>
              <el-input
                v-model="JoinProjectInf.event_name"
                class="searchInputinPop"
                placeholder="请输入要加入的项目名称"
              />
            </div>
            <div style="margin-top: 30px">
              <span>项目密匙</span>
              <el-input
                v-model="JoinProjectInf.event_secret"
                class="searchInputinPop"
                placeholder="请输入项目密匙（若无请忽略）"
              />
            </div>
          </div>

          <template #footer>
            <div class="dialog-footer">
              <el-button @click="PjoinProject = false">取消</el-button>
              <el-button type="primary" @click="JoinProject()">
                确定
              </el-button>
            </div>
          </template>
        </el-dialog>
        <!-- 加入项目的pop  -->

        <el-button
          class="createBtn"
          type="primary"
          plain
          @click="PCreateProject = true"
          >新建项目</el-button
        >
        <!-- 新建项目的pop  -->
        <el-dialog
          v-model="PCreateProject"
          title="Tips"
          width="500"
          :before-close="checkClose"
          class="Pop"
        >
          <template #header>新建项目</template>
          <div class="PopinputContainer">
            <div style="margin-top: 10px">
              <span>项目名称</span>
              <el-input
                v-model="CreateProjectInf.event_name"
                class="searchInputinPop"
                placeholder="请输入新建的项目名称"
              />
            </div>
            <div style="margin-top: 30px">
              <span>项目负责人</span>
              <el-input
                v-model="useUser.userInf.name"
                class="searchInputinPop"
                disabled="true"
              />
            </div>
            <div style="margin-top: 30px">
              <span>项目密匙</span>
              <el-input
                v-model="CreateProjectInf.event_secret"
                class="searchInputinPop"
                placeholder="请设计项目密匙（若无请忽略）"
              />
            </div>
            <div style="margin-top: 30px">
              <span>项目总款项</span>
              <el-input
                v-model="CreateProjectInf.event_expectIncome"
                class="searchInputinPop"
                placeholder="请输入项目总款项"
              />
            </div>
            <!-- <div style="margin-top: 30px;">
                            <span>项目总款项</span>
                            <el-input v-model="CreateProjectInf.event_realIncome" class="searchInputinPop"
                                placeholder="请输入项目总款项" />
                        </div>
                        <div style="margin-top: 30px;">
                            <span>项目总款项</span>
                            <el-input v-model="CreateProjectInf.event_expectIncome" class="searchInputinPop"
                                placeholder="请输入项目总款项" />
                        </div> -->
            <div style="margin-top: 30px">
              <span>项目所属公司</span>
              <el-input
                v-model="CreateProjectInf.event_belongCompany"
                class="searchInputinPop"
                disabled="true"
              />
            </div>
          </div>

          <template #footer>
            <div class="dialog-footer">
              <el-button @click="PCreateProject = false">取消</el-button>
              <el-button type="primary" @click="CreateProject">
                确定
              </el-button>
            </div>
          </template>
        </el-dialog>
        <!--新建项目的pop  -->
      </div>
      <el-table
        :data="ProjectsList"
        style="width: 100%"
        stripe
        class="projectTable"
      >
        <el-table-column prop="event_name" label="项目名称" width="180" />
        <el-table-column prop="event_leader" label="项目负责人" width="100" />
        <el-table-column prop="event_status" label="状态" width="180">
          <!-- <template #default="{ row }">
                        <el-select v-model="row.event_status" placeholder="Select" size="large" style="width: 120px"
                            @change="updataEventStatus(row.id)">
                            <el-option v-for="item in statusList" :key="item.value" :label="item.label"
                                :value="item.value" />
                        </el-select>
                    </template> -->
        </el-table-column>
        <el-table-column prop="event_outlay" label="项目支出" width="180" />
        <el-table-column prop="event_realIncome" label="项目实收" width="170" />
        <el-table-column
          prop="event_expectIncome"
          label="项目应收"
          width="170"
        />
        <el-table-column
          prop="event_belongCompany"
          label="主办公司"
          width="180"
        />
        <el-table-column label="操作">
          <template #default="{ row }">
            <el-button type="primary" @click="checkEventDetail(row)"
              >查看</el-button
            >
            <el-button type="default" @click="quitEvent(row)">退出</el-button>
            <el-button
              v-if="row.event_leader == useUser.userInf.name"
              type="danger"
              @click="deleteEvent(row)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<style lang="scss">
.container {
  min-width: 100%;
  min-height: 100%;
  background-color: rgb(245, 246, 247);

  .tableContainer {
    margin-top: 12px;
    background-color: white;

    .toolContainer {
      position: relative;
      height: 80px;
      display: flex;
      align-items: center;
      position: relative;
      &:before {
        content: "";
        width: 86%;
        border-bottom: 2px solid #ebeef5;
        position: absolute;
        bottom: 38px;
      }
      .searchContainer {
        height: 100%;
        width: 400px;
        position: absolute;
        left: -20px;
        background-color: #5e81b9;
        display: flex;
        align-items: center;
        border-top-right-radius: 100px;
        border-bottom-right-radius: 100px;
        box-shadow: 5px 4px 12px rgba(0, 0, 0, 0.47);
        position: relative;
        &:before {
          content: "";
          width: 10px;
          height: 10px;
          position: absolute;
          bottom: -10px;
          background-color: #5e81b9;
          box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.47) inset;
          -webkit-clip-path: polygon(100% 0, 0 0, 100% 100%);
          clip-path: polygon(100% 0, 0 0, 100% 100%);
        }
      }

      .Pop {
        // height: 600px;

        .PopinputContainer {
          margin-top: 20px;
          width: 100%;
          display: flex;
          flex-direction: column;
          align-items: center;

          .searchInputinPop {
            margin-left: 8px;
            height: 50px;
            width: 300px;
          }
        }

        .dialog-footer {
          margin-top: 20px;
          width: 100%;
          display: flex;
          justify-content: center;
        }
      }

      .searchInputMyProject {
        width: 300px;
        height: 50px;
        margin-left: 30px;
      }

      .joinBtn {
        position: absolute;
        right: 130px;
        height: 50px;
      }

      .createBtn {
        position: absolute;
        right: 30px;
        height: 50px;
      }
    }

    outline: none;

    .projectTable {
      margin-top: 30px;
      border-top: 2px solid #ebeef5;
      .Status1 {
        background-color: #91a8d0;
      }
    }
  }
}
</style>

<script setup>
// 搜索图标Element Plus
import { Search } from "@element-plus/icons-vue";
import { ElMessage, ElMessageBox } from "element-plus";
import { useRouter } from "vue-router";
const router = useRouter();

import { ref, onMounted } from "vue";
import api from "@/api/index";

import { useProjectStore } from "../../store/project";
const useProject = useProjectStore();

import { useUserStore } from "../../store/user";
const useUser = useUserStore();

import { useCompanyStore } from "../../store/company";
const useCompany = useCompanyStore();
const bApi = api.bcApi;
const getProjects = () => {
  const union_id = useUser.userInf.union_id;
  bApi.getEventMy({ union_id: union_id }).then((res) => {
    console.log(res.data);
    ProjectsList.value = res.data.events;
  });
};
onMounted(() => {
  getProjects();
});

const PjoinProject = ref(false);
const PCreateProject = ref(false);
const MyProjectName = ref("");

const ProjectsList = ref([]);
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

const JoinProjectInf = ref({
  event_name: "",
  event_secret: "",
  user_id: useUser.userInf.open_id,
});
const CreateProjectInf = ref({
  event_name: "",
  event_secret: "",
  event_outlay: "",
  event_realIncome: "",
  event_expectIncome: "",
  event_belongCompany: useCompany.company_inf.name,
  user_id: useUser.userInf.open_id,
});

const CreateProject = () => {
  console.log(CreateProjectInf.value);
  CreateProjectInf.value.event_outlay = 0;
  CreateProjectInf.value.event_realIncome = 0;

  PCreateProject.value = false;
  bApi.inputEventInf(CreateProjectInf.value).then((res) => {
    console.log(res.data);
    getProjects();
    ElMessage.success("创建成功");
  });
};

const JoinProject = () => {
  console.log(JoinProjectInf.value);
  PjoinProject.value = false;
  bApi.addMemberIntoEvent(JoinProjectInf.value).then((res) => {
    console.log(res.data);
    getProjects();
    ElMessage.success("加入成功");
  });
};
const checkClose = (done) => {
  ElMessageBox.confirm("确定要退出吗").then(() => {
    done();
  });
};

const checkEventDetail = (row) => {
  ElMessage.success("跳转到项目详情");
  useProject.project_detail_id = row.id;
  useProject.project_name = row.event_name;
  useProject.project_inf = row;
  useProject.project_judgment = true;
  console.log(useProject.project_inf);
  console.log(useProject.project_detail_id);
  router.push("/projectManagement");
};
</script>

