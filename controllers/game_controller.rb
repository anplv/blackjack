class GameController
  attr_reader :user_name

  MOVES = { 1 => 'Пропустить ход',
            2 => 'Взять карту',
            3 => 'Открыть карты' }.freeze

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new('Дилер')
  end

  def name
    puts 'Перед началом игры введите ваше имя:'
    @gamer = Gamer.new(gets.strip.chomp)
    puts "#{@gamer.name}, добро пожаловать!"
  end

  def start
    @deck.starter_set(@gamer)
    @deck.starter_set(@dealer)
    puts "Раздача карт\r"
    (['/', '—', '\\', '|'] * 4).each do |item|
      print "#{item}\r"
      sleep 0.2
    end
    puts "Игра началась!\n"
  end

  def show_cards
    puts 'Ваши карты:'
    @gamer.cards_in_hands.each_key do |card|
      print "|#{card}| "
    end
    puts "\n"
    puts '~' * 15
    puts 'Карты дилера:'
    puts '|*| ' * @dealer.cards_in_hands.size
    puts '~' * 15
  end

  def show_bank
    puts 'Ваша ставка 10 долларов.'
    puts "На вашем счете #{@gamer.cash_account}."
    puts '~' * 15
    puts 'Ставка дилера 10 долларов.'
    puts "На счете дилера #{@dealer.cash_account}."
    puts '~' * 15
  end

  def show_moves
    puts 'Ваш ход! Введите номер действия, котрое хотите сделать:'
    MOVES.each do |move_number, move|
      puts "#{move_number} -> #{move}"
    end
  end

  def gamer_choice
    move_number = gets.to_i
    case move_number
    when 1
      @gamer.to_pass
      puts 'Вы пассуете!'
      dealer_move
    when 2
      @gamer.take_card(@deck)
      new_card = @gamer.cards_in_hands.keys.last
      puts "Новая карта: |#{new_card}|."
    when 3
      @gamer.open_cards
    end
  end
end
