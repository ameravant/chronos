unless $LOADED_FEATURES.include?('bacon_helper.rb')
	load(File.expand_path("#{__FILE__}/../../../../bacon_helper.rb"))
	$LOADED_FEATURES << 'bacon_helper.rb'
end

require 'time'
require 'date'
require 'chronos/datetime/gregorian'

GDT = Chronos::Datetime::Gregorian

describe 'Chronos::Datetime::Gregorian' do
	describe 'creating valid dates' do
		it 'should be able to create a civil date' do
			proc {
				GDT.civil(2008, 10, 20)
			}.should.not.raise
		end

		it 'should be able to create an ordinal date' do
			proc {
				GDT.ordinal(2008, 200)
			}.should.not.raise
		end

		it 'should be able to create a commercial date' do
			proc {
				GDT.commercial(2008, 5, 11)
			}.should.not.raise
		end

		it 'should be able to create a civil date with time'
		it 'should be able to create an ordinal date with time'
		it 'should be able to create a commercial date with time'

		describe '::iso_8601' do
			it 'Should parse YYYY-MM-DD>T<HH:MM:SS±HH:SS correctly' do
				result = nil
				proc {
					result = GDT.iso_8601('2001-12-31T09:41:29+02:00')
				}.should.not.raise
				result.year.should.equal 2001
				result.month.should.equal 12
				result.day_of_month.should.equal 31
				result.hour.should.equal 9
				result.minute.should.equal 41
				result.second.should.equal 29
				result.offset.seconds.should.equal 7200
			end
		end
	end
	
	describe 'creating invalid dates' do
		it 'should raise with an invalid month'
		it 'should raise with an invalid day of month'
		it 'should raise with an invalid week'
		it 'should raise with an invalid day of week'
		it 'should raise with an invalid day of year'
		it 'should raise with a non integral value for year'
		it 'should raise with a non integral value for month'
		it 'should raise with a non integral value for week'
		it 'should raise with a non integral value for day of year'
		it 'should raise with a non integral value for day of month'
		it 'should raise with a non integral value for day of week'
	end
	
	describe 'a created datetimes attributes' do
		it 'should have a year attribute, returning an Integer'
		it 'should have a month attribute, returning an Integer'
		it 'should have a week attribute, returning an Integer'
		it 'should have a day (day of month) attribute, returning an Integer'
		it 'should have a day_of_year attribute, returning an Integer'
		it 'should have a day_of_month attribute, returning an Integer'
		it 'should have a day_of_week attribute, returning an Integer'
		it 'should have an hour attribute, returning an Integer'
		it 'should have a minute attribute, returning an Integer'
		it 'should have a second attribute, returning an Integer'
		it 'should have a millisecond attribute, returning an Integer'
		it 'should have a microsecond attribute, returning an Integer'
		it 'should have a nanosecond attribute, returning an Integer'
		it 'should have a picosecond attribute, returning an Integer'
		it 'should have a month_name attribute, returning a String'
		it 'should have a day_name attribute, returning a String'
		it 'should have an offset attribute, returning a Duration::Gregorian'
	end
	
	describe 'format' do
		it 'should format localized month-names with %%A'
		it 'should format localized day-names %%B'
		it 'should format 4-digit years with %%4y and %%y'
		it 'should format 2-digit years with %%2y'
		it 'should format months with %%m'
		it 'should format day of month with %%d'
		it 'should format week (iso 8601) with %%w'
		it 'should format day of week with %%'
		it 'should format 2-digit months zero padded with %%0m'
		it 'should format 2-digit months space padded with %%0m'
	end
	
	describe 'succeeding method' do
	end
	

