class MoviePolicy < ApplicationPolicy
  def create?
    admin?
  end

  def edit?
    admin?
  end

  def new?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def add_category?
    admin?
  end

  def remove_category?
    admin?
  end
end
