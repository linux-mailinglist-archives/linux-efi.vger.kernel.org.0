Return-Path: <linux-efi+bounces-5918-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF5CD8FAE
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EDB53029228
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A1313286;
	Tue, 23 Dec 2025 10:56:08 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291F3002B3
	for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487368; cv=none; b=i+Bnbnj0wMWq9jUNbNLi5nJRzD0WSSJugzYLOSdaNRmKzS9l69HdhtZBklHCZBKDIeELF5nC+eimDLw26f/T5eO19hZqncUjn9UjRHExUzHIn/evrTwMa1Dug+I3Yl7hvMrZNHLkEB8vPJlIa4ZUkdWDSKWAlnZFebTNN6Iw8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487368; c=relaxed/simple;
	bh=UFL3EYFptdWksL2TrqK20utlZjnMf15IQidFIh37P6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dj5S6dI2Kjy7ENAPEnEZKrEc1KDCsBKRCbgBJ6rwi4l4ohvEDbU3QYHQ0hUxi4wO62o4El3PEOUT9M694EMpnYSt5ODw02TPwi6HscEx4lct1PFcXoWAp5iouXB9/hGpGpX01WPsj/XHOFNSy1MU29WXFTsDCxauhznzVzxtsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4511f736011so3539663b6e.0
        for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 02:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766487366; x=1767092166;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spoP0+Albf1P/crjcQ63AptEOAl1TVHeih5dAbMZP+Q=;
        b=bmNi+vK1Pb54fmgZ1WtftDv7J6RbLChJrjASYeZRWnV7qsGvZQ294f/wRLClEIaozC
         H8lIq3wBeVfVr17uj9hi0uw/IQWBIrxQRubz7FljyjPLy1Nzhci/oHO03berlHR/YygI
         QLodwNg30VBZZv5pYLary598frElS+LoeT/rmCcwHeBiO41CGpVHwnYurqTlVyAmlel1
         Cu76jOfQg/fKBMdBQJSBLo6H46sZ18x6xYKgVArRCWadeApCZQrj7na6yHxz483lCp8f
         d6jsGukEIR43eC9af8sAPKQlZd0zMPblt4ZumvRBGibdUQWF+rYWSGQaML7vfC56JmBa
         lIgg==
X-Gm-Message-State: AOJu0Ywc2aNch0N1d+MaMkiPaVnTBXoQoWorohlWl9EUciDUw3uQ920/
	W0IPe2SKQlZuoRW6GhINTc/Jv5OKGh/fBQUC4HO8tiGl/Qq0NaYiJRqy
X-Gm-Gg: AY/fxX5yMkmNAcqkpdphdYdbNLzVcdo5eqUgxd3aaqY92MXzN33e00tEUVdgqOKQlEg
	tDqO7kW7fBOKZQBfvLHsR2Mq/RuyzNg9ZOcQXc7Hriq800OROmZ0LYJbrF7VZbSX8c6QPP23sZy
	YUa4vWUbtoY1tyb+EjLJ2qHHWB90xI/QNBumBXymL8CZxIrONzFrr4We7AzgEUs+sDhXElVNu+7
	osN0bfJz2THX9Ahl+fRlVptnLRgUVfrks1/WS6/3ghQqmZ+lLi/AratlK4dPQxCB4apxQTGS3dY
	tr83UG1AR2Ovo5OL4N3S2cxGUtoaboM2gTn8G0ClA+XTQ6XWDEoFxagqUJQ6XW3xvr8NNlkegPc
	i55NFNrAeOnbCIWfYnsVGPYt+cbtZ/qF2KupVZp8E2pbKGV8UrWhy9HyV9ZUhnfgMi01SVhG2kf
	/LFBnZZrZjyDQdE0ePVc6wop0=
X-Google-Smtp-Source: AGHT+IGiZkiYPTPZNUrOfsgRj6L7DBQ+OVmkgtvSX3FWGLRox+YADwlzHeeAwjVmg585DG80xaAIMA==
X-Received: by 2002:a05:6808:1b2c:b0:450:f45e:f4a7 with SMTP id 5614622812f47-457a28920femr7624447b6e.8.1766487365699;
        Tue, 23 Dec 2025 02:56:05 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaac129c7sm7610763fac.21.2025.12.23.02.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:56:05 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] arm64: efi: Fix NULL pointer crash in 6.19-rc2
Date: Tue, 23 Dec 2025 02:55:42 -0800
Message-Id: <20251223-efi_fix_619-v1-0-e0146b8b9d73@debian.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC91SmkC/yXMQQ6CMBAF0KtM/pomzqBiexViCJYpjgs0LRgSw
 t2Nunybt6FoNi0ItCHr24o9JwTiihDv/TSqswGBIAc5sUjtNFmXbO3O7F198Rz7ZhDPR1SEV9Z
 k629rr3+X5fbQOH8L7PsHLVOPoW8AAAA=
