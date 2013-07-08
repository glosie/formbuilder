class FieldsController < ApplicationController
  respond_to :json

  def index
    @fields = Field.all
  end

  def destroy
    field = Field.find params[:id]
    field.destroy
    # return empty object for Backbone
    render json: {}
  end
end