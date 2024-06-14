import csv

def write_strings_to_csv(file_path, string_list):
    """
    Writes a list of strings to a CSV file as a single row.

    :param file_path: str, the path to the file where the strings will be written as a CSV row
    :param string_list: list of str, the strings to write to the CSV file
    """
    # Open the file at the given path in write mode (this will overwrite existing files)
    with open(file_path, mode='w', newline='') as file:
        # Create a CSV writer object
        writer = csv.writer(file)
        # Write the list of strings as a single row to the CSV file
        writer.writerow(string_list)

# Example usage:
strings = ['Hello', 'World', 'This is a test']
file_path = 'output.csv'
write_strings_to_csv(file_path, strings)

