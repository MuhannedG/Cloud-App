class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /posts/:post_id/comments
  def index
    @comments = @post.comments
  end

  # GET /posts/:post_id/comments/1
  def show
  end

  # GET /posts/:post_id/comments/new
  def new
    @comment = @post.comments.build
  end

  # GET /posts/:post_id/comments/1/edit
  def edit
  end

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: [@post, @comment] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/:post_id/comments/1
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @post, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: [@post, @comment] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/:post_id/comments/1
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post, status: :see_other, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to posts_path, alert: "Post not found."
    end

    def set_comment
      @comment = @post.comments.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to @post, alert: "Comment not found."
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end

