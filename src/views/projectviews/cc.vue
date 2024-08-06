<template>
  <div>
    <input type="file" ref="inp" @change="handleFileChange" />
    <button @click="previewPDF">本页面预览</button>
    <button @click="parsePDF">解析</button>
    <button @click="openNewWindow">用新窗口打开</button>
    <div id="PDFContainer" class="pdf-container">
      <div class="title">Here is PDF view</div>
    </div>
  </div>
</template>
  
  <script setup>
import { ref, onMounted } from "vue";
import * as pdfjsLib from "../../../node_modules/pdfjs-dist/build/pdf.mjs";
console.log("There is code to parse PDF-file By ikun家族");

pdfjsLib.GlobalWorkerOptions.workerSrc =
  "./node_modules/pdfjs-dist/build/pdf.worker.mjs";

const inp = ref(null);

// const PDFContainer = ref(null);
const pdfContainerRef = ref(null);

onMounted(() => {
    
  // 获取id为PDFContainer的DOM元素，并赋值给pdfContainerRef
  pdfContainerRef.value = document.getElementById("PDFContainer");
});
const handleFileChange = (e) => {
  const file = e.target.files[0];
  if (file.type === "application/pdf") {
    console.log("PDF file selected", file.name);
  } else {
    throw Error("Selected file is not a PDF!");
  }
};

const previewPDF = () => {
  console.log(inp.value);
  if (inp.value.files.length) {
    let file = inp.value.files[0];
    let reader = new FileReader();
    reader.onload = async (e) => {
      let typedArray = new Uint8Array(e.target.result);
      readPDF(typedArray);
    };
    reader.readAsArrayBuffer(file);
  }
};

const readPDF = (typedArray) => {
  let url = URL.createObjectURL(
    new Blob([typedArray], { type: "application/pdf" })
  );
  pdfjsLib.getDocument(url).promise.then(function (pdf) {
    let pageNum = pdf.numPages;
    if (pageNum === 0) {
      throw Error("This is an empty PDF!");
    }
    console.log(`Your PDF-file has ${pageNum} Pages`);
    renderPDFPages(pdf);
  });
};

// const renderPDFPages = (pdf) => {
//   for (let i = 1; i <= pdf.numPages; i++) {
//     pdf.getPage(i).then(function (page) {
//       var scale = 1.5;
//       var viewport = page.getViewport({ scale: scale });
//       var canvas = document.createElement("canvas");
//       var context = canvas.getContext("2d");
//       canvas.height = viewport.height;
//       canvas.width = viewport.width;
//       PDFContainer.value.appendChild(canvas);
//       var renderContext = {
//         canvasContext: context,
//         viewport: viewport,
//       };
//       var renderTask = page.render(renderContext);
//       renderTask.promise.then(() => {
//         console.log(`Page ${i} rendered`);
//       });
//     });
//   }
// };
const renderPDFPages = (pdf) => {
  for (let i = 1; i <= pdf.numPages; i++) {
    pdf.getPage(i).then(function (page) {
      var scale = 1.3;
      var viewport = page.getViewport({ scale: scale });
      var canvas = document.createElement("canvas");
      var context = canvas.getContext("2d");
      canvas.height = viewport.height;
      canvas.width = viewport.width;

      // 确保PDFContainer.value不是null
      if (pdfContainerRef.value) {
        pdfContainerRef.value.appendChild(canvas);
      } else {
        console.error("PDFContainer is null, cannot append canvas element.");
      }
      var renderContext = {
        canvasContext: context,
        viewport: viewport,
      };
      var renderTask = page.render(renderContext);
      renderTask.promise.then(() => {
        console.log(`Page ${i} rendered`);
      });
    });
  }
};
const parsePDF = () => {
  alert("Not implemented yet");
  console.log("Not implemented yet");
};

const openNewWindow = () => {
  if (inp.value.files.length) {
    let file = inp.value.files[0];
    let reader = new FileReader();
    reader.onload = async (e) => {
      let typedArray = new Uint8Array(e.target.result);
      let url = URL.createObjectURL(
        new Blob([typedArray], { type: "application/pdf" })
      );
      window.open(url, "_blank");
    };
    reader.readAsArrayBuffer(file);
  }
};
</script>
  
  <style>
.pdf-container {
  /* 你的样式 */
  height:1200px;
  width: 80%;
  border: 2px solid black;
  overflow: scroll;
}
</style>