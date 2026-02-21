class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]
  before_action :authorize_book!, only: [:edit, :update, :destroy]

  def edit
end

def update
  if @book.update(book_params)
    redirect_to book_path(@book), notice: "You have updated book successfully.", status: :see_other
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @book.destroy
  redirect_to books_path, notice: "削除しました", status: :see_other
end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @user = current_user
      @books = Book.all 
      render :index, status: :unprocessable_entity
    end
  end

  def index
    @books = Book.all
    @book = Book.new 
    @user  = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def authorize_book!
    @book = Book.find(params[:id])
    return if @book.user_id == current_user.id

    redirect_to books_path, alert: "権限がありません"
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
