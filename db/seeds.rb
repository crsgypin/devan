

taipei = City.find_or_create_by(:name=>"台北市")
xinpei = City.find_or_create_by(:name=>"新北市")
taoyuan = City.find_or_create_by(:name=>"桃園縣")
City.find_or_create_by(:name=>"新竹縣")
City.find_or_create_by(:name=>"新竹市")

taipei.districts.find_or_create_by(:name=>"大安區")
taipei.districts.find_or_create_by(:name=>"松山區")
taipei.districts.find_or_create_by(:name=>"士林區")
taipei.districts.find_or_create_by(:name=>"內湖區")
xinpei.districts.find_or_create_by(:name=>"板橋區")
xinpei.districts.find_or_create_by(:name=>"土城區")
xinpei.districts.find_or_create_by(:name=>"中和區")
xinpei.districts.find_or_create_by(:name=>"永和區")
taoyuan.districts.find_or_create_by(:name=>"中壢市")
taoyuan.districts.find_or_create_by(:name=>"平鎮市")
taoyuan.districts.find_or_create_by(:name=>"桃園市")


doz = Manufacturer.find_or_create_by(:name=>"豆之味")
daw = Manufacturer.find_or_create_by(:name=>"大蕓")
