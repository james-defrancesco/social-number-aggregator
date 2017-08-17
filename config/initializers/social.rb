

# Twitter 
#
TWITTER_CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = "PUwAm6V8TWZDafg37q8lsM4uE"
  config.consumer_secret     = "jLAOO42Udhzl7zv2eUIC1kVooDTjXF2uj7cnmUpSjgwMfQy25X"
  config.access_token        = "27150302-4bAhWNSYppo3NutcoKWhDvMpQmVopxpUeJCT1sCI1"
  config.access_token_secret = "3gsHs7lZsZhrwEeEPEURhOipMRR1yHWj5v7b1s0ij08xr"
end

# Youtube
#
Yt.configure do |config|
  config.log_level            = :debug
  config.api_key              = 'AIzaSyBKW7Y3xhk7cSiFwhGcYpUqNFBgihGk5KI'
end

# Facebook
# 
FACEBOOK_ClIENT = Koala::Facebook::API.new('EAACEdEose0cBAMqZCcXrRL7v6OqofbchNAAWOsObsioph5ZAeYU5qZAjwU6WddGKXsK9km3uixD9u6EZChsobZBuZC16ivZAutbmloNuBwtiLZAoDvrGbltwxcbqOfRz1wKNnX1t2ZBIEDgzRPNLc6bkU7Gt28ZAcrZC5dw15YUjdIvZAfHHIx0khIvofMssFCL5NvAZD')
