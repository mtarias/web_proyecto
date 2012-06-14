class GroupsController < ApplicationController

  skip_before_filter :require_login, :only => :public_events
  layout 'login'
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @members = @group.group_members
    
    #Invitar a amigos al grupo
    @friends = nil
    unless params[:search].blank?
      @friends = User.search(params[:search])

      @group.group_members.each do |g|
        @friends -= User.where(:id => g.user_id)
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    @group.user_id = session[:user_id]
    respond_to do |format|
      if @group.save
        @group_member = @group.group_members.create(params[:group_member])
        @group_member.user_id = session[:user_id]
        @group_member.save
        format.html { redirect_to groups_path, notice: 'Group was successfully created.' }
        format.json { render action: "index"}
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  def add_friend
    @group = Group.find(params[:id])
    @member = @group.group_members.create(params[:member])
    @member.user_id = params[:member_id]

    respond_to do |format|
      if @member.save
        format.html { redirect_to groups_path, notice: I18n.t(:successful_invitation) ,:email => User.find(params[:member_id]).email}
        format.json { head :no_content }
      else
        format.json { redirect_to @group.errors, status: :unprocessable_entity}
      end
    end
  end
end
