// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function () {
  $('#task_language').on('change', function (e) {
    const value = e.target.value;
    const lang = langToAceLang[value];
    if (!lang) console.error("Cannot find language: " + value);
    ['#tests_editor', '#runtime_editor', '#initial_editor'].forEach(function (id) {
      $(id).data({
        editor: lang,
      });
    })
    challenge.bindEditors();
  })
});

const langToAceLang = {
  javascript: "javascript",
  rust: "rust",
  swift: "swift",
  kotlin: "kotlin",
  java: "java"
}
