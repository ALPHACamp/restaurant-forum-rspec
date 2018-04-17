class AddAuthenticationTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authentication_token, :string

    User.find_each do |user|
      user.generate_authentication_token
      user.save!
      puts "generate user #{user.id} token"
    end
  end
end
