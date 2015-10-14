Puppet::Type.type(:filesystem).provide :luks do
    desc "Manages filesystem of a luks containe"

    commands :mount => 'mount'

    def create
        mkfs(@resource[:fs_type])
    end

    def exists?
        fstype != nil
    end

    def destroy
        # no-op
    end

    def fstype
        mount('-f', '--guess-fstype', @resource[:name]).strip
    rescue Puppet::ExecutionFailure
        nil
    end

    def mkfs(fs_type)
        mkfs_params = { "reiserfs" => "-q" }
        mkfs_cmd    = ["mkfs.#{fs_type}", @resource[:name]]

        if mkfs_params[fs_type]
            mkfs_cmd << mkfs_params[fs_type]
        end

        if resource[:options]
            mkfs_options = Array.new(resource[:options].split)
            mkfs_cmd << mkfs_options
        end

        execute mkfs_cmd
    end

end
