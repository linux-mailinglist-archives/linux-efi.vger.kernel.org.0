Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C8C2A401
	for <lists+linux-efi@lfdr.de>; Sat, 25 May 2019 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfEYL0N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 May 2019 07:26:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36344 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfEYL0H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 May 2019 07:26:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so12390532wru.3
        for <linux-efi@vger.kernel.org>; Sat, 25 May 2019 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqkbz42r/JkXQTE9JdHM5dm2nu1g0Kj971dkCS8AvjE=;
        b=gqFR2hJeFw3u2HpUwckkEXBS3nmH3rAd5ohGNgyItfKUneMiagkz0GCf+6di8LXz1k
         n/Mq3Vy9WDy8tApfAEICrVbZM1TOi/M692RmO0NyXNl5lFy2ZffOXXUQvKFKJzuQIdCK
         LmWAgBVdc8aRM8ACeRHdIRClURjrj3Y55+7Bw4EXv1xTU3fc5Fa5otRHRPEOn0Cr0VZm
         PV2hDTJuwE+n6eW9XcKNciAfa6kac2I9V5LR2/dgVAVqLK+3l11y0lKz/BSNoxTHIg84
         z6Jz43oR45LWnNrbbn/pbaL6BSC6tp8Mpii3mTTgMXWvCMKOTA7YidujFD7vdA599zW2
         yWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqkbz42r/JkXQTE9JdHM5dm2nu1g0Kj971dkCS8AvjE=;
        b=PO4d9DveSC4ryjihO5E6xNf88ASW7B111ZAjUk9rUDKQc2koOartO02jfdsBfmNAE6
         bbTnx79X46V3a52BzrFj3bxK2YHcq4i7x2lcD1Q12fQzRM8PBqDY9GmlHY/d9Is0Lm9C
         huxbVa1lDOnUqsJmBpFEt1yuj4E5WjmA4ojDzzrOJEi70NeBHTW3+AsKQNaQnKwBNGgP
         Auv4T0/pI8YtoIqwUZ1jZnnko8RYedo9OOM4HRx8xP70M8L23hlHJB0BCGnM0f1slOVm
         QjcD0j3LQrF7BWGRkho3YyemDHiOziU6K2YDp6hjl6yR8sR6KgFgup2STVax9xk/CcQb
         tgkw==
X-Gm-Message-State: APjAAAW1v7cYeSWc0Z1ozIl/sl/8lVLNi4r24S4yHNWKkl1malpNGBOQ
        WtdFuU2Lh2NHOUgrpJ5AVynM/OOIaoVHLw==
X-Google-Smtp-Source: APXvYqxij2cl8Xak5nxfQjV4vpcP7YSzfaEmiCLsngtqKa9nIR+Zof+eXjOIOX2fxJR36Lo1BdM1fw==
X-Received: by 2002:adf:bc94:: with SMTP id g20mr14398118wrh.206.1558783564787;
        Sat, 25 May 2019 04:26:04 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:3ccc:7074:9336:6a6e])
        by smtp.gmail.com with ESMTPSA id y16sm4942010wru.28.2019.05.25.04.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 04:26:04 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Gen Zhang <blackgod016574@gmail.com>,
        Rob Bradford <robert.bradford@intel.com>
Subject: [PATCH 1/2] efi/x86: Add missing error handling to old_memmap 1:1 mapping code
Date:   Sat, 25 May 2019 13:25:58 +0200
Message-Id: <20190525112559.7917-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525112559.7917-1-ard.biesheuvel@linaro.org>
References: <20190525112559.7917-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Gen Zhang <blackgod016574@gmail.com>

The old_memmap flow in efi_call_phys_prolog() performs numerous memory
allocations, and either does not check for failure at all, or it does
but fails to propagate it back to the caller, which may end up calling
into the firmware with an incomplete 1:1 mapping.

So let's fix this by returning NULL from efi_call_phys_prolog() on
memory allocation failures only, and by handling this condition in the
caller. Also, clean up any half baked sets of page tables that we may
have created before returning with a NULL return value.

Note that any failure at this level will trigger a panic() two levels
up, so none of this makes a huge difference, but it is a nice cleanup
nonetheless.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
[ardb: update commit log, add efi_call_phys_epilog() call on error path]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/efi.c    | 2 ++
 arch/x86/platform/efi/efi_64.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e1cb01a22fa8..a7189a3b4d70 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -85,6 +85,8 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
 	pgd_t *save_pgd;
 
 	save_pgd = efi_call_phys_prolog();
+	if (!save_pgd)
+		return EFI_ABORTED;
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index cf0347f61b21..08ce8177c3af 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -84,13 +84,15 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 	if (!efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_switch_mm(&efi_mm);
-		return NULL;
+		return efi_mm.pgd;
 	}
 
 	early_code_mapping_set_exec(1);
 
 	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
 	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
+	if (!save_pgd)
+		return NULL;
 
 	/*
 	 * Build 1:1 identity mapping for efi=old_map usage. Note that
@@ -138,10 +140,11 @@ pgd_t * __init efi_call_phys_prolog(void)
 		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
 	}
 
-out:
 	__flush_tlb_all();
-
 	return save_pgd;
+out:
+	efi_call_phys_epilog(save_pgd);
+	return NULL;
 }
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
-- 
2.20.1

