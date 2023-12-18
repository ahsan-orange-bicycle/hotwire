class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream { render turbo_stream: turbo_stream.append("posts-list", partial: "posts/post", locals: { post: @post }) }
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("error_explanation", partial: "shared/error_messages", locals: { record: @post }) }
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("post_#{@post.id}", partial: "posts/post", locals: { post: @post }) }
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("error-messages", partial: "shared/error_messages", locals: { record: @post }) }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
  
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("post_#{@post.id}") }
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
