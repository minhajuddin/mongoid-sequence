require "mongoid-sequence/version"
require "active_support/concern"

module Mongoid
  module Sequence
    extend ActiveSupport::Concern

    included do
      before_create :set_sequence
    end

    module ClassMethods
      attr_accessor :sequence_fields

      def sequence(field)
        self.sequence_fields ||= []
        self.sequence_fields << field
        self.field field, :type => Integer
      end
    end


    protected
    def set_sequence
      self.class.sequence_fields.each do |field|
        self[field] =  get_next_ids(field)
      end if self.class.sequence_fields
    end

    def get_next_ids(field, number_of_values = 1)
      next_sequence = self.mongo_session.command(
        findAndModify: "__sequences",
        query:  {"_id" => "#{self.class.name.underscore}_#{field}"},
        update: {"$inc" => { seq: number_of_values}},
        new: true,
        upsert: true)
      next_sequence["value"]["seq"]
    end

  end
end
