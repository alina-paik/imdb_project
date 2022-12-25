class UserPolicy < ApplicationPolicy
  def update?
    user.id == record.id
  end

  def edit?
    user.id == record.id
  end
end
