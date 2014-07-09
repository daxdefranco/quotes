require 'spec_helper'

class UpdateLinksSpec < UseCaseSpec

  let(:quote_one) { create_quote }
  let(:quote_two) { create_quote }
  let(:input) do
    {
      :first  => quote_one.id,
      :second => quote_two.id
    }
  end
  let(:use_case)  { UseCases::UpdateLinks.new(input) }

  describe "call" do
    let(:result_one)  { gateway.get(quote_one.id) }
    let(:result_two)  { gateway.get(quote_two.id) }

    describe "with unexpected input" do
      let(:quote_one) { build_quote }

      it "fails" do
        assert_failure { use_case.call }
      end
    end

    it "updates links for the given quotes" do
      assert_empty quote_one.links
      assert_empty quote_two.links

      use_case.call

      assert_includes result_one.links, quote_two.id
      assert_includes result_two.links, quote_one.id
    end
  end

end