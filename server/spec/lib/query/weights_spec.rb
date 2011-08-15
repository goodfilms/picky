require 'spec_helper'

describe Picky::Query::Weights do
  
  context 'with weights' do
    before(:each) do
      @weights = described_class.new [:test1, :test2]         => 6,
                                     [:test1]                 => 5,
                                     [:test3]                 => 3,
                                     [:test3, :test2]         => 4,
                                     [:test1, :test4]         => 5,
                                     [:test4, :test1]         => 5,
                                     [:test4, :test1, :test2] => 4,
                                     [:test1, :test4, :test2] => 4,
                                     [:test4, :test5]         => 3,
                                     [:test5, :test1]         => 2,
                                     [:test1, :test5]         => 2,
                                     [:test3, :test1]         => 2,
                                     [:test1, :test3]         => 2
    end
    
    describe 'score_for' do
      it 'gets the category names from the combinations' do
        combinations = [
          stub(:combination1, :category_name => :test1),
          stub(:combination1, :category_name => :test2)
        ]
        
        @weights.score_for(combinations).should == +6
      end
    end
    
    describe "weight_for" do
      it "should return zero if there is no specific weight" do
        @weights.weight_for([:not_a_specific_allocation]).should be_zero
      end
    end
  
    def self.it_should_return_a_specific_weight_for(allocation, weight)
      it "should return weight #{weight} for #{allocation.inspect}" do
        @weights.weight_for(allocation).should == weight
      end
    end
  
    it_should_return_a_specific_weight_for [:test1, :test2],         6
    it_should_return_a_specific_weight_for [:test1],                 5
    it_should_return_a_specific_weight_for [:test1, :test3],         2
    it_should_return_a_specific_weight_for [:test3],                 3
    it_should_return_a_specific_weight_for [:test3, :test2],         4
    it_should_return_a_specific_weight_for [:test1, :test4],         5
    it_should_return_a_specific_weight_for [:test4, :test1],         5
    it_should_return_a_specific_weight_for [:test4, :test1, :test2], 4
    it_should_return_a_specific_weight_for [:test1, :test4, :test2], 4
    it_should_return_a_specific_weight_for [:test4, :test5],         3
    it_should_return_a_specific_weight_for [:test5, :test1],         2
    it_should_return_a_specific_weight_for [:test1, :test5],         2
    it_should_return_a_specific_weight_for [:test3, :test1],         2
  
    describe 'to_s' do
      it 'is correct' do
        @weights.to_s.should == "Picky::Query::Weights({[:test1, :test2]=>6, [:test1]=>5, [:test3]=>3, [:test3, :test2]=>4, [:test1, :test4]=>5, [:test4, :test1]=>5, [:test4, :test1, :test2]=>4, [:test1, :test4, :test2]=>4, [:test4, :test5]=>3, [:test5, :test1]=>2, [:test1, :test5]=>2, [:test3, :test1]=>2, [:test1, :test3]=>2})"
      end
    end
    describe 'empty?' do
      it 'is correct' do
        @weights.empty?.should == false
      end
    end
  end
  context 'without weights' do
    before(:each) do
      @weights = described_class.new
    end
    describe 'empty?' do
      it 'is correct' do
        @weights.empty?.should == true
      end
    end
  end
  
end