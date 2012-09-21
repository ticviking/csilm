#Binary Operaters - ILM

exports = module.exports

#Constants

###
These binary operators are used to construct and evaluate problems
###
operators = 
  and: 
    op:(a, b) -> a && b
    str:"&&"
  or: 
    op:(a, b) -> a || b
    str:"||"
  not: 
    op:(a) -> !a
    str:"!"
###
BoolExp


A boolean expression, nested at most complexity deep
  BoolExp(1) -> true && false
  BoolExp(2) -> (false || true) && true
and so on
###
class BoolExp
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
  nodeString: (n) ->
    ###
      Do an inorder traversal with some string interplation to get a string
      representation of a subtree.
    ###
    left = n*2+1
    right = n*2
    if n > @leftLeaf 
      ""
    else if  typeof @expr[n] == 'boolean'
      @expr[n].toString()
    else if @expr[n] == 'not'
      "( #{operators[@expr[n]].str} #{@nodeString(left)} )"
    else
      "( #{@nodeString(left)} #{operators[@expr[n]].str} #{@nodeString(right)} )"

  toString: ->
    @nodeString(1) #get the nodeString from root

exports.BoolExp = BoolExp