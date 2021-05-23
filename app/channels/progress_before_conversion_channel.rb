class ProgressBeforeConversionChannel < ApplicationCable::Channel
  def subscribed
    puts "Channel Subscribed"
    stream_from "progress_before_conversion_channel"
  end

  def unsubscribed
    puts "Channel Unubscribed"
  end
end
