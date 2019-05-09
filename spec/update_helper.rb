def update(n)
  n.times { GildedRose.new(@items).update_quality }
end
