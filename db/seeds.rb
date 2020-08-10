kim = User.create(name:"Kim", email:"kim@kim.com" , password:"password" )
brad = User.create(name:"Brad", email:"brad@brad.com" , password:"password" )

Game.create(user_id: kim.id)
Game.create(user_id: brad.id)

kim.games.create(user_id: kim.id)
brad.games.create(user_id: brad.id)








