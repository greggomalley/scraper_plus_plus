class ScrapesController < ApplicationController
  before_action :set_scrape, only: %i[ show edit update destroy ]

  # GET /scrapes or /scrapes.json
  def index
    @scrapes = Scrape.all
  end

  # GET /scrapes/1 or /scrapes/1.json
  def show
  end

  # GET /scrapes/new
  def new
    @scrape = Scrape.new
    @scrape_rules = ScrapeRule.all
  end

  # GET /scrapes/1/edit
  def edit
    @scrape_rules = ScrapeRule.all
  end

  # POST /scrapes or /scrapes.json
  def create
    @scrape = Scrape.new(scrape_params)

    respond_to do |format|
      if @scrape.save
        format.html { redirect_to scrape_url(@scrape), notice: "Scrape was successfully created." }
        format.json { render :show, status: :created, scrape: @scrape }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scrape.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scrapes/1 or /scrapes/1.json
  def update
    respond_to do |format|
      if @scrape.update(scrape_params)
        format.html { redirect_to scrape_url(@scrape), notice: "Scrape was successfully updated." }
        format.json { render :show, status: :ok, scrape: @scrape }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scrape.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrapes/1 or /scrapes/1.json
  def destroy
    @scrape.destroy!

    respond_to do |format|
      format.html { redirect_to scrapes_url, notice: "Scrape was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def scrape
    @scrape = Scrape.find(params[:id])
    ScrapeJob.new.perform(@scrape.id)
    redirect_to scrape_url(@scrape), notice: "Scrape was successfully run."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scrape
    @scrape = Scrape.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def scrape_params
    params.fetch(:scrape, {}).permit(:name, :url, :format, :retries, :schedule_id, scrape_rule_ids: [])
  end
end
