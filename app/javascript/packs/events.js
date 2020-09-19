function showPosts() {
  $('#posts').removeClass('d-none')
  $('#followers').removeClass('d-none').addClass('d-none')
  $('#followers-btn').removeClass('active')
  $('#posts-btn').removeClass('active').addClass('active')
}

function showFollowers() {
  $('#followers').removeClass('d-none')
  $('#posts').removeClass('d-none').addClass('d-none')
  $('#posts-btn').removeClass('active')
  $('#followers-btn').removeClass('active').addClass('active')
}

$(() => $('#posts-btn').on('click', () => showPosts()))
$(() => $('#followers-btn').on('click', () => showFollowers()))
