// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
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
});

challenge = {};
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
    var editor = ace.edit(elem.id);
    editor.setTheme("ace/theme/monokai");
    editor.session.setMode("ace/mode/" + lang);
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