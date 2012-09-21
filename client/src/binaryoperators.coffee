#Binary Operaters - ILM

exports = module.exports

#Constants

###
These binary operators are used to construct and evaluate problems
###
operators = 
  and: 
    op:(left, right) -> left && right
    str:"&&"
  or: 
    op:(left, right) -> left || right
    str:"||"
  not: 
    op:(left) -> !left
    str:"!"

class BoolExp
  ###
  Create a new BoolExp
  @Param depth - The depth of the binary tree to generate
  @Param ops - which operations should the tree use
  So the following might give:
    BoolExp(1) -> true && false
    BoolExp(2) -> (false || true) && true
  and so on
  ###
  constructor: (depth=1, ops = ['and', 'or', 'not'] )->
    ###
    The Expression is stored as a binary tree in an array where the following 
    are true:
     expr[0] is the evaluated value of the tree
     expr[1] is the root of the tree
     and for any node n
        expr[2*n] is the right child
        expr[2*n + 1] is the left child
    ###
    @expr = []

    ###
    Fill the leafnodes with random boolean values
    ###
    [@rightLeaf, @leftLeaf] = [Math.pow(2, depth), Math.pow(2, depth+1)-1 ]    
    for i in [@rightLeaf .. @leftLeaf]
      @expr[i] = (Math.random()<.5)
    ###
    Fill in the nodes with random values
    ###
    for i in [1 .. @rightLeaf-1]
        @expr[i] = ops[Math.floor( Math.random() * ops.length )]
    ###
    Evaluate and stick in 0 to save time
    ###
    @expr[0] = @evaluate(1)
  nodeString: (n) ->
    ###
      Do an inorder traversal with some string interplation to get a string
      representation of a subtree.
    ###
    if n > @leftLeaf then "" #Sanity check
    else if  typeof @expr[n] == 'boolean'
      if @expr[n] then "T" else "F"
    else if @expr[n] == 'not'
      "( #{operators[@expr[n]].str} #{@nodeString(@left n)} )"
    else
      "( #{@nodeString( @left n )} #{operators[@expr[n]].str} #{ @nodeString( @right n ) } )"
  ###
  Evaluate the expression starting from 
  @param n index of the node to begin evaluating on
  ###
  evaluate: (n) ->
    if n > @leftLeaf then undefined
    else if typeof @expr[n] == 'boolean' then @expr[n]
    else 
      {op} = operators[ @expr[n] ]
      op(@evaluate(@left n), @evaluate( @right n) )
  value: -> @expr[0]
  left: (n) -> n*2 + 1
  right: (n) -> n*2
  toString: ->
    @nodeString(1) #get the nodeString from root


exports.BoolExp = BoolExp