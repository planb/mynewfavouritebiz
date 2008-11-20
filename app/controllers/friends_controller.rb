class FriendsController < ApplicationController
  
  before_filter :login_required
  before_filter :get_user
  
  def index
    # Listing all friends for a user.
    @friends = @user.friends
    @pending_friends = @user.pending_friends
  end
  
  def show
  end
  
  def new
    # Request a friendship.
    current_user.request_friendship_with(@user)
    redirect_to user_path(@user)
    flash[:success] = "Friendship Request Has Been Sent"
  end
  
  def accept_friendship
    # Mark all selected as completed.
    
    Friendship.update_all(["accepted_at = ?", Time.now], :friend_id => params[:pending_friend_ids])
    
    # current_user.accept_friendship_with(@user)
    redirect_to friends_path
    flash[:notice] = "Friendships Have Been Accepted"
  end
  
  def destroy
    # Remove a friend.
    @not_friend = User.find(params[:id])
    get_user.delete_friendship_with(@not_friend)
    flash[:notice] = "You Are No Longer Friends With #{@not_friend.login}"
    
    respond_to do |format|
      format.html { redirect_to friends_path }
      format.xml  { head :ok }
    end
  end

  private
  
  def get_user
    @user = User.find(params[:user_id])
  end
end
