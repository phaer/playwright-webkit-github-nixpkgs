import { test, expect } from "@playwright/test";

test("hello is visible. Foobar", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByText("hello")).toBeVisible();
});
