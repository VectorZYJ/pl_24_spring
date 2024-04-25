import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.lang.NumberFormatException;

public class FileAdder {
    public static int length = 0;

    public static int adder(String[] elements) {
        int total = 0;
        for (int i=0; i<length; i++) {
            try {
                int value = Integer.parseInt(elements[i]);
                total += value;
            } catch (NumberFormatException e) {
                System.out.println("Ignoring bad input: " + elements[i]);
            }
        }
        return total;
    }

    public static String[] readFile() {
        Scanner fileNameReader = new Scanner(System.in);
        System.out.println("Enter a file name:");
        String fileName = fileNameReader.nextLine();
        fileNameReader.close();

        String[] fileContents = new String[2000];
        try (Scanner fileReader = new Scanner(new File(fileName))) {
            while (fileReader.hasNextLine()) {
                fileContents[length] = fileReader.nextLine();
                length ++;
            }
        } catch (FileNotFoundException e) {
            System.out.println("Error -- File " + fileName + " not found");
        }
        return fileContents;
    }

    public static void main(String[] args) {
        String[] fileContents = FileAdder.readFile();
        int total = FileAdder.adder(fileContents);
        System.out.println("The total is " + total);
    }
}