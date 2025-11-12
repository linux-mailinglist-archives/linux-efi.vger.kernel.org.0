Return-Path: <linux-efi+bounces-5492-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D53C53D30
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 19:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6293B50E2
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97065241695;
	Wed, 12 Nov 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4V7Ap5aY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67F23BCEE
	for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970012; cv=none; b=YzXexeTG9jS+PPSUG5uHvfmZyJ72c1ia+cZrJJf6JCGhDLbNTUeI+wl26TNE4COhIIPXrwLgP9SlCA1hNI2koYPVPCfQCgkjPBJpIMrJg4GOYwxOgWO32hO8vBI3Zels0P8qAAOUBEcLe1tW9FCS+k+2Ls5j0WW0Qg28Q0FoNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970012; c=relaxed/simple;
	bh=003eDf487+/JnLFLqYpPYfK/2vm5gkecToxT/3en7uw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VMqH783EKj0sy5IKsB85RmDebUO3Ma/t5zSzvSDmlnr2hxsqdLyVXzNpCjNgqOw9Uxg1ImBik3sVWmUMepatHHc+1Zi0qtVIySfkfwR2JTQl/L4bJ9mp3czQXDXqDQbFYuZUTODzk+AZhTMdJYV2UySrsnV/cpd6QmRXDvBPxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4V7Ap5aY; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b728157fb3bso102947366b.2
        for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762970009; x=1763574809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+eOMzGKKanyGN0tH11nblupgXRAzHAohg2TuWXaWxk=;
        b=4V7Ap5aYuYRlAAWyLV4ZcB6y41B7riBLzskhn+4U4sTaNU/gzEc2lT9ASLEsk9PbVM
         EDS4su3086o1cLbmLWu1SpSjPRVubA895KSa9O1bSsuCZdXkWQUPVt19Mo5DoVdhjc/B
         WGBQbN4Z03bPgDK3VSDnAvMWyMogLeB1Op2pNod0fLXZdSBaUmfWYgG2Pi2BRQAJVbxe
         1g0k4MSQbjrF9YcTNb4MxL4dsFHp0tJEkxWTA6HMADA8Du6L5jw+KaH25JH/dNuMp8X8
         9N5DiOOM4Z8zpfo1afNRjU92NkPXf2U6gFSV5gIgOMwPUzvdSFqNaM1ooAJmyxXoSyjC
         6DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970009; x=1763574809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+eOMzGKKanyGN0tH11nblupgXRAzHAohg2TuWXaWxk=;
        b=XzEbdUxv/7jSLs4JXa4nUBhuzekYGNwFvCXptymP2pPtrsmHXDCP4CmZBIIPxbnbGj
         BOTplxlk5JR2ul52/I24a0brZDzQM7Cg8uYKsj2/KprDpFlOtrGUhRSeqBFK4/Et/CEy
         K/FzgSmc0ndRAWxNOBSpjiJfCCYVClKmu17J8AczmXnIIyOi8Z/m5sIDPdZtFKG2T2fv
         HRrDGEbPy3FWCSQ9XjMDPHuaAUkRPmKoZKJN5aURZ84KYnZWmRdRdXVHwWT+vx5xNk0W
         qkOiN6Y95hTZPut98WAxXoUleVRH/h34otbR4N3TrTxWVZx/6CKymCCPMfWFMrKrMMiu
         DpiQ==
X-Gm-Message-State: AOJu0YysxtpPC4hdY+9Pnn6Sglm66wbM9b64lKhPP8wjh/ybwKxa/fNY
	jeUo4gtxZvrV+LHDmSfO76ys9z86NtUs3x4rBQ0mZ65hHj4Nl7k0y05Lei/Qujhq3tx8gmORXg=
	=
X-Google-Smtp-Source: AGHT+IG9WP11h9VdD0dZFi4qlzvNDIv2CKBVpmrA5lbfV8P6grjSJNkODFrARGIB/GbmRH1vdjS2Wf4Y
X-Received: from ejbd2.prod.google.com ([2002:a17:906:3442:b0:b72:2a7f:6a3f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:60cf:b0:b0c:b51b:81f6
 with SMTP id a640c23a62f3a-b7331aa4ff3mr414862166b.43.1762970009118; Wed, 12
 Nov 2025 09:53:29 -0800 (PST)
Date: Wed, 12 Nov 2025 18:53:18 +0100
In-Reply-To: <20251112175316.2841017-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112175316.2841017-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2361; i=ardb@kernel.org;
 h=from:subject; bh=HTJBxTs9yVOT5hDnqvVphswVoRlVz8UfGhOKDMbc6GM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVPkZF9PYl7hyXUtBtWJ/rGG1ZpJrE0GOzUYhXhTSx9P4
 dA+YNpRysIgxsUgK6bIIjD777udpydK1TrPkoWZw8oEMoSBi1MAJlLswvDPJHjeuY1RH+UD4hl4
 Lh928TKJmnv94Oa0/Vb22x/K/vKRYmR4XRXFKyQ96cQKzUd5crZdZobf3W5pvKms7DqkFyLrksg LAA==
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112175316.2841017-5-ardb+git@google.com>
Subject: [PATCH 1/2] lkdtm/bugs: Add cases for BUG and PANIC occurring in
 hardirq context
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Add lkdtm cases to trigger a BUG() or panic() from hardirq context. This
is useful for testing pstore behavior being invoked from such contexts.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/misc/lkdtm/bugs.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

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
-- 
2.52.0.rc1.455.g30608eb744-goog


