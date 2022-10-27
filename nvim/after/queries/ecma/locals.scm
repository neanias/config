;; inherits: ecma
;; extends
(field_definition 
  property: [(property_identifier) (private_property_identifier)] @definition.var)

(assignment_expression
  left: (member_expression
    object: (this)
    property: [(property_identifier) (private_property_identifier)] @definition.var))

(method_definition
  ([(property_identifier) (private_property_identifier)] @definition.function)
  (#set! definition.var.scope parent))

(member_expression
  object: (this)
  property: (property_identifier) @reference)
