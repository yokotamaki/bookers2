class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to books_path
  end

  def index
    @users = User.all
    @book = Book.new #部分テンプレートに伴い追加
    @user = current_user #部分テンプレートに伴い追加
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  private
  def user_params
    params.require(:user).permit(:profile_image, :introduction)
  end
end

