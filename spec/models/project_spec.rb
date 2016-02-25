require 'spec_helper'
# shoulda needs to be required otherwise the 'have_many' test will fail!
require 'shoulda/matchers'

describe Project, type: :model do
  it { is_expected.to have_many :reviews }
end