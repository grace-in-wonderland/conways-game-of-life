defmodule GridTests do
  use ExUnit.Case

  test "turn the cells" do
     one = [ {5,6}, {6,6}, {7,6},
             {5,7} ]

    two = [        {6,5},
            {5,6}, {6,6},
            {5,7} ]

    three = [ {5,5}, {6,5},
              {5,6}, {6,6},
              {5,7}, {6,7} ]

    four = [      {5,5}, {6,5},
            {4,6}, 		          {7,6},
	                {5,7}, {6,7} ]

    assert Grid.turn(one) -- two == []
    assert Grid.turn(two) -- three == []
    assert Grid.turn(three) -- four == []
  end

end
