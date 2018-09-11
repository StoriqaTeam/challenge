class Runner
  def self.from_lang(lang)
    if lang == 'javascript'
      return JavascriptRunner.new
    elsif lang == 'rust'
      return RustRunner.new
    elsif lang == 'golang'
      return GoRunner.new
    end
  end

  def run(program)
    raise "Called Runner.run, but Runner is abscract class"
  end 

  def run_docker(command, root)
    output = ""
    container_name = SecureRandom.hex
    begin
      Timeout::timeout(5) do
        `docker run --name #{container_name} #{command}`
      end
    rescue Timeout::Error => e
      `docker stop #{container_name}`
    end
    output = `docker logs #{container_name} 2>&1`
    output += "\n -----------------"
    `docker rm #{container_name}`
    `rm -rf #{root}`
    output
  end

  def self.grade(task_solution)
    runner = self.from_lang(task_solution.task.language)
    program = task_solution.task.runtime + "\n" + task_solution.solution + "\n" + task_solution.task.tests
    res = []
    output = runner.run(program)
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
    root = Dir.mktmpdir
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
    run_docker("-v #{root}:/app lok814/babel-node:1.0 babel-node /app/index.js", root)
  end
end

class RustRunner < Runner
  def run(program)
    root = Dir.mktmpdir
    Dir.mkdir("#{root}/src")
    open("#{root}/src/main.rs", "w") do |file|
      file.write(program)
    end
    open("#{root}/Cargo.toml", "w") do |file|
      file.write(
        <<-CONTENTS
          [package]
          name = "task"
          version = "0.1.0"
          authors = ["Noname"]
          
          [dependencies]
        CONTENTS
      )
    end
    run_docker("-v #{root}:/app -w='/app' rust:1.28 cargo run", root)
  end
end

class GoRunner < Runner
  def run(program)
    root = Dir.mktmpdir
    open("#{root}/main.go", "w") do |file|
      file.write(program)
    end
    run_docker("-v #{root}:/app -w='/app' golang:1.11 go run main.go", root)
  end
end