While we plan to surface settings in the UI, at this time site-specific settings need to be added to your code. And that's where you `utilities/config.yml` file comes into play.

Adding Settings
----------------

The config file is of the [YAML](http://www.yaml.org/) file type, which has a strict indentation-based syntax.

The settings are broken up by the current environment, so you can use different settings if you need.

You should break your settings up as semantically as possible to keep it simple for you. You can use our [sapwood settings file](https://github.com/seancdavis/sapwood/blob/master/config/sapwood.sample.yml) as an example of how you might configure your settings file.

You should use this for values you may use throughout the site that you want to abstract into one location. One example is URLs for social sites. That way you don't have to dig through markup if one of your social URLs change.

Accessing Settings
----------------

The settings are available in a view through the `site_setting` method. Settings are loaded into a recursive set of `OpenStruct` objects.

Let's say you are in development and have this setting:

```yaml
development:
  social:
    facebook: https://www.facebook.com/I_Am_Awesome
```

You could get to the *https://www.facebook.com/I_Am_Awesome* value through `site_setting.social.facebook`.
