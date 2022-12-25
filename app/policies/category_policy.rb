class CategoryPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def edit?
    admin?
  end

  def new?
    admin?
  end
end
