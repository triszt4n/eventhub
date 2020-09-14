function showPosts() {
  $('#posts').removeClass('d-none')
  $('#subs').removeClass('d-none').addClass('d-none')
  $('#subs-btn').removeClass('active')
  $('#posts-btn').removeClass('active').addClass('active')
}

function showSubs() {
  $('#subs').removeClass('d-none')
  $('#posts').removeClass('d-none').addClass('d-none')
  $('#posts-btn').removeClass('active')
  $('#subs-btn').removeClass('active').addClass('active')
}

$(() => $('#posts-btn').on('click', () => showPosts()))
$(() => $('#subs-btn').on('click', () => showSubs()))
