class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  # GET /games
  # GET /games.json
  def index
    @team = Team.find(params[:team_id])
    @game = @team.games
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @team = Team.find(params[:team_id])
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
     @team = Team.find(params[:team_id])
  end

  # POST /games
  # POST /games.json
  def create

    @team = Team.find(params[:team_id])
    @game = @team.games.new(game_params)


    respond_to do |format|
      if @game.save
        set_max_team_point
        format.html { redirect_to @team, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render 'teams/show'}
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
         set_max_team_point
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy   
    respond_to do |format|
      format.html { redirect_to team_path(@game.team_id), notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:game_point, :team_id)
    end

    def set_max_team_point
      #I must add this for destroy opation, 
      if @team_point != @team.games.maximum('game_point')
           @team.point = @team.games.maximum('game_point')
           @team.save
      end
          
    end


end


