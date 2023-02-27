def get_value(obj, key):
    keys = key.split("/")
    for k in keys:
        obj = obj.get(k)
        if obj is None:
            return None
    return obj

# Example usage
obj1 = {"a": {"b": {"c": "d"}}}
key1 = "a/b/c"
value1 = get_value(obj1, key1)
print(value1)  # Output: d

obj2 = {"x": {"y": {"z": "a"}}}
key2 = "x/y/z"
value2 = get_value(obj2, key2)
print(value2)  # Output: a


//The get_value function takes the obj and key as inputs. The key is split into individual keys using the split function, with "/" as the separator. The function then iterates over each key in the keys list and gets the value of the key from the obj dictionary using the get function. If the key is not present in the dictionary, the function returns None. If all keys are successfully retrieved, the function returns the final value.
