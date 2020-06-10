title 'Tests to confirm libunistring libraries exist'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libunistring")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libunistring' do
  impact 1.0
  title 'Ensure libunistring libraries exist as expected'
  desc '
  We check that the directories that libunistring installs are present.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty}
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "include")}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "lib")}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "share")}") do
    its('stdout') { should_not be_empty }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
