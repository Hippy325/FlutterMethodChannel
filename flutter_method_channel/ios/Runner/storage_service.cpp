#include <fstream>
#include <sstream>
#include <string>
#include <cstring>

extern "C" {
    const char* read_file(const char* path) {
        std::ifstream file(path);
        std::stringstream buffer;
        buffer << file.rdbuf();
        std::string content = buffer.str();
        char* result = (char*)malloc(content.size() + 1);
        strcpy(result, content.c_str());
        return result;
    }

    const char* write_string(const char* path, const char* text) {
        std::ofstream file(path, std::ios_base::app);
        file << text << "\n";
        file.close();
        return read_file(path);
    }
}
