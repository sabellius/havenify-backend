class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def parameter_missing
    render json: { error: 'Missing parameter' }, status: :unprocessable_entity
  end

  def record_invalid(exception)
    render json: { error: exception.record.errors.full_messages.join(',') }, status: :unprocessable_entity
  end
end
