module Ruboty
  module Handlers
    class Tune < Base
      NAMESPACE = "tune"

      on(
        /add tune (?<url>.+) \[(?<tags>.+)\]\z/,
        name: "add",
        description: "Add new tune (tags separated with comma. e.g.: メタル,メロスピ,Helloween)"
      )

      on(
        /(?<tag>.+)が[聴聞き]きたい\z/,
        name: "recommend",
        description: "Recommend a tune with given tag."
      )

      on(
        /今日のメタル\z/,
        name: "todays_metal",
        description: "Recommend Today's metal tune."
      )

      def add(message)
        url = message[:url]
        tags = message[:tags].split(/,/).map(&:downcase)
        tags.each {|t| table[t].try(:push, url) || table[t] = [url] }
        message.reply("Added #{url}")
      end

      def recommend(message)
        tag = message[:tag].downcase
        url = table[tag].try(:sample) || "Nothing"
        message.reply(url)
      end

      def todays_metal(message)
        url = table["メタル"].try(:sample) || "Nothing"
        message.reply("Your Today's METAL is #{url}")
      end

      private
      def table
        robot.brain.data[NAMESPACE] ||= {}
      end
    end
  end
end
