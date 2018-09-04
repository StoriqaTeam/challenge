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

  def self.grade(task_solution)
    runner = self.from_lang(task_solution.task.language)
    program = task_solution.task.runtime + "\n" + task_solution.solution + "\n" + task_solution.task.tests
    res = []
    output = runner.run(program)
    puts "Output:"
    p output
    output.split("\n").each do |line|
      matches = GRADE_REGEX.match(line)
      if matches
        name = matches[1]
        passed = matches[2] == "ok"
        res << TaskSolutionResult.new(name: name, passed: passed, task_solution_id: task_solution.id)
      end
    end
    # The program didn't compile
    if res.count == 0
      res << TaskSolutionResult.new(name: "Compilation", passed: false, task_solution_id: task_solution.id)
    end
    res
  end
end

GRADE_REGEX = /(.*): (ok|fail)/i

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
      output = `docker run --rm --stop-timeout 3 -v #{root}:/app lok814/babel-node:1.0 babel-node /app/index.js 2>&1`
    end
    output
  end

  def grade(task_solution, program)
  end
end

class RustRunner < Runner
end