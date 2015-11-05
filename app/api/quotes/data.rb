module Quotes

  class Data < Grape::API

    helpers do
      def current_user
        @current_user = params[:userid]
      end
    end

    resource :quotes do

      desc "List all quotes"

      get do

        if current_user
          @quotes = User.find_by_id(@current_user).quotes
        else
          @quotes = Quote.all
        end

        response = {
          total: @quotes.size,
          quotes: @quotes
        }

      end

    end

    resource :quote do

      desc "Show one quote by id or get a random one for the day"

      params do
        optional :id, type: Integer, default: nil, desc: "Quote ID"
      end

      get do

        if params[:id]

          Quote.find_by_id(params[:id])

        else

          @today = Date.today.to_s

          @user_id = current_user ? User.find_by_id(@current_user).id : 0

          @today_quote = Day.where(date: @today, user_id: @user_id).first

          if @today_quote

            return Quote.find_by_id(@today_quote.quote_id)

          else

            if current_user

              # Build an array of ids of this users quotes [2,4,7]
              @user_quote_ids = User.find_by_id(@current_user).quotes.map { |q| q.id }

              # Pick on for them
              @random_id = @user_quote_ids[Random.rand(@user_quote_ids.size)]

            else
              @random_id = Random.rand(Quote.all.size) + 1
            end

            # Store the result for the day and user ( no user will be user_id = 0)
            Day.create(date: @today, quote_id: @random_id, user_id: @user_id)

            return Quote.find_by_id(@random_id);

          end

        end

      end

    end

  end
end
