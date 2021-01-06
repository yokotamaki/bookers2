class UsersController < ApplicationController

  def index
    @users = User.all #一覧を表示するためall
    @book = Book.new #部分テンプレートに伴い追加(books/form)
    @user = current_user #部分テンプレートに伴い追加
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new #部分テンプレートに伴い追加(books/form)
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

