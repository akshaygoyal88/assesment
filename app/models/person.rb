class Person < ApplicationRecord
    has_one :detail, dependent: :destroy
    validates :name, :email, presence: true
    validates :email, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    accepts_nested_attributes_for :detail
end
