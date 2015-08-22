# Sinatra program for Fluc

### Files  
*api.rb;  Ruby Program with Sinatra to provide Restful APIs for Restaurant  
*app.rb:  Ruby Program with Sinatra to put some data into the Mongo DB  
*mongoid.yml:  Connector to Mongo DB  
*Gemfile:  Ruby file for executing api.rb and app.rb  
*vendor:  Library


### How to Run  

1. In this directory, execute "bundle install".  This is one time only  
2. Configure mongoid.yml according to your environment  
3. Start up Mongo db  
4. Execute "bundle exec ruby app.rb"  
5. From Browser, access to http://localhost:4567/  
6. Click "create" once (for test data)  
7. Stop the server  
8. Execute "bundle exec ruby api.rb"  
9. Access to http://localhost:4567/  
    You can use Advanced Rest Client (Chrome extension) or curl  
    
   * GET http://localhost:4567/  returns all restaurants in DB
   * GET http://localhost:4567/<id> returns specified restaurant
   * PUT http://localhost:4567/<id> updates the specified restaurant (param is JSON)
   * DELETE http://localhost:4567/<id> deletes the specified restaurant
