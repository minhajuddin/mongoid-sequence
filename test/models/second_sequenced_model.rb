class SecondSequencedModel
  include Mongoid::Document
  include Mongoid::Sequence

  sequence :auto_increment
end
