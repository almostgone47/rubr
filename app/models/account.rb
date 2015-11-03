class Account < ActiveRecord::Base
  has_secure_password

  has_many(:rating_connections, :foreign_key => :rater_id, :dependent => :destroy)
  has_many(:reverse_rating_connections, :class_name => :RatingConnection,
           :foreign_key => :ratee_id, :dependent => :destroy)
  has_many :ratings, :through => :rating_connections, :source => :ratee

  # TODO: has_and_belongs_to_many accounts for matches
  before_create { generate_token(:auth_token) }

  validates_presence_of :email, :first_name, :last_name, :zip, :looking_for, :gender, :age, :user_name
  validates :user_name, uniqueness: { case_sensitive: false }, length: { maximum: 24 }
  validates_numericality_of :age, only_integer: true,
                                  greater_than: 17,
                                  less_than: 100

  validates :looking_for, inclusion: { in: %w(male female any) }
  validates :gender, inclusion: { in: %w(male female) }

  validates_format_of :zip, with: /\d{5}(-\d{4})?/, message: "Zip should be in the form 12345 or 12345-1234"
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Email isn't valid"

  def full_name
    "#{first_name} #{last_name}"
  end

  # Get info about likes/dislikes
  def all_likes
    self.ratings.where(rating_type: "like")
  end

  def all_dislikes
    self.ratings.where(rating_type: "dislike")
  end

  # TODO: test this
  def has_rated? account
    self.ratings.include? account
  end

  # Set info about likes/dislikes
  def like account
    if account
      if account != self
        # TODO do like_token checks here
        RatingConnection.create(
          rater: self,
          ratee: account,
          rating_type: "like"
        )

        # Like them back
        if account.fake_account
          RatingConnection.create(
            rater: account,
            ratee: self,
            rating_type: "like"
          )
        end
      end
    end
  end

  def dislike account
    if account
      if account != self
        RatingConnection.create(
          rater: self,
          ratee: account,
          rating_type: "dislike"
        )
      end
    end
  end

  def is_matched? account
    if account
      if self.ratings.include? account
        if account.ratings.include? self
          return true
        end
      end
    end
    return false
  end

  # TOOD: IT KEEPS GETTING WORSE, WHY DID YOU WRITE
  # MESSAGES LIKE THIS. STOP IT.
  def messages_with account
    if account
      results = Message.where(sender_id: [self.id, account.id],
                    receiver_id: [self.id, account.id]).order(sent_at: :asc)
      puts results
      return results

    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Account.exists?(column => self[column])
  end

end
