class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @users = @game.users
  end

  # GET /games/new
  def new
    @game = Game.new
    @users = User.all
  end

  # GET /games/1/edit
  def edit
    @users = @game.users
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new()
    users_list = game_params[:users_list].reject!(&:blank?)
    users_list.each do |user|
        @game.frame_by_users.new(user_id: user)
    end
    @game.players = users_list.length
    redirect_to Game.find_by_id(@game.id), notice: 'Game was successfully created'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:users_list => [])
    end
end
