# frozen_string_literal: true

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # presence
  validates :name, presence: true

  # uniqueness
  validates :email, uniqueness: true

  # format
  validates :email, format: { with: /\w+@sistemadefrete.\w+/ }

  validates :name, format: { with: /[A-Z][a-z]+/ }
end
