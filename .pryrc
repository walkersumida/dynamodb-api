if defined?(PryByebug)
  Pry.commands.alias_command '_c', 'continue'
  Pry.commands.alias_command '_s', 'step'
  Pry.commands.alias_command '_n', 'next'
  Pry.commands.alias_command '_f', 'finish'
  Pry.commands.alias_command '_w', 'whereami'
end
