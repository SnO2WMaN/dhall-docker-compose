let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Type

let StringOrNumber
    : Type
    = < String : Text | Number : Natural >

let ListOrDict
    : Type
    = < Dict : Map Text StringOrNumber | List : List (Optional StringOrNumber) >

let BuildArgs : Type = < Dict : Map Text StringOrNumber | List : List (Optional StringOrNumber) >

let Build
    : Type
    =  { context : Optional Text, dockerfile : Optional Text ,args: Optional BuildArgs}
      

let StringOrList
    : Type
    = < String : Text | List : List Text >

let Healthcheck
    : Type
    = { disable : Optional Bool
      , interval : Optional Text
      , retries : Optional Natural
      , test : Optional StringOrList
      , timeout : Optional Text
      }

let Labels
    : Type
    = < Object : Map Text Text | List : List Text >

let Options
    : Type
    = Map Text (Optional StringOrNumber)

let Logging
    : Type
    = { driver : Text, options : Optional Options }

let Networks
    : Type
    = < List : List Text
      | Object :
          Optional
            { aliases : List Text, ipv4_address : Text, ipv6_address : Text }
      >

let Ulimits
    : Type
    = < Int : Natural | Object : { hard : Natural, soft : Natural } >

let Resource
    : Type
    = { cpus : Text, memory : Text }

let Deploy
    : Type
    = { mode : Text
      , replicas : Natural
      , labels : Labels
      , update_config :
          { parallelism : Natural
          , delay : Text
          , failure_action : Text
          , monitor : Text
          , max_failure_ratio : Natural
          }
      , resources : { limits : Resource, reservations : Resource }
      , restartPolicy :
          { condition : Text
          , delay : Text
          , maxAttempts : Natural
          , window : Text
          }
      , placement : { constraints : List Text }
      }

let DependsOn
    : Type = < Short : List Text | Long : Map Text { condition : Text } >

let Ports
    : Type = < Short : List StringOrNumber | Long : List { published : StringOrNumber, target : StringOrNumber } >

let Environment : Type = < Dict : Map Text StringOrNumber | List : List (Optional StringOrNumber) >

let Service
    : Type
    = { deploy : Optional Deploy
      , build : Optional Build
      , cap_add : Optional (List Text)
      , cap_drop : Optional (List Text)
      , cgroup_parent : Optional Text
      , command : Optional StringOrList
      , container_name : Optional Text
      , depends_on : Optional DependsOn
      , devices : Optional (List Text)
      , dns : Optional StringOrList
      , dns_search : Optional (List Text)
      , domainname : Optional Text
      , entrypoint : Optional StringOrList
      , env_file : Optional StringOrList
      , environment : Optional Environment
      , expose : Optional (List StringOrNumber)
      , external_links : Optional (List Text)
      , extra_hosts : Optional ListOrDict
      , healthcheck : Optional Healthcheck
      , hostname : Optional Text
      , image : Optional Text
      , ipc : Optional Text
      , labels : Optional Labels
      , links : Optional (List Text)
      , logging : Optional Logging
      , mac_address : Optional Text
      , network_mode : Optional Text
      , networks : Optional Networks
      , pid : Optional Text
      , ports : Optional Ports
      , privileged : Optional Bool
      , read_only : Optional Bool
      , restart : Optional Text
      , security_opt : Optional (List Text)
      , shm_size : Optional StringOrNumber
      , sysctls : Optional ListOrDict
      , stdin_open : Optional Bool
      , stop_grace_period : Optional Text
      , stop_signal : Optional Text
      , tmpfs : Optional StringOrList
      , tty : Optional Bool
      , ulimits : Optional (Map Text Ulimits)
      , user : Optional Text
      , userns_mode : Optional Text
      , volumes : Optional (List Text)
      , working_dir : Optional Text
      }

let DriverOpts
    : Type
    = Map Text StringOrNumber

let Ipam
    : Type
    = { driver : Text, config : List { subnet : Text } }

let External
    : Type
    = < Bool : Bool | Object : { name : Text } >

let Volume
    : Type
    = { driver : Optional Text
      , driver_opts : Optional DriverOpts
      , ipam : Optional Ipam
      , external : Optional External
      }

let Volumes
    : Type
    = Map Text (Optional Volume)

let Services
    : Type
    = Map Text Service

let TopLevelVolume = Volume

let TopLevelVolumes
    : Type
    = Map Text (Optional TopLevelVolume)

let TopLevelNetwork
    : Type
    = {}

let TopLevelNetworks
    : Type
    = Map Text (Optional TopLevelNetwork)

let ComposeConfig
    : Type
    = { version : Text
      , services : Optional Services
      , networks : Optional TopLevelNetworks
      , volumes : Optional TopLevelVolumes
      }

in  { ComposeConfig
    , Services
    , Service
    , StringOrNumber
    , Deploy
    , Build,BuildArgs
    , StringOrList
    , ListOrDict
    , Healthcheck
    , Labels
    , Logging
    , Networks
    , Ulimits
    , Volumes
    , Volume,Environment
    , Options,DependsOn,Ports
    , DriverOpts
    , Ipam
    , External,TopLevelNetwork,TopLevelNetworks,TopLevelVolumes
    }
