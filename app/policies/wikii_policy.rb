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
        wikiis = scope.all # if the user is an admin, show them all the wikis
      elsif user.present? && user.role == 'premium'
        all_wikiis = scope.all
        all_wikiis.each do |wikii|
          if !wikii.private? || wikii.user == user || wikii.collaborators.pluck(:user_id).include?(user.id)
            wikiis << wikii # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # for standard users
        all_wikiis = scope.all
        wikiis = []
        all_wikiis.each do |wikii|
          if wikii.collaborators.pluck(:user_id).include?(user.id) || !wikii.private?
            wikiis << wikii # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikiis # return the wikis array we've built up
    end
  end
end
