#include <iostream>
#include <fmt/core.h>
#include <uuid.h>
#include <random> // Include this header for std::mt19937

int main()
{
    // Define some ANSI escape codes for colors
    constexpr auto red = "\033[31m";
    constexpr auto green = "\033[32m";
    constexpr auto reset = "\033[0m";

    // Print colored output
    fmt::print("{}This text is red!{} {}\n", red, reset, "and this is green!");

    // Create a random number generator
    std::random_device rd;
    std::mt19937 rng(rd());

    // Create a UUID generator using the random number generator
    uuids::basic_uuid_random_generator<std::mt19937> uuid_gen(rng);

    // Generate a UUID
    uuids::uuid id = uuid_gen();

    // Print the UUID using fmt
    std::cout << "Generated uuid: " << id << std::endl;

    return 0;
}
