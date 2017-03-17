class CreateCampaign < ActiveRecord::Migration[5.0]
    def change
        create_table :campaigns do |t|
            t.string :campaign_identity, null: false
            t.string :name
            t.belongs_to :api_token, index: true, foreign_key: { on_delete: :nullify }
            t.belongs_to :provider, index: true, foreign_key: { on_delete: :nullify }
            t.index [:provider_id, :campaign_identity, :api_token_id], unique: true, name: 'unique_campaign'
        end
      end
end
