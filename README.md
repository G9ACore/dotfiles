Иерархия:
```
dotfiles/
├── flake.nix                    # Точка входа, все inputs
├── flake.lock
│
├── hosts/                       # Конфиги конкретных машин
│   ├── laptop/                  # Реальная система
│   │   ├── default.nix          # Главный конфиг хоста
│   │   ├── hardware.nix         # hardware-configuration.nix
│   │   └── disk.nix             # Разметка дисков (опционально)
│   └── vm/                      # Виртуальная машина
│       ├── default.nix
│       └── hardware.nix
│
├── modules/                     # Переиспользуемые модули
│   ├── nixos/                   # Системный уровень
│   │   ├── core.nix             # Базовые настройки (nix, locale, boot)
│   │   ├── audio.nix            # Pipewire
│   │   ├── network.nix          # NetworkManager, firewall
│   │   ├── gaming.nix           # Steam, gamemode, wine
│   │   ├── niri.nix             # Сессия, greetd, XDG
│   │   └── security.nix         # Sudo, polkit, pam
│   │
│   └── home/                    # Home Manager уровень
│       ├── core.nix             # Shell, git, nixvim базовые утилиты
│       ├── stylix.nix           # Тема, шрифты, обои
│       ├── niri.nix             # Конфиг niri (config.kdl)
│       ├── noctalia.nix         # Noctalia Shell
│       ├── zen-browser.nix      # Zen Browser
│       ├── terminal.nix         # Kitty + fish
│       ├── gaming.nix           # Heroic, ludusavi и т.п.
│       └── minecraft.nix        # Prismlauncher
│
├── users/                       # Профили пользователей
│   ├── main.nix                 # Ты — полный профиль
│   └── guest.nix                # Гостевой — без игр, минимум
│
└── lib/                         # Вспомогательные функции
    └── mkHost.nix               # Хелпер для nixosSystem
```