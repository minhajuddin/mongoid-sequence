class FirstSequencedModel
  include Mongoid::Document
  include Mongoid::Sequence

  sequence :auto_increment
end
