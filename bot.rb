require 'cinch'
require 'mumble-ruby'
require_relative "lib/cinch/plugins/mumble.rb"

bot = Cinch::Bot.new do
  configure do |c|
    # add all required options here
    c.nick = 'cinch-mumble'
    c.server = 'irc.freenode.net'
    c.channels = ['#cinch-bots']
    c.plugins.plugins = [Cinch::Plugins::CinchMumble] # optionally add more plugins
  end
end

bot.start

