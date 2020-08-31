require 'active_support/concern'

module Messages
  extend ActiveSupport::Concern

  def get_messages(conversation_type, message_amount)
    # converst a string into a constant so the model can be called dynamically
    model = "#{conversation_type.capitalize}::Conversation".constantize
    @conversation = model.find(params[:conversation_id])
    # get messages
    @messages = @conversation.messages.order(created_at: :desc).limit(message_amount).offset(params[:message_to_display_offset].to_i)
    # set a variable to get another previous messages of the conversation
    @messages_to_display_offset = params[:message_to_display_offset].to_i + message_amount

    @type = conversation_type.downcase
    # if the messages are the last in the conversation set the variable as 0
    # so that load more messages link will be removed
    if @conversation.messages.count < @messages_to_display_offset
      @messages_to_display_offset = 0
    end
  end
end
