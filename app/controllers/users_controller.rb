class UsersController < ApplicationController

  def index
    @users = User.all #一覧を表示するためall
    @book = Book.new #部分テンプレート(books/form)
    @user = current_user #部分テンプレート(uses/info)
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new #部分テンプレート(books/form)
    @books = @user.books #ユーザが投稿した本の
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

