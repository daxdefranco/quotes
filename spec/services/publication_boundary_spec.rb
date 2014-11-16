require 'spec_helper'

class PublicationBoundarySpec < ServiceSpec
  let(:publication) { create_publication }
  let(:boundary) { Services::PublicationBoundary.new }
  let(:result) { boundary.for(publication) }

  it "grants access to uid" do
    assert_equal publication.uid, result.uid
  end

  it 'grants access to author' do
    assert_equal publication.author, result.author
  end

  it 'grants access to title' do
    assert_equal publication.title, result.title
  end

  it "grants access to publisher" do
    assert_equal publication.publisher, result.publisher
  end

  it "grants access to year" do
    assert_equal publication.year, result.year
  end

end