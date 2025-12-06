Return-Path: <linux-efi+bounces-5816-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A82ACAAC8A
	for <lists+linux-efi@lfdr.de>; Sat, 06 Dec 2025 20:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4C60304FEA1
	for <lists+linux-efi@lfdr.de>; Sat,  6 Dec 2025 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0322C21DF;
	Sat,  6 Dec 2025 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0LgAxSX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6462D77FA
	for <linux-efi@vger.kernel.org>; Sat,  6 Dec 2025 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765047686; cv=none; b=rOH5BIziRiwYRkzVbEFH7DMRfQARhGfMw6csGItF8X8Il2bsXTREsYuVisiTHj3h9T2xxbdewWWlivL8Avpe5+KpDeSPOIStb1OpoxLFSDj11tVFW0+ZVLJ63WKQrVwIpDG+KA4tFG2QBqM1lAcihhDJ6rQiA3CKWqr3Fp7rdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765047686; c=relaxed/simple;
	bh=RK1Hc4AiJMLd66pIpInJZ/WqsPC5FZ2b1h4T0MicAYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZYw8MVoPU+dMWMiNnMoqGI9xG6es65RR2y7FhMU79hbp+Vb9KfGvX1qFJv+bSRS+YNB7VPEZpNIEKCg5XRhYz1SHVQmVy8tj4S85qSo429OBOcT0xylCWaLgIqkp+2PxwUm2RfEmpShIPc7hz52HrpDA3pLzHr+TRrQOFksays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0LgAxSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A2EC116D0;
	Sat,  6 Dec 2025 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765047684;
	bh=RK1Hc4AiJMLd66pIpInJZ/WqsPC5FZ2b1h4T0MicAYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0LgAxSXZscP4/VQn33waV7mcnDh0N3Z4p5hmI2CDdBOW/Gk4LXky10rjiA1YmtOY
	 TnIgnv/uChJoo9njaEgfJ8Mp+cc8MKJz+Pd3mI6fR+FYTk6tLxatLi7okW9nTF/zAa
	 KYpwGM2ZxcI6++DaTTDj4IcjFdubs8Cw2twrs2gKP3Bpup1Cw11xZqGGlRDENbrmQr
	 k8G6z90jKs2kkqoaZvQQnUBwe537UocCDpnTdydwL2tYZXMq8xyTUBUoEmm2WhqK8F
	 Qa32j0YkOZJzv6nv12wpts0o6OjcH6KxzdYfJKs5c95Xo8eGvx05EH3HBKFnGiQ+15
	 ebp08BB4dDZig==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 1/2] lkdtm/bugs: Add cases for BUG and PANIC occurring in hardirq context
Date: Sat,  6 Dec 2025 20:01:16 +0100
Message-ID: <20251206190114.892262-5-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251206190114.892262-4-ardb@kernel.org>
References: <20251206190114.892262-4-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2909; i=ardb@kernel.org; h=from:subject; bh=RK1Hc4AiJMLd66pIpInJZ/WqsPC5FZ2b1h4T0MicAYU=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JIdOktmYWY93WkoV3jjNMrz6wZGtMV/jjAzaiV56smDCJO 1Ygo+12RykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIg9+MDA83f/vEd25h8crI /rBjx6covu2a5fBQZJ/pC+MzzLPm29UzMpzlfHOd963I5zbhD0a10ZUPpd/wT5S2sz5mP+lEZol kBzcA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Add lkdtm cases to trigger a BUG() or panic() from hardirq context. This
is useful for testing pstore behavior being invoked from such contexts.

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/misc/lkdtm/bugs.c               | 53 ++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |  2 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 376047beea3d..fa05d77acb55 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -8,6 +8,7 @@
 #include "lkdtm.h"
 #include <linux/cpu.h>
 #include <linux/list.h>
+#include <linux/hrtimer.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
@@ -100,11 +101,61 @@ static void lkdtm_PANIC_STOP_IRQOFF(void)
 	stop_machine(panic_stop_irqoff_fn, &v, cpu_online_mask);
 }
 
+static bool wait_for_panic;
+
+static enum hrtimer_restart panic_in_hardirq(struct hrtimer *timer)
+{
+	panic("from hard IRQ context");
+
+	wait_for_panic = false;
+	return HRTIMER_NORESTART;
+}
+
+static void lkdtm_PANIC_IN_HARDIRQ(void)
+{
+	struct hrtimer timer;
+
+	wait_for_panic = true;
+	hrtimer_setup_on_stack(&timer, panic_in_hardirq,
+			       CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+	hrtimer_start(&timer, us_to_ktime(100), HRTIMER_MODE_REL_HARD);
+
+	while (wait_for_panic)
+		;
+
+	hrtimer_cancel(&timer);
+}
+
 static void lkdtm_BUG(void)
 {
 	BUG();
 }
 
+static bool wait_for_bug;
+
+static enum hrtimer_restart bug_in_hardirq(struct hrtimer *timer)
+{
+	BUG();
+
+	wait_for_bug = false;
+	return HRTIMER_NORESTART;
+}
+
+static void lkdtm_BUG_IN_HARDIRQ(void)
+{
+	struct hrtimer timer;
+
+	wait_for_bug = true;
+	hrtimer_setup_on_stack(&timer, bug_in_hardirq,
+			       CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+	hrtimer_start(&timer, us_to_ktime(100), HRTIMER_MODE_REL_HARD);
+
+	while (wait_for_bug)
+		;
+
+	hrtimer_cancel(&timer);
+}
+
 static int warn_counter;
 
 static void lkdtm_WARNING(void)
@@ -696,7 +747,9 @@ static noinline void lkdtm_CORRUPT_PAC(void)
 static struct crashtype crashtypes[] = {
 	CRASHTYPE(PANIC),
 	CRASHTYPE(PANIC_STOP_IRQOFF),
+	CRASHTYPE(PANIC_IN_HARDIRQ),
 	CRASHTYPE(BUG),
+	CRASHTYPE(BUG_IN_HARDIRQ),
 	CRASHTYPE(WARNING),
 	CRASHTYPE(WARNING_MESSAGE),
 	CRASHTYPE(EXCEPTION),
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index cff124c1eddd..67cd53715d93 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -1,6 +1,8 @@
 #PANIC
 #PANIC_STOP_IRQOFF Crashes entire system
+#PANIC_IN_HARDIRQ Crashes entire system
 BUG kernel BUG at
+#BUG_IN_HARDIRQ Crashes entire system
 WARNING WARNING:
 WARNING_MESSAGE message trigger
 EXCEPTION
-- 
2.47.3


