require 'spec_helper'
# shoulda needs to be required otherwise the 'have_many' test will fail!
require 'shoulda/matchers'

describe Project, type: :model do
  it { is_expected.to have_many :reviews }
  
  it 'is not valid with a name of less than three characters' do
    project = Project.new(name: 'Cr')
    expect(project).to have(1).error_on(:name)
    expect(project).not_to be_valid
  end

end