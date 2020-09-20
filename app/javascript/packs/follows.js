function showEvents() {
  $('#events').removeClass('d-none')
  $('#users').removeClass('d-none').addClass('d-none')
  $('#users-btn').removeClass('active')
  $('#events-btn').removeClass('active').addClass('active')
}

function showUsers() {
  $('#users').removeClass('d-none')
  $('#events').removeClass('d-none').addClass('d-none')
  $('#events-btn').removeClass('active')
  $('#users-btn').removeClass('active').addClass('active')
}

$(() => $('#events-btn').on('click', () => showEvents()))
$(() => $('#users-btn').on('click', () => showUsers()))
