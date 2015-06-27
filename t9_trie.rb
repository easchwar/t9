class T9TrieNode
  LETTER_VALUES = {
    'a' => 2,
    'b' => 2,
    'c' => 2,
    'd' => 3,
    'e' => 3,
    'f' => 3,
    'g' => 4,
    'h' => 4,
    'i' => 4,
    'j' => 5,
    'k' => 5,
    'l' => 5,
    'm' => 6,
    'n' => 6,
    'o' => 6,
    'p' => 7,
    'q' => 7,
    'r' => 7,
    's' => 7,
    't' => 8,
    'u' => 8,
    'v' => 8,
    'w' => 9,
    'x' => 9,
    'y' => 9,
    'z' => 9
  }

  def self.letter_key(letter)
    LETTER_VALUES(letter)
  end

  def self.build_from_dict(file)
    dict = File.readlines(file).map(&:chomp)
    trie = T9TrieNode.new
    dict.each do |word|
      trie.insert(word)
    end
    trie
  end

  attr_reader :children, :words

  def initialize(word = nil)
    @words = word.nil? ? [] : [word]
    @children = {} 
  end

  def add_child(key)
    return nil if self.children[key]

    new_node = T9TrieNode.new 
    self.children[key] = new_node

    new_node
  end

  def add_word(word)
    return nil if self.words.include?(word)
    self.words << word  
    word
  end

  def insert(word)
    current = self 

    word.chars.each do |char|
      number = T9TrieNode.letter_key(char)
      current.add_child(number) unless current.children[number]
      current = current.children[number] 
    end

    current.add_word(word) 
  end

  def retrieve(word)
    current = self

    word.chars.each do |char|
      number = T9TrieNode.letter_key(char) 
      current = current.children[number]

      return nil if current.nil?
    end

    current
  end

  def retrieve_next_word(node)
    
    queue = [node]
    until queue.empty?
      current = queue.shift
      return current.words.first unless current.words.empty?
      queue += current.children.values
    end

    nil
  end
end
