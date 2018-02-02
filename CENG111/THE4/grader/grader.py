import copy
import sys
from test_cases import *

def is_leaf(tree):
    return children(tree) == []
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

def get_node_with_force(tree, node_name):
    if datum(tree)[0] == node_name:
        return datum(tree)
    else:
        result = None
        for child in children(tree):
            result = result or get_node_with_force(child, node_name)
        return result

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

def get_max_in_height(tree, height):
    return sorted(get_in_height(tree,height), key=lambda x: x[1], reverse=True)[0][1]


def get_nodes(tree):
    if is_leaf(tree):
        return [datum(tree)[0]]
    else:
        result = [datum(tree)[0]]
        for child in children(tree):
            result += get_nodes(child)
        return result

def check_nodes(tree, new_tree, executeds):
    nodes1 = get_nodes(tree)
    nodes2 = get_nodes(new_tree) + executeds
    return sorted(nodes1) == sorted(nodes2)

def check_constraint_one(tree):
    if is_leaf(tree):
        return True
    else:
        max_child = -1
        for child in children(tree):
            if datum(child)[1] > max_child:
                max_child = datum(child)[1]

        if datum(tree)[1] < max_child:
            return False

        else:
            result = True
            for child in children(tree):
                result = result and check_constraint_one(child)
                if not result:
                    break
            return result

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

def check_added_correctly(tree,new_tree, executeds, threshold_height): 
    tree_cons_one, exs = help_ben_solo(copy.deepcopy(tree), 1)
    if exs:
        print 'Constraint 1 should not have executed commanders'
        return False
    nodes_below = []
    h = 1
    while h < threshold_height:
        nodes_below += get_in_height(tree_cons_one, h)
        h += 1
    for node in nodes_below:
        if node[0] in executeds:
            continue
        ancestors = filter(lambda x: get_height_of_node(tree_cons_one, x) > threshold_height ,get_path_to_root(tree_cons_one, node))
        new_parent = get_parent(new_tree, node)
        if new_parent not in ancestors:
            return False
    return True

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

def check_constraint_two(tree, new_tree, executeds, threshold_height):
    tree_cons_one,_ = help_ben_solo(copy.deepcopy(tree),1)
    nodes_below = []
    h = 1
    while h < threshold_height:
        nodes_below += get_in_height(tree_cons_one, h)
        h += 1
    for node in nodes_below:
        if node[0] in executeds:
            continue
        new_parent = get_parent(new_tree, node)
        sum_of_children = get_sum_of_children(new_tree, new_parent)
        if sum_of_children > new_parent[1]:
            return False
    return True

def check_in_height_swap(tree, new_tree, threshold_height):
    tree_cons_one, _ = help_ben_solo(copy.deepcopy(tree), 1)
    nodes_above = []
    h = get_height(tree) - 1
    while h >= threshold_height:
        nodes_above = get_in_height(tree, h)
        h -= 1
    for node in nodes_above:
        old_parent = get_parent(tree, node)
        new_parent = get_parent(tree_cons_one, node)
        if old_parent != new_parent and get_height_of_node(tree, old_parent) == get_height_of_node(tree_cons_one, new_parent):
            if get_height_of_node(tree, old_parent) == get_height_of_node(tree_cons_one, old_parent):
                print node, new_parent, old_parent
                return False
    return True

def check_unnecessary_execution(tree, new_tree, executeds, threshold_height):
    tree_cons_one, exs = help_ben_solo(copy.deepcopy(tree),1)
    if exs:
        print 'Constraint 1 should not have executed nodes!'
        return False
    for node in executeds:
        node = get_node_with_force(tree,node)
        ancestors = filter(lambda x: get_height_of_node(tree_cons_one, x) > threshold_height ,get_path_to_root(tree_cons_one, node))  
        for parent in ancestors:
            sum_of_children = get_sum_of_children(new_tree, parent)
            if sum_of_children + node[1] <= parent[1]:
                maximum = get_max_in_height(new_tree, get_height_of_node(new_tree, parent) -1)
                if maximum <= node[1]:
                    return False
    return True

def check_case(tree, new_tree, executeds, threshold_height):
    if not check_nodes(tree, new_tree, executeds):
        print 'Error: Nodes are not equal'
        return False
    if not check_constraint_one(new_tree):
        print 'Error: Constraint 1 does not hold!'
        return False
    if not check_added_correctly(tree, new_tree, executeds, threshold_height):
        print 'Error: Some node is added to wrong commander!'
        return False
    if not check_constraint_two(tree, new_tree, executeds, threshold_height):
        print 'Error: Constraint 2 does not hold!'
        return False
    if not check_in_height_swap(tree, new_tree, threshold_height):
        print 'Error: In height swap!'
        return False
    if not check_unnecessary_execution(tree, new_tree, executeds, threshold_height):
        print 'Error: Unnecessary execution!'
        return False
    return True

if len(sys.argv) != 2:
    sys.exit("usage: ./grader <test-case>")

main_folder = "the4_submissions/"
case = sys.argv[1]
case_index = int(sys.argv[1]) - 1

try:
    from the4 import help_ben_solo
except:
    print 'Function cannot be imported'
    sys.exit(-1)

new_tree = []
executeds = []
try:
    tree, threshold = test_cases[case_index][0], test_cases[case_index][1]
    new_tree, executeds = help_ben_solo(copy.deepcopy(tree),threshold)
    if not check_case(tree, new_tree, executeds, threshold):
        print 'CASE ' + case + ': FAILED'
        print new_tree, executeds
    else:
        print 'CASE ' + case + ': OK'
	print new_tree, executeds
            
except:
    print 'CASE ' + case + ': FAILED with Exception'
    if new_tree:
        print new_tree, executeds
