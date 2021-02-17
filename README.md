# ClockApp
ClockApp contains analog view of watch. It is an iOS app which is developed by SwiftUl and also conform MVVM architecture

<image src="Images/ClockApp-Scene1.png" width=200> <image src="Images/ClockApp-Scene2.png" width=200> <image src="Images/ClockApp-Scene3.png" width=200>

## Features
- Set Alarm 
- Use Stopwatch 
- View Current Time 


<img src="/Images/AlarmView.gif" width="200"  /> - <img src="/Images/StopwatchView.gif" width="200"  /> - <img src="/Images/TimeView.gif" width="200"  />

## Tech
- SwiftUI
- Swift 5.0
- MVVM architecture
## Components
| File | Description |
| ------ | ------ |
| TickShape | Generate tick in the circumference|
| ClockView | Design the analog clock view |
| NeedleView | Generate needle for minute, hour, second|
| NumberView | Create circular number view |
| CheckBoxView | Make selectable checkbox |
| ActionButtonStyle | Circular button style |
| RoundRectangleButtonStyle | RoundRectangle button style |

## Critical Logics
Selecting any point on clock changing time is done with creating hidden niddle

```sh
@ViewBuilder func getSelectableView(width: CGFloat, height: CGFloat) -> some View {
        ForEach(0..<360){ index in
            NeedleView(width: width, height: height, color: Color.backgroundColor.opacity(0.001), bottomLineHeight: 30)
                .rotationEffect(.degrees(Double(index)))
                .onTapGesture {
                    updateNeedlePosition(position: index)
                }
        }
    }
```
## Motivation and Credit
- The design and stopwatch logic is motivated from [StepByStep Learning - iOS Programming](https://www.youtube.com/watch?v=13BhbutmQdA&list=PLFK9eRgQ_3FYZ4JDsHcQWBVndFNbdO1JW) Youtube Channel
- The time logic is inheritted from [Kavsoft](https://www.youtube.com/watch?v=BTtERko7j1Y) Youtube Channel

## License

MIT
