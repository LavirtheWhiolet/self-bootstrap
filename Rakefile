require 'tmpdir'

file "peg2rb.rb" => ["peg2rb.peg"] do
  previous_peg2rb = "peg2rb.rb"
  step = 1
  loop do
    current_peg2rb = "#{Dir.tmpdir}/peg2rb#{step}.rb"
    sh "ruby #{previous_peg2rb} peg2rb.peg > #{current_peg2rb}"
    if File.read(current_peg2rb) == File.read(previous_peg2rb)
      mv current_peg2rb, "peg2rb.rb"
      break
    else
      step += 1
      continue
    end
  end
end
