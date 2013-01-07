require 'net/http'

class PadsController < ApplicationController
  respond_to :html


  # GET /pads/1
  def show
    @pad_id = params[:id]

    res = hackpad.request :get, "/api/1.0/pad/#{@pad_id}/content.txt"

    if res.is_a? Net::HTTPSuccess
      respond_with @content = res.body
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end    
  end

  # GET /pads/new
  def new
  end

  # POST /pads
  def create
    content = params[:content]

    res = hackpad.request :post, "/api/1.0/pad/create", nil, {}, content, { 'Content-Type' => 'text/plain' }

    if res.is_a? Net::HTTPSuccess
      json = ActiveSupport::JSON.decode res.body
      redirect_to pad_path json['padId']
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end
  end

  # GET /pads/1/edit
  def edit
    @pad_id = params[:id]

    res = hackpad.request :get, "/api/1.0/pad/#{@pad_id}/content/latest.txt"

    if res.is_a? Net::HTTPSuccess
      respond_with @content = res.body
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end    
  end

  # POST /pads/1
  def update
    @pad_id = params[:id]
    content = params[:content]

    res = hackpad.request :post, "/api/1.0/pad/#{@pad_id}/content", nil, {}, content, { 'Content-Type' => 'text/plain' }

    if res.is_a? Net::HTTPSuccess
      redirect_to pad_path @pad_id
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end
  end

  # GET /pads
  def index
    res = hackpad.request :get, "/api/1.0/pads/all"

    if res.is_a? Net::HTTPSuccess
      json = ActiveSupport::JSON.decode(res.body)
      redirect_to pad_path @pad_id
    else
      logger.warn "#{res.inspect}: #{res.body}"
      head :bad_request
    end
  end
end
