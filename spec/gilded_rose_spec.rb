require 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it "checks for Sulfuras's quality not changing with days" do
      item1 = [Item.new('Sulfuras, Hand of Ragnaros',0,80)]
      item2 = [Item.new('Sulfuras, Hand of Ragnaros',-1,80)]
      GildedRose.new(item1).update_quality
      GildedRose.new(item2).update_quality
      expect(item1[0].quality).to eq 80
      expect(item2[0].quality).to eq 80
    end
  end
end
