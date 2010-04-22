module Jekyll

  class Git

    class Describe
      def to_liquid
        @to_liquid ||= `git describe --always`
      end
    end

    class Log
      def to_liquid
        @to_liquid ||= begin
          `git log '--pretty=format:%H\1%aN\1%ar\1%s'`.split("\n").map do |line|
            hash, author, date, subject = line.split("\1")
            {"hash" => hash, "author" => author, "date" => date, "subject" => subject}
          end
        end
      end
    end

    def to_liquid
      @to_liquid ||= {"describe" => Describe.new, "log" => Log.new}
    end

  end

end
