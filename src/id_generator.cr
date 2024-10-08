require "opentelemetry-api/src/api/abstract_id_generator"

module OpenTelemetry
  # struct AbstractIdGenerator < IdGenerator::Base
  #   def trace_id
  #     Slice(UInt8).new(16, 0)
  #   end

  #   def span_id
  #     Slice(UInt8).new(8, 0)
  #   end
  # end

  struct IdGenerator < API::AbstractIdGenerator
    getter generator : OpenTelemetry::API::AbstractIdGenerator::AbstractBase
    class_property generator : OpenTelemetry::API::AbstractIdGenerator::AbstractBase = OpenTelemetry::IdGenerator::Unique.new

    def initialize(variant : String | Symbol = "unique")
      case variant.to_s.downcase
      # generate this via a macro
      when "unique"
        @generator = OpenTelemetry::IdGenerator::Unique.new
      when "random"
        @generator = OpenTelemetry::IdGenerator::Random.new
      else
        raise "unknown variant #{variant}"
      end
    end

    def trace_id
      @generator.trace_id
    end

    def span_id
      @generator.span_id
    end

    def self.trace_id
      generator.trace_id
    end

    def self.span_id
      generator.span_id
    end
  end
end

require "./id_generator/*"
