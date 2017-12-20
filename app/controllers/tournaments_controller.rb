class TournamentsController < ApplicationController
  include TournamentsDoc

  after_action :verify_authorized


  def index
    authorize Tournament
    tournaments = policy_scope(Tournament).page(params[:page])
    render json: tournaments
  end

  def show
    tournament = Tournament.find(params[:id])
    authorize tournament
    render json: tournament
  end


  before_action :doorkeeper_authorize!, only: %i[create update destroy start end]
  after_action :verify_policy_scoped, only: %i[create update destroy start end]

  def create
    tournament = policy_scope(Tournament).new
    authorize tournament
    form = TournamentForm.new(tournament)
    if form.validate(permitted_attributes(tournament))
      form.save
      return render json: form.model,
                    status: :created
    end
    render_validation_errors(form)
  end

  def update
    tournament = policy_scope(Tournament).find(params[:id])
    authorize tournament
    form = TournamentForm.new(tournament)
    if form.validate(permitted_attributes(tournament))
      form.save
      return render json: form.model
    end
    render_validation_errors(form)
  end

  def destroy
    tournament = policy_scope(Tournament).find(params[:id])
    authorize tournament
    tournament.destroy!
    head :no_content
  end

  def start
    tournament = policy_scope(Tournament).find(params[:id])
    authorize tournament
    tournament.update!(status: :in_progress)
    render json: tournament
  end

  def end
    tournament = policy_scope(Tournament).find(params[:id])
    authorize tournament
    tournament.update!(status: :ended)
    render json: tournament
  end
end
