class FramesController < ApplicationController
  before_action :set_frame, only: [:show, :edit, :update, :destroy]
  
  # GET /frames
  # GET /frames.json
  def index
    @frames = Frame.all
  end

  # GET /frames/1
  # GET /frames/1.json
  def show
  end

  # GET /frames/new
  def new
    @frame = Frame.new
    @game_id = params[:game_id]
    @game = Game.find_by_id(@game_id)
  end

  # GET /frames/1/edit
  def edit
  end

  # POST /frames
  # POST /frames.json
  def create
    @game = Game.find_by_id(params[:game_id])
    @frame_by_user = FrameByUser.where(user_id: params[:frame][:user_id], game_id: params[:game_id]).first
    @frame = Frame.new(frame_params.merge(frame_by_user: @frame_by_user, turn: @frame_by_user.game.turn))
    unless @frame.save
      @game_id = params[:game_id]
      @game = Game.find_by_id(@game_id)
      render :new
      return nil
    end
    update_past()
    set_score_general()
    set_turn_general()
    set_winner() if @game.turn == 10
    redirect_to Game.find_by_id(params[:game_id]), notice: 'Frame was successfully created'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_frame
      @frame = Frame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def frame_params
      params.require(:frame).permit(:try1, :try2, :try3, :score, :turn)
    end
    
  def update_past
    one_frame = @frame.frame_by_user.frames.where(turn: (@frame.turn - 1)).first
    if one_frame
      if one_frame.status == 'strike'
          score = one_frame.score + @frame.score
          one_frame.update(score: score)
      elsif one_frame.status == 'spare'
          score = one_frame.score + @frame.try1
          one_frame.update(score: score)
      end
    end
    two_frame = @frame.frame_by_user.frames.where(turn: (@frame.turn - 2)).first
    if two_frame
      if two_frame.status == 'strike' && one_frame.try2 == 0
          score = two_frame.score + @frame.try1
          two_frame.update(score: score)
      end
    end
  end
  
  def set_turn_general
    if @frame.turn < 10 
      game = @game
      players_last_turn = 0
      game.frame_by_users.each do |user|
          frame = user.frames.order(:turn).last
          players_last_turn += 1 if frame && frame.turn == game.turn
      end
      game.plus_turn if game.players == players_last_turn
    end
  end
  
  def set_score_general
    score = 0
    @frame_by_user.frames.each do |frame|
      score += frame.score
    end
    @frame_by_user.final_score = score
    @frame_by_user.save
  end
  
  def set_winner
    game = @game
    if game.players == game.frames.where(turn: 10).count
        game.winner = game.frame_by_users.order(:final_score).last.user.username
        game.save
    end
  end
end
