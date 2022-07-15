# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :shipping_company, optional: true
  validates :name, presence: true
  validate :existing_email_domain

  validates :name, format: { with: /[A-Z][a-z]+/ }

  after_validation :associate_company_id

  private

  def associate_company_id
    dominio = email.match(/@\w.+/)[0]
    if ShippingCompany.exists?(email_domain: dominio)
      self.shipping_company_id = ShippingCompany.where(email_domain: dominio).ids[0]
    end
  end

  def existing_email_domain
    if email.present? && !email.match(/@\w.+/).nil? && !ShippingCompany.exists?(email_domain: email.match(/@\w.+/)[0])
      errors.add(:email, 'deve possuir um dominio existente.')
    end
  end
end
