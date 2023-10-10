class ScrapeResultsController < ApplicationController
  before_action :set_scrape_result, only: %i[ show edit update destroy ]

  # GET /scrape_results or /scrape_results.json
  def index
    @scrape_results = ScrapeResult.all
  end

  # GET /scrape_results/1 or /scrape_results/1.json
  def show
  end

  # GET /scrape_results/new
  def new
    @scrape_result = ScrapeResult.new
  end

  # GET /scrape_results/1/edit
  def edit
  end

  # POST /scrape_results or /scrape_results.json
  def create
    @scrape_result = ScrapeResult.new(scrape_result_params)

    respond_to do |format|
      if @scrape_result.save
        format.html { redirect_to scrape_result_url(@scrape_result), notice: "Scrape result was successfully created." }
        format.json { render :show, status: :created, location: @scrape_result }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scrape_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scrape_results/1 or /scrape_results/1.json
  def update
    respond_to do |format|
      if @scrape_result.update(scrape_result_params)
        format.html { redirect_to scrape_result_url(@scrape_result), notice: "Scrape result was successfully updated." }
        format.json { render :show, status: :ok, location: @scrape_result }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scrape_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrape_results/1 or /scrape_results/1.json
  def destroy
    @scrape_result.destroy!

    respond_to do |format|
      format.html { redirect_to scrape_results_url, notice: "Scrape result was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scrape_result
      @scrape_result = ScrapeResult.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scrape_result_params
      params.fetch(:scrape_result, {})
    end
end
