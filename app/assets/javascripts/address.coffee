$ ->
  $('#user_postcode').jpostal({
    postcode : ['#user_postcode'],
    address : {
              '#user_prefecture' : '%3',
              '#user_address_city' : '%4',
              '#user_address_street' : '%5%6%7'
    }
  })
