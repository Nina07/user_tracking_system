class InvestmentsController < ApplicationController
  before_action :set_investment, only: [:show, :edit, :update, :destroy]

  # GET /investments
  # GET /investments.json
  def index
    @investments = Investment.all
    @user=User.find(session[:user_id])
    puts "the user id is #{@user.id}"
    @investment=@user.investments.first
    #puts "the investment id is #{@investment.id}"
    #puts "this is id #{@user.id}"
  end

  # GET /investments/1
  # GET /investments/1.json
  def show
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    @user=User.find(session[:user_id])
     @investment=@user.investments.first
    flag=Date.today.end_of_month

    if @user.type=="manager" && @manager.investments.where("total_inv<?",3000) && flag==1
      puts "Your Total Investments are less then the compulsory amount."
    
    elsif @user.type=="lead" && @lead.investments.where("total_inv<?",1500) && flag==1
      puts "Your investments are less then the compulsory amount"

    else @user.type=="developer" && @developer.investments.where("total_inv<?",300) && flag==1
      puts "Your investments are less then the compulsory amount"
    end

  end

  # GET /investments/new
  def new
    @investment = Investment.new
  end

  # GET /investments/1/edit
  def edit
    #puts "id is #{@user.id}"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    @user=User.find(session[:user_id])
    #raise params.inspect
    puts "user id is #{@user.id}"
    #@investment=@user.investments.find()
    @investment=Investment.last
    #@investment=@inv.id
    puts "this is investment #{@investment.id}"
    @edit=params[:amount]
    @investment.update(:amount=>params[:amount])
    total_inv= 0
    if @edit!='nil'
       puts " this is #{@investment.total_inv}"
        @investment.total_inv = @investment.total_inv + @edit.to_i
        @user.total_amount= @user.total_amount - @edit.to_i
        puts "#this is edit #{@edit.to_i}"
        puts " this is #{@investment.total_inv}"
        #Investment.update(:total_inv=>@investment.total_inv)   
        @investment.update(:total_inv=>@investment.total_inv)
        @user.update(:total_amount=>@user.total_amount)
        puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        @month=Time.now.month
        @investment.update(:month=>@month)
    end
     # @investment.update(:total_inv = '@investment.total_inv')
     puts "this is type of edit #{@edit.class}"
     
      redirect_to investments_path, :notice=>"Your investment has been saved"
   end

  # POST /investments
  # POST /investments.json
  def create
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    @investment = Investment.new(amount:params[:amount])

    respond_to do |format|
      if @investment.save
        format.html { redirect_to @investment, notice: 'Investment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @investment }
      else
        format.html { render action: 'new' }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investments/1
  # PATCH/PUT /investments/1.json
  def update
    respond_to do |format|
      if @investment.update(investment_params)
        format.html { redirect_to @investment, notice: 'Investment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investments/1
  # DELETE /investments/1.json
  def destroy
    @investment.destroy
    respond_to do |format|
      format.html { redirect_to investments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investment
     #@investment = Investment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def investment_params
      params.require(:investment).permit(:month, :amount, :total_inv)
    end
end
