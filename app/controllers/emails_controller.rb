class EmailsController < ApplicationController
  before_action :authenticate_user!, except:[:index]

  def index
    @emails = Email.all.sort{|a,b| b.id<=>a.id}
    @unread_emails = Email.where(is_read?:false).count
  end

  def create
    @email = Email.new(object:Faker::Book.title, body:Faker::TvShows::SouthPark.quote)
    @unread_emails = Email.where(is_read?:false).count

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
    @hello = "hello"

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
    @email = Email.find(params[:id])
    @email.update(is_read?: !@email.is_read?)
    @emails = Email.all.sort{|a,b| b.id <=> a.id}
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end   
  end


end
