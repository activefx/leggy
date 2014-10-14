module Leggy
  module Helpers
    extend ActiveSupport::Concern

    module ClassMethods

      def attr_reader(*params)
        @attr_readers ||= []
        @attr_readers.concat params
        super(*params)
      end

      def attr_writer(*params)
        @attr_writers ||= []
        @attr_writers.concat params
        super(*params)
      end

      def attr_accessor(*params)
        @attr_accessors ||= []
        @attr_accessors.concat params
        super(*params)
      end

      def attr_readers
        @attr_readers
      end

      def attr_writers
        @attr_writers
      end

      def attr_accessors
        @attr_accessors
      end

    end

  end
end
