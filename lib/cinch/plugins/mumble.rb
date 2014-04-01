require 'cinch'

module Cinch
  module Plugins
    class CinchMumble
      include Cinch::Plugin
      match /mumble play (.*)/, method: :play
      match /mumble stop/, method: :stop
      match /mumble list/, method: :list
      match /mumble connect/, method: :connect

      def play(m, file)
        %x{mpc update}
        m.reply "Playing..."
        %x{mpc add #{file}; mpc play}
      end

      def stop(m)
        m.reply 'Stopping current sound clip...'
        %x{mpc -f %position% | head -n 1 | mpc del}
      end

      def list(m)
        %x{mpc update}
        m.reply 'I will PM you a list.'

        tracks = %x{mpc listall}
        m.user.send tracks.split("\n").join ', '
      end

      def execute()

      end

      def connect
      end

      def initialize(*args)
        super
        %x{mpc repeat off}
        %x{mpc single off}
        %x{mpc consume on}
        @mumble = Mumble::Client.new('localhost', 64738, 'cinch-mumble')
        @mumble.connect
        sleep(1)
        @mumble.join_channel 'Main Lounge'
        @mumble.stream_raw_audio('/tmp/mumble.fifo')
      end

    end

  end
end
