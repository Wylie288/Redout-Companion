package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;
//import android.util.Log;
import java.lang.String;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class regex
{
	static Pattern reg=Pattern.compile(".*");
	static Matcher str;
	static String input;
	static String key;

	public double setInput(String inp)
	{
		try
		{
			input=inp;
			return 1;
		}
		catch (Exception e)
		{
			return 0;
		}
	}

	public double setExpression(String exp)
	{
		try
		{
			reg=Pattern.compile(exp);
			key=exp;
			return 1;
		}
		catch (Exception e)
		{
			reg=Pattern.compile(".*");
			return 0;
		}
	}

	public double search()
	{
		try
		{
			reg=Pattern.compile(key);
			str=reg.matcher(input);
			if (str.find())
				return 1;
			return 0;
		}
		catch (Exception e)
		{
			return 0;
		}
	}

	public double match()
	{
		try
		{
			reg=Pattern.compile("^"+key+"$");
			str=reg.matcher(input);
			if (str.find())
				return 1;
			return 0;
		}
		catch (Exception e)
		{
			return 0;
		}
	}

	public String replace(String newstr)
	{
		try
		{
			return input.replaceFirst(key, newstr);
		}
		catch (Exception e)
		{
			return newstr;
		}
	}

	public double keyCount()
	{
		return (double) str.groupCount()+1;
	}
	public String getKey(double key)
	{
		try
		{
			return str.group((int) key);
		}
		catch (Exception e)
		{
			return "";
		}
	}
}
