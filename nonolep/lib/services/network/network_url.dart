class NetworkUrl{
  static const baseURL = "http://192.168.1.5:8090/";

  static List<String> excludedPath = [
    user(UserEndpoint.register),
    user(UserEndpoint.login),
  ];

  static String user(UserEndpoint userEndpoint){
    switch(userEndpoint){
      case UserEndpoint.register:
        return "register";
      case UserEndpoint.login:
        return "login";
      case UserEndpoint.updateUser:
        return "auth/user";
      case UserEndpoint.getUser:
        return "auth/user";
    }
  }
}

enum UserEndpoint{
  register,
  login,
  updateUser,
  getUser
}