class AddImageToQuote < ActiveRecord::Migration

    def up
      add_attachment :quotes, :image
    end

    def down
      remove_attachment :quotess, :image
    end

end
