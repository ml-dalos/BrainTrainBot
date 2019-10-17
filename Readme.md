#BrainTrainBot
##About:
A Telegram bot for training your brain using questions from [What?Where?When? database(in Russian)](https://db.chgk.info/).

You can find bot by his nickname - @QuizTrainBrainBot.

##For developers:
1. Install ruby
2. Install gem [bundler](https://bundler.io/)
3. Configure [PostgreSQL](https://www.postgresql.org/)
4. Run `bundle install`
5. Create directory **confings** in project directory, create files **database.yaml** and **secrets.yaml**
6. Put database config in **database.yaml**, e.g.
   ```
   adapter: postgresql
   database: braintrain
   encoding: unicode
   pool: 5
   timeout: 5000
   ``` 
7. Put TelegramBot secret token(bot_api_key) into **secrets.yaml**, e.g.
   ```
   bot_api_key: 'DDDDDDDDD:XXXXXXxxxxDDDXx_DXxXXxXxDDXxxXxXxxX'
   ```
8. Run `rake db:start` for creating database
9. Run `rake db:migrate` for performing migrations
10. If you need to drop or reload database you can use `rake db:drop` and `rake db:reload`
11. Make file bin/app.rb executable `chmod +x bin/app.rb`
12. Run `bin/app.rb` for starting bot
13. Have fun!