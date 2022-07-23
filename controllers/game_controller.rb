# frozen_string_literal: true

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
    puts
  end

  def start
    @deck.starter_set(@gamer)
    @deck.starter_set(@dealer)
    puts "Раздача карт...\r"
    loading
    puts "Игра началась!\n"
  end

  def loading
    (['/', '—', '\\', '|'] * 4).each do |item|
      print "#{item}\r"
      sleep 0.2
    end
  end

  def show_cards
    puts 'Ваши карты:'
    @gamer.cards_in_hands.each_key do |card|
      print "|#{card}| "
    end
    puts "\n" * 2
    puts "Ваши очки: #{@gamer.points}"
    puts "\nКарты дилера:"
    puts '|*| ' * @dealer.cards_in_hands.size
  end

  def to_bet
    puts 'Ваша ставка 10 долларов.'
    @gamer.cash_account -= 10
    puts "\nСтавка дилера 10 долларов."
    @dealer.cash_account -= 10
  end

  def show_bank
    puts "На вашем счете #{@gamer.cash_account} долларов."
    puts "На счете дилера #{@dealer.cash_account} долларов."
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
      gamer_pass
    when 2
      gamer_take_card
    when 3
      open_cards
    end
  end

  def gamer_pass
    @gamer.to_pass
    puts 'Вы пасуете!'
    dealer_choice
  end

  def gamer_take_card
    @gamer.take_card(@deck)
    new_card = @gamer.cards_in_hands.keys.last
    puts "Новая карта: |#{new_card}|."
    dealer_choice
  end

  def open_cards
    puts 'Ваши карты:'
    puts @gamer.open_cards
    puts "\n" * 2
    puts 'Карты дилера:'
    puts @dealer.open_cards
  end

  def dealer_choice
    sleep 2
    score_sum = @dealer.cards_in_hands.values.sum
    if score_sum >= 17
      dealer_pass
    elsif score_sum < 17
      dealer_take_card
    end
  end

  def dealer_pass
    @dealer.to_pass
    puts 'Дилер пасует!'
    open_cards
  end

  def dealer_take_card
    @dealer.take_card(@deck)
    puts 'Дилер берет карту!'
  end

  def scoring
    puts 'Подсчёт очков.'
    loading
    bust?
    if @gamer.points < @dealer.points
      puts 'Вы проиграли!'
      @dealer.wins += 1
      @dealer.cash_account += 20
    elsif @gamer.points > @dealer.points
      @gamer.wins += 1
      @gamer.cash_account += 20
    else
      puts 'Ничья!'
      @dealer.cash_account += 10
      @gamer.cash_account += 10
    end
  end

  def bust?
    if @gamer.bust? && !@dealer.bust?
      puts 'Вы проиграли! Перебор'
      @dealer.wins += 1
      @dealer.cash_account += 20
    elsif !@gamer.bust? && @dealer.bust?
      puts 'Вы выиграли! У дилера перебор'
      @gamer.wins += 1
      @gamer.cash_account += 20
    elsif @gamer.bust? && @dealer.bust?
      puts 'Ничья! У обоих игроков перебор'
      @dealer.cash_account += 10
      @gamer.cash_account += 10
    end
  end

  def game_score
    puts 'Количество очков по результатам партии:'
    puts "#{@gamer.name} - #{@gamer.points}"
    puts "#{@dealer.name} - #{@dealer.points}"
  end

  def match_score
    puts "\nСчёт по партиям:"
    puts "#{@gamer.name} - #{@gamer.wins}"
    puts "#{@dealer.name} - #{@dealer.wins}"
  end

  def new_game?
    puts 'Чтобы начать новую партию, нажмите Enter'
    puts 'Чтобы выйти, введите любой символ и нажмите Enter'
    gamer_input = gets.chomp
    if gamer_input == ''
      @gamer.fold_cards
      @dealer.fold_cards
      @deck.new_deck
    else
      abort
    end
  end

  def new_match?
    puts 'Чтобы начать новую игру, нажмите Enter'
    puts 'Чтобы выйти, введите любой символ и нажмите Enter'
    gamer_input = gets.chomp
    true if gamer_input == ''
    abort
  end

  def game_over?
    if @gamer.cash_account.zero?
      puts 'Вы проиграли!'
      show_bank
      match_score
    elsif @dealer.cash_account.zero?
      puts 'Вы выиграли!'
      show_bank
      match_score
    end
  end
end
