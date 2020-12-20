class QuestionBlueprint < UserOwnedBlueprint
  fields :title, :private
  association :answers, blueprint: AnswerBlueprint
end