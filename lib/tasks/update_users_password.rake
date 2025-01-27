namespace :users do
  desc "Set default password for users with empty password_digest"
  task set_default_password: :environment do
    default_password = "1234" # Change this to a secure default password
    User.where(password_digest: [ nil, "" ]).find_each do |user|
      user.password = default_password
      user.password_confirmation = default_password
      user.save!
      puts "Updated password for user: #{user.email}"
    end
  end
end
