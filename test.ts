const values = ["one", "two", "three"] as const;
type ValuesType = (typeof values)[number];
