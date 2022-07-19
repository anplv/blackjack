class GameController
  attr_reader :user_name

  ACTIONS = { 1 => 'Пропустить ход',
              2 => 'Взять карту',
              3 => 'Открыть карты' }.freeze

  def initialize
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def name
    puts 'Перед началом игры введите ваше имя:'
    @gamer = Gamer.new(gets.strip.chomp, @deck)
    puts "#{@gamer.name}, добро пожаловать!"
  end

  def show_cards
    puts 'Ваши карты:'
    @gamer.cards_in_hands.each do |card|
      print card.keys.first + '|'
    end
    puts "\nКарты дилера: ***"
  end

  def show_action
    puts 'Введите номер действия, котрое хотите сделать:'
    ACTIONS.each do |action_number, action|
      puts "#{action_number} -> #{action}"
    end
  end

  def select_action
    action_number = gets.to_i
    case action_number
    when 1
      @gamer.to_pass
    when 2
      @gamer.take_card
    when 3
      @gamer.open_cards
    end
  end
end
