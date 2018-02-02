def get_path_to_root(tree, node):
    result = []
    current_parent = get_parent(tree,node)
    if not current_parent:
        return []
    while current_parent[0] != "Ben Solo":
        result.append(current_parent)
        current_parent = get_parent(tree, current_parent)
    result.append(current_parent)
    return result

def get_nodes(tree):
    if is_leaf(tree):
        return [datum(tree)[0]]
    else:
        result = [datum(tree)[0]]
        for child in children(tree):
            result += get_nodes(child)
        return result

def is_leaf(tree):
    return children(tree) == []

def get_node_with_force(tree, node_name):
    if datum(tree)[0] == node_name:
        return datum(tree)
    else:
        result = None
        for child in children(tree):
            result = result or get_node_with_force(child, node_name)
        return result

def datum(tree):
    return tuple(tree[0:2])

def children(tree):
    return tree[2:]

def get_parent(tree, node):
    if datum(tree) == node:
        return None
    else:
        found = False
        for child in children(tree):
            if datum(child) == node:
                found = True
                return datum(tree)
        if not found:
            result = None
            for child in children(tree):
                result = result or get_parent(child, node)
                if result:
                    return result

def get_height_of_node_helper(tree, node, c_height):
    if c_height <= 0:
        return -1
    if datum(tree) == node:
        return c_height
    result = -1
    for child in children(tree):
        result = max(result, get_height_of_node_helper(child, node, c_height - 1))
    return result

def get_height_of_node(tree, node):
    tree_height = get_height(tree)
    return get_height_of_node_helper(tree, node, tree_height)

def get_height(tree):
    if is_leaf(tree):
        return 1
    else:
        maximum = -1
        for child in children(tree):
            current = 1 + get_height(child)
            if current > maximum:
                maximum = current
        return maximum

def get_in_height_helper(tree,height,current):
    if current < height:
        return []
    elif height == current:
        return [datum(tree)]
    else:
        result = []
        for child in children(tree):
            subresult = get_in_height_helper(child,height, current-1)
            if subresult:
                result += subresult
        return result

def get_in_height(tree,height):
    return get_in_height_helper(tree, height, get_height(tree))

def change_node(tree, parent, old, new):
    if is_leaf(tree):
        return tree
    elif datum(tree) == old:
        tree[0] = new[0]
        tree[1] = new[1]
        return tree
    elif datum(tree) == parent:
        for child in children(tree):
            if datum(child) == old:
                child[0] = new[0]
                child[1] = new[1]
        return tree
    else:
        for child in children(tree):
            change_node(child, parent, old, new)
        return tree

def swap_nodes(tree, node_l, node_u):
    parent1 = get_parent(tree,node_l)
    parent2 = get_parent(tree,node_u)
    if parent1 != node_u:
        change_node(tree, parent1, node_l, ("Temp", 0))
        change_node(tree, parent2, node_u, node_l)
        change_node(tree, parent1, ("Temp",0), node_u)
    else:#change between parent and its child
        change_node(tree, parent1, node_l, ("Temp", 0))
        change_node(tree, parent2, node_u, node_l)
        change_node(tree, node_l, ("Temp",0), node_u)


def constraint_one(tree):
    i = 1
    height = get_height(tree)
    while i < height:
        lower = get_in_height(tree, i)
        upper = get_in_height(tree, i+1)
        for l in lower:
            for u in upper:
                if l[1] > u[1]:
                    swap_nodes(tree, l, u)
                    lower = get_in_height(tree, i)
                    upper = get_in_height(tree, i+1)
                    break
        i += 1
    return tree

def get_sum_of_children(tree, node):
    if is_leaf(tree):
        return 0
    elif datum(tree) == node:
        sum_ = 0
        for child in children(tree):
            sum_ += datum(child)[1]
        return sum_
    else:
        sum_ = 0
        for child in children(tree):
            sum_ = get_sum_of_children(child, node)
            if sum_:
                break
        return sum_

# function that removes the given node from given parent
def remove_node(tree, parent, node):
    if is_leaf(tree):
        return False
    elif datum(tree) == parent:
        for child in children(tree):
            if datum(child) == node:
                tree.remove(child)
        return True
    else:
        for child in children(tree):
            if remove_node(child, parent, node):
                return True
        return False

def get_max_force_in_height(tree, height):
    return sorted(get_in_height(tree, height), key=lambda x: x[1],reverse=True)[0][1]

# function that appends the given node to given parent
def append_node(tree, parent, node):
    if is_leaf(tree) and datum(tree) != parent:
        return False
    elif datum(tree) == parent:
        tree.append(list(node))
        return True
    else:
        for child in children(tree):
            if append_node(child, parent, node):
                return True
        return False

def constraint_two(tree, threshold_height):
    below_nodes = []
    removeds = []
    h = 1
    while h < threshold_height:
        below_nodes += get_in_height(tree,h)
        h += 1
    below_nodes = sorted(below_nodes, key=lambda x: x[1], reverse=True)
    for node in below_nodes:
	# get ancestors on path to the root which are above the threshold
        ancestors = filter(lambda x: get_height_of_node(tree, x) > threshold_height ,get_path_to_root(tree, node))
        to_be_removed = True
        for a in ancestors:
            height_of_a = get_height_of_node(tree,a)
            if height_of_a == threshold_height + 1:
                max_of_below = -1
            else:
                max_of_below = get_max_force_in_height(tree, height_of_a - 2)
            if a[1] >= get_sum_of_children(tree, a) + node[1] and node[1] >= max_of_below:
                remove_node(tree, get_parent(tree,node), node)
                append_node(tree, a, node)
                to_be_removed = False
                break
        if to_be_removed:
            remove_node(tree, get_parent(tree,node),node)
            removeds.append(node[0])
    return tree, removeds

def help_ben_solo(tree, threshold_height):
    tree = constraint_one(tree)
    return constraint_two(tree, threshold_height)


case19 = (['Ben Solo', 50, ['Jack', 9, ['Fredo', 2, ['Kyle', 1], ['Luke', 1]], ['Vincenzo', 1], ['Fred', 6, ['Ela', 3], ['Han', 3]]], ['John', 18, ['Rocco', 1], ['Nico', 14, ['James', 10, ['George', 11, ['Jerry', 2]]]]]], 2)

print help_ben_solo(case19[0],case19[1])
