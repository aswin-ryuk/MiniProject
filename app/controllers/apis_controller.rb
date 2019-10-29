require 'httparty'
require 'json'

class ApisController < ApplicationController

#load_and_authorize_resource

  def index
    if params[:api].present? && params[:api][:url].present?
      url =  params[:api][:url]
      begin 
        @response = HTTParty.get(url , verify: false)
      rescue Exception => e
        @response = 'Problem in API Link'
        Rails.logger.info "Error in processing POST request #{e} uri: #{url}"
      end
    else
      @response = "Please enter any Get API link." if request.xhr?
    end
  end


end
