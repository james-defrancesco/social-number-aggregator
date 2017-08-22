influencers = Influencer.all

influencers.each do |i|
  unless i.full_name.nil?
    full_name = i.full_name.split(' ')
    i.update_attribute :first_name, full_name[0]
    i.update_attribute :last_name, full_name[1]
    puts "updated #{full_name[0]} #{full_name[1]}"
  end
end