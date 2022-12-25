desc "SET ADMIN"
namespace :users do
  task(:add_admin, [:email] => :environment) do |t, args|
    user = User.find_by(email: args[:email])
    user.update(admin: true)
  end

  task(:remove_admin, [:email] => :environment) do |t, args|
    user = User.find_by(email: args[:email])
    user.update(admin: false)
  end
end
