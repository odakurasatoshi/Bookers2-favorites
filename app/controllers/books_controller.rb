class BooksController < ApplicationController
before_action :authenticate_user!, except: [:top, :about]

	def about
	end
	def top
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@book =Book.find(params[:id])
		@book1 = Book.new
		@user = User.find(@book.user_id)
		@comment =Comment.new
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user_id != current_user.id
		   redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		@book.user_id = current_user.id
		if @book.update(book_params)
		   flash[:notice] = "Book was successfully updated."
		   redirect_to book_path(@book.id)
		else
		   @books = Book.all
		   render action: :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
      	book.destroy
      	redirect_to books_path
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
		   flash[:notice] = "Book was successfully created."
		   redirect_to book_path(@book.id)
		else
		   @user = User.find(current_user.id)
		   @books = Book.all
		   render action: :index
		end
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
