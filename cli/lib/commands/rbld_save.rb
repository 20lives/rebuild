module Rebuild::CLI
  class RbldSaveCommand < Command
    private

    def default_file(env)
      "#{env.name}-#{env.tag}.rbld"
    end

    public

    def initialize
      @usage = "[OPTIONS] [ENVIRONMENT] [FILE]"
      @description = "Save local environment to file"
    end

    def run(parameters)
      env, file = parameters
      env = Environment.new( env )
      file = default_file( env ) if !file or file.empty?
      rbld_log.info("Going to save #{env} to #{file}")

      warn_if_modified( env, 'saving' )
      engine_api.save(env, file)

      rbld_print.progress "Successfully saved environment #{env} to #{file}\n"
    end
  end
end
