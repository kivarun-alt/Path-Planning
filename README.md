Rapidly-exploring Random Trees (RRT) are a popular family of algorithms used in motion planning
and robotics to efficiently explore and navigate high-dimensional spaces. The functioning of RRT is as
follows,
• In the basic RRT algorithm, a tree is incrementally grown from the start towards a goal by randomly
sampling points in the configuration space and extending the tree towards these sampled points.
• RRT grows the tree by iteratively selecting a random point in the space, finding the nearest node
in the existing tree, and extending the tree towards the random point.
RRT* (RRT star), the algorithm we use for the project, is an extension of the basic RRT algorithm
that addresses some of its limitations and improves its performance.The main feature of RRT* is after
every new node is added to the tree, RRT* checks if any existing nodes can be reached more efficiently
through the new node. If so, it rewires the tree to improve the path quality. RRT* also optimizes the
cost-to-come for each node in the tree by considering the cost of reaching that node from the root of the
tree.

***NOTE*** This is a part of the final evaluation of Autonomous Vehicles course for Masters programme in Mechanical Engineering
at Politecnico di Milano. Use it as a reference for your projects but do not plagiarise.
