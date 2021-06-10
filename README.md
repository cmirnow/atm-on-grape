# API ATM on Grape & Rails
Guys, this is a test task, and nothing more... :)

## Quickly start

```bash
git clone https://github.com/cmirnow/atm-on-grape.git
cd atm-on-grape
bundle install
bundle exec rake db:migrate
bundle exec rake db:seed
rails s
```
You can see the list of grape API routes by running:
```bash
rails grape:routes
       GET  |  /api/:version/banknote_asset(.:format)      |  v1  |  list       
     PATCH  |  /api/:version/banknote_asset(.:format)      |  v1  |  get money  
       PUT  |  /api/:version/banknote_asset/:id(.:format)  |  v1  |  update cash
```
You can find out what banknotes the ATM has:
```
curl http://localhost:3000/api/v1/banknote_asset.json
```
Get any amount (if possible):
```
curl -X PATCH http://localhost:3000/api/v1/banknote_asset.json -d "sum=666"
```
Top up banknotes:
```
curl -X PUT http://localhost:3000/api/v1/banknote_asset/1.json -d "banknote1=10&banknote2=10&banknote5=10&banknote10=10&banknote25=10&banknote50=10"
```
Hope this helps. You won't get real money, but knowledge is cool. :)