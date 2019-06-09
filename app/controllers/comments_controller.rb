class CommentsController < ApplicationController
  def create
    @comment = set_params.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to set_path
  end

  def destroy
    find_comments
    @comment.destroy
    redirect_to set_path
  end

  def edit
    find_comments
  end

  def update
    find_comments
    @comment.update(comment_params)
    redirect_to set_path
  end

  private

  def set_params
    if params[:report_id]
      Report.find(params[:report_id])
    elsif params[:book_id]
      Book.find(params[:book_id])
    end
  end
  
  def set_path
    if params[:report_id]
      report_path(set_params)
    elsif params[:book_id]
      book_path(set_params)
    end
  end

  def find_comments
    @comment = set_params.comments.find(params[:id])
  end
 
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
