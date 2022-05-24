class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :shipping_company, optional: true
  validates :name, presence: true 
  validate :existing_email_domain

  after_validation :associate_company_id

  private 
    def associate_company_id 
      dominio = self.email.match(/@\w.+/)[0]
      if ShippingCompany.where(email_domain:dominio).exists?
        self.shipping_company_id = ShippingCompany.where(email_domain:dominio).ids[0]
      end 
    end

    def existing_email_domain
      if self.email.present? && !self.email.match(/@\w.+/).nil? && !ShippingCompany.where(email_domain: self.email.match(/@\w.+/)[0]).exists?
        self.errors.add(:email, "deve possuir um dominio existente.")
      end
    end
end
