# frozen_string_literal: true

class ShippingCompaniesController < ApplicationController
  before_action :authenticate_admin!, only: %i[index new create active disable]

  def index
    @shipping_companies = ShippingCompany.all
  end

  def show
    @shipping_company = ShippingCompany.find(params[:id])

    if user_signed_in?
      if current_user.shipping_company_id != @shipping_company.id
        redirect_to root_path, notice: 'Acesso permitido apenas para Administradores ou Usuários desta Transportadora'
      end
    elsif !admin_signed_in?
      redirect_to root_path, notice: 'Acesso permitido apenas para Administradores ou Usuários desta Transportadora'
    end
  end

  def new
    @shipping_company = ShippingCompany.new
  end

  def create
    shipping_company_params = params.require(:shipping_company).permit(:brand_name, :corporate_name, :street, :city,
                                                                       :email_domain, :registration_number, :state, :number, :distance)
    @shipping_company = ShippingCompany.new(shipping_company_params)
    if @shipping_company.save
      redirect_to shipping_company_path(@shipping_company.id), notice: 'Transportadora cadastrada com sucesso!'
    else
      flash.now[:notice] = 'Falha ao cadastrar a Transportadora'
      render :new
    end
  end

  def active
    shipping_company = ShippingCompany.find(params[:id])

    shipping_company.active!

    redirect_to shipping_company_path(shipping_company.id)
  end

  def disable
    shipping_company = ShippingCompany.find(params[:id])

    shipping_company.disable!

    redirect_to shipping_company_path(shipping_company.id)
  end
end
