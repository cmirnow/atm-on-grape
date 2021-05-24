## API ATM on Grape & Rails
Guys, this is a test task, and nothing more... :)

# Quickly start

```bash
git clone atm-on-grape
cd atm-on-grape
bundle install
bundle exec rake db:migrate
bundle exec rake db:seed
rails s
```
You can see the list of grape API routes by running:
```bash
$ rails grape:routes
       GET  |  /api/:version/banknote_data(.:format)      |  v1  |  list       
     PATCH  |  /api/:version/banknote_data(.:format)      |  v1  |  get money  
       PUT  |  /api/:version/banknote_data/:id(.:format)  |  v1  |  update cash
```
You can find out what banknotes the ATM has:
```
$ curl http://localhost:3000/api/v1/banknote_data.json
```
Get any amount (if possible):
```
$ curl -X PATCH http://localhost:3000/api/v1/banknote_data.json -d "sum=666"
```
Top up banknotes:
```
$ curl -X PUT http://localhost:3000/api/v1/banknote_data/1.json -d "banknote1=5&banknote2=2&banknote5=5&banknote10=1&banknote25=2&banknote50=3"
```
Hope this helps. You won't get real money, but knowledge is cool. :)