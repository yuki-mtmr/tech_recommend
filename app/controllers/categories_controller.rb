class CategoriesController < ApplicationController

  def ruby
    @posts =Post.left_joins(:post_categories).where(:post_categories => {:category_id => [1] })
  end

  def rails
    @posts =Post.left_joins(:post_categories).where(:post_categories => {:category_id => [2] })
  end

  def aws
    @posts =Post.left_joins(:post_categories).where(:post_categories => {:category_id => [3] })
  end

  def js
    @posts =Post.left_joins(:post_categories).where(:post_categories => {:category_id => [4] })
  end

  def docker
    @posts =Post.left_joins(:post_categories).where(:post_categories => {:category_id => [5] })
  end

end
