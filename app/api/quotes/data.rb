module Quotes
  class Data < Grape::API

    resource :quotes do

      desc "List quotes or show a single quote by id"

      params do
        optional :id, type: Integer, default: nil
      end

      get do

        if params[:id]

          Quote.find_by_id(params[:id])

        else

          @quotes = Quote.all

          response = { total: @quotes.size, quotes: @quotes }

        end

      end

    end

  end
end
