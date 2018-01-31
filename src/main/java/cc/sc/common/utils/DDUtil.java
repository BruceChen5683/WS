package cc.sc.common.utils;

import java.util.Date;

import org.activiti.engine.impl.util.json.JSONObject;

public class DDUtil {
	private static String DDCorpId = "ding3c00d7cc2059e140";
	private static String DDCorpSecre = "Rdfo0QbhdfGgEFjiiaHtAEySm4xNB6i0uASG2D--bxXvAMBQqemGmxXpI0ZCCjS9";
	private static String DDACCESSTOKEN = null;
	private static long DDEXPTIME = new Date().getTime();
	private static String WXACCESSTOKEN = null;
	private static long WXEXPTIME = new Date().getTime();

	public static String getAccessToken(int type) {
		long nowDate = new Date().getTime();
		String access_token = "";
		if (type == 0) {
			if (DDACCESSTOKEN == null || DDEXPTIME < nowDate) {
				String url = "https://oapi.dingtalk.com/gettoken?corpid=" + DDCorpId + "&corpsecret=" + DDCorpSecre;
				JSONObject jObject = HttpRequestUtils.httpGet(url);
				DDACCESSTOKEN = jObject.getString("access_token");
				DDEXPTIME = new Date().getTime() + 7200;
			}
			access_token = DDACCESSTOKEN;
		} else {
			if (WXACCESSTOKEN == null || WXEXPTIME < nowDate) {
				String url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=wxc24ec838f227d48c&corpsecret=PRXuniTBQPuaLVBxdm-9_K9CEBiNZycU90QDdVVJ6gh6PJdvPLj4_L88QTsVu4zO";
				JSONObject jObject = HttpRequestUtils.httpGet(url);
				WXACCESSTOKEN = jObject.getString("access_token");
				WXEXPTIME = new Date().getTime() + 7200;
			}
			access_token = WXACCESSTOKEN;
		}
		return access_token;
	}

	public static void sendMessage(JSONObject param) {
		String url = "https://oapi.dingtalk.com/message/send?access_token=" + getAccessToken(0);
		JSONObject res = HttpRequestUtils.httpPost(url, param);
		System.out.println(res.toString());
	}

}
