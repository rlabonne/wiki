class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @wikiis = policy_scope(Wikii)
  end

  def downgrade
    current_user.standard!
    current_user.wikiis.each do |wikii|
      if wikii.private?
        wikii.update :private => false
      end
    end
    flash[:notice] = "Your account has been downgraded back to standard."
    redirect_to root_path
  end
end
