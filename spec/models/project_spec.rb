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