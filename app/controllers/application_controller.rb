class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_domain

  private

  def set_domain
    @domain = request.subdomains.any? ? "#{request.subdomains(0).first}.#{request.domain}" : request.domain
  end
end
