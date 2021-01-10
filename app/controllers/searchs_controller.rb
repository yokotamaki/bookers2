class SearchsController < ApplicationController

  def search
    @keyword = params[:keyword]
    @model = params[:model]
    search = params[:search]
    if @model == 'user'
      @user = User.search(search,@keyword)
    elsif @model == 'book'
      @book = Book.search(search,@keyword)
    end
  end

end
