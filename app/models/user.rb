class User < ApplicationRecord
  has_many :articles
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, {presence: true, length: {minimum: 3, maximum: 25},
    uniqueness: {case_sensitive: false}}
  validates :email, {presence: true, length: {minimum: 5, maximum: 100},
    uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}}
  before_save {self.email = email.downcase}

  has_secure_password
end