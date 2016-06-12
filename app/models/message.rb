class Message < ActiveRecord::Base
    def formatted_time_sent
        self.sent_at.strftime("%b %e, %l:%M %p")
    end
end
