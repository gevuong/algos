class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def count
    @store.length
  end

  def extract
    raise "no element to extract" if count == 0

    val = @store[0]

    if count > 1
      @store[0] = @store.pop
      self.class.heapify_down(@store, 0, &prc)
    else
      # Last element left.
      @store.pop
    end

    val
  end

  def peek
    raise "no element to peek" if count == 0
    @store[0]
  end

  def push(val)
    @store << val
    self.class.heapify_up(@store, self.count - 1, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    child_indices = []
    child_indices << (2 * parent_index + 1) if (2 * parent_index + 1) < len
    child_indices << (2 * parent_index + 2) if (2 * parent_index + 2) < len
    child_indices
  end

  def self.parent_index(child_index)
    parent_index = (child_index - 1) / 2
    raise "root has no parent" if child_index == 0
    parent_index
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    # check the child against its parent
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    left_child_idx, right_child_idx = child_indices(len, parent_idx)

    parent_val = array[parent_idx]

    # children_val = [array[left_child_idx], array[right_child_idx]]

    # if parent is greater than either of its two children swap them.

    children = []
    children << array[left_child_idx] if left_child_idx
    children << array[right_child_idx] if right_child_idx

    if children.all? { |child| prc.call(parent_val, child) <= 0 }
      return array
    end

    # Choose smaller of two children.
    swap_idx = nil
    if children.length == 1
      swap_idx = left_child_idx
    else
      swap_idx =
        prc.call(children[0], children[1]) == -1 ? left_child_idx : right_child_idx
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], parent_val
    heapify_down(array, swap_idx, len, &prc)
  end


  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    # As a convenience, return array
    return array if child_idx == 0

    parent_idx = parent_index(child_idx)
    child_val, parent_val = array[child_idx], array[parent_idx]
    if prc.call(child_val, parent_val) >= 0

      return array
    else
      # swap
      array[child_idx], array[parent_idx] = parent_val, child_val
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
