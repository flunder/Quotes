class QuotesController < ApplicationController

  before_action :set_quote, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  before_filter :authenticate_user!, only: [:edit, :update, :destroy]

  def index
    @quotes = @user.quotes.reverse_order
  end

  def show
  end

  def new
    @quote = Quote.new
  end

  def edit

    if current_user != @quote.user
      redirect_to(:back, notice: "Sry, You're not allowed to do this.")
     else
      puts "CORRECT"
     end

  end

  def create

    @quote = Quote.new(quote_params)
    current_user.quotes << @quote

    respond_to do |format|
      if @quote.save
        format.html { redirect_to action: "index", notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to action: "index", notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_quote
      @quote = Quote.find(params[:id])
    end

    def set_user

      if params['user']
        @user = User.find_by_id(params['user'])
      else
        @user = current_user
      end

    end

    def quote_params
      params.require(:quote).permit(:quote, :by, :image)
    end
end
