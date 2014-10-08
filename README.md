<a href="http://couchfoodie.io" target="_blank">Couchfoodie</a>
===========

You don't like cooking that much and got sick of most local resturants; yet you still need to eat everyday.

I love cooking, whether it's fancy dinner cuisine or just sunday afternoon desserts; and I'm open to the idea of inviting a guest to taste my cooking!

What if there is a community platform that gap the supply and demand of homemade cooking?

You get...home cooked meal and a new friend!

I get...someone who appreciate my cooking and a new friend!

This is the golden opportunity to cure starvation, longingness and socialize with your neighbors!

# How to run couchfoodie on your local machine #

## Install  

* Fork this repository
* Download to your desktop or your preferred directory
* In terminal 

	`cd desktop/couchfoodie`

	`bundle install --without production`

## Environments and outside sources you need to set up

### .env file

* You'll need to make a `.env` file under root directory to hold the env variables. 
* Under desktop/couchfoodie `cp .env.example .env`

### Database

* You'll need to set up postgres database on your local machine

	<code>brew update</code>

	<code>brew install postgresql</code>

	For more detailed installation guide, see <a href="http://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/" target="_blank">here</a>


### Faceboook login setup

* This app uses facebook login for user authentication. 
* The `.env` file include the `FACEBOOK_APP_ID` and `FACEBOOK_APP_SECRET` for a fb_login app development version, it should work out of box. If for some reason it stopped working, you can follow instructions <a href="https://developers.facebook.com/docs/facebook-login/v2.1" target="_blank">here</a> to set up a new facebook login app.

### Amazon AWS S3

* This app uses <a href="http://aws.amazon.com/s3/?sc_channel=PS&sc_campaign=AWS_Free_Tier_2013_T&sc_country=US&sc_publisher=Google&sc_medium=b_test_storage_e-aws_s3&sc_content=40951151682&sc_detail=Aws%20s3&sc_category=storage_CDN&sc_segment=s3&sc_matchtype=e" target="_blank">Amazon S3</a> for photo storage. You'd need to set up a seperate amazon S3 account. AWS allows free account and usage.

* Register a free account if you don't have one yet. <a href="http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html" target="_blank">Make a bucket</a> to store photos just for this app.

* After logging in S3, generate ACCESS KEY ID and SECRET ACCESS KEY under `Services -> IAM -> Users -> your username -> Security Credentials`
* Retrieve the following information:

1. Your AMAZON S3 BUCKET NAME, as a string.
2. Your S3 ACCESS KEY ID
3. Your S3 SECRET ACCESS KEY
4. Your S3 Bucket AWS ASSET HOST URL (this can be found by going `bucket -> Properties`, it looks something like `https://couchfoodie.s3.amazonaws.com`)

* Enter the those information to the appropiate matching lines in your `.env` file

### carrierwave

* This app uses <a href="https://github.com/carrierwaveuploader/carrierwave" target="_blank">carrierwave</a> for photo processing. 
* `gem install carrierwave`
* Carrierwave uses ImagMagick to do the ACTUAL photo processing work
* `brew install imagemagick`

### carrierwave-aws

* This app uses `carrierwave-aws` as adaptor for carrierwave + Amazon S3
* `gem install carrierwave-aws`


### Sidekiq

* This app uses <a href="https://github.com/mperham/sidekiq" target="_blank">sidekiq</a> for background processing of photo.
* `gem install sidekiq`

### Redis

* Sidekiq uses redis for data storage, so you'll need to install and run a redis instance locally.
* Run `brew install redis`

### Mandrill for email

* This app uses <a href="https://www.mandrill.com/" target="_blank">Mandrill</a> for email server.
* Visit Mandrill site, register a free account and retrieve USERNAME and PASSWORD, input those values in your `.env` file. 

## Up and running locally

* Create empty database by running `bundle exec rake db:setup`
* Generate secrets.yml file by running `bundle exec rake secret:create_file`
* Run the database migration by running `bundle exec rake db:migrate`

* Run redis instance locally: Open one terminal window, run `redis-server`
* This app uses Procfile to start both web server and worker server, run `gem install foreman` to make sure you have foreman installed.
* Open another terminal window, run `foreman start`
* In browser, go to `http://localhost:5000`
