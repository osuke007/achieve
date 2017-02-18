class NotificationsController < ApplicationController
  before_action :authenticate_user!

#自分の通知のみを全て表示

  def index
    @notifications = Notification.where(user_id: current_user.id).order(created_at: :desc)
  end

=begin
def index
    @notifications = Notification.where(user_id: current_user.id).where(read: false).order(created_at: :desc)
end
=end
end
