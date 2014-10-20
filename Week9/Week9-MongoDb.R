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
authdb = db

ns = sprintf("%s.%s", db, "towns")

mongo <- mongo.create(host=mongohost, username=user, password=pass, db=authdb)
print (mongo)

if(!mongo.is.connected(mongo)) {
  mongo.get.last.err(mongo)
} else 
{

  print (mongo.get.database.collections(mongo, db))
  
  cursor <- mongo.find(mongo, ns)
  
  # Step though the matching records and display them
  while (mongo.cursor.next(cursor))
    print(mongo.cursor.value(cursor))
  mongo.cursor.destroy(cursor)
  
  
  mongo.insert(mongo, ns, list(name="New York", population=22200000))
  
  mongo.get.last.err(mongo, db=db)
}