require 'spec_helper'

class PublicationSpec < Minitest::Spec
  let(:added_by) { 23 }
  let(:author) { 'John Doe' }
  let(:title) { 'A Critique of Something' }
  let(:publisher) { 'Pension Books LTD' }
  let(:year) { 2001 }
  let(:uid) { nil }

  let(:publication) do
    Entities::Publication.new(added_by, author, title, publisher, year, uid)
  end

  describe 'construction' do
    it 'can be built with five arguments' do
      assert_correct_storage
    end

    describe 'without' do

      describe 'added_by' do
        let(:added_by) {nil}
        it('fails') {assert_failure{publication}}
      end

      describe 'author' do
        let(:author)  {nil}
        it('fails')   {assert_failure{publication}}
      end

      describe 'title' do
        let(:title)  {nil}
        it('fails')   {assert_failure{publication}}
      end

      describe 'publisher' do
        let(:publisher) {nil}
        it('fails') {assert_failure{publication}}
      end

      describe 'year' do
        let(:year) {nil}
        it('fails')   {assert_failure{publication}}
      end

    end
  end

  describe 'reconstruction' do
    let(:uid) { 23 }

    it 'can be built with a uid' do
      assert_correct_storage
    end
  end

  def assert_correct_storage
    assert_equal author, publication.author
    assert_equal title, publication.title
    assert_equal publisher, publication.publisher
    assert_equal year, publication.year
    assert_equal uid, publication.uid
  end
end
