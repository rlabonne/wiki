class WikiiPolicy < ApplicationPolicy
  attr_reader :user, :wikii

  def initialize(user, wikii)
    @user = user
    @wikii = wikii
  end

  def index?
    false
  end

  def show?
    scope.where(:id => wikii.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    if wikii.private?
      user.admin? || wikii.user == user
    else
      user.present?
    end
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || wikii.user == user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end


    def resolve
      wikiis = []
      if user.present? && user.role == 'admin'
        wikiis = scope.all
      elsif user.present? && user.role == 'premium'
        all_wikiis = scope.all
        all_wikiis.each do |wikii|
          if !wikii.private? || wikii.user == user
            wikiis << wikii
          end
        end
      else
        all_wikiis = scope.all
        wikiis = []
        all_wikiis.each do |wikii|
          if !wikii.private?
            wikiis << wikii
          end
        end
      end
      wikiis
    end
  end
end
