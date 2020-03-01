class PostsController < ApplicationController
  before_action :redirect_if_not_signed_in, only: [:new]

  def new
    @branch = params[:branch]
    @categories = Category.where(branch: @branch)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to root_path
    end
  end

  def show
    @post = Post.find(params[:id])
    return unless user_signed_in?

    @message_has_been_sent = conversation_exist?
  end

  def hobby
    posts_for_branch(params[:action])
  end

  def study
    posts_for_branch(params[:action])
  end

  def team
    posts_for_branch(params[:action])
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category_id).merge(user_id: current_user.id)
  end

  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = fetch_posts.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.js { render partial: 'posts/posts_pagination_page' }
    end
  end

  def fetch_posts
    PostsForBranchService.new(
      branch: params[:action],
      search: params[:search],
      category: params[:category]
    ).call
  end

  def conversation_exist?
    Private::Conversation.between_users(current_user.id, @post.user.id).present?
  end
end
