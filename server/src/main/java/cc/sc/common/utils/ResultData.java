package cc.sc.common.utils;

/**
 * 手机端返回结果类
 */

public class ResultData {
    private int errcode;
    private Object data;
    private String errmsg;


    public ResultData() {

    }

    public ResultData(String errmsg) {
        errcode = -1;
        this.errmsg = errmsg;
    }

    public static ResultData getOKResultData(Object data) {
        ResultData resultData = new ResultData();
        resultData.errcode = 0;
        resultData.data = data;
        return resultData;
    }

    public static ResultData getERRResultData(Object data) {
        ResultData resultData = new ResultData();
        resultData.errcode = -1;
        resultData.data = data;
        return resultData;
    }

    public int getErrcode() {
        return errcode;
    }

    public void setErrcode(int errcode) {
        this.errcode = errcode;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getErrmsg() {
        return errmsg;
    }

    public void setErrmsg(String errmsg) {
        this.errmsg = errmsg;
    }

}
