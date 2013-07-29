YouCompleteMe Vim plugin module for Puppet
==========================================

Puppet recipe for installing YouCompleteMe for Vim.

## Usage

You can just include the class:

```
class { 'youcompleteme': }
```

Or you can also add a `require` for your YouCompleteMe's repo:

```
# Considering your path to the plugin is ~/.vim/bundle/YouCompleteMe
class { 'youcompleteme':
  require => Vcsrepo["/home/${id}/.vim/bundle/YouCompleteMe"]
}
```

Internally the only requirement is for having the plugin path directory. See `Options` for more info.

## Options

You can pass in the path to the plugin:

```
class { 'youcompleteme':
  pluginpath => "/home/${id}/code/YouCompleteMe"
}
```

By default the plugin path is `/home/${id}/.vim/bundle/YouCompleteMe`.

## Contributing

Contributions are very welcome. Please feel free to open a pull request if you think you can improve something or add a nice-to-have feature.

## License

See `LICENSE`.
