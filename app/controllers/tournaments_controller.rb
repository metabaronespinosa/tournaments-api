class TournamentsController < ApplicationController
  before_action :doorkeeper_authorize!, only: %i[enlisted create update destroy start end]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[create update destroy start end]

  # Public actions

  def index
    authorize Tournament
    tournaments = policy_scope(Tournament).
                  apply_filters(params).
                  order(starts_at: :asc).
                  page(params[:page])
    render json: tournaments,
           meta: pagination_meta(tournaments)
  end

  def enlisted
    authorize Tournament
    tournaments = current_user.tournaments.
                  apply_filters(params).
                  order(starts_at: :asc).
                  page(params[:page])
    render json: tournaments,
           meta: pagination_meta(tournaments)
  end

  def show
    tournament = Tournament.includes(:competitors, rounds: :players).find(params[:id])
    authorize tournament
    render json: tournament,
           include: %w[competitors rounds rounds.players]
  end

  # Actions for authenticated users

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

  # Actions for tournament organisers

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
