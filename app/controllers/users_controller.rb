class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @current_user=User.find(session[:user_id])
  end

  # GET /users/new
  def new
    @user = User.new
    #@manager= Manager.new
    #@developer= Developer.new
    #@lead= Lead.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    #raise params.inspect
    #@user = User.new(user_params)
    if params["user"]["type"]=="manager"
      @manager= Manager.create(name:params[:user][:name], password:params[:user][:password], salary:params[:user][:salary],total_amount:params[:user][:total_amount])
      #puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      respond_to do |format|
        if @manager.save
          format.html { redirect_to users_path, notice: 'User was successfully created.' }
          format.json { render action: 'show', status: :created, location: @manager }
        else
          format.html { render action: 'new' }
          format.json { render json: @manager.errors, status: :unprocessable_entity }
        end
      end

    elsif params["user"]["type"]=="lead"
          @lead= Lead.create(name:params[:user][:name], password:params[:user][:password], salary:params[:user][:salary],total_amount:params[:user][:total_amount])
          respond_to do |format|
            if @lead.save
              format.html { redirect_to users_path, notice: 'User was successfully created.' }
              format.json { render action: 'show', status: :created, location: @lead }
            else
              format.html { render action: 'new' }
              format.json { render json: @lead.errors, status: :unprocessable_entity }
            end
          end

      else params["user"]["type"]=="developer"
        @developer= Developer.create(name:params[:user][:name], password:params[:user][:password], salary:params[:user][:salary],total_amount:params[:user][:total_amount])
        respond_to do |format|
          if @developer.save
            format.html { redirect_to users_path, notice: 'User was successfully created.' }
            format.json { render action: 'show', status: :created, location: @developer }
          else
            format.html { render action: 'new' }
            format.json { render json: @developer.errors, status: :unprocessable_entity }
          end
        end
      end
    
    puts "<<<<<<<<<<<<<<<<< #{params[:user][:type]}"
  end

  def login
    
    if @user=User.find_by_name_and_password(params[:name],params[:password])
      session[:user_id]=@user.id
      #puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
      redirect_to user_path(@user)
    else
      puts "Check your details again!"
            redirect_to user_path(@user)

    end
    
   
    #redirect_to user_path
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name,:password, :type, :salary, :total_amount)
    end
end

