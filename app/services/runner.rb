class Runner
  def self.from_lang(lang)
    if lang == 'javascript'
      return JavascriptRunner.new
    elsif lang == 'rust'
      return RustRunner.new
    end
  end

  def run(program)
    raise "Called Runner.run, but Runner is abscract class"
  end 
end

class JavascriptRunner < Runner
  def run(program)
    output = ""
    Dir.mktmpdir do |root|
      open("#{root}/index.js", "w") do |file|
        file.write(program)
      end
      open("#{root}/.babelrc", "w") do |file|
        file.write('
          {
            "presets": ["es2015"]
          }        
        ')
      end
      output = `docker run -v #{root}:/app lok814/babel-node:1.0 babel-node /app/index.js 2>&1`
    end
    output
  end
end

class RustRunner < Runner
end