require 'tmpdir'

file "peg2rb.rb" => ["peg2rb.peg"] do
  previous_peg2rb = "peg2rb.rb"
  with step = 1 do
    current_peg2rb = "#{Dir.tmpdir}/peg2rb-#{step}.rb"
    sh "ruby #{previous_peg2rb} peg2rb.peg > #{current_peg2rb}"
    if File.read(current_peg2rb) == File.read(previous_peg2rb)
      mv current_peg2rb, "peg2rb.rb"
      break
    else
      previous_peg2rb = current_peg2rb
      step += 1
      redo
    end
  end
end

def with(*args, &block)
  while true
    block.()
    break
  end
end