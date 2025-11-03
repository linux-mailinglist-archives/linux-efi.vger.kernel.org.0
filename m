Return-Path: <linux-efi+bounces-5339-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC953C2C5B6
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 15:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA93A9425
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59132FF64C;
	Mon,  3 Nov 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrMy3RgC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589C2C3256
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179009; cv=none; b=N3WkFatLPZ7h3N0ThEnLlzxJZe/RGtM3asY0hdVtyWdpDoYCQW1iAPbsWPEscfMZF5mlL8Zea+8hw6oqE+K7Cs6CacNzBKbAyPZNssS8YiAruKLeXdvs2pGcRsoadp576Q++rl5VXWSIc/RT54sHjWhxISqMFsOxUXOv7OCCkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179009; c=relaxed/simple;
	bh=vFA033Qsh0V9dHRxfZixdaC31W15d3Y/0CdWR8hNBm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic8kBO0qSlHbsJ4WUOi33+I9WrSwME/cnm9PLnOsvLvEFAkwsGIa3RBac/XG0W3tYi4KQKJcEG2ACdwndt8F0oN2vO2nSj4kUzdT3/W7s3YNRK9z017W2AEEuaIe9CX7zavBVuOPbPJLuuelXFcmPVUntfENjC/go3ktim+AqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrMy3RgC; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63e336b1ac4so6817338d50.1
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 06:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179007; x=1762783807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfQyk1ATssChWIZHKh68xWHNZI/4pYmTFVMCY0adxik=;
        b=HrMy3RgC6CKad7GU6hG9h3G6NucEBtMw+cHjhR2S43hmdloDMyjUdPKms9qoTUzKxR
         O/ZYFxOgMWpqNlUbS/dMvErXhK2IC2QmVRQUluvtyKkA9ihCGIx60NYZeYXJnS8yheoL
         B7hQWefxks3YN7YIyvQHvw66jR7xjib2aS2OPzXZe2oc7ETxabC1bZIy0h+8TY1dI5CF
         7xMgV8UHAN5pYM/t6brVGXFP6MHMSVGfZIE61rQ2VkTRAwTr7pHBIQwdPHelBdKuUvP/
         c+ehmjGFB+V82BQZM/TRv9kHrrTYnXJnyeG41GpD7uXpB2/lb5hvcwjA95gKH9M0CKoV
         di2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179007; x=1762783807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfQyk1ATssChWIZHKh68xWHNZI/4pYmTFVMCY0adxik=;
        b=eqnNnEO5ULAhJsJXTcgzK3Nk35GjJhYcoHVptc2Ppghl2GA+fG6nO4k7fe4/0YeLVJ
         WFuBhJcwA+O9nl48lUrDPwNy0/dqEQQFs0v/jmhtW+S3beHxo5YsaN3ipOcRLNMcRULO
         FuNi7IMJ/uUj1oMKy1x0a37LXRgGjLdoBH+XawoMqKDWIhktX629pted0lArq7jRrqIE
         HXxCWefYnojGjxXS+b+gP+NwX6MSVfhyLsLFuqY2ezaTbjooNznA+0oQxHbF4jo5eQhY
         cmvE+xtCfS+HIopvqyMLZkVtn0hil/1E6R6y1B6RNRIhdbtdH3ji+J8ZI8DvEaaUZdT6
         /I7w==
X-Forwarded-Encrypted: i=1; AJvYcCUCsHm3+Ln4Deah3zUWmwWDBjgil//h7ot0n6oKKOm37i1jgeHWe0qw++5t2oL+sC8ZGmjtg4oPOMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekTSZymhJyB3uQuOHDixDK/n1AjezkWkTC4XE2EF/AoGD9qAD
	Q/XFj/XXrYZSx2W8W6bkmBTNowyQLpCpRyQQY/EeHKRu0CwZEjBV+0rb
