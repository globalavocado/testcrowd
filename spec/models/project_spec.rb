require 'spec_helper'
require 'shoulda/matchers'

describe Project, type: :model do
  it { is_expected.to have_many :reviews }
  
  it 'is not valid with a name of less than three characters' do
    project = Project.new(name: 'Cr')
    expect(project).to have(1).error_on(:name)
    expect(project).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Project.create(name: "Kevin's clever mapping drone")
 	project = Project.new(name: "Kevin's clever mapping drone")
 	expect(project).to have(1).error_on(:name)
  end

end

describe '#average_rating' do
  context 'no reviews' do
    it 'returns "N/A" when there are no reviews' do
      project = Project.create(name: 'Crowdfundingtestproject')
      expect(project.average_rating).to eq 'N/A'
    end
  end

  context '1 review' do
    it 'returns that rating' do
      project = Project.create(name: 'Crowdfundingtestproject')
      project.reviews.create(rating: 4)
      expect(project.average_rating).to eq 4
    end
  end

end