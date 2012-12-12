class EmbedsController < ApplicationController
  respond_to :html

  # GET /pads/1/embed
  def show
    @pad_opts = {
      clientId: HACKPAD_CLIENT_ID,
      subDomain: 'localdev',
      padId: params[:pad_id],
      timestamp: Time.now.to_i,
      name: "tess euser = ` ~ ! @ # $ % ^ & * ( ) [ ] { } ; : \' \" < > , . / ? | \\",
      email: 'teuser@hackpad.test'
    }

    @signature = hackpad_sign embed_signature_data @pad_opts

    respond_with @pad_opts
  end

  # GET /pads/1/embed/nosig
  def nosig
    respond_with @padId = params[:pad_id]
  end

  # GET /pads/1/embed/noemail
  def noemail
    @pad_opts = {
      clientId: HACKPAD_CLIENT_ID,
      subDomain: 'localdev',
      padId: params[:pad_id],
      timestamp: Time.now.to_i,
    }

    @signature = hackpad_sign embed_signature_data @pad_opts

    render :show
  end
end