X-Gm-Gg: ASbGnctItRWhtMj2RB6bbuAmFlFC63g2IcWRb9/XyXsp8lpLjYOXXp2e2BIu/yXujW3
	czuiwHSEjM1+oNecMA09DNXe/SINornBaPWghPkRz3+TIq45/uPDqcDDBRMjFSgdQ3BPPINcThg
	kEdpv8k9lzlNp9Y3UQ62YrgDps4kVFoA9wpw1novVmne70LIhKfm+C429i4C/RqwAfOwYUkSp90
	L6yV45pI7GRTUO7aHUvxqxLbt9LK5bM2Ik2hsEzZy3idFZP8MGxoxKDPbHcXzEfNGeQAzKyR2Mi
	vwqD4usfxS4559vFN3Ym50/DZRcmUAvS3rmyhQ6bpKFYA8MkA7kbdaU/4LGhMocx921hPobc7zU
	K6ShWLCr4spK9BCJ1+kpDpFvLeVgyx4XPODpNbYLV9ZwAylqFC9zgYOGLGjmQbXAkSyJ+8Hgn+c
	XhUhPTNnxpBzkk01uUjA8=
X-Google-Smtp-Source: AGHT+IE7lqjpNXxghnMZod6+D4zbN048ddiMkCK1yfatGXisy1rmBb6LaTKcgH0DfjJR6u/iLeBUoQ==
X-Received: by 2002:a05:690e:1a67:b0:63e:1a6a:abbb with SMTP id 956f58d0204a3-63f915b1277mr7510237d50.19.1762179006787;
        Mon, 03 Nov 2025 06:10:06 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691d900fesm942047b3.1.2025.11.03.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:10:06 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: dwmw@amazon.co.uk,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	hpa@zytor.com
Cc: x86@kernel.org,
	apopple@nvidia.com,
	thuth@redhat.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: [PATCH v3 1/2] x86/boot: Fix page table access in 5-level to 4-level paging transition
Date: Mon,  3 Nov 2025 14:09:22 +0000
Message-ID: <20251103141002.2280812-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103141002.2280812-1-usamaarif642@gmail.com>
References: <20251103141002.2280812-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transitioning from 5-level to 4-level paging, the existing code
incorrectly accesses page table entries by directly dereferencing CR3
and applying PAGE_MASK. This approach has several issues:

- __native_read_cr3() returns the raw CR3 register value, which on
  x86_64 includes not just the physical address but also flags. Bits
  above the physical address width of the system i.e. above
  __PHYSICAL_MASK_SHIFT) are also not masked.
- The PGD entry is masked by PAGE_SIZE which doesn't take into account
  the higher bits such as _PAGE_BIT_NOPTISHADOW.

Replace this with proper accessor functions:
- native_read_cr3_pa(): Uses CR3_ADDR_MASK to additionally mask
  metadata out of CR3 (like SME or LAM bits). All remaining bits are
  real address bits or reserved and must be 0.
- mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
  flags above bit 51 (_PAGE_BIT_NOPTISHADOW in particular). Bits below
  51, but above the max physical address are reserved and must be 0.

Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/boot/compressed/pgtable_64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index bdd26050dff77..0e89e197e1126 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -3,6 +3,7 @@
 #include <asm/bootparam.h>
 #include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
+#include <asm/pgtable.h>
 #include <asm/processor.h>
 #include "../string.h"
 #include "efi.h"
@@ -168,9 +169,10 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
 		 */
-		*trampoline_32bit = __native_read_cr3() | _PAGE_TABLE_NOENC;
+		*trampoline_32bit = native_read_cr3_pa() | _PAGE_TABLE_NOENC;
 	} else {
-		unsigned long src;
+		u64 *new_cr3;
+		pgd_t *pgdp;
 
 		/*
 		 * For 5- to 4-level paging transition, copy page table pointed
@@ -180,8 +182,9 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * We cannot just point to the page table from trampoline as it
 		 * may be above 4G.
 		 */
-		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
+		pgdp = (pgd_t *)native_read_cr3_pa();
+		new_cr3 = (u64 *)(native_pgd_val(pgdp[0]) & PTE_PFN_MASK);
+		memcpy(trampoline_32bit, new_cr3, PAGE_SIZE);
 	}
 
 	toggle_la57(trampoline_32bit);
-- 
2.47.3


