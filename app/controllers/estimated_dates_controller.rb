# frozen_string_literal: true

class EstimatedDatesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    @estimated_date = EstimatedDate.new
  end

  def create
    estimated_date_params = params.require(:estimated_date).permit(:min_distance, :max_distance, :business_day)
    @estimated_date = EstimatedDate.new(estimated_date_params)
    @estimated_date.shipping_company_id = current_user.shipping_company_id
    
    if @estimated_date.save
      redirect_to estimated_date_path(current_user.shipping_company_id),
                  notice: 'Nova linha de estimativa adicionada com sucesso'
    else
      rendering_failure
    end
  end

  def show
    @endereco = ShippingCompany.find(params[:id])
    return unless admin_signed_in? || (user_signed_in? && current_user.shipping_company_id == @endereco.id)

    @estimated_date_lines = EstimatedDate.where(shipping_company_id: @endereco.id)
  end

  private

  def rendering_failure
    flash[:notice] = 'Falha ao adicionar a nova linha de estimativa'
    render :new
  end
end
