function showPosts() {
  $('#events').removeClass('d-none')
  $('#followers').removeClass('d-none').addClass('d-none')
  $('#followers-btn').removeClass('active')
  $('#events-btn').removeClass('active').addClass('active')
}

function showFollowers() {
  $('#followers').removeClass('d-none')
  $('#events').removeClass('d-none').addClass('d-none')
  $('#events-btn').removeClass('active')
  $('#followers-btn').removeClass('active').addClass('active')
}

$(() => $('#events-btn').on('click', () => showPosts()))
$(() => $('#followers-btn').on('click', () => showFollowers()))
