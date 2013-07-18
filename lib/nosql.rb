require "nosql/version"

module Nosql
  class Error < StandardError; end

  class Connection

    class << self
      EXEC_METHODS = [:execute, :exec_query]

      def enable!(&block)
        connection = ActiveRecord::Base.connection
        EXEC_METHODS.each do |method_name|
          next unless connection.respond_to?(method_name)
          connection.class_eval do
            alias_method "original_#{method_name}", method_name
            define_method(method_name) do |*args|
              raise Nosql::Error.new(args)
            end
          end
        end
      end

      def disable!
        #cleanup stubbed functions
        connection = ActiveRecord::Base.connection
        EXEC_METHODS.each do |method_name|
          original_method_name = "original_#{method_name}"
          next unless connection.respond_to?(method_name) && connection.respond_to?(original_method_name)
          connection.class_eval do
            alias_method method_name, original_method_name
          end
        end
      end
    end
  end
end
