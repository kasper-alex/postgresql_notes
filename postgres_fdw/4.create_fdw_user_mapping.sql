--мапинг пользователя postgres для подключения к удаленному серверу
CREATE USER MAPPING FOR postgres SERVER <SERVER_NAME>
    OPTIONS ("user" '<USER>', password '<PASS>');