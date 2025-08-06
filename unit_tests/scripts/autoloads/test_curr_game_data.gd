extends GutTest

func test_format_time():
    # Test cases from original request
    assert_eq(CurrGameData.format_time(10.0), "10s", "10 seconds")
    assert_eq(CurrGameData.format_time(60.0), "1m", "1 minute")
    assert_eq(CurrGameData.format_time(71.0), "1m11s", "1 minute 11 seconds")
    assert_eq(CurrGameData.format_time(3600.0), "1h", "1 hour exactly")
    assert_eq(CurrGameData.format_time(3601.0), "1h1s", "1 hour 1 second")
    
    # Additional test cases
    assert_eq(CurrGameData.format_time(0.0), "0s", "Zero seconds")
    assert_eq(CurrGameData.format_time(0.999), "1s", "Rounding up")
    assert_eq(CurrGameData.format_time(59.0), "59s", "Just under 1 minute")
    assert_eq(CurrGameData.format_time(3600.0), "1h", "Exactly 1 hour")
    assert_eq(CurrGameData.format_time(3660.0), "1h1m", "1 hour 1 minute")
    assert_eq(CurrGameData.format_time(3661.0), "1h1m1s", "1 hour 1 minute 1 second")
    assert_eq(CurrGameData.format_time(7200.0), "2h", "Exactly 2 hours")
    assert_eq(CurrGameData.format_time(7261.0), "2h1m1s", "2 hours 1 minute 1 second")
    assert_eq(CurrGameData.format_time(3599.0), "59m59s", "Just under 1 hour")
    assert_eq(CurrGameData.format_time(86400.0), "24h", "Exactly 1 day")
    assert_eq(CurrGameData.format_time(90061.0), "25h1m1s", "25 hours 1 minute 1 second")
    assert_eq(CurrGameData.format_time(123.456), "2m3s", "Floating point input")