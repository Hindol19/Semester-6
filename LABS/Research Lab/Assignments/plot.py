import numpy as np
import matplotlib.pyplot as plt

# Define the range for the input size n
n = np.linspace(1, 20, 400)  # 400 points between 1 and 20

# Define the time complexity functions
O_1 = np.ones_like(n)
O_log_n = np.log(n)
O_n = n
O_n_log_n = n * np.log(n)
O_n_squared = n ** 2
O_2_n = 2 ** n
O_factorial = np.array([np.math.factorial(int(i)) for i in n])

# Plot the functions
plt.figure(figsize=(10, 8))

plt.plot(n, O_1, label='$O(1)$', color='blue')
plt.plot(n, O_log_n, label='$O(\log n)$', color='orange')
plt.plot(n, O_n, label='$O(n)$', color='green')
plt.plot(n, O_n_log_n, label='$O(n \log n)$', color='red')
plt.plot(n, O_n_squared, label='$O(n^2)$', color='purple')
plt.plot(n, O_2_n, label='$O(2^n)$', color='brown')
plt.plot(n, O_factorial, label='$O(n!)$', color='pink')

# Set the scale of the y-axis to logarithmic to better visualize large values
plt.yscale('log')

# Adding labels and title
plt.xlabel('Input size (n)')
plt.ylabel('Time Complexity')
plt.title('Comparison of Time Complexities')
plt.legend()
plt.grid(True)

# Display the plot
plt.show()
