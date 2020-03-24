class BlogsController < ApplicationController
  # TODO: search blogs via tags, and GIN index

  before_action :find_blog, only: [:edit, :update, :destroy, :show]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.tags = blog_tags_as_array

    if @blog.save
      flash[:success] = "Posted new blog!"
      redirect_to blogs_url
    else
      flash[:error] = "Couldn't post new blog"
      render :new
    end
  end

  def edit
  end

  def update    
    @blog.assign_attributes(blog_params)
    @blog.tags = blog_tags_as_array

    if @blog.save
      flash[:success] = "Updated blog successfully"
    else
      flash[:error] = "Something went wrong updating the blog :("
    end

    redirect_to blogs_url
  end

  def delete
    if @blog.destroy
      flash[:success] = "Deleted blog successfully"
    else
      flash[:error] = "Something went wrong deleting the blog :("
    end

    redirect_to blogs_index
  end

  def show
  end

  private

  def find_blog
    @blog = Blog.find_by(id: params[:id])
    if @blog.nil?
      flash[:error] = "Couldn't find the blog :("
      redirect_to blogs_url
    end
  end

  def blog_params
    if params[:blog].present?
      _p = params.require(:blog).permit(:title, :content)
      return _p
    else
      {}
    end
  end

  def blog_tags_as_array
    if params[:blog].present? && params[:blog][:tags].present?
      return params[:blog][:tags].split(",").map{|_m| _m.strip}
    else
      return []
    end
  end
end
