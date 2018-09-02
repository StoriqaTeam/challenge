//= require jquery
//= require rails-ujs
//= require activestorage
//= require materialize
//= require_tree .

$(document).ready(function () {
  $('select').material_select();
  hljs.initHighlightingOnLoad();
  challenge.bindPreviews();
  challenge.bindEditors();
  challenge.renderNotice();
});

challenge = {};

challenge.renderNotice = function () {
  const notice = $('#notice').text();
  if (notice) {
    Materialize.toast(notice, 2000);
  }
}

challenge.bindPreviews = function () {
  $('[data-preview]').each(function (i, elem) {
    const targetId = $(elem).data().preview;
    challenge.renderMarkdown(elem.value, targetId);
    $(elem).off('input');
    $(elem).on('input', function () {
      challenge.renderMarkdown(elem.value, targetId)
    })
  });
}

challenge.bindEditors = function () {
  $('[data-editor]').each(function (i, elem) {
    const lang = $(elem).data().editor;
    const input_id = "#" + $(elem).data().input;
    const editor = ace.edit(elem.id);
    editor.setTheme('ace/theme/chrome');
    const initialValue = $(input_id).val();
    if (initialValue) editor.setValue(initialValue);
    editor.session.setMode("ace/mode/" + lang);
    editor.off('change');
    editor.on('change', function (event, editor) {
      const value = editor.getValue();
      $(input_id).val(value);
    })
  });
}

challenge.highlight = function () {
  $('pre code').each(function (i, block) {
    hljs.highlightBlock(block);
  });
}
challenge.renderCode = function (text, id) {
  const elem = $("#" + id);
  elem.html("<pre><code>" + text + "</code></pre>");
  challenge.highlight();
}
challenge.renderMarkdown = function (text, id) {
  const converter = new showdown.Converter();
  const html = converter.makeHtml(text);
  const elem = $("#" + id);
  elem.html(html);
  challenge.highlight();
}

challenge.onRunTestsClick = function(e) {
  e.preventDefault();
  e.stopPropagation();
  const id = $("#task_solution_id").val();
  const solution = $("#task_solution_solution").val();
  const tests = $("#task_solution_tests").val();
  $('#run_tests_button').attr('disabled', true);
  $.ajax({
    method: "POST",
    url: "/try",
    data: { id: parseInt(id, 10), code: solution + '\n' + tests }
  })
  .done(function( msg ) {
    $('#run_tests_button').attr('disabled', false);
  })
  .fail(function( e ) {
    $('#run_tests_button').attr('disabled', false);
    alert("Error");
  });
}
