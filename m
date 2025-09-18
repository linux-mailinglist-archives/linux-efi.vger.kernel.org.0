Return-Path: <linux-efi+bounces-4858-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EDBB841FE
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120F317AEBC
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 10:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722130594F;
	Thu, 18 Sep 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFxkCaxD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D00304BCD
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191447; cv=none; b=FNi7+7nCkB8IPTp9UfaQrqM48U27InmFxFejdfMlDeCHwiuwYPSm9UKQ0KBGi8B/x27jTFMyH9FMFGvFssMq1kGz3klPKlzFDTFArs5aD5KxXXHfTZxYNXndVHXBZqhyuV7XhBd5J8CC1NQOCKFEFkn3CqX01GJ0O2lEi4zIHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191447; c=relaxed/simple;
	bh=nj7i29BJluBpWURQYZUxvNADD0EB9W2SAuUGs1F5qNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ijNwBuXT1aNZ9x/DucQEhIgsxtsRIQBxBtaVQ9T+cxTxyetDRzduYi7pcrsTCgYlmjfeKwDauRC/h8WeIq6WfTWMnOBqQBxuwTYSbW3v81LEgKoG9bDvUqblsdgjUwdqy3FUWwV0jjGqpn7Uwztn6cJQb8Z5a9ds6IttwbVnupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFxkCaxD; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-62f9cfb8075so760292a12.2
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 03:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191444; x=1758796244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1LXz7drZR69NRcqoi9vT6ordOH/o85U4ZownXle33jo=;
        b=dFxkCaxDZO3OnhB8RAH7MPeZ71uvQuwcqyyUBoN2R7FEvaVRYzt184/fa2mCEihoB+
         OwIZ+TGaj2DGs6gcgXq1vnAEWoni95OytFd2l5oK+yS0AyLn13TGmNlKaqgbg3zEAnDr
         0fylXUYPNT2E8irkNSI768dbMrJaCBkLv0ckTTaPbvQ70k3vcGUWEQ1Pq1wupmc1WcRn
         mjrPm5ftQCBjEGniVtpkjAiEXe20nbGB+GDvC3ngJiG/v4ZPg2fEJ+b+4jYHDx2ivMxx
         s4qiiKdYQ2Gxe/02Zi7QA8/ZXcXijYzhRA4c28ikmOYLMXTgBzbMAobe16VGwoXp3QTQ
         g4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191444; x=1758796244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LXz7drZR69NRcqoi9vT6ordOH/o85U4ZownXle33jo=;
        b=ET8b56aoQJ+RvMiO9OxI35IUkSMDzNP1zYLLFN772PuxU3LVRO4F9ets8YszFT8Ge9
         DQfnvOwIk6irIx5NwCMDrYF+LWaoiEXIKFyb9LYp7kSqoMNOuGsZaGztGlx18cP5ONhf
         f4pKFFrI3OzcyQoKLw6tSMi0t9QuRp7kqjV6NGtiLNNr9uV38Z203mxf9kmjSaNVjmJQ
         KOapIwj4i7izPQ41liUOIqcCwHE0DcNwiTpF13uk53n6Rj0icaYX2NjNhuSoEw6OJOqE
         /6hn3I09nuvhcwm2NIvhXdLr0C5jbmyxzJG63pF7z1r7bknEtZGavYcaa9Ld4BZekl5Q
         ZkDw==
X-Gm-Message-State: AOJu0Yyj8UPE3LyrYDJam+eSM+5rIpmYt2KkSkQUCidFNINO5jNgySA/
	+VFEPqYNV9UuM8dVvWkrHB2kHR8J5h7p4IjTQpovntLEeYkXMJoZHm5stZj6XVRDR4OiEWvzcv7
	gzYUOxN7DmKuEqhMUaoXMw8lyyFCJWi9vOM/ja4b+nxeAmWkpSaKA1E1BPgPMIb8zBZoBhMY0DH
	XV8rJfcFgk0oKDu2GoRi29JgztcK161Q==
