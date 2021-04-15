class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: [:edit, :update, :show, :destroy]
    before_action :set_post, only: [:create, :edit, :show, :update, :destroy]
  
    def create
      @comment = @post.comments.create(params[:comment].permit(:comment, :post_id))
      @comment.user_id = current_user.id
  
      respond_to do |format|
        if @comment.save
          format.html { redirect_to post_path(@post) }
          format.js # renders create.js.erb
        else
          format.html { redirect_to post_path(@post), notice: "comment did not save. Please try again."}
          format.js
        end
      end
    end
  
    def new
    end
  
  
    def destroy
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      redirect_to post_path(@post)
    end
  
    def edit
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
    end
  
    def update
      @comment = @post.comments.find(params[:id])
       respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to post_path(@post), notice: 'comment was successfully updated.' }
        else
          format.html { render :edit }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def show
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
    
    def set_comment
      @comment = Comment.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:comment, :post_id, :user_id)
    end
  end