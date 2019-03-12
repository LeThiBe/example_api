module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  ERROR_CODES = {
    record_not_found: 603,
    unauthorized: 401,
    missing_token: 604,
    record_invalid: 610,
    authentication_error: 601,
    invalid_token: 602,
    expired_signature: 605,
    decode_error: 606
  }.freeze

  included do
    rescue_from ActiveRecord::RecordInvalid,
      ExceptionHandler::AuthenticationError,
      ExceptionHandler::MissingToken, ExceptionHandler::InvalidToken,
      ExceptionHandler::ExpiredSignature, ExceptionHandler::DecodeError,
      ActiveRecord::RecordNotFound do |err|
      handle_error err
    end
  end

  private
  def handle_error err, details = nil
    key = err.class.name.demodulize.underscore.to_sym
    status = ExceptionHandler::ERROR_CODES[key]
    message = {
      error_code: status,
      message: details || I18n.t("api.error.#{key}")
    }
    render json: message, status: status
  end
end