=begin
	describe 'consistency in advanding, creation and values'
		describe 'should be consistent over a full cycle (402 years)' do
			it '???' do
				days				 = [nil, 31,28,31,30,31,30,31,31,30,31,30,31]
				init         = Chronos::Datetime::Gregorian.civil(1999,1,1)
				day_of_month = nil
				day_of_week  = init.day_of_week
				day_number	 = init.day_number
				1999.upto(2401) { |year| # test a bit more than 1 full cycle, luckily weekdays have a full cycle over 400 years too
					puts "year: #{year}" if year%100 == 0
					day_of_year = 1
					1.upto(12) { |month|
						ldim = days[month] + ((month == 2 && Chronos::Datetime::Gregorian.leap_year?(year)) ? 1 : 0)
						1.upto(ldim) { |day_of_month|
							date1 = Chronos::Datetime::Gregorian.civil(year, month, day_of_month)
							date2 = Chronos::Datetime::Gregorian.ordinal(year, day_of_year)
							date3 = Chronos::Datetime::Gregorian.commercial(date1.commercial_year, date1.week, day_of_week)
							date4 = Date.civil(year, month, day_of_month)
							
							# test if consistent with Time
							date4.year.should.be.equal(date1.year)
							date4.cwyear.should.be.equal(date1.commercial_year)
							date4.month.should.be.equal(date1.month)
							date4.strftime("%V").to_i.should.be.equal(date1.week)
							date4.yday.should.be.equal(date1.day_of_year)
							date4.day.should.be.equal(date1.day_of_month)
							((date4.wday+6)%7).should.be.equal(date1.day_of_week)
							
							# test if different constructors yield the same
							date1.should.be.equal(date2)
							date1.should.be.equal(date3)
							
							# test incremental integrity
							day_number.should.be.equal(date1.day_number)
							year.should.be.equal(date1.year)
							day_of_year.should.be.equal(date1.day_of_year)
							month.should.be.equal(date1.month)
							day_of_month.should.be.equal(date1.day_of_month)
							day_of_week.should.be.equal(date1.day_of_week)
		
							day_number	+= 1
							day_of_year += 1
							day_of_week	 = (day_of_week+1)%7
						}
						proc {
							Chronos::Datetime::Gregorian.civil(year, month, day_of_month+1)
						}.should.raise
					}
				}
			end
		end
	end # describe consistency
=end
end # describe Chronos::Datetime::Gregorian

