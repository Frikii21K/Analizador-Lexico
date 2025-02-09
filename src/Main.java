import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Main {
    public static void main(String[] args) {
        // Establecer el Look and Feel Nimbus para un aspecto moderno
        try {
            for (UIManager.LookAndFeelInfo info : UIManager.getInstalledLookAndFeels()){
                if ("Nimbus".equals(info.getName())){
                    UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (Exception e) {
            System.out.println("No se pudo establecer Nimbus, se utilizará el Look and Feel por defecto.");
        }

        SwingUtilities.invokeLater(() -> createAndShowGUI());
    }

    private static void createAndShowGUI() {
        // Crear la ventana principal
        JFrame frame = new JFrame("Analizador Léxico");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        frame.setLocationRelativeTo(null); // Centrar la ventana

        // Panel principal con márgenes
        JPanel panel = new JPanel(new BorderLayout());
        panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        // Panel superior (barra de herramientas) para el botón "Analizar"
        JPanel toolbar = new JPanel(new FlowLayout(FlowLayout.RIGHT));
        JButton analyzeButton = new JButton("Analizar");
        toolbar.add(analyzeButton);
        panel.add(toolbar, BorderLayout.NORTH);

        // Área de texto para el código de entrada
        JTextArea inputArea = new JTextArea();
        inputArea.setFont(new Font("Consolas", Font.PLAIN, 14));
        JScrollPane inputScroll = new JScrollPane(inputArea);
        inputScroll.setBorder(BorderFactory.createTitledBorder("Código de Entrada"));

        // Área de texto para mostrar los resultados
        JTextArea outputArea = new JTextArea();
        outputArea.setFont(new Font("Consolas", Font.PLAIN, 14));
        outputArea.setEditable(false);
        JScrollPane outputScroll = new JScrollPane(outputArea);
        outputScroll.setBorder(BorderFactory.createTitledBorder("Resultados"));

        // Utilizar JSplitPane para dividir el área de entrada y la de resultados
        JSplitPane splitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, inputScroll, outputScroll);
        splitPane.setDividerLocation(300);
        splitPane.setResizeWeight(0.5);
        splitPane.setContinuousLayout(true);
        panel.add(splitPane, BorderLayout.CENTER);

        // Invoca al analizador léxico
        analyzeButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String code = inputArea.getText();
                Lexer lexer = new Lexer(new java.io.StringReader(code));
                String result = "";
                try {
                    result = lexer.tokenize();
                } catch(Exception ex) {
                    result = "Error: " + ex.getMessage();
                }
                outputArea.setText(result);
            }
        });

        frame.getContentPane().add(panel);
        frame.setVisible(true);
    }
}
