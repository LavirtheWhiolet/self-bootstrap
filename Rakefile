
file "peg2rb.rb" => "peg2rb.peg" do
  previous_peg2rb = "peg2rb.rb"
  step = 1
  once do
    current_peg2rb = "generated/peg2rb-#{step}.rb"
    sh "ruby #{previous_peg2rb} peg2rb.peg > #{current_peg2rb}"
    if File.read(current_peg2rb) == File.read(previous_peg2rb)
      mv current_peg2rb, "peg2rb.rb"
    else
      previous_peg2rb = current_peg2rb
      step += 1
      redo
    end
  end
end

task :all => ["peg2rb.rb"]

task :default => :all

task :clean do
  FileList["generated/*", "doc/*"].each { |entry| rm_r entry }
end

# ---- Utilities ----

# executes +block+ once. Inside +block+ one may use +break+, +next+ and +redo+.
def once(&block)
  while true
    yield
    break
  end
end
