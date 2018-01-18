class CollaboratorsController < ApplicationController
  def create
    @wikii = Wikii.find(params[:wikii_id])
    @user = User.find_by_email(params[:collaborator][:user])

    if User.exists?(@user.id)
      @collaborator = @wikii.collaborators.new(wikii_id: @wikii.id, user_id: @user.id)

      if @collaborator.save
        flash[:notice] = "User added"
      else
        flash[:error] = "Error"
      end
      redirect_to @wikii
    else
      flash[:error] = "Error, no such user"
      redirect_to @wikii
    end
  end

  def destroy
    @wikii = Wikii.find(params[:wikii_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Delete successfull"
      redirect_to @wikii
    else
      flash.now[:alert] = "There was an error"
      redirect_to @wikii
    end
  end
end
