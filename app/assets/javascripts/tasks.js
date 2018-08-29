// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function () {
  $('#task_language').on('change', function(e) {
    const value = e.target.value;
    const lang = langToAceLang[value];
    
  })
});

const langToAceLang = {
  javascript: "javascript",
  rust: "rust",
  swift: "swift",
  kotlin: "kotlin",
  java: "java"
}
