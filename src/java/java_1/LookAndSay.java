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
            int length = 1;
            char head = s.charAt(0);
            String result = "";
            for (int i = 1; i < s.length(); i++) {
                if (s.charAt(i) == head) {
                    length++;
                } else {
                    result += length;
                    result += head;
                    length = 1;
                    head = s.charAt(i);
                }
            }
            result += length;
            result += head;
            return result;
    }
}
