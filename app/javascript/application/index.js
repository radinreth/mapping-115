document.addEventListener("turbolinks:load", function(){
  const currentPage = App.helper.getCurrentPage();
  console.log(currentPage)
  if (App[currentPage]) {
    App[currentPage]().init();
  }
})