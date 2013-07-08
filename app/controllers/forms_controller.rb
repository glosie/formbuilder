class FormsController < ApplicationController
  respond_to :json

  def index
    @forms = Form.all
  end

  def show
    @form = Form.find params[:id]
  end

  def create
    @form = Form.new(form_params)
    if @form.save
      render "forms/show"
    else
      respond_with @form
    end
  end

  def update
    @form = Form.find params[:id]
    @form.update_attributes fields_attributes: params[:fields_attributes] if params[:fields_attributes]
    if @form.save
      render "forms/show"
    else
      respond_with @form
    end
  end

  def destroy
    form = Form.find params[:id]
    form.fields.destroy_all
    form.destroy
    # return empty object for Backbone
    render json: {}
  end

  private

  def form_params
    params.require(:form).permit(:id, :name, fields_attributes: [:id, :name, :icon, :component_type, :order, :options, :helptext, :required, :placeholder] )
  end

end