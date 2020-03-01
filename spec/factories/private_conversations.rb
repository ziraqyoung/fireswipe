FactoryBot.define do
  factory :private_conversation, class: 'private::Conversation' do
    association :recipient, factory: :user
    association :sender, factory: :user

    factory :private_conversation_with_messages do
      transient do
        message_count {1}
      end

      after(:create) do |private_conversation, evaluator|
        create_list(:private_message, evaluator.message_count, conversation: private_conversation)
      end
    end
  end
end
