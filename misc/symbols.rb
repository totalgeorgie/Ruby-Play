def super_print(string, options = {})
  defaults = {
    :times => 1,
    :upcase => false,
    :reverse => false
  }
  
  values = defaults.merge(options)
  
  string.reverse! if values[:reverse]
  string.upcase! if values[:upcase]
  values[:times].times { puts string }
end