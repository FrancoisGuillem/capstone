(function() {
  'use strict';

  angular.module("spa-demo.subjects")
    .component("sdTagList", {
      templateUrl: tagListHtml,
      controller: tagListController,
    });

  tagListHtml.$inject = ["spa-demo.config.APP_CONFIG"];
  function tagListHtml(APP_CONFIG) {
    return APP_CONFIG.tag_list_html;
  }

  tagListController.$inject = ["$q", "spa-demo.subjects.Tag"];
  function tagListController($q, Tag) {
    var vm = this;
    vm.taglist = [];
    Tag.query().$promise.then(function(x, d) {
      vm.taglist = x;
    })
  }

  angular.module("spa-demo.subjects")
    .component("sdTagForm", {
      templateUrl: tagFormHtml,
      controller: tagFormController
    })

  tagFormHtml.$inject = ["spa-demo.config.APP_CONFIG"];
  function tagFormHtml(APP_CONFIG) {
    return APP_CONFIG.tag_form_html;
  }

  tagFormController.$inject = ["$q", "spa-demo.subjects.Tag"];
  function tagFormController($q, Tag) {
    console.log("tagFormController");
  }
}());
