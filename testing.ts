type InferAsTuple = [unknown, ...unknown[]];

const options = [
  { label: "View", value: "VIEW" },
  { label: "Full access", value: "FULL_ACCESS" },
] satisfies InferAsTuple;

console.log(options[2])
