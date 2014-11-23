module Ruboty
  module Handlers
    class Metal < Base
      METAL_VOICES = %w(
        アーライ！！
        ライザスカイッ！！
        ラーイナーウ！！
        あーいしてーんだろ
      )

      on /metal$/i, name: "all_right", description: "Return 'All right' to 'metal'"

      def all_right(message)
        message.reply(METAL_VOICES.sample)
      end
    end
  end
end
