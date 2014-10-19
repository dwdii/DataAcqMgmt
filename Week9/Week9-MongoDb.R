# 
# Author: Daniel Dittenhafer
#
# Created: Oct 19, 2014
#
# Description: Mongo Db Sandbox
#
require (rmongodb)

mongohost = "ds047040.mongolab.com:47040"
user = "admin"
pass = "a"
db = "myfirstmongo"

mongo <- mongo.create(host=mongohost, username=user, password=pass, db=db)

if(mongo.is.connected(mongo)) {
  print (mongo.get.database.collections(mongo, db))
  
}