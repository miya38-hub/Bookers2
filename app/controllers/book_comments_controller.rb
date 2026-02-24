class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book = @book

    if @book_comment.save
      redirect_to book_path(@book)
    else
      @book_comments = @book.book_comments.includes(:user).order(created_at :disc)
      render "books/show" , status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = book.book_comments.find(params[:id])

    unless comment.user == current_user
      return redirect_to book_path(book)
    end

    comment.destroy
    redirect_to book_path(book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end

