TriangleValidator = Struct.new(:side_a, :side_b, :side_c) do
  def is_valid?
    side_a + side_b > side_c &&
    side_a + side_c > side_b &&
    side_b + side_c > side_a
  end
end
