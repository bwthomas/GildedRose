require './item.rb'

class GildedRose
  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)

    @special = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"]
  end

  def appreciate(item)
    change        = @special.include?(item) ? 1 : -1
    change        = change - 1 if item.sell_in < 0

    quality       = [0, item.quality + change].max
    item.quality  = [50, quality].min
  end

  def tick
    for item in @items
      next if item.name =~ /Sulfuras/

      appreciate(item)

      if (item.name == "Backstage passes to a TAFKAL80ETC concert")
        appreciate(item) if (item.sell_in < 11)
        appreciate(item) if (item.sell_in < 6)
      end

      item.sell_in  = item.sell_in - 1;
    end
  end

end
