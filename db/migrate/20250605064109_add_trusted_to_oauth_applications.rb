class AddTrustedToOauthApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :oauth_applications, :trusted, :boolean, after: :confidential, default: false, null: false
  end
end
