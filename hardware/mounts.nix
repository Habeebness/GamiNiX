{ lib, config, ...}:

lib.mkIf config.mounts.enable {
services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
services.samba = {
  enable = true;
  securityType = "user";
  extraConfig = ''
    workgroup = WORKGROUP
    server string = smbnix
    netbios name = smbnix
    security = user 
    #use sendfile = yes
    #max protocol = smb2
    # note: localhost is the ipv6 localhost ::1
    hosts allow = 192.168.122.181
    hosts deny = 0.0.0.0/0
    guest account = nobody
    map to guest = bad user
  '';
  shares = {
    public = {
      path = "/home/iggut/Downloads/rddm";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "yes";
      "create mask" = "0777";
      "directory mask" = "0777";
    };
  };
};
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
