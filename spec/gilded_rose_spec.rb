require 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    context 'Sulfuras' do
      it 'checks for quality not changing with days' do
        item = [Item.new('Sulfuras, Hand of Ragnaros', 9, 80)]
        GildedRose.new(item).update_quality
        expect(item[0].quality).to eq 80
      end

      it 'checks for quality being same even after sell by date' do
        item = [Item.new('Sulfuras, Hand of Ragnaros', -1, 80)]
        GildedRose.new(item).update_quality
        expect(item[0].quality).to eq 80
      end
    end

    context 'Aged Brie' do
      it "doesn't let the quality get over 50" do
        item = [Item.new('Aged Brie', 9, 50)]
        GildedRose.new(item).update_quality
        expect(item[0].sell_in).to eq 8
        expect(item[0].quality).to eq 50
      end

      it 'increases in quality by 1 if quality < 50' do
        item = [Item.new('Aged Brie', 10, 20)]
        GildedRose.new(item).update_quality
        expect(item[0].sell_in).to eq 9
        expect(item[0].quality).to eq 21
      end

      it 'quality increases at double rate each day after sell by date' do
        items = [Item.new('Aged Brie', 0, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 12
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq -2
        expect(items[0].quality).to eq 14
      end
    end
  end
end
