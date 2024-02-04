# Degree of an array
# Given a non-empty array of non-negative integers nums, the degree of this array is 
# defined as the maximum frequency of any one of its elements.Your task is to find the 
# smallest possible length of a (contiguous)subarray of nums, that has the same degree as nums.

# Example 1:
# Input: nums = [1,2,2,3,1]
# Output: 2
# Explanation:
# The input array has a degree of 2 because both elements 1 and 2 appear twice.
# Of the subarrays that have the same degree:
# [1, 2, 2, 3, 1], [1, 2, 2, 3], [2, 2, 3, 1], [1, 2, 2], [2, 2, 3], [2, 2]
# The shortest length is 2. So return 2.

# Example 2:
# Input: nums = [1,2,2,3,1,4,2]
# Output: 6
# Explanation:
# The degree is 3 because the element 2 is repeated 3 times.
# So [2,2,3,1,4,2] is the shortest subarray, therefore returning 6.



# Alex H's answer:
# Leetcode

def find_shortest_subarry(nums):
    """
        Time Complexity: O(n): we go iterate the list once, and for loops are stacked operations
        Space Complexity: O(n): our dictionary will grow as our number grows
    """
    # initialize dictionary
    info_dict = {}
    # loop through nums to populate into dictionary
    for i, num in enumerate(nums):
        if num in info_dict:
            info_dict[num]['freq'] += 1
            info_dict[num]['last'] = i
        else:
            info_dict[num] = {'freq' : 1, 'first' : i, 'last' : i}
    # initialize degree and min_length
    degree = 0
    min_length = float('inf')
    # loop to deteremine our degree
    for num in info_dict:
        degree = max(degree, info_dict[num]['freq'])
    # loop to find the minimum length of subarray with the same degree
    for num in info_dict:
        if info_dict[num]['freq'] == degree:
            length = info_dict[num]['last'] - info_dict[num]['first'] + 1
            min_length = min(min_length, length)
    return min_length

print(find_shortest_subarry([1,2,2,3,1]))