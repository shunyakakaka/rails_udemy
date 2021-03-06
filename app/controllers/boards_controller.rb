class BoardsController < ApplicationController
  before_action :set_target_board, only: [:show, :edit, :update, :destroy]

  def index
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page])
  end

  def new
    @board = Board.new(flash[:board])
  end
  
  def create
    board = Board.new(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板が作成されました！"
      redirect_to board_path(board.id)
    else
      redirect_to new_board_path, flash: {board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  def show
    @comment = Comment.new(board_id: @board.id)
  end
  
  def edit
  end

  def update
    if @board.update(board_params)
      flash[:notice] = "編集しました"
      redirect_to board_path(@board.id)
    else
      flash[:error_messages] = @board.errors.full_messages
      flash[:board] = @board
      redirect_to edit_board_path(flash[:board])
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: {notice: "「#{@board.title}」の掲示板が削除されました！"}
  end

  private

  def board_params
    params.require(:board).permit(:name, :title, :body, tag_ids: [])
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end