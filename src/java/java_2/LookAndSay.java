import java.util.function.Function;
import java.util.regex.MatchResult;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class LookAndSay {
    public static void main(String... args) {
        System.out.println(ant(10));
    }

    public static String ant(int n) {
        String s = "1";
        for (int line = 0; line < 10; line++) {
            s = next(s);
        }
        return s;
    }

    public static String next(String s) {
        return replace(s, "(.)\\1*", m -> m.group().length() + m.group(1));
    }

    public static String replace(
            String s,
            String regex,
            Function<MatchResult, String> fn) {
        StringBuffer sb = new StringBuffer();
        Matcher m = Pattern.compile(regex).matcher(s);
        while (m.find()) {
            m.appendReplacement(sb, fn.apply(m));
        }
        m.appendTail(sb);
        return sb.toString();
    }
}
