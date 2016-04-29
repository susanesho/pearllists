# Pearllists

[![Build Status](https://travis-ci.org/andela-oesho/pearllists.svg?branch=master)](https://travis-ci.org/andela-oesho/pearllists)
[![Test Coverage](https://codeclimate.com/github/andela-oesho/pearllists/badges/coverage.svg)](https://codeclimate.com/github/andela-oesho/pearllists/coverage)
[![Code Climate](https://codeclimate.com/github/andela-oesho/pearllists/badges/gpa.svg)](https://codeclimate.com/github/andela-oesho/pearllists)

Pearllists is a bucket list API that allows you to create as many bucket lists as you want it can contain the things you would love to do in your lifetime, e.g wedding shopping list, V.I.P list to be invited and so many other fascinating things.

This API is created to meet just that need.

The endpoints that the API provides are listed below:

| Http verb | Endpoint | Description
|--- | --- | ---
| POST | /users/ |  Creates a new user.
| POST | /auth/login | Logs in a user
| GET | /auth/logout | Logs a user out
| POST | api/v1/bucketlists/ | Creates a new bucket list
| GET  | api/v1/bucketlists/ | Lists all the created bucket lists
| GET | api/v1/bucketlists/:id | Gets single bucket list
| GET | api/v1/bucketlists?q=name | Gets bucket list with the name specified
| GET | api/v1/bucketlists?page=2&limit=23 | Paginates your bucket lists.
| PUT | api/v1/bucketlists/:id | Updates this bucket list
| DELETE | api/v1/bucketlists/:id | Deletes this single bucket list
| POST | api/v1/bucketlists/:id/items/ | Creates a new item in bucket list
| PUT | api/v1/bucketlists/:id/items/:item_id | Updates a bucket list item
| DELETE | api/v1/bucketlists/:id/items/:item_id | Deletes an item in a bucket list

Only the new user creation and user login endpoints are accessible without being logged in. All others require the user to be logged in with a valid token.

All operations of a user are only within the scope of the users' bucket list(s) and/or item(s).

* To create a user, access `[POST /users/]` with the following parameters:

  `email - this should be of the type string`

  `password - should be string and must not be less than 8 characters`

* To login, access `[POST /auth/login]` with the following parameters:

  `email - should be a registered email`

  `password - should be a registered password`

  This returns an authentication token. Which must be present as an Authorization header in all requests made until after you log out or when the token expires. It should be used in the following format:

  `Authorization: "aaaaaaaaaaaaaaa.bbbbbbbbbbbbbbb.ccccccccccccccc"`


* To view all bucketlists, access `[GET /bucketlists/]`

  This shows all your bucketlists with their corresponding items, if you have any.

* To create a bucketlist, access `[POST /bucketlists/]` with the following parameters:

  `name - name of your bucketlist`

* To get a bucketlist with a particular id, access `[GET /bucketlists/:id]`

  This fetches the bucket list with the specified id.

* To get a bucketlist with a particular id, access `[GET /bucketlists?q=name]`

  This fetches the bucket list with the specified name.

* To get a bucketlist with a particular id, access `[GET /bucketlists?page=1&limit=20]`

  Gets bucket lists and paginates them as stated. In this case, it lists 20 bucket lists per page.

  The default number of bucket lists for pagination is 20 per page but you can specify that you want as much as 100 on a page.

* To update a bucketlist, access `[PUT /bucketlists/:id]` with the following parameters:

  `name - name of the bucket list you want to update`

* To delete a bucketlist, access `[DELETE /bucketlists/id]`.

  Deletes the bucket list with the specified id and all it associated items.

* To create a bucketlist item, access `[POST /bucketlists/:bucketlist_id/items]` with the following parameters:

  `name - name of your bucketlist item`

* To update a bucketlist item, access `[PUT /bucketlists/:bucketlist_id/items/:id] ` with the following parameters:

  `name - name of your bucketlist item`

  `status - This states whether you have achieved or done this particular item. Defaults to false. Only change to true if you want to check it as done.`


* To delete a bucketlist item, access `[DELETE /bucketlists/:bucketlist_id/items/:id]`.

  Deletes the bucket list item with the specified id.

**Notice**
* This API is versioned. All endpoints should be accessed prefixed with `api/v1/`
* You may test this API using Postman or cURL if you do not have a front-end client.

You can also find the documentation for this awesome API [here](http://pearllists.herokuapp.com/)

## API URI
You can access the API with this URI and point to the any of the available endpoints. [https://pearllists.herokuapp.com/api/{endpoint}](https://pearllists.herokuapp.com).

## Development Dependencies
* This API was built using rails-api.
* JWT was used for token authentication.
* Rspec was used for full end-to-end testing.
* Active Model Serializers was used for formatting json response.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andela-oesho/pearllists.

* Fork it ( https://github.com/andela-ooesho/pearllists/fork)
* Create your feature branch (git checkout -b feature/my-new-feature)
* Commit your changes (git commit -am 'Add some feature')
* Push to the branch (git push origin feature/my-new-feature)
* Create a new Pull Request

Thank you.