class EmbedsController < ApplicationController
  respond_to :html

  # GET /pads/1/embed
  def show
    opts = {
      :padId => params[:pad_id],
      :email => 'teuser@hackpad.test',
      :name => 'tess e. user'
    }
    req = hackpad.create_signed_request :get, "/ep/api/embed-pad?#{opts.to_query}", nil, { :scheme => :query_string }
    respond_with @pad_url = hackpad.uri + req.path
  end

  # GET /pads/1/embed/nosig
  def nosig
    @pad_subdomain = "localdev"
    respond_with @pad_id = params[:pad_id]
  end

  # GET /pads/1/embed/noemail
  def noemail
    opts = {
      :padId => params[:pad_id]
    }
    req = hackpad.create_signed_request :get, "/ep/api/embed-pad?#{opts.to_query}", nil, { :scheme => :query_string }
    @pad_url = hackpad.uri + req.path
    render :show
  end

  # GET /pads/1/embed/new
  def script
    respond_with @pad_url = "#{hackpad.uri}/#{params[:pad_id]}.js"
  end
end
