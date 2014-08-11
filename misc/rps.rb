def rps player_choice
  winner(player_choice, computer_choice)
end

def computer_choice
  ["Rock", "Paper", "Scissors"].sample
end

def winner (player_choice, computer_choice)
  return "#{computer_choice}, Draw" if player_choice == computer_choice
  
  return "#{computer_choice}, Win" if player_choice == "Rock" && computer_choice == "Scissors"
  
  if player_choice == "Rock" && computer_choice == "Paper"
    return "#{computer_choice}, Lose"
  end
  
  if player_choice == "Paper" && computer_choice == "Scissors"
    return "#{computer_choice}, Lose"
  end
  
  if player_choice == "Paper" && computer_choice == "Rock"
    return "#{computer_choice}, Win"
  end
  
  if player_choice == "Scissors" && computer_choice == "Rock"
    return "#{computer_choice}, Lose"
  end
  
  if player_choice == "Scissors" && computer_choice == "Paper"
    return "#{computer_choice}, Win"
  end
end

5.times do
  puts(rps("Rock"))
end

#Wrap this in a class and have a game_loop that prompts for player input