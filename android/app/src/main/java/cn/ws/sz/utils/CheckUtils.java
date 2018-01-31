package cn.ws.sz.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.widget.Toast;

public class CheckUtils {
	
/*	中国移动：134、135、136、137、138、139、150、151、152、157(TD)、158、159、182、183、184、187、178、188、147（数据卡号段） 、1705（虚拟运营商移动号段）

	中国联通：130、131、132、145(数据卡号段)155、156、176、185、186、1709（虚拟运营商联通号段）

	中国电信：133、153、177、180、181、189、（1349卫通）、1700（虚拟运营商电信号段）*/

	// 验证手机号格式
	public static boolean isMobile(String mobiles) {
		Pattern p = Pattern
				.compile("^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$");
		Matcher m = p.matcher(mobiles);

		return m.matches();
	}

	// 验证邮箱格式
	public static boolean isEmail(String email) {
		String str = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
		Pattern p = Pattern.compile(str);
		Matcher m = p.matcher(email);

		return m.matches();
	}

	public static boolean checkNetwork(Context conrtext) {
		ConnectivityManager connManager = (ConnectivityManager) conrtext.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo info = connManager.getActiveNetworkInfo();
		if (info == null || !info.isAvailable()) {
			Toast.makeText(conrtext.getApplicationContext(), "网络未连接", Toast.LENGTH_SHORT).show();
			return false;
		}
		return true;
	}

	public static boolean checkSDCard(Context conrtext) {
		if (android.os.Environment.getExternalStorageState().equals(
				android.os.Environment.MEDIA_MOUNTED)) {
			return true;
		} else {
			Toast.makeText(conrtext.getApplicationContext(), "SD卡不存在", Toast.LENGTH_SHORT).show();
			return false;
		}
	}


	public static boolean checkIdcard(String value) {
		int length = 0;
		if (value == null) {
			return false;
		} else {
			length = value.length();


			if (length != 15) {
			} else if (length != 18) {
			} else {
				return false;
			}
		}

		//不判断城市
// String[] areasArray = { "11", "12", "13", "14", "15", "21", "22", "23", "31",
//               "32", "33", "34", "35", "36", "37", "41", "42", "43", "44",
//               "45", "46", "50", "51", "52", "53", "54", "61", "62", "63",
//               "64", "65", "71", "81", "82", "91" };
//
//
// HashSet < String > areasSet = new HashSet < String > (Arrays.asList(areasArray));
// String valueStart2 = value.substring(0, 2);
//
//
// if (areasSet.contains(valueStart2)) {} else {
//   return false;
// }

		Pattern pattern = null;
		Matcher matcher = null;


		int year = 0;
		switch (length) {
			case 15:
				year = Integer.parseInt(value.substring(6, 8)) + 1900;


				if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
					pattern = Pattern.compile("^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"); // 测试出生日期的合法性
				} else {
					pattern = Pattern.compile("^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"); // 测试出生日期的合法性
				}
				matcher = pattern.matcher(value);
				if (matcher.find()) {
					return true;
				} else {
					return false;
				}
			case 18:
				year = Integer.parseInt(value.substring(6, 10));


				if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
					pattern = Pattern.compile("^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"); // 测试出生日期的合法性
				} else {
					pattern = Pattern.compile("^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"); // 测试出生日期的合法性
				}


				matcher = pattern.matcher(value);
				if (matcher.find()) {
					int S = (Integer.parseInt(value.substring(0, 1)) + Integer.parseInt(value.substring(10, 11))) * 7 + (Integer.parseInt(value.substring(1, 2)) + Integer.parseInt(value.substring(11, 12))) * 9 + (Integer.parseInt(value.substring(2, 3)) + Integer.parseInt(value.substring(12, 13))) * 10 + (Integer.parseInt(value.substring(3, 4)) + Integer.parseInt(value.substring(13, 14))) * 5 + (Integer.parseInt(value.substring(4, 5)) + Integer.parseInt(value.substring(14, 15))) * 8 + (Integer.parseInt(value.substring(5, 6)) + Integer.parseInt(value.substring(15, 16))) * 4 + (Integer.parseInt(value.substring(6, 7)) + Integer.parseInt(value.substring(16, 17))) * 2 + Integer.parseInt(value.substring(7, 8)) * 1 + Integer.parseInt(value.substring(8, 9)) * 6 + Integer.parseInt(value.substring(9, 10)) * 3;
					int Y = S % 11;
					String M = "F";
					String JYM = "10X98765432";
					M = JYM.substring(Y, Y + 1); // 判断校验位
					if (M.equals(value.substring(17, 18))) {
						return true; // 检测ID的校验位
					} else {
						return false;
					}
				} else {
					return false;
				}
			default:
				return false;
		}
	}


}
