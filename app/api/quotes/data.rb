module Quotes
  class Data < Grape::API

    resource :quotes_data do

      desc "list"
      get do
        Quote.all
      end

    end

  end
end
