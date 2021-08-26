class EmailsController < ApplicationController
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

end