X-Google-Smtp-Source: AGHT+IGUquYXpi2xrIo18MZawlB6gxNVwBfa77lbrIIZHKX8Fpb5Qx9xXEK4QYttljX7a5cizhaLtJAe
X-Received: from edbev11.prod.google.com ([2002:a05:6402:540b:b0:62f:f6a:43ba])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5210:b0:62f:3721:fc8c
 with SMTP id 4fb4d7f45d1cf-62f846a13f7mr4583585a12.37.1758191443543; Thu, 18
 Sep 2025 03:30:43 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:19 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; i=ardb@kernel.org;
 h=from:subject; bh=AwRe+ieGv51rAlmd3os99ZtjQYVM4Fjtomg80IO3BGI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0ffu7Hx2rC6Yu2+C13jZCdw5DvK+nWau/35sVhftaX
 tp8npDfUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyIp6RYcV5l8DV7Qfd7C7x
 d5Wun8r8crV6ic8C9h1zMjXOSHO8v8rwP3F1/+/nc0s3B19zT/4R/KFS8CZb2eepvuv4xAMuFnN LcgMA
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-18-ardb+git@google.com>
Subject: [PATCH v3 8/8] arm64/efi: Call EFI runtime services without disabling preemption
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The only remaining reason why EFI runtime services are invoked with
preemption disabled is the fact that the mm is swapped out behind the
back of the context switching code.

The kernel no longer disables preemption in kernel_neon_begin().
Furthermore, the EFI spec is being clarified to explicitly state that
only baseline FP/SIMD is permitted in EFI runtime service
implementations, and so the existing kernel mode NEON context switching
code is sufficient to preserve and restore the execution context of an
in-progress EFI runtime service call.

Most EFI calls are made from the efi_rts_wq, which is serviced by a
kthread. As kthreads never return to user space, they usually don't have
an mm, and so we can use the existing infrastructure to swap in the
efi_mm while the EFI call is in progress. This is visible to the
scheduler, which will therefore reactivate the selected mm when
switching out the kthread and back in again.

Given that the EFI spec explicitly permits runtime services to be called
with interrupts enabled, firmware code is already required to tolerate
interruptions. So rather than disable preemption, disable only migration
so that EFI runtime services are less likely to cause scheduling delays.
To avoid potential issues where runtime services are interrupted while
polling the secure firmware for async completions, keep migration
disabled so that a runtime service invocation does not resume on a
different CPU from the one it was started on.

Note, though, that the firmware executes at the same privilege level as
the kernel, and is therefore able to disable interrupts altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index a60444dcec68..9b1603a69b69 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -10,6 +10,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/kmemleak.h>
+#include <linux/kthread.h>
 #include <linux/screen_info.h>
 #include <linux/vmalloc.h>
 
@@ -181,7 +182,19 @@ bool arch_efi_call_virt_setup(void)
 	if (WARN_ON(!mutex_trylock(&efi_rt_lock)))
 		return false;
 
-	efi_virtmap_load();
+	if (preemptible() && (current->flags & PF_KTHREAD)) {
+		/*
+		 * Disable migration to ensure that a preempted EFI runtime
+		 * service call will be resumed on the same CPU. This avoids
+		 * potential issues with EFI runtime calls that are preempted
+		 * while polling for an asynchronous completion of a secure
+		 * firmware call, which may not permit the CPU to change.
+		 */
+		migrate_disable();
+		kthread_use_mm(&efi_mm);
+	} else {
+		efi_virtmap_load();
+	}
 
 	/*
 	 * Enable access to the valid TTBR0_EL1 and invoke the errata
@@ -207,7 +220,13 @@ void arch_efi_call_virt_teardown(void)
 	 */
 	uaccess_ttbr0_disable();
 
-	efi_virtmap_unload();
+	if (preemptible() && (current->flags & PF_KTHREAD)) {
+		kthread_unuse_mm(&efi_mm);
+		migrate_enable();
+	} else {
+		efi_virtmap_unload();
+	}
+
 	mutex_unlock(&efi_rt_lock);
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


