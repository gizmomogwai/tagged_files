require 'digest/sha1'

class TaggedFilesController < ApplicationController
  # GET /tagged_files
  # GET /tagged_files.json
  def index
    query = params[:query]
    if query.blank?
      @tagged_files = TaggedFile.all
    else
      @tagged_files = TaggedFile.find_for_query(query)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tagged_files }
    end
  end

  # GET /tagged_files/1
  # GET /tagged_files/1.json
  def show
    @tagged_file = TaggedFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tagged_file }
    end
  end

  # GET /tagged_files/new
  # GET /tagged_files/new.json
  def new
    @tagged_file = TaggedFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tagged_file }
    end
  end

  # GET /tagged_files/1/edit
  def edit
    @tagged_file = TaggedFile.find(params[:id])
  end

  # POST /tagged_files
  # POST /tagged_files.json
  def create
    data = params[:tagged_file]
    uploaded_file = data.delete(:binary_data)
    binary_data = uploaded_file.read
    data[:sha1] = Digest::SHA1.hexdigest(binary_data)
    data[:size] = binary_data.size
    data[:original_filename] = uploaded_file.original_filename

    @tagged_file = TaggedFile.new(data)

    respond_to do |format|
      if @tagged_file.save_and_store_file(binary_data)
        format.html { redirect_to @tagged_file, notice: 'Tagged file was successfully created.' }
        format.json { render json: @tagged_file, status: :created, location: @tagged_file }
      else
        format.html { render action: "new" }
        format.json { render json: @tagged_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tagged_files/1
  # PUT /tagged_files/1.json
  def update
    @tagged_file = TaggedFile.find(params[:id])

    respond_to do |format|
      if @tagged_file.update_attributes(params[:tagged_file])
        format.html { redirect_to @tagged_file, notice: 'Tagged file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tagged_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tagged_files/1
  # DELETE /tagged_files/1.json
  def destroy
    @tagged_file = TaggedFile.find(params[:id])
    @tagged_file.destroy

    respond_to do |format|
      format.html { redirect_to tagged_files_url }
      format.json { head :no_content }
    end
  end
end
