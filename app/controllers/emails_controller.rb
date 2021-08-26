class EmailsController < ApplicationController
  before_action :authenticate_user!, except:[:index]

  def index
    @emails = Email.all.sort{|a,b| b.id<=>a.id}
  end

  def create
    @email = Email.new(object:Faker::Book.title, body:Faker::TvShows::SouthPark.quote)
    
    if @email.save
      @emails = Email.all.sort{|a,b| b.id<=>a.id}
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js {}
      end      
    else
      flash[:notice] = "Echec réception d'email"
      redirect_to root_path
    end

  end

  def show
    @email = Email.find(params[:id])
    @email.update(is_read?: true)
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    @emails = Email.all.sort{|a,b| b.id<=>a.id}
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end   

  end

  def update
    # puts "🚌"*60
    # puts params
    # puts "🚌"*60
    @email = Email.find(params[:id])
    # puts "🚛"*60
    # puts @email.id
    puts "🚛"*60
    puts @email.is_read?
    puts "🏎"*60

    @email.update(is_read?: !@email.is_read?)

    # if !@email.is_read?
    #   @email.update(is_read? :true)
    # else @email.update(is_read? :false)

    # end
    # @email.update(params.require(:data).permit(:is_read?))


    @emails = Email.all.sort{|a,b| b.id<=>a.id}
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end   

  end


end
