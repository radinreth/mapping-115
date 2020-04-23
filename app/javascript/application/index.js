document.addEventListener("turbolinks:load", function(){
  const currentPage = App.helper.getCurrentPage();
  if (App[currentPage]) {
    App[currentPage]().init();
  }
})