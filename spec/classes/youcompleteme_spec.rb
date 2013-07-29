require 'spec_helper'

describe "youcompleteme" do
  let(:facts) { { id: "username" } }

  it do
    should contain_file("/home/username/.vim/bundle/YouCompleteMe").with({
      "ensure"  => "directory"
    })

    should contain_file("/home/username/ycm_build").with({
      "ensure"  => "directory",
      "require" => "File[/home/username/.vim/bundle/YouCompleteMe]"
    })

    should contain_exec("makefiles-ycm").with({
      "path"    => "/usr/bin:/usr/sbin:/bin",
      "command" => "cd /home/username/ycm_build && cmake -G \"Unix Makefiles\" . /home/username/.vim/bundle/YouCompleteMe/cpp",
      "require" => "File[/home/username/ycm_build]"
    })

    should contain_exec("make-ycm_core").with({
      "path"    => "/usr/bin:/usr/sbin:/bin",
      "command" => "make ycm_core",
      "require" => "Exec[makefiles-ycm]"
    })
  end

  context "when plugin path is given as param" do
    let(:params) { { pluginpath: "/home/username/code/YouCompleteMe" } }

    it do
      should contain_file("/home/username/code/YouCompleteMe").with({
        "ensure"  => "directory"
      })

      should contain_file("/home/username/ycm_build").with({
        "ensure"  => "directory",
        "require" => "File[/home/username/code/YouCompleteMe]"
      })
    end
  end
end
