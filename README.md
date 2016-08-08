# Node Red Contrib: Flick Electric Price
A Node-Red node that emits the current flick electric price.

## Motivation
At home we use Flick Electric as our power company. Unlike most electricity resellers in New Zealand, they bill you at the current spot price. Usually this is very good; overnight you can pay just cents per kilowatt hour. However at during peak times the price may be 3 or 4 times the usual price.

The Flick mobile app is able to report the current realtime price to you, so obviously there is an API involved somewhere. Some quick snooping with mitmproxy soon revealed that there was a nicely thought out web API just waiting for me to talk to.

Using the API, I am able to query the current market rate and act accordingly. For example:
* By multiplying the current spot price by my current power consumption, I can measure my power usage in "dollar-hours"; i.e. how many dollars it would cost me if I kept consuming power at the current rate.
* By cross referencing with a thermometer, then during Winter I can turn my heatpump on once the night time price kicks in, and turn it off again as soon as the morning power usage spikes. (11PM till 6AM).

## Usage
1. Set up the node with your email address and password.
2. Feed an input into the node to trigger fetching the price. I suggest using an "Inject" node with a 15 minute repeat.
3. The output is in dollars.

## Notes
The FlickElectric price only changes once every 15 minutes; there is no point fetching it any more often than that.
