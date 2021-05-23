class PdfToImageChannel < ApplicationCable::Channel
  def subscribed
    puts "Channel Subscribed"
    stream_from "pdf_to_image_channel"
  end

  def unsubscribed
    puts "Channel Unsubscribed"
  end
end
