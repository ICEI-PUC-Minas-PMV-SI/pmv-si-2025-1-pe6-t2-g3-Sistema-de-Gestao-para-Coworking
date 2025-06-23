import { dirname } from "path";
import { fileURLToPath } from "url";
import { FlatCompat } from "@eslint/eslintrc";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const compat = new FlatCompat({
  baseDirectory: __dirname,
});

const eslintConfig = [
  ...compat.extends(
    "next/core-web-vitals",
    "next/typescript",
    "plugin:prettier/recommended",
  ),

  {
    files: ["**/*.ts", "**/*.tsx"],
    rules: {
      "no-restricted-globals": "off",
      "react/jsx-no-bind": "off",
      "jsx-a11y/anchor-is-valid": "off",
      "prettier/prettier": "off",
      "@typescript-eslint/no-explicit-any": "off",
      "@typescript-eslint/no-unused-vars": "off"
    },
  },
];

export default eslintConfig;
