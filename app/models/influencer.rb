class Influencer < ApplicationRecord
  require 'net/http'

  scope :alphabetically, -> { order("last_name ASC") }

  def self.get_twitter_numbers(user)
    #return tw unless is_good_time.empty?
    begin
      TWITTER_CLIENT.user(user).followers_count
    rescue Twitter::Error::TooManyRequests => e
      sleepy_time = e.rate_limit.reset_in + 1
      Rails.logger.info("following - sleeping #{distance_of_time_in_words Time.now, sleepy_time}")
      return 'F: Check back in 1h'
    rescue Twitter::Error::NotFound => e
      return '*'
    end
  end

  def self.get_twitter_profile(user)
    #return tw unless is_good_time.empty?
    begin
      TWITTER_CLIENT.user(user)
    rescue Twitter::Error::TooManyRequests => e
      sleepy_time = e.rate_limit.reset_in + 1
      Rails.logger.info("following - sleeping #{distance_of_time_in_words Time.now, sleepy_time}")
      return 'F: Check back in 1h'
    rescue Twitter::Error::NotFound => e
      return '*'
    end
  end

  def self.get_youtube_numbers(sub_id)
    #return unless is_good_time.empty?
    @id = sub_id
    # todo:
    # get you id converter:
    #   https://www.googleapis.com/youtube/v3/channels?key=AIzaSyDsGZDPI461UR5JvTysAqv7PW7HSzj50KU&forUsername=" + $scope.channelName + "&part=id"
    begin
      channel = Yt::Channel.new id: "#{@id}"
      channel.subscriber_count
    rescue Yt::Errors::NoItems => e
      return '*'
    end
  end

  def self.get_instagram_numbers(user)
    #return unless is_good_time.empty?
    begin
      ig = InstaScraper::HTML::Account.new(user.gsub(/^@/,''))
      @instagram_following = ig.data.deep_find('followed_by').fetch('count')
    rescue
      return '*'
    end
  end

  def self.get_facebook_numbers(user)
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

  # def self.search(search)
  #   where('first_name ILIKE :search OR last_name ILIKE :search OR company ILIKE :search', search: "%#{search}%")
  # end

  def self.is_good_time
    where('last_checked < ?', 30.minutes.ago)
  end

end
