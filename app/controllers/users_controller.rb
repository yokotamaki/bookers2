class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to books_path, notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @book = Book.new #部分テンプレートに伴い追加
    @user = current_user #部分テンプレートに伴い追加
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

