(function() {
  'use strict';
  angular.module("spa-demo.subjects").component("sdCurrentTags", {
    templateUrl: currentTagsTemplateUrl,
    controller: currentTagsController
  });

  currentTagsTemplateUrl.$inject = ["spa-demo.config.APP_CONFIG"];
  function currentTagsTemplateUrl(APP_CONFIG) {
    return APP_CONFIG.current_tag_html;
  }

  currentTagsController.$inject = ["spa-demo.subjects.Tag"];
  function currentTagsController(Tag) {
    var vm = this;

    vm.tags = [];
    vm.selected = null;

    vm.select = select;


    Tag.query().$promise.then(function(x, d) {
      vm.tags = x;
      vm.selected = vm.tags[0];
    })

    //////////////////////////
    function select(tag) {
      if (tag == vm.selected) {
        vm.selected = null;
        return;
      }
      vm.selected = tag;
      console.log("selected", tag);
    }

  }

}());
