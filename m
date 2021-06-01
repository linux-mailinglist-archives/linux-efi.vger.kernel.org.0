Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC6396E53
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jun 2021 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhFAH4S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Jun 2021 03:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233142AbhFAH4M (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Jun 2021 03:56:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3071B613AF;
        Tue,  1 Jun 2021 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622534070;
        bh=8iXYec1EZ58uKODN+/RDQBJPalkCOTMKuHjI/4/gVTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNH7kKadv/iTtuQmn9mAdgw/V8+YCjy1DqHXWUFiXc7O7Z97U93ghR8hdTkkksSW/
         VI5T2up7eyBKFjbU/SXGXslrR/ThUIx0ugUvMyUA0hobthBtGRIXI2sBYBp3mhlLkh
         kLZw4hmvu09pwMFy3yVCDHEAzR7pCyXi690g86uvk96goQMVj3gSNsm7qLmKC/zfh0
         hG7xnKsHPimCGT+JzCMpm3q65iPHvJqsw+FZQy828PhIdHLc7a7BW2q4TvV7MaJldl
         vAXshniqWXGDV5dEP/6Mcrk+oS7qzWxiG4ThXI7Lty4kbNdXYA2hRe1XTuA+3ElUmx
         R/x9GhloDdVCw==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/3] x86/crash: remove crash_reserve_low_1M()
Date:   Tue,  1 Jun 2021 10:53:54 +0300
Message-Id: <20210601075354.5149-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210601075354.5149-1-rppt@kernel.org>
References: <20210601075354.5149-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The entire memory range under 1M is unconditionally reserved at
setup_arch(), so there is no need for crash_reserve_low_1M() anymore.

Remove this function.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/include/asm/crash.h |  6 ------
 arch/x86/kernel/crash.c      | 13 -------------
 2 files changed, 19 deletions(-)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index f58de66091e5..8b6bd63530dc 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -9,10 +9,4 @@ int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
 void crash_smp_send_stop(void);
 
-#ifdef CONFIG_KEXEC_CORE
-void __init crash_reserve_low_1M(void);
-#else
-static inline void __init crash_reserve_low_1M(void) { }
-#endif
-
 #endif /* _ASM_X86_CRASH_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 54ce999ed321..e8326a8d1c5d 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -70,19 +70,6 @@ static inline void cpu_crash_vmclear_loaded_vmcss(void)
 	rcu_read_unlock();
 }
 
-/*
- * When the crashkernel option is specified, only use the low
- * 1M for the real mode trampoline.
- */
-void __init crash_reserve_low_1M(void)
-{
-	if (cmdline_find_option(boot_command_line, "crashkernel", NULL, 0) < 0)
-		return;
-
-	memblock_reserve(0, 1<<20);
-	pr_info("Reserving the low 1M of memory for crashkernel\n");
-}
-
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
 static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
-- 
2.28.0

