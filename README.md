Structure for all projects in Ommani using Riverpod and AutoRoute, alongside with GetIt to make life easier

## Features

Contains a structure for your project that is easy to follow and understand.

Fully support for `Mono Repositories` and `Clean Architecture`.

Help you simplify your work with more features on below.

| Supported features        | Description                                                                     |
|---------------------------|---------------------------------------------------------------------------------|
| `DIO`                     | Wrapper of `DIO` package, api creator with declarative syntax                   | 
| `JWT Authentication`      | Support retry request, save token                                               |
| `Logging`                 | Logging to console and internal app by shaking device                           |
| `Development Environment` | Support `dev`, `staging`, `prod` internally env by directly by `Env` instance   |
| `File`                    | Support upload file, image, video, load file by url                             |
| `Dependencies Injection`  | Simple DI system powered by `GetIt`                                             |
| `Push Notification`       | Predefined API for push notification                                            |
| `Firebase`                | Support `FirebaseCrashlytics`, `FirebaseAnalytics`, `Firebase PushNotification` |     
| `Navigation`              | Easily routes management and navigation with `AutoRoute`                        |                            
| `Localization`            | Powered by `Slang` package                                                      |
| `Theme`                   | Global theme with `GlobalThemeConfiguration`                                    |
| `Single Sign On`          | Fully supported                                                                 |

## Getting started

Add your package to `pubspec.yaml` file:

```yaml
dependencies:
  ommanisoft_mobile_framework:
    git: 
        url: ssh://git@gitlab.com/mobile-ommanisoft/common/ommanisoft_mobile_framework.git
        path: mobile_framework/
        ref: latest-tag-you-seen-in-gitlab
```

## Changelog

[See change log detail]()

## Maintainers

<table>
  <tr>
    <td align="center">
      <a href="https://gitlab.com/minhngock18">
        <img src="https://gitlab.com/uploads/-/system/user/avatar/4805493/avatar.png" width="100px;" alt="Contributor 1"/><br />
        <sub><b>Minh Pham</b></sub>
      </a>
    </td>
  </tr>
</table>


## Contributors

## License

`Ommani JSC 2023` - [License]()

