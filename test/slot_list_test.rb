require File.expand_path('../../test/test_helper', __FILE__)

class SlotListTest < Test::Unit::TestCase
  def test_block
    list = Earlydoc::Tetra::SlotList.block
    assert_equal list.size, Earlydoc::Tetra::SlotList::RANGE_IN_HOURS * 6, 'expected number of slots equal to hours * six 10-minute'
  end

  def test_block_with_morning
    list = Earlydoc::Tetra::SlotList.block :morning
    start = Earlydoc::Tetra::SlotList::MORNING_START

    assert_equal Time.parse("#{start}:00", Time.now), list.first.begin, "expected first block to start at #{start}:00"
    assert_equal Time.parse("#{start}:10", Time.now), list.first.end, "expected first block to end at #{start}:10"
  end

  def test_block_with_midday
    list = Earlydoc::Tetra::SlotList.block :midday
    start = Earlydoc::Tetra::SlotList::MIDDAY_START
    
    assert_equal Time.parse("#{start}:00", Time.now), list.first.begin, "expected first block to start at #{start}:00"
    assert_equal Time.parse("#{start}:10", Time.now), list.first.end, "expected first block to end at #{start}:10"
  end

  def test_block_with_evening
    list = Earlydoc::Tetra::SlotList.block :evening
    start = Earlydoc::Tetra::SlotList::EVENING_START
    
    assert_equal Time.parse("#{start}:00", Time.now), list.first.begin, "expected first block to start at #{start}:00"
    assert_equal Time.parse("#{start}:10", Time.now), list.first.end, "expected first block to end at #{start}:10"
  end
end