class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    current_user.favorites.find_or_create_by(book: book)  # 重複防止
    redirect_back fallback_location: book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    current_user.favorites.where(book: book).destroy_all  # 既に重複してても全部消す
    redirect_back fallback_location: book_path(book)
  end

end
