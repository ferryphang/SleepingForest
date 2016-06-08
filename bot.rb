require 'facebook/messenger'
require './config'
require 'unirest'
require 'byebug'

include Facebook::Messenger
book = pasal = nil
Bot.on :message do |message|
  message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
  message.sender      # => { 'id' => '1008372609250235' }
  message.seq         # => 73
  message.sent_at     # => 2016-04-22 21:30:36 +0200
  message.text        # => 'Hello, bot!'
  message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]

  if message.text == "mazmur"
    book = message.text
  end

  if book && pasal
    response = Unirest.get "http://alkitab.gbippl.id/alkitab/tb/#{book}/#{pasal}"
    response.body.each do |ayat|
      Bot.deliver(
        recipient: message.sender,
        message: {
          text: "#{ayat["verse"]}. #{ayat["content"]}"
          }
      )
      sleep 2
    end
    book = pasal = nil
  end
  if book 

    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "Oke #{book} pasal berapa yang ingin anda baca?"
      }
    ) 
    pasal = message.text
  end
  if book.nil?
    Bot.deliver(
    recipient: message.sender,
      message: {
        text: "Halo ketikkan kitab yang ingin anda ketahui?"
      }
    ) 
  end

end


Bot.on :delivery do |delivery|
  delivery.ids       # => 'mid.1457764197618:41d102a3e1ae206a38'
  delivery.sender    # => { 'id' => '1008372609250235' }
  delivery.recipient # => { 'id' => '2015573629214912' }
  delivery.at        # => 2016-04-22 21:30:36 +0200
  delivery.seq       # => 37

  puts "Human was online at #{delivery.at}"
end