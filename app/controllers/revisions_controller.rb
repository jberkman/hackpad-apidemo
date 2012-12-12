require 'net/http'

class RevisionsController < ApplicationController
  respond_to :html

  # GET /revisions
  def index
    @pad_id = params[:pad_id]
    path = "/api/1.0/pad/#{@pad_id}/revisions"
    opts = {
      clientId: HACKPAD_CLIENT_ID,
      expires: Time.now.to_i + 60,
    }
    opts[:signature] = hackpad_sign signature_data 'GET', path, nil, opts

    http = Net::HTTP.new HACKPAD_SERVER.host, HACKPAD_SERVER.port
    req = Net::HTTP::Get.new "#{path}?#{opts.to_query}"

    res = http.request req

    if res.is_a? Net::HTTPSuccess
      respond_with @revisions = ActiveSupport::JSON.decode(res.body)
    else
      logger.warn res.inspect
      head :bad_request
    end    
  end

  # GET /revisions/1
  # GET /revisions/1.json
  def show
    @revision = Revision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @revision }
    end
  end

  # GET /revisions/new
  # GET /revisions/new.json
  def new
    @revision = Revision.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @revision }
    end
  end

  # GET /revisions/1/edit
  def edit
    @revision = Revision.find(params[:id])
  end

  # POST /revisions
  # POST /revisions.json
  def create
    @revision = Revision.new(params[:revision])

    respond_to do |format|
      if @revision.save
        format.html { redirect_to @revision, notice: 'Revision was successfully created.' }
        format.json { render json: @revision, status: :created, location: @revision }
      else
        format.html { render action: "new" }
        format.json { render json: @revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /revisions/1
  # PUT /revisions/1.json
  def update
    @revision = Revision.find(params[:id])

    respond_to do |format|
      if @revision.update_attributes(params[:revision])
        format.html { redirect_to @revision, notice: 'Revision was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revisions/1
  # DELETE /revisions/1.json
  def destroy
    @revision = Revision.find(params[:id])
    @revision.destroy

    respond_to do |format|
      format.html { redirect_to revisions_url }
      format.json { head :no_content }
    end
  end
end
