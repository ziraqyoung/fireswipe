class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
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

  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = fetch_posts.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.js { render partial: 'posts/posts_pagination_page' }
    end
  end

  def fetch_posts
    branch = params[:action]
    search = params[:search]
    category = params[:category]

    if category.blank? && search.blank?
      Post.by_branch(branch).all
    elsif category.blank? && search.present?
      Post.by_branch(branch).search(search)
    elsif category.present? && search.blank?
      Post.by_category(branch, category)
    elsif category.present? && search.present?
      Post.by_category(branch, category).search(search)
    else

    end
  end
end