X-Change-ID: 20251223-efi_fix_619-3891ca7d2914
To: Ard Biesheuvel <ardb@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, riel@surriel.com, puranjay@kernel.org, 
 usamaarif642@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; i=leitao@debian.org;
 h=from:subject:message-id; bh=UFL3EYFptdWksL2TrqK20utlZjnMf15IQidFIh37P6U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpSnVEfEn88+VR44GzKHbDtxIvHlHSEjjrsUc4Z
 UbZAdtQHR6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaUp1RAAKCRA1o5Of/Hh3
 bVv/D/4xoP7Y2y+3fcB+zUfr4xmdyGo5n5zqDOli8tg0MB89tYdCdmkVdAYEMmP3vSKTXqClnvs
 UmrNtHWvGGzJYz5PIo+0Kl4WUqqptbSBIwmHGaJvKVEOtZFrTMZBV9if9ipzZG30ZnaMxLPbGZs
 mD3A8ViD32tj+U4sHI3yAuWeg/8oXXe19hP9nKi4z9FzFjoC6MQYlYT0etsbrR8yv/odZnBDCnz
 JipP/fejbbmkM1pUTy7gkR3jDrJXl2AopNSDNF9tHirQoZKuRMTXGvpUBjIC9GiEKDYVhEkskwG
 RNHb3wJjiPjkluPHGsEoJROxJLsbXoH/oDybAhg8sA/9rrm86lYLi0CDoFhqIWiCp9fPT6Z3WOW
 J48ClXay2ExTVxR3sxsQ4yxFL//XlDKp8z6eUSTCUZwN4UpEXk628sFIfqBeL/pgDY9nyehCJLi
 p0wiIiIfpD/pVZf+qFIXKvkRuFdb4Ok7VafjRFTJUxqdAEIL2t9/sVCX0de47D7lktxCi+7mbZi
 38hqCxb0nHW/tWoXkFy27ZDkgjCFtdhWpLh9KJmPValJ6pDFyZAwKV6Oe6wIHmxjViYKjwBKIbm
 iWROh78kfH/W1WOjwtQqe8LlRIA+jis99v58RIvBjtt/QCIW06ok5WKjvKIlx+c6djDZ4PhhhNe
 EExYfr5jjmGbHJw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

I am seeing the following crash on arm64 with 6.19-rc2 (commit 9448598b22c5
("Linux 6.19-rc2"))

	Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c8

	Call trace:
	cap_capable (security/commoncap.c:82 security/commoncap.c:128) (P)
	security_capable (security/security.c:?)
	ns_capable_noaudit (kernel/capability.c:342 kernel/capability.c:381)
	__ptrace_may_access (./include/linux/rcupdate.h:895 kernel/ptrace.c:326)
	ptrace_may_access (kernel/ptrace.c:353)
	do_task_stat (fs/proc/array.c:467)
	proc_tgid_stat (fs/proc/array.c:673)
	proc_single_show (fs/proc/base.c:803)
	seq_read_iter (fs/seq_file.c:209)
	seq_read (./include/linux/ioprio.h:59 ./include/linux/ioprio.h:84 ./include/linux/fs.h:2177 fs/seq_file.c:158)
	vfs_read (./arch/arm64/include/asm/uaccess.h:46 fs/read_write.c:560)
	ksys_read (fs/read_write.c:705)
	__arm64_sys_read (fs/read_write.c:722)
	invoke_syscall (arch/arm64/kernel/syscall.c:46)
	el0_svc_common+0x90/0xe0
	do_el0_svc (arch/arm64/kernel/syscall.c:150)
	el0_svc (arch/arm64/kernel/entry-common.c:724)
	el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:743)
	el0t_64_sync (arch/arm64/kernel/entry.S:596)

This was bissected to commit a5baf582f4 ("arm64/efi: Call EFI runtime services without
disabling preemption").

After the commit above, it crashes arm64 with a NULL pointer dereference in
cap_capable() when running below (ocassionally). Unfortunately I still don't
have a simple reproducer, and it takes about 10 minutes to crash on my systems.
it always crash with below[1] application.

From my investigation, the root cause is that efi_mm lacks user_ns
initialization. When kthread_use_mm(&efi_mm) temporarily adopts efi_mm
for EFI calls, LSM hooks expect mm->user_ns to be valid for credential
checks. With it being NULL, capability checks crash.

This series contains two patches:

1. efi: Initialize efi_mm.user_ns to &init_user_ns (the actual fix)
2. kthread: Add WARN_ON_ONCE() to catch similar bugs early (RFC)

The second patch is mostly an RFC that adds a warning in
kthread_use_mm() to detect any mm_struct missing user_ns initialization,
helping prevent similar NULL pointer crashes in the future.

Link: https://github.com/facebookincubator/below [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      arm64: efi: Fix NULL pointer dereference by initializing user_ns
      kthread: Warn if mm_struct lacks user_ns in kthread_use_mm()

 drivers/firmware/efi/efi.c | 1 +
 kernel/kthread.c           | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-efi_fix_619-3891ca7d2914

Best regards,
--  
Breno Leitao <leitao@debian.org>


