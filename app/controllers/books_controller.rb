class BooksController < ApplicationController

  def index
    @books = Book.all #投稿情報を全て取得
    @book = Book.new #新規投稿を保存する
    @user = current_user #ログインしているユーザ情報
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id #投稿とユーザ情報の紐付け
    @book.save
    redirect_to book_path(@book.id)
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)

    user = User.find(params[:id])
    user.update(user_params)
    redirect_to books_path
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name, :introduction)
  end

end
