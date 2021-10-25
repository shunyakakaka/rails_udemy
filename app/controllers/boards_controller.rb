class BoardsController < ApplicationController
  before_action :set_target_board, only: [:show, :edit, :update, :destroy]

  def index
    @boards = Board.page(params[:page])
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
  end
  
  def edit
  end

  def update
    @board.update(board_params)
    redirect_to board_path(@board.id)
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: {notice: "「#{@board.title}」の掲示板が削除されました！"}
  end

  private

  def board_params
    params.require(:board).permit(:name, :title, :body)
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end