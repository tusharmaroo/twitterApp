class LogicsController < ApplicationController
  #caching the index action for some time
  caches_action :index, expires_in: 10.hours

  #index action (core logic)
  def index
  	#Twitter Authentication
  	twitterAppClient = Twitter::REST::Client.new do |config|
	  config.consumer_key        = "CtIM8qPkPFQ808mwleqV6g"
	  config.consumer_secret     = "dFi4BqUlqpeWsyGKkaq869GszIsReIyWVF24QLjio"
	end
	
	#put in the tweet id whose data is to be fetched
  	tweet_id = "425703426602074112"
  	
  	#wiitter API call url
	url = 'https://api.twitter.com/1.1/statuses/retweets/'+tweet_id+'.json?trim_user=false'

	#Fetching the url's response
	@responses = twitterAppClient.get(url).body

	#parsing each response & pushing in array
	@responseArray = Array.new
	@responses.each do |response|
		followersCount = response[:user][:followers_count]
		profileImage = response[:user][:profile_image_url]
		#little hack to find the original image
		correctedProfileImage = profileImage.gsub("_normal", "")
		tempArray = [correctedProfileImage, followersCount]
		@responseArray << tempArray
	end
	
	#removing any repeatation from array
	@responseArray = @responseArray.uniq

	#sorting the array 
	@responseArraySorted = @responseArray.sort {|a,b| b[1] <=> a[1]}

	#the top ten people
	@results = @responseArraySorted.first(10)

  end
end
