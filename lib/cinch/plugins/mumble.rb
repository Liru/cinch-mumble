require 'cinch'
require 'ruby-mpd'

module Cinch
  module Plugins
    class CinchMumble
      include Cinch::Plugin
      match /mumble play( [A-Za-z0-9\_\-\.]+)/, method: :play
      match /mumble stop/, method: :stop
      match /mumble list/, method: :list
      match /mumble connect/, method: :connect
      match /mumble update/, method: :update
      match /mumble queue ([A-Za-z0-9\_\-\.]+)/, method: :queue
      match /mumble volume (\d{1,3})/, method: :volume

      def play(m, file='') # TODO: Refactor play and queue.
        unless file.empty?
          regex = file.gsub /^|\s+|$/, '.*'
          songs = @mpd.files.keep_if { |s| s =~ regex }
          if songs.empty?
            m.reply "I've got nothing by that name."
            return
          end
          m.reply 'Playing...'
          @mpd.add songs.sample
        end
        # play, no matter what.
        @mpd.play
      end

      def queue(m, file)
        unless file.empty?
          regex = file.gsub /^|\s+|$/, '.*'
          songs = @mpd.files.keep_if { |s| s =~ regex }

          if songs.empty?
            m.reply "I've got nothing by that name."
            return
          end

          m.reply 'Queued.'
          @mpd.add songs.sample
        end
      end

      def stop(m)
        m.reply 'Stopping current sound clip...'
        @mpd.stop
        @mpd.delete 1
      end

      def list(m)
        m.reply 'I will PM you a list.'

        tracks = @mpd.list
        m.user.send tracks.split("\n").join ', '
      end

      def update(m)
        m.reply "Updating database. This may take a while."
        @mpd.update
      end


      def volume(m, vol)
        m.reply "Setting volume to #{vol}."
        @mpd.volume = vol
      end


      def execute()

      end

      def connect # connect to mumble AND mpd.
        @mpd.connect
        @mumble.connect
        sleep 1
        @mumble.join_channel 'Main Lounge'
        @mumble.stream_raw_audio('/tmp/mumble.fifo')
      end

      def initialize(*args) # TODO: Error handling for initializing. Lots of it.
        super
        @mpd = MPD.new
        @mpd.connect
        @mumble = Mumble::Client.new('localhost', 64738, 'cinch-mumble')
        @mumble.connect
        sleep(1)
        @mumble.join_channel 'Main Lounge'
        @mumble.stream_raw_audio('/tmp/mumble.fifo')
      end

    end

  end
end
