module CloudflareDev
  class Image < Object
    def inspect
      "Image id=#{id}, filename=#{filename}"
    end

    def <=>(other)
      id <=> other.id
    end
  end
end
