require 'navigation_helper.rb'

module ApplicationHelper
  include Private::ConversationsHelper
  include NavigationHelper
  include PostsHelper
  include Private::MessagesHelper

  def private_conversations_windows
    params[:controller] != 'messengers' ? @private_conversations_windows : []
  end
end
