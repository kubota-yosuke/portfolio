document.addEventListener('turbolinks:load', () => {

    $(function() {
        setTimeout("$('.flash').fadeOut('slow')", 2000);
    });
  
})