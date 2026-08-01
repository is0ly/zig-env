# zig-env

Zig-окружения на любой версии тулчейна. Никакого скаффолдинга — только компилятор и zls.

## В проекте

```sh
echo 'use flake github:is0ly/zig-env#master' > .envrc
direnv allow
```

Всё. `zig` и `zls` доступны при входе в каталог.

Конкретная версия:

```sh
echo 'use flake github:is0ly/zig-env#"0.16.0"' > .envrc
direnv reload
```

## Разово, без direnv

```sh
nix develop github:is0ly/zig-env#master
nix develop github:is0ly/zig-env#"0.16.0"
```

Без атрибута берётся `master`:

```sh
nix develop github:is0ly/zig-env
```

## Какие версии доступны

Все атрибуты из `mitchellh/zig-overlay`:

```sh
nix flake show github:mitchellh/zig-overlay
```

## Оговорка

`zls` берётся с master-ветки и рассчитан на свежий Zig.
На старых версиях компилятора LSP может ругаться на синтаксис.
