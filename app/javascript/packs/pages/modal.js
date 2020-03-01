$(document).on("turbolinks:load", function() {
  $("body").on("click", ".single-post-card, .single-post-list", function() {
    var posted_by = $(this)
      .find(".card-footer .posted-by")
      .html();

    var post_heading = $(this)
      .find(".post-content h3")
      .html();
    var post_content = $(this)
      .find(".post-content p")
      .html();
    var interested = $(this)
      .find(".card-footer a.interested")
      .attr("href");
    $(".modal-header .posted-by").text(posted_by);
    $(".loaded-data h3").text(post_heading);
    $(".loaded-data p").text(post_content);
    $(".loaded-data a.interested").attr("href", interested);
    $(".myModal").modal("show");
  });
});
