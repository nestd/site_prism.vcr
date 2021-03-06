module SPV
  class Fixtures
    # Prepares incoming raw list of fixtures to be used for inserting
    # into VCR.
    #
    # Applies a given list of modifiers to list of fixtures.
    class Handler
      def initialize(options, convertor = Converter)
        @options = options

        @converter = convertor
      end

      def handle_raw(raw_fixtures, modifiers)
        converted_fixtures = @converter.convert_raw(raw_fixtures)

        modifiers.map do |modifier|
          converted_fixtures.each do |converted_fixture|
            modifier.modify(converted_fixture)
          end
        end

        converted_fixtures
      end

      def handle_set_raws(*fixtures_set, modifiers)
        fixtures_set.map do |fixtures_raw|
          handle_raw fixtures_raw, modifiers
        end
      end
    end # class Handler
  end # class Fixtures
end # module SPV