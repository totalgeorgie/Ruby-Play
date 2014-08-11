def remix(ingredients)
  remixed = []
  alcohols, mixers = separate_ingredients(ingredients)
  until remixed.length == ingredients.length
    remixed << [alcohols.shuffle!.pop, mixers.shuffle!.pop]
  end
  
  has_original?(remixed, ingredients) ? remix(ingredients) : remixed
end

def separate_ingredients(ingredients)
  alcohols = []
  mixers = []
  ingredients.each do |recipe|
    alcohols << recipe[0]
    mixers << recipe[1]
  end
  [alcohols, mixers]
end

def has_original?(remixed, ingredients)
  remixed.any? { |pair| ingredients.include?(pair) }
end

#Make sure that it doesn't give us original ingredients again 

#we shovel this_mix into remixed every time we delete something from alcohols/mixers
