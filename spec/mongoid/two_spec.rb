require 'spec_helper'

if defined?(Mongoid) && ::Mongoid::VERSION =~ /^2(.*)/

  describe Money do
    let(:priceable) { Priceable.create(:price => Money.new(100, 'EUR')) }

    context "serialize" do
      it "serializes correctly a Money object to a hash of cents and currency" do
        priceable.price.cents.should == 100
        priceable.price.currency.should == Money::Currency.find('EUR')
      end
    end

    context "deserialize" do
      subject { priceable.price }
      it { should be_an_instance_of(Money) }
      it { should == Money.new(100, 'EUR') }
      it "returns nil if a nil value was stored" do
        nil_priceable = Priceable.create(:price => nil)
        nil_priceable.price.should be_nil
      end
    end
  end
end
