require 'spec_helper'

describe Internals::Results::Full do
  
  describe "class accessors" do
    it "should have accessors for max_results" do
      max_results = stub :max_results
      old_results = described_class.max_results
      described_class.max_results = max_results

      described_class.max_results.should == max_results

      described_class.max_results = old_results
    end
  end
  
  describe 'initialize' do
    context 'without allocations' do
      it 'should not fail' do
        lambda {
          described_class.new
        }.should_not raise_error
      end
      it 'should set the allocations to allocations that are empty' do
        described_class.new.instance_variable_get(:@allocations).should be_empty
      end
    end
    context 'with allocations' do
      it 'should not fail' do
        lambda {
          described_class.new :some_allocations
        }.should_not raise_error
      end
      it 'should set the allocations to an empty array' do
        described_class.new(:unimportant, :some_allocations).instance_variable_get(:@allocations).should == :some_allocations
      end
    end
  end
  
  describe 'duration' do
    before(:each) do
      @results = described_class.new
    end
    it 'should return the set duration' do
      @results.duration = :some_duration

      @results.duration.should == :some_duration
    end
    it 'should return 0 as a default' do
      @results.duration.should == 0
    end
  end
  
  describe 'total' do
    it 'should delegate to allocations.total' do
      allocations = stub :allocations
      results = described_class.new nil, allocations

      allocations.should_receive(:total).once

      results.total
    end
  end
  
  describe 'prepare!' do
    before(:each) do
      @results = described_class.new
      @allocations = stub :allocations
      @results.stub! :allocations => @allocations
    end
    it 'should process' do
      @allocations.should_receive(:process!).once.with(20, 0).ordered
      
      @results.prepare!
    end
  end
  
end