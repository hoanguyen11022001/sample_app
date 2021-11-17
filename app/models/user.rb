class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w\-.+]+@[a-z\-\d.]+\.[a-z]+\z/i.freeze
  before_save{email.downcase!}
  validates :name, presence: true,
            length: {maximum: Settings.length.name_50}
  validates :email, presence: true,
            length: {maximum: Settings.length.email_255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
            length: {minimum: Settings.length.password_8}, allow_nil: true
  has_secure_password
  attr_accessor :remember_token
  scope :order_by_name, ->(sort_order){order name: sort_order}

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end
  end

  def remember_me
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end
end
