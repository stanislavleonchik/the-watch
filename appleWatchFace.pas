uses graphWPF, WPFObjects;

var ClockWidth := window.Height / 3;
var ungle := PI * 2 / 120;
var (w,h) := (window.Width / 2, window.Height / 2);
var HourArrow : lineWPF := nil;
var MinuteArrow : lineWPF := nil;
var SecondArrow : lineWPF := nil;


procedure watchFaceCreate;
begin 
  SetStandardCoords(1.0,window.width / 2, window.Height / 2);
//  circle(0, 0, window.height / 3);
  var counter := 0;
  var a := 0.0;
  while a <= PI + 0.1 do begin
    if counter mod 5 = 0  then pen.Width := 5 else pen.Width := 1;
    line(window.height / 3 * cos(a), window.height * sin(a) / 3, -window.height * cos(a) / 3, -window.height * sin(a) / 3);
    a += ungle;
    counter += 1;
  end;
  pen.Width := 0;
  circle(0, 0, window.height / 3.1);
end;

procedure initArrows;
begin
  SecondArrow := new lineWPF(w,h,w,h,rgb(229, 76, 60));
  SecondArrow.SetLineWidth(1);
  MinuteArrow := new lineWPF(w,h,w,h,rgb(random(256), random(256), random(256)));
  MinuteArrow.SetLineWidth(3);
  HourArrow := new lineWPF(w,h,w,h,rgb(random(256), random(256), random(256)));
  HourArrow.SetLineWidth(5);
end;

procedure moveArrows;
begin
  var tempUngle := PI*2 / 60;
  var tempHourUngle := PI*2 / 12;
  while true do begin
    var ct := System.DateTime.Now;
    var secondUngle := -PI / 2 + tempUngle * ct.second + (PI * 2 / 1000 / 60) * ct.Millisecond;
    var minuteUngle := -PI / 2 + tempUngle * ct.minute + (secondUngle + PI / 2) / 60;
    var hourUngle   := -PI / 2 + tempHourUngle * ct.hour + (minuteUngle + PI / 2) / 12;
    
    
    HourArrow.x2   := w + ClockWidth / 2 * cos(hourUngle);     HourArrow.y2 := h + ClockWidth / 2 * sin(hourUngle);
    MinuteArrow.x2 := w + ClockWidth / 3 * 2 * cos(minuteUngle); MinuteArrow.y2 := h + ClockWidth / 3 * 2 * sin(minuteUngle);
    SecondArrow.x2 := w + ClockWidth * cos(secondUngle); SecondArrow.y2 := h + ClockWidth * sin(secondUngle);
  end;
end;


begin
  watchFaceCreate;
  initArrows;
  moveArrows
end.