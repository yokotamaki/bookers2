class BooksController < ApplicationController

  def index
    @books = Book.all #投稿情報を全て取得
    @book = Book.new #新規投稿を保存する #バリデーション@bookの部分？
  end

  def show
    @book = Book.find(params[:id]) #本の名前タイトルなど引っ張ってくるため
    @book_new = Book.new #新規投稿画面に何も表示させなくするため（部分テンプレート）
    @user = @book.user #showから部分テンプレート（info）を呼び出すときに使う
    @book_comment = BookComment.new
  end

  def create
    @book = Book.new(book_params) #入力されたデータが@bookに入る
    @book.user_id = current_user.id #投稿とユーザ情報の紐付け
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all #本の一覧画面表示させるため?　部分テンプレートじゃないところ
      @user = current_user #user info表示のため　部分テンプレートで使用しているため
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id]) #本の編集画面に情報を表示させるため
    if @book.user.id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private #ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
