Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3937E12B9BA
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 19:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfL0SCd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 13:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbfL0SCc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Dec 2019 13:02:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C5922B48;
        Fri, 27 Dec 2019 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577469751;
        bh=GKYrCZ9/aDSL9Px/0Qf08dFJn+ZicSl101ldxGOtSH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUfjiCc1qpxm0wILDcimGRolnWgX/DtzfXSWl70PCM3lqK2YpAQpXHaBGk5lTSalt
         g/+pwWyWlFGuxA2ngo7dI0ERGR8sbgj9Zw1Hcnnd8hoc2T1vkXWoI2Vc4sEfvwOYlG
         Smq7b9pfMXK/qmlIlYBBCLW0s8FD2HgBBxAyKTX8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Young <dyoung@redhat.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org, x86@kernel.org
Subject: [PATCH AUTOSEL 4.14 06/57] x86/efi: Update e820 with reserved EFI boot services data to fix kexec breakage
Date:   Fri, 27 Dec 2019 13:01:31 -0500
Message-Id: <20191227180222.7076-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227180222.7076-1-sashal@kernel.org>
References: <20191227180222.7076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Dave Young <dyoung@redhat.com>

[ Upstream commit af164898482817a1d487964b68f3c21bae7a1beb ]

Michael Weiser reported that he got this error during a kexec rebooting:

  esrt: Unsupported ESRT version 2904149718861218184.

The ESRT memory stays in EFI boot services data, and it was reserved
in kernel via efi_mem_reserve().  The initial purpose of the reservation
is to reuse the EFI boot services data across kexec reboot. For example
the BGRT image data and some ESRT memory like Michael reported.

But although the memory is reserved it is not updated in the X86 E820 table,
and kexec_file_load() iterates system RAM in the IO resource list to find places
for kernel, initramfs and other stuff. In Michael's case the kexec loaded
initramfs overwrote the ESRT memory and then the failure happened.

Since kexec_file_load() depends on the E820 table being updated, just fix this
by updating the reserved EFI boot services memory as reserved type in E820.

Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
bypassed in the reservation code path because they are assumed as reserved.

But the reservation is still needed for multiple kexec reboots,
and it is the only possible case we come here thus just drop the code
chunk, then everything works without side effects.

On my machine the ESRT memory sits in an EFI runtime data range, it does
not trigger the problem, but I successfully tested with BGRT instead.
both kexec_load() and kexec_file_load() work and kdump works as well.

[ mingo: Edited the changelog. ]

Reported-by: Michael Weiser <michael@weiser.dinsnail.net>
Tested-by: Michael Weiser <michael@weiser.dinsnail.net>
Signed-off-by: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kexec@lists.infradead.org
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20191204075233.GA10520@dhcp-128-65.nay.redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 5b513ccffde4..cadd7fd290fa 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -257,10 +257,6 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 		return;
 	}
 
-	/* No need to reserve regions that will never be freed. */
-	if (md.attribute & EFI_MEMORY_RUNTIME)
-		return;
-
 	size += addr % EFI_PAGE_SIZE;
 	size = round_up(size, EFI_PAGE_SIZE);
 	addr = round_down(addr, EFI_PAGE_SIZE);
@@ -290,6 +286,8 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	early_memunmap(new, new_size);
 
 	efi_memmap_install(new_phys, num_entries);
+	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+	e820__update_table(e820_table);
 }
 
 /*
-- 
2.20.1

