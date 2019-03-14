# API Documentation

  * [TicketApiWeb.EventController](#ticketapiweb-eventcontroller)
    * [index](#ticketapiweb-eventcontroller-index)
  * [TicketApiWeb.PaymentController](#ticketapiweb-paymentcontroller)
    * [create](#ticketapiweb-paymentcontroller-create)
    * [show](#ticketapiweb-paymentcontroller-show)
    * [create](#ticketapiweb-paymentcontroller-create)
  * [TicketApiWeb.TicketController](#ticketapiweb-ticketcontroller)
    * [index](#ticketapiweb-ticketcontroller-index)
    * [create](#ticketapiweb-ticketcontroller-create)
    * [show](#ticketapiweb-ticketcontroller-show)
  * [TicketApiWeb.UserController](#ticketapiweb-usercontroller)
    * [create](#ticketapiweb-usercontroller-create)
    * [update](#ticketapiweb-usercontroller-update)

## TicketApiWeb.EventController
### <a id=ticketapiweb-eventcontroller-index></a>index
#### List all events
##### Request
* __Method:__ GET
* __Path:__ /api/v1/events

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: 2m5tad1hg756gl30640003r4
```
* __Response body:__
```json
{
  "data": [
    {
      "adress": "adress",
      "id": 51299,
      "name": "event",
      "start_at": "2010-04-17T14:00:00Z",
      "ticket_counts": [
        {
          "max_size": 20,
          "price": 20,
          "size_left": 15,
          "t_type": "multiple",
          "ticket_type": "event"
        },
        {
          "max_size": 10,
          "price": 35,
          "size_left": 9,
          "t_type": "avoid_one",
          "ticket_type": "event"
        }
      ]
    }
  ]
}
```

## TicketApiWeb.PaymentController
### <a id=ticketapiweb-paymentcontroller-create></a>create
#### Create payment
##### Request
* __Method:__ POST
* __Path:__ /api/v1/payments
* __Request headers:__
```
accept: application/json
authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJUaWNrZXRBcGkiLCJleHAiOjE1NTI2NTUzMTYsImlhdCI6MTU1MjU2ODkxNiwiaXNzIjoiVGlja2V0QXBpIiwianRpIjoiYmUzODc5Y2UtYzQxYy00MzI0LWFkNzMtMGNjOGU1ZjgzZDRkIiwibmJmIjoxNTUyNTY4OTE1LCJzdWIiOiI0NDkzIiwidHlwIjoiYWNjZXNzIn0.BXBAT9K_ySazkSIYO-8L5rEqr19a8USI7n5L6C8xKN-d6AQgeTRSFF1e2QQp5q45AyFRQ7EXCMKt_1GEXVk-Xg
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "payment": {
    "card_info": "info",
    "currency": "eur",
    "info": "some info",
    "ticket_id": 2913,
    "user_id": 4493
  }
}
```

##### Response
* __Status__: 201
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: 2m5tad1fg9vka6itqo000351
location: /api/v1/payments/1017
```
* __Response body:__
```json
{
  "data": {
    "id": 1017,
    "info": "some info"
  }
}
```

### <a id=ticketapiweb-paymentcontroller-show></a>show
#### Show payments
##### Request
* __Method:__ GET
* __Path:__ /api/v1/payments/1017
* __Request headers:__
```
accept: application/json
authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJUaWNrZXRBcGkiLCJleHAiOjE1NTI2NTUzMTYsImlhdCI6MTU1MjU2ODkxNiwiaXNzIjoiVGlja2V0QXBpIiwianRpIjoiYmUzODc5Y2UtYzQxYy00MzI0LWFkNzMtMGNjOGU1ZjgzZDRkIiwibmJmIjoxNTUyNTY4OTE1LCJzdWIiOiI0NDkzIiwidHlwIjoiYWNjZXNzIn0.BXBAT9K_ySazkSIYO-8L5rEqr19a8USI7n5L6C8xKN-d6AQgeTRSFF1e2QQp5q45AyFRQ7EXCMKt_1GEXVk-Xg
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: 2m5tad1fsb6ja6itqo000371
```
* __Response body:__
```json
{
  "data": {
    "id": 1017,
    "info": "some info"
  }
}
```

### <a id=ticketapiweb-paymentcontroller-create></a>create
#### invalid creattion params
##### Request
* __Method:__ POST
* __Path:__ /api/v1/payments
* __Request headers:__
```
accept: application/json
authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJUaWNrZXRBcGkiLCJleHAiOjE1NTI2NTUzMTYsImlhdCI6MTU1MjU2ODkxNiwiaXNzIjoiVGlja2V0QXBpIiwianRpIjoiN2VlYzhjZmItYjViYi00NDg4LTk2NTgtMjRkMzNjZmNlYjlkIiwibmJmIjoxNTUyNTY4OTE1LCJzdWIiOiI0NDkxIiwidHlwIjoiYWNjZXNzIn0.VCKyh8lp5UCtbaW08bCodvL6oYDUfgC1fzpEfoB-V6JZ1UWDYsCeGmLr_qM7fxA7WqiZsBgTMyH7zoaaoPYxKQ
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "payment": {
    "info": null
  }
}
```

##### Response
* __Status__: 422
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: 2m5tad1e9qop435cis0003q4
```
* __Response body:__
```json
{
  "errors": {
    "info": [
      "can't be blank"
    ],
    "ticket_id": [
      "can't be blank"
    ],
    "user_id": [
      "can't be blank"
    ]
  }
}
```

## TicketApiWeb.TicketController
### <a id=ticketapiweb-ticketcontroller-index></a>index
#### List all tickets
##### Request
* __Method:__ GET
* __Path:__ /api/v1/tickets
* __Request headers:__
```
accept: application/json
authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJUaWNrZXRBcGkiLCJleHAiOjE1NTI2NTUzMTYsImlhdCI6MTU1MjU2ODkxNiwiaXNzIjoiVGlja2V0QXBpIiwianRpIjoiM2UxNmM4Y2EtYTUyNC00ZGI2LWI0NmQtZDMzNzY0Yjk0NzZhIiwibmJmIjoxNTUyNTY4OTE1LCJzdWIiOiI0NDc3IiwidHlwIjoiYWNjZXNzIn0.SuIbMs2Dnd_zA_yhZyEYNLhRUZ2P-m25jTkozCivHwNFPuvhI4niQCeKFTSGMfiQb6_Yi5P7RCcoqz3wbc-Z5Q
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: 2m5tad0mt4d8sn4o1g0003e4
```
* __Response body:__
```json
{
  "data": [
    {
      "first_name": "some updated first_name",
      "id": 2892,
      "last_name": "some updated last_name",
      "only_reserved": true,
      "paid": false,
      "reservation_code": null
    }
  ]
}
```

### <a id=ticketapiweb-ticketcontroller-create></a>create
#### Reserve ticket
##### Request
* __Method:__ POST
* __Path:__ /api/v1/tickets
* __Request headers:__
```
accept: application/json
authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJUaWNrZXRBcGkiLCJleHAiOjE1NTI2NTUzMTYsImlhdCI6MTU1MjU2ODkxNiwiaXNzIjoiVGlja2V0QXBpIiwianRpIjoiYTU5Yjg4NTktZGU0Mi00ZDQyLWFkNGEtNDQ4YTA0NGM4Y2FlIiwibmJmIjoxNTUyNTY4OTE1LCJzdWIiOiI0NDc4IiwidHlwIjoiYWNjZXNzIn0.LPhpr0vjyXQ2BATM7Y4BUSiXrEbvGnYdUMxoHgTGy44VW_iZZXGH4ibbXaHBtOWEIAt37MGZyavRe5SiMiJU3Q
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "ticket": {
    "count": 2,
    "event_id": 51286,
    "first_name": "some first_name",
    "last_name": "some last_name",
    "ticket_type_id": 102644
  }
}
```

##### Response
* __Status__: 201
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: 2m5tad0nrbtbfcb5uo0003g4
location: /api/v1/tickets/2894
```
* __Response body:__
```json
{
  "data": {
    "first_name": "some first_name",
    "id": 2894,
    "last_name": "some last_name",
    "only_reserved": true,
    "paid": false,
    "reservation_code": "KalWMhy"
  }
}
```

### <a id=ticketapiweb-ticketcontroller-show></a>show
#### Update ticket
##### Request
* __Method:__ GET
* __Path:__ /api/v1/tickets/2896
* __Request headers:__
```
accept: application/json
authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJUaWNrZXRBcGkiLCJleHAiOjE1NTI2NTUzMTYsImlhdCI6MTU1MjU2ODkxNiwiaXNzIjoiVGlja2V0QXBpIiwianRpIjoiZDI2ZmViOTItNzYxOC00YmI2LTg1N2MtYmJjYmZkZDlkYjljIiwibmJmIjoxNTUyNTY4OTE1LCJzdWIiOiI0NDgwIiwidHlwIjoiYWNjZXNzIn0.zPBLKeNtcynhqcrKXRvBzEI9Awzq4yHQwXMUYKeIueoCLm9_3qQ60-bZPwGpv_pf3vYAIiwsM71fHwa7uX0naw
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: 2m5tad14rk48iercag0003l4
```
* __Response body:__
```json
{
  "data": {
    "first_name": "some updated first_name",
    "id": 2896,
    "last_name": "some updated last_name",
    "only_reserved": true,
    "paid": false,
    "reservation_code": "5ILRmsk"
  }
}
```

## TicketApiWeb.UserController
### <a id=ticketapiweb-usercontroller-create></a>create
#### Create user
##### Request
* __Method:__ POST
* __Path:__ /api/v1/users
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "user": {
    "email": "some@email.pl",
    "first_name": "some first_name",
    "is_active": true,
    "last_name": "some last_name",
    "password": "some password",
    "password_confirmation": "some password",
    "phone_number": "some phone_number"
  }
}
```

##### Response
* __Status__: 201
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: 2m5tad0ctlv84v27cc0002k2
location: /api/v1/users/4474
```
* __Response body:__
```json
{
  "email": "some@email.pl",
  "first_name": "some first_name",
  "id": 4474,
  "is_active": true,
  "last_name": "some last_name",
  "phone_number": "some phone_number",
  "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJUaWNrZXRBcGkiLCJleHAiOjE1NTI2NTUzMTYsImlhdCI6MTU1MjU2ODkxNiwiaXNzIjoiVGlja2V0QXBpIiwianRpIjoiNWY4NWE3MDYtZTc0Yi00Zjc2LTk2YTYtYWUyYWYyNmM1ODIwIiwibmJmIjoxNTUyNTY4OTE1LCJzdWIiOiI0NDc0IiwidHlwIjoiYWNjZXNzIn0.hSihlY6HHfqccyetFRWCywEWcvtOqL7LPP-gPkNt58O5jOtudu2oE_EiQnEvSt2SyVqLop189OmqpC5ocbc5tw"
}
```

### <a id=ticketapiweb-usercontroller-update></a>update
#### Update user
##### Request
* __Method:__ PUT
* __Path:__ /api/v1/users
* __Request headers:__
```
accept: application/json
authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJUaWNrZXRBcGkiLCJleHAiOjE1NTI2NTUzMTYsImlhdCI6MTU1MjU2ODkxNiwiaXNzIjoiVGlja2V0QXBpIiwianRpIjoiM2Y2MGU1OGUtMDQ1NS00Zjc5LTg0MzktOTYzZTRkMmE4ZDc0IiwibmJmIjoxNTUyNTY4OTE1LCJzdWIiOiI0NDc2IiwidHlwIjoiYWNjZXNzIn0.Oa-L3YEzAIVKQU_R6g9VhR2jFO0tR2hJvHGMAsY_1QaLGnDyG4si6a0SUrIQbafy3WMfg6pYqlO7dyS-SQ8LJQ
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "user": {
    "email": "someupdated@email.pl",
    "first_name": "some updated first_name",
    "is_active": false,
    "last_name": "some updated last_name",
    "password": "some updated password",
    "password_confirmation": "some updated password",
    "phone_number": "some updated phone_number"
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: 2m5tad0kkn23mrl0ms0003l3
```
* __Response body:__
```json
{
  "data": {
    "email": "someupdated@email.pl",
    "first_name": "some updated first_name",
    "id": 4476,
    "is_active": false,
    "last_name": "some updated last_name",
    "phone_number": "some updated phone_number"
  }
}
```

