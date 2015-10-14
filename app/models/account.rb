class Account < ActiveRecord::Base
  has_secure_password

  # TODO: has_and_belongs_to_many accounts for matches
  before_create { generate_token(:auth_token) }

 # validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :email
  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Account.exists?(column => self[column])
  end

end
