require 'gilded_rose'
require 'update_helper'

describe GildedRose do
  describe '#update_quality' do
    context 'sulfuras' do
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

    context 'aged-brie' do
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

    context 'normal-item' do
      before(:each) do
        @items = [Item.new('normal', 1, 5)]
      end

      it 'quality drop by 1 each day' do
        update(1)
        expect(@items[0].sell_in).to eq 0
        expect(@items[0].quality).to eq 4
      end

      it 'quality drops by double after sell by date' do
        update(2)
        expect(@items[0].sell_in).to eq -1
        expect(@items[0].quality).to eq 2
      end
      it 'quality never becomes negative' do
        update(4)
        expect(@items[0].sell_in).to eq -3
        expect(@items[0].quality).to eq 0
      end
    end
  end
end
