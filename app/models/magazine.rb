class Magazine < ActiveRecord::Base
    has_many :subscriptions
    has_many :readers, through: :subscriptions

    def email_list
        emails = self.readers.map {|reader| reader.email}
        emails.join(";")
    end

    def self.most_popular
        Magazine.find(Subscription.group("magazine_id").order("COUNT(magazine_id) DESC").limit(1)[0].magazine_id)
    end
end