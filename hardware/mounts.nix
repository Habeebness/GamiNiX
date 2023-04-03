{ lib, config, ...}:

lib.mkIf config.mounts.enable {
	fileSystems."/run/media/iggut/gamedisk" =
  { device = "/dev/disk/by-uuid/9E049FCD049FA735";  # Windows game drive nvme
    fsType = "ntfs";
		options = [
    "uid=1000"
    "gid=1000"
    "rw"
    "user"
    "exec"
    "umask=000"
		];
  };
}
