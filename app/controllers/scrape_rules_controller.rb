class ScrapeRulesController < ApplicationController
  before_action :set_scrape_rule, only: %i[ show edit update destroy ]

  # GET /scrape_rules or /scrape_rules.json
  def index
    @scrape_rules = ScrapeRule.all
  end

  # GET /scrape_rules/1 or /scrape_rules/1.json
  def show
  end

  # GET /scrape_rules/new
  def new
    @scrape_rule = ScrapeRule.new
  end

  # GET /scrape_rules/1/edit
  def edit
  end

  # POST /scrape_rules or /scrape_rules.json
  def create
    @scrape_rule = ScrapeRule.new(scrape_rule_params)

    respond_to do |format|
      if @scrape_rule.save
        format.html { redirect_to scrape_rule_url(@scrape_rule), notice: "Scrape rule was successfully created." }
        format.json { render :show, status: :created, location: @scrape_rule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scrape_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scrape_rules/1 or /scrape_rules/1.json
  def update
    respond_to do |format|
      if @scrape_rule.update(scrape_rule_params)
        format.html { redirect_to scrape_rule_url(@scrape_rule), notice: "Scrape rule was successfully updated." }
        format.json { render :show, status: :ok, location: @scrape_rule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scrape_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrape_rules/1 or /scrape_rules/1.json
  def destroy
    @scrape_rule.destroy!

    respond_to do |format|
      format.html { redirect_to scrape_rules_url, notice: "Scrape rule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scrape_rule
      @scrape_rule = ScrapeRule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scrape_rule_params
      params.fetch(:scrape_rule, {}).permit(:id, :name, :xpath, :key, :scrape_type, :parent_id)
    end
end
