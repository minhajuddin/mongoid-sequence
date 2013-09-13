class ParanoiaSequencedModel
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Sequence

  sequence :auto_increment
end
