class UserOwnedBlueprint < Blueprinter::Base
  identifier :id
  field :user_name do |object|
    object.user.name
  end
end