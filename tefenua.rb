#
# def coords_to_tiles(lat_deg,lon_deg, zoom)
#   puts "#{lat_deg},#{lon_deg}, #{zoom}"
#   lat_rad = lat_deg * Math::PI / 180
#   n       = 2 ** zoom
#
#   xtile = n * ((lon_deg + 180) / 360)
#   ytile = (1.0 - Math.log(Math.tan(lat_rad) + (1.0 / Math.cos(lat_rad))) / Math::PI).to_i / (2.0 * n)
#
#   puts xtile
#   puts ytile
#
# end

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
last = coords_to_tiles(lat2, long2, zoom)

puts "#{zoom} #{first[:x]} #{first[:y]} #{last[:x]} #{last[:y]} #{zoom}"

# n = 2 ^ zoom
# xtile = n * ((lon_deg + 180) / 360)
# ytile = n * (1 - (log(tan(lat_rad) + sec(lat_rad)) / π)) / 2
#
#
# n = 2 ^ zoom
# lon_deg = xtile / n * 360.0 - 180.0
# lat_rad = arctan(sinh(π * (1 - 2 * ytile / n)))
# lat_deg = lat_rad * 180.0 / π