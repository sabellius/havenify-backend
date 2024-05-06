class Api::V1::PropertiesController < ApplicationController
  def index
    properties = Property.all
    render json: PropertySerializer.new(properties).serializable_hash.to_json, status: :ok
  end

  def create
    property = Property.new(property_params)
    if property.save
      render json: PropertySerializer.new(properties).serializable_hash.to_json, status: :created
    else
      render_record_invalid(property)
    end
  end

  def update
    if property.update(property_params)
      render json: PropertySerializer.new(property).serializable_hash.to_json, status: :ok
    else
      render_record_invalid(property)
    end
  end

  def show
    render json: PropertySerializer.new(property).serializable_hash.to_json, status: :ok
  end

  def destroy
    property.destroy
    render status: :no_content
  end

  private

  def property_params
    params.require(:property).permit(:name, :description, :address, :city, :zipcode, :type, :price, :bedrooms, :bathrooms, :square_meters, :user_id)
  end

  def property
    @property ||= Property.find(params[:id])
  end
end
