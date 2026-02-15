#include <cstdint>
#include <iomanip>
#include <iostream>
#include <limits>
#include <string>
#include <vector>

struct WindowAnswer {
    bool ok;
    long long max_sum;
    std::size_t start_index;
    std::size_t end_index;
    std::string reason;
};

/*
Test-case block (before logic):
T0: arr={8,-3,4,2,-10,5,1}, k=3
    windows: [0]=9, [1]=3, [2]=-4, [3]=-3, [4]=-4, [5]=14, [6]=6
    expected: ok=1, max_sum=14, start=5, end=0
T1: arr={1,2,3,4,5}, k=5
    windows: [0]=15 only
    expected: ok=1, max_sum=15, start=0, end=4
T2: arr={-5,-2,-9,-1}, k=2
    windows: [0]=-7, [1]=-11, [2]=-10, [3]=-6
    expected: ok=1, max_sum=-6, start=3, end=0
T3: arr={1073741824,1073741824,-2,7}, k=2
    windows: [0]=2147483648, [1]=1073741822, [2]=5, [3]=1073741831
    expected: ok=1, max_sum=2147483648, start=0, end=1
T4: arr={9,8,7}, k=4
    expected: ok=0, reason=\"k_out_of_range\"
T5: arr={9,8,7}, k=0
    expected: ok=0, reason=\"k_out_of_range\"
*/

/*
Rare buggy orthogonal pattern (spot this while implementing):
std::abs(INT64_MIN) -> overflow because |INT64_MIN| cannot fit in int64.
INT64_MIN=-9223372036854775808; INT64_MAX=9223372036854775807; |min|=9223372036854775808 -> out of range.
*/

WindowAnswer max_circular_window_exact_k(const std::vector<long long>& arr,
                                         std::size_t k) {
    const std::size_t n = arr.size();

    // Real data precheck path:
    // n=7,k=3 -> valid
    // n=3,k=4 -> invalid
    // n=3,k=0 -> invalid
    if (n == 0 || k == 0 || k > n) {
        return {false, 0, 0, 0, "k_out_of_range"};
    }

    // TODO(core_logic_1):
    // middle-first numeric setup:
    // n=7,k=3 -> middle_start=n/2=3 -> window indices {3,4,5} -> sum=2+(-10)+5=-3
    // then outward starts: 2,4,1,5,0,6 (user computes by hand).
    //
    // Required containers with real sizes before use:
    // doubled length = 2*n; for n=7 -> 14
    // prefix length = 2*n+1; for n=7 -> 15; prefix[0]=0
    //
    // TODO(edge_cases):
    // 1) all negative values, keep largest (least negative) window
    // 2) k==n exactly one circular window
    // 3) tie handling rule: same sum -> smaller start index
    //
    // TODO(tricky_conditions):
    // 1) Use int64 path only; int32 overflows on T3:
    //    1073741824 + 1073741824 = 2147483648 > 2147483647
    // 2) end index wraps: end=(start+k-1)%n
    // 3) validate start range set = {0..n-1}, count=n
    //
    // TODO(clever_tricks):
    // 1) O(n) using sliding window over doubled array, window count=n
    // 2) optional prefix-sum formula: win(i)=pref[i+k]-pref[i]
    // 3) avoid modulo in hot path using doubled array indexing

    // Boilerplate return path so file compiles now.
    return {false, 0, 0, 0, "todo_not_implemented"};
}

static void print_case(const std::string& name, const std::vector<long long>& arr,
                       std::size_t k, const WindowAnswer& got,
                       const WindowAnswer& expected) {
    std::cout << "CASE " << name << "\n";
    std::cout << "  input n=" << arr.size() << " k=" << k << " arr=[";
    for (std::size_t i = 0; i < arr.size(); ++i) {
        std::cout << arr[i];
        if (i + 1 != arr.size()) {
            std::cout << ",";
        }
    }
    std::cout << "]\n";

    std::cout << "  got      ok=" << got.ok << " sum=" << got.max_sum
              << " start=" << got.start_index << " end=" << got.end_index
              << " reason=" << got.reason << "\n";
    std::cout << "  expected ok=" << expected.ok << " sum=" << expected.max_sum
              << " start=" << expected.start_index << " end=" << expected.end_index
              << " reason=" << expected.reason << "\n";

    // Order requested: tests in comments -> debate tests -> expected behavior -> evaluate outputs.
    // Debate/output check is explicit, no hidden assertion aborts:
    const bool same =
        (got.ok == expected.ok) &&
        (got.max_sum == expected.max_sum) &&
        (got.start_index == expected.start_index) &&
        (got.end_index == expected.end_index) &&
        (got.reason == expected.reason);
    std::cout << "  verdict=" << (same ? "MATCH" : "MISMATCH") << "\n\n";
}

int main() {
    // State transition demo:
    // tests.size: 0->1->2->3->4->5->6
    // index set after push: {0,1,2,3,4,5}
    struct TestCase {
        std::string name;
        std::vector<long long> arr;
        std::size_t k;
        WindowAnswer expected;
    };

    std::vector<TestCase> tests;
    tests.push_back({"T0", {8, -3, 4, 2, -10, 5, 1}, 3, {true, 14, 5, 0, ""}});
    tests.push_back({"T1", {1, 2, 3, 4, 5}, 5, {true, 15, 0, 4, ""}});
    tests.push_back({"T2", {-5, -2, -9, -1}, 2, {true, -6, 3, 0, ""}});
    tests.push_back({"T3", {1073741824LL, 1073741824LL, -2, 7}, 2,
                     {true, 2147483648LL, 0, 1, ""}});
    tests.push_back({"T4", {9, 8, 7}, 4, {false, 0, 0, 0, "k_out_of_range"}});
    tests.push_back({"T5", {9, 8, 7}, 0, {false, 0, 0, 0, "k_out_of_range"}});

    // Middle-first execution order:
    // count=6 -> mid index=3 -> run T3 first, then outward 2,4,1,5,0.
    const std::size_t m = tests.size() / 2;  // 6/2=3
    std::vector<std::size_t> order = {m, m - 1, m + 1, m - 2, m + 2, 0};

    for (std::size_t idx : order) {
        const auto& tc = tests[idx];
        const WindowAnswer got = max_circular_window_exact_k(tc.arr, tc.k);
        print_case(tc.name, tc.arr, tc.k, got, tc.expected);
    }

    return 0;
}

