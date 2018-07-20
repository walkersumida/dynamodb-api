module Dynamodb
  module Api
    module Config
      module Options
        def defaults
          @defaults ||= {}
        end

        def option(name, options = {})
          defaults[name] = settings[name] = options[:default]

          class_eval <<-RUBY
          def #{name}
            settings[#{name.inspect}]
          end

          def #{name}=(value)
            settings[#{name.inspect}] = value
          end

          def #{name}?
          #{name}
          end

          def reset_#{name}
            settings[#{name.inspect}] = defaults[#{name.inspect}]
          end
          RUBY
        end

        def reset
          settings.replace(defaults)
        end

        def settings
          @settings ||= {}
        end
      end
    end
  end
end
