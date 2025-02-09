let
  l1npengtul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmy492dN8mCQIP/f/ecxu9DIBHbhQF5Yte28CJZ1hgf";
  users = [l1npengtul];

  abandonedfactory = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO6PX4Nay53OW6pHoYcUrvCSf8dIk4mxWxiQrtGVOC0E";
  systems = [abandonedfactory];
in {
  "secret1.age".publicKeys = [l1npengtul];
  "secret2.age".publicKeys = users ++ systems;
  "playit-secret.age".publicKeys = [abandonedfactory];
}
