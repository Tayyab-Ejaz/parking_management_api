
WorkingHour.delete_all
Reservation.delete_all
CarType.delete_all
ParkingSlot.destroy_all
User.delete_all

User.create(name: 'Test 1', email: 'test_1@gmail.com', password: '12345678')
User.create(name: 'Admin 1', email: 'admin@gmail.com', password: '12345678', role: User.roles[:admin])

# Seed car types
suv = CarType.create(name: 'SUV')
sedan = CarType.create(name: 'Sedan')
van = CarType.create(name: 'Van')
bus = CarType.create(name: 'Bus')

ParkingSlot.create!(
  description: 'Slot A',
  for_disabled_only: true,
  has_shade: true,
  is_available: true,
  price_per_hour: 15.0,
  availability_time_start: '1970-01-01 00:00:00',
  availability_time_end: '1970-01-01 23:59:00',
  car_types: [suv, sedan] 
)

ParkingSlot.create!(
  description: 'Slot B',
  for_disabled_only: false,
  has_shade: false,
  is_available: true,
  price_per_hour: 10.0,
  availability_time_start: '1970-01-01 00:00:00',
  availability_time_end: '1970-01-01 23:59:00',
  car_types: [sedan, van] 
)

ParkingSlot.create!(
  description: 'Slot C',
  for_disabled_only: true,
  has_shade: false,
  is_available: true,
  price_per_hour: 20.0,
  availability_time_start: '1970-01-01 00:00:00',
  availability_time_end: '1970-01-01 23:59:00',
  car_types: [van, bus]  
)

ParkingSlot.create!(
  description: 'Slot D',
  for_disabled_only: false,
  has_shade: true,
  is_available: true,
  price_per_hour: 12.5,
  availability_time_start: '1970-01-01 00:00:00',
  availability_time_end: '1970-01-01 23:59:00',
  car_types: [suv, van]  
)

ParkingSlot.create!(
  description: 'Slot E',
  for_disabled_only: true,
  has_shade: true,
  is_available: true,
  price_per_hour: 18.0,
  availability_time_start: '1970-01-01 07:00:00',
  availability_time_end: '1970-01-01 19:59:00',
  car_types: [bus, sedan] 
)

ParkingSlot.create!(
  description: 'Slot F',
  for_disabled_only: false,
  has_shade: true,
  is_available: true,
  price_per_hour: 18.0,
  availability_time_start: '1970-01-01 07:00:00',
  availability_time_end: '1970-01-01 19:59:00',
  car_types: [van, suv] 
)

ParkingSlot.create!(
  description: 'Slot G',
  for_disabled_only: false,
  has_shade: true,
  is_available: true,
  price_per_hour: 18.0,
  availability_time_start: '1970-01-01 07:00:00',
  availability_time_end: '1970-01-01 19:59:00',
  car_types: [van, suv, bus, sedan] 
)


ParkingSlot.create!(
  description: 'Slot H',
  for_disabled_only: false,
  has_shade: true,
  is_available: true,
  price_per_hour: 20.0,
  availability_time_start: '1970-01-01 07:00:00',
  availability_time_end: '1970-01-01 19:59:00',
  car_types: [van, suv, bus, sedan] 
)

ParkingSlot.create!(
  description: 'Slot I',
  for_disabled_only: false,
  has_shade: true,
  is_available: true,
  price_per_hour: 10.0,
  availability_time_start: '1970-01-01 07:00:00',
  availability_time_end: '1970-01-01 19:59:00',
  car_types: [van, suv] 
)


ParkingSlot.create!(
  description: 'Slot J',
  for_disabled_only: false,
  has_shade: true,
  is_available: true,
  price_per_hour: 5,
  availability_time_start: '1970-01-01 07:00:00',
  availability_time_end: '1970-01-01 19:59:00',
  car_types: [van] 
)

ParkingSlot.create!(
  description: 'Slot K',
  for_disabled_only: false,
  has_shade: true,
  is_available: true,
  price_per_hour: 1,
  availability_time_start: '1970-01-01 07:00:00',
  availability_time_end: '1970-01-01 19:59:00',
  car_types: [bus] 
)

ParkingSlot.create!(
  description: 'Slot L',
  for_disabled_only: false,
  has_shade: true,
  is_available: true,
  price_per_hour: 30,
  availability_time_start: '1970-01-01 07:00:00',
  availability_time_end: '1970-01-01 19:59:00',
  car_types: [van, sedan] 
)



puts "Seeded #{ParkingSlot.count} parking slots with car types."
