class CreateStatistic < ActiveRecord::Migration[5.0]
    def change
        create_table :statistics do |t|
            t.integer :click, default: 0
            t.integer :impression, default: 0
            t.float :cost, default: 0
            t.integer :conversion, default: 0
            t.date :date

            t.belongs_to :provider, index: true, foreign_key: { on_delete: :nullify }
            t.belongs_to :campaign, index: true, foreign_key: { on_delete: :nullify }
            t.belongs_to :api_token, index: true, foreign_key: { on_delete: :nullify }

            t.index [:campaign_id, :date, :provider_id, :api_token_id], unique: true, name: "unique_daily_report"
        end
      end
end
