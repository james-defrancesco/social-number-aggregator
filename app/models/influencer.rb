class Influencer < ApplicationRecord
  require 'net/http'

  def self.get_twitter_numbers(user)
    begin
      TWITTER_CLIENT.user(user).followers_count
    rescue Twitter::Error::TooManyRequests => e
      sleepy_time = e.rate_limit.reset_in + 1
      Rails.logger.info("following - sleeping #{distance_of_time_in_words Time.now, sleepy_time.secs}")
      sleep sleepy_time
      retry
    rescue Twitter::Error::NotFound => e
        return '*'
    end
  end

  def self.get_youtube_numbers(sub_id)
    @id = sub_id
    # todo:
    # get you id converter:
    #   https://www.googleapis.com/youtube/v3/channels?key=AIzaSyDsGZDPI461UR5JvTysAqv7PW7HSzj50KU&forUsername=" + $scope.channelName + "&part=id"
    begin
      channel = Yt::Channel.new id: "#{@id}"
      channel.subscriber_count
    rescue Yt::Errors::NoItems => e
      # Rails.logger.info "Youtubed returned nil"
      return ''
    end
  end

  def self.get_instagram_numbers(user)
    begin
      ig = InstaScraper::HTML::Account.new(user.gsub(/^@/,''))
      ig.data.deep_find('followed_by').fetch('count')
    rescue
      return nil
    end
  end

  def self.get_facebook_numbers(user)
    # begin
    #   FACEBOOK_CLIENT.get_connections(user, "likes")
    # rescue => e
    #   return "#{e.message}"
    # end
    ''
  end

  def self.get_yt_user_id(id)
    data = HTTParty.get(
      "https://www.googleapis.com/youtube/v3/channels?key=AIzaSyCgtPlsqP4ahadFmOj1GeRoGq3FfHmWMjI&forUsername=#{id}&part=id"
    )
    if data['items'].empty?
      return id
    end
    data = data['items'][0]['id']
    Rails.logger.info "\n\n\n #{data}\n\n\n"
  end

end
