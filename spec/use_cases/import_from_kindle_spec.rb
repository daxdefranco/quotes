require 'spec_helper'

class ImportFromKindleSpec < UseCaseSpec

  let(:file) do
    File.read("spec/support/kindle_clippings_with_dups.txt")
  end
  let(:user_uid) { 23 }
  let(:input) do
    {
      :user_uid => user_uid,
      :file => file
    }
  end
  let(:use_case) { UseCases::ImportFromKindle.new(input) }
  let(:result) { use_case.call }

  describe "call" do

    describe 'with input that cannot be parsed' do
      let(:file) { "some nonsense" }

      it 'nothing is added to the gateway' do
        assert_equal "Not a valid kindle clippings file", result.error
        assert_empty quotes_gateway.all
      end
    end

    describe "with parsable input" do

      it "adds all quote entities to the gateway" do
        assert_nil result.error

        result = quotes_gateway.all
        assert_kind_of Array, result
        assert_kind_of Entities::Quote, result.last
        assert_equal 23, result.last.added_by
        assert_equal 'Sample Author', result.last.author
        assert_includes result.last.content, 'sample highlight'
      end

      describe 'with duplicate quotes' do
        before do
          seed_database_with_duplicate_quotes
        end

        it "returns possible duplicates" do
          assert_nil result.error

          duplicates = result.possible_duplicates
          assert_equal 4, duplicates.size
          assert_includes duplicates.flatten.map(&:content),
            "This is a duplicate sample highlight."

          assert_equal 3, quotes_gateway.all.size
        end
      end

      def seed_database_with_duplicate_quotes
        input = {
          :user_uid => user_uid,
          :file => File.read("spec/support/sample_kindle_clippings.txt")
        }

        UseCases::ImportFromKindle.new(input).call
      end
    end

  end

end