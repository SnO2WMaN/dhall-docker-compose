let defaults = ./defaults.dhall

let types = ./types.dhall

in    types
    ⫽ { Service = { Type = types.Service, default = defaults.Service }
      ,  Build = { Type = types.Build, default = defaults.Build }
      , Volume = { Type = types.Volume, default = defaults.Volume }
      , Config =
        { Type = types.ComposeConfig, default = defaults.ComposeConfig }
      , Healthcheck =
        { Type = types.Healthcheck, default = defaults.Healthcheck }
      }