__END__
class TestDatetime < Test::Unit::TestCase
	Dt = Chronos::Datetime

	def test_creation
		[
			[2006,12,31],
		].each { |(y,m,d)|
			dt = Dt.civil(y,m,d)
			assert_equal(y, dt.year)
			assert_equal(m, dt.month)
			assert_equal(d, dt.day_of_month)
		}
	end

	def test_leap
		assert Dt.leap?(2000)
		assert !(Dt.leap?(2001))
		assert (Dt.leap?(1996))
	end

	def test_today
		now   = Dt.now
		now2  = Time.now
		today = Dt.today
		assert now
		assert today
		assert_equal now.year, now2.year
		assert_equal now.month, now2.month
	end

	def test_ordinal
		now = Time.now
		data = Dt.today
		assert data
	end

	# brute force test of integrity of datetime object
	# simply tests for continuity of the constructor (day_number)
	def test_integrity
		days				 = [nil, 31,28,31,30,31,30,31,31,30,31,30,31]
		init         = Dt.civil(1999,1,1)
		day_of_month = nil
		day_of_week  = init.day_of_week
		day_number	 = init.day_number
		1999.upto(2401) { |year| # test a bit more than 1 full cycle, luckily weekdays have a full cycle over 400 years too
			puts "year: #{year}" if year%100 == 0
			day_of_year = 1
			1.upto(12) { |month|
				ldim = days[month] + ((month == 2 && Dt.leap?(year)) ? 1 : 0)
				1.upto(ldim) { |day_of_month|
					date1 = Dt.civil(year, month, day_of_month)
					date2 = Dt.ordinal(year, day_of_year)
					date3 = Dt.commercial(date1.commercial_year, date1.week, day_of_week)
					date4 = Date.civil(year, month, day_of_month)
					
					# test if consistent with Time
					assert_equal(date4.year, date1.year, "Time and Chronos::Datetime differ in year #{[year, month, day_of_month].inspect}")
					assert_equal(date4.cwyear, date1.commercial_year, "Time and Chronos::Datetime differ in cwyear #{[year, month, day_of_month].inspect}")
					assert_equal(date4.month, date1.month, "Time and Chronos::Datetime differ in month #{[year, month, day_of_month].inspect}")
					assert_equal(date4.strftime("%V").to_i, date1.week, "Time and Chronos::Datetime differ in week #{[year, month, day_of_month].inspect}")
					assert_equal(date4.yday, date1.day_of_year, "Time and Chronos::Datetime differ in day of year #{[year, month, day_of_month].inspect}")
					assert_equal(date4.day, date1.day_of_month, "Time and Chronos::Datetime differ in day of year #{[year, month, day_of_month].inspect}")
					assert_equal((date4.wday+6)%7, date1.day_of_week, "Time and Chronos::Datetime differ in day of year #{[year, month, day_of_month].inspect}")
					
					# test if different constructors yield the same
					assert_equal(date1, date2, "date constructed via civil and ordinal not the same #{[year, month, day_of_month].inspect}")
					assert_equal(date1, date3, "date constructed via civil and commercial not the same #{[year, month, day_of_month].inspect}")
					
					# test incremental integrity
					assert_equal(day_number, date1.day_number, "day number #{[year, month, day_of_month].inspect} #{date1.inspect}")
					assert_equal(year, date1.year, "year #{[year, month, day_of_month].inspect} #{date1.inspect}")
					assert_equal(day_of_year, date1.day_of_year, "day of year #{[year, month, day_of_month].inspect} #{date1.inspect}")
					assert_equal(month, date1.month, "month #{[year, month, day_of_month].inspect} #{date1.inspect}")
					assert_equal(day_of_month, date1.day_of_month, "day of month #{[year, month, day_of_month].inspect} #{date1.inspect}")
					assert_equal(day_of_week, date1.day_of_week, "day of week #{[year, month, day_of_month].inspect} #{date1.inspect}")

					day_number	+= 1
					day_of_year += 1
					day_of_week	 = (day_of_week+1)%7
				}
				assert_raise(ArgumentError) { Dt.civil(year, month, day_of_month+1) }
			}
		}
	end

	def test_day_of_week
		assert_equal(6, Dt.civil(1982,5,23).day_of_week)
		assert_equal(5, Dt.civil(2000,1,1).day_of_week)
		assert_equal(6, Dt.civil(2006,12,24).day_of_week)
	end
	
	def test_commercial
		assert_equal(2,Dt.commercial(2006,1,2).day_of_week)
		# if this fails our tests are broken
		#assert_equal 1,Dt.commercial(2006,1,2).day_of_month

		month = Dt.commercial(2006,1,2).month_and_day_of_month[0]
		assert_equal 1, month

		# this return value varies from ISO8601 standards,since 1st Jan 2006 was sunday, it would taken as 52/53 week of previous year
		# hence 2nd day of 1 st week, would be Tuesday not wednesday
		# correct me, if i am wrong
		#assert_equal 'Tuesday', Dt.commercial(2006,1,2).day_name
	end

	def test_time
		dt_time = Dt.time(10)
		assert dt_time
		assert_equal dt_time.second, 0
		assert_equal dt_time.usec, 0
		assert_equal dt_time.minute, 0
		assert_equal dt_time.hour, 10
		assert_raise(Chronos::NoDatePart) {dt_time.month}
	end

	def test_epoch
		dt_time = Dt.epoch(Time.at(0))
		assert dt_time
		# this depends upon, when you executed your test case
		assert_equal dt_time.year, 1970
		assert_equal dt_time.month, 1
		assert_equal dt_time.second, 0
	end

	def test_at_time
		dt_time = Dt.time(10)
		dt_time = dt_time.at(20)
		assert_equal dt_time.hour, 20
		assert_equal dt_time.timezone, nil
		assert_raise(Chronos::NoDatePart) { dt_time.month}
	end

	def test_date_and_time
		dt_time = Dt.now
		assert dt_time.month
		assert dt_time.second
		dt_date = dt_time.strip_time
		dt_only_time = dt_time.strip_date
		assert_raise(Chronos::NoTimePart) { dt_date.hour}
		assert_raise(Chronos::NoDatePart) { dt_only_time.month}
	end

	def test_succeeding
		dt_civil = Dt.civil(2000,3,31)
		assert_raise(ArgumentError) { dt_civil.succeeding(:month) }
		dt_civil = Dt.civil(2004,2,29)
		assert_raise(ArgumentError) { dt_civil.succeeding(:year) }
		# FIXME put some more special cases here
		dt_time = Dt.now
		dt_time_next = dt_time.succeeding(:hour)
		assert_equal (dt_time.hour+1), dt_time_next.hour
	end
end

