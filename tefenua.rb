def coords_to_tiles(lat_deg, lng_deg, zoom)
  # puts "#{lat_deg},#{lng_deg}, #{zoom}"
  lat_rad = lat_deg/180 * Math::PI
  n1 = 2.0 ** zoom
  n2 = 2.0 ** (zoom - 1)
  x = ((lng_deg + 180.0) / 360.0 * n1).to_i
  # y = ((1.0 - Math::log(Math::tan(lat_rad) + (1 / Math::cos(lat_rad))) / Math::PI) / 2.0 * n2).to_i

  num = Math::log(Math::tan(lat_rad) + (1 / Math::cos(lat_rad)))
  den = Math::PI

  y = ((1.0 -  num / den ) / 2.0 * n1).to_i
  # y = ((1.0 - ( Math::log(Math::tan(lat_rad) + (1 / Math::cos(lat_rad))) / Math::PI)) * n2).to_i
  
  {:x => x, :y =>y}
end

lat1  = ARGV[0].to_f
long1 = ARGV[1].to_f

lat2  = ARGV[2].to_f
long2 = ARGV[3].to_f

zoom  = ARGV[4].to_i

first = coords_to_tiles(lat1, long1, zoom)
last  = coords_to_tiles(lat2, long2, zoom)

value = %x( echo 'hi' )

cmd1 = "./dl-script #{zoom} #{first[:x]} #{last[:x]} #{first[:y]} #{last[:y]} #{zoom}"
cmd2 = "./combine   #{zoom} #{first[:x]} #{last[:x]} #{first[:y]} #{last[:y]}"

%x( rm **.jpg )
value1 = %x( #{cmd1} )
value2 = %x( #{cmd2} )
