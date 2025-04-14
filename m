Return-Path: <linux-efi+bounces-3328-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD9A88119
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 15:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103F53B820F
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 13:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A015CD55;
	Mon, 14 Apr 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/yK20E5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9C1547F2
	for <linux-efi@vger.kernel.org>; Mon, 14 Apr 2025 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635868; cv=none; b=jV1FLQIohwmWcdXeKCUPG7Wmkzcay3JHXGSFcds1GyabhsE7TYkms4qMV3cVG/I6PF8zXYSYqLkItWzgw8CAA26rQmY7O5rNn4jikpargulx20Gkgtog6plK6BnmmkawjHmGsJXEI86wm5Nx6CPylv00uqW2CwQmutUOznuYuJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635868; c=relaxed/simple;
	bh=lQW7T3zihemZmzdrOBiP9dliTYs4FytRf0yt0XFRgGs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QUFakmllBYmhkXTos4y6oSvABz/IS7oT2rearvUVv8yPvvywsmUoQ8N2dL3KNw8u+M24lIziZ3zPJlmCA/7o2Hm6+/anoohL8YRFfsGv6JTvfXPEjF1es1MRK+3cHoUkUJv5WnEqM6iT4ngQQDH5ODegdNTWm/O27+QsQLx93QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/yK20E5; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39c184b20a2so1989757f8f.1
        for <linux-efi@vger.kernel.org>; Mon, 14 Apr 2025 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744635865; x=1745240665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=90z5BYjm+GnPAldnLugn0ZfKCYdU/jqXvR9HE9Ehnz0=;
        b=y/yK20E5t8UQejmrnjnXFIWPECUuXYhm00cMRIwlWjWu10/Gtf7rLIvag6MmrD5I3+
         tmK0MgQSROUNRUPHggkWI8T3wrRC2XVOJeLsuwzLylQifbSbDiZM/E8/TjB5xlvkio5Y
         i//Hplv4sue1qYdvt0Xtbm/skoGECx06F8WXUBCaxQPe6iGwDmxp1GNmSzKVQ5m6t/Zx
         YFyc0lrB5y1KIEbQVwYVAB3QmtRJpWZkoHssuthkYmJh/Kw+xHqFjYMLWNQWp0yYac7C
         7u34NHOAXRrOOoO0tn/BeBaLrFuJnzDnlDO5JFvTKPRPBvgiUDihC/xwDcKnSWnDHhe3
         Ll6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744635865; x=1745240665;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90z5BYjm+GnPAldnLugn0ZfKCYdU/jqXvR9HE9Ehnz0=;
        b=hb+JRFxKPEf/mZUW0MZ9aZn2JERZRIoGNxtW2JQnIc1o5jJmYsRd+/m2tt7ZWdOGIi
         bBdeMdNkUp92pdRBMTTApzZzHBlYchFI+PktshxrpKtrejxK0xHwEZCat1eoeGEzToUX
         q9Gn7Ul/Sdt4a7s5A9aTLWgLyBThmeP/Gbf+C02DpFjDyVFVsC7QGegOzQn9hZXTtCHz
         QeXyzCg5KdYQCla333V2O8tAqCdTzkZh9Qof/bNCMHy9X7MM6qyNB7lTYcWqt8Z3QK1N
         zdz1TgDX9WnhIcXUurhLjZNhY61VCevqyLGp71Uk6nPnFU5nw8yuRKNAKzJ6AlpwtUZs
         Sl9Q==
X-Gm-Message-State: AOJu0Yx1P7vgNnlo6AYV3dMx/Ww5JH93VGq6F4GbJq4+76Zt+qd/O1m5
	frpF7AFr5qq8m7pWCAmSa7pUDDwsUC31YZ2BQYySFn48sa7r2yBOkeI6+Efyo5uO5RmgNRWUiMp
	c0i+/AVC+yyn2hhWLBlyBNLq8+n1lQ50uZGG9uk96rXkKxRTwjMNcnBcFMpdU/jRWrWJTuVWPfT
	kcT8vd6N2G6zfNArWRBK74WvYYTA==
X-Google-Smtp-Source: AGHT+IEGDtaLV21TS9M6AusnMQuE1Ec2LybBBB25wMJDrzLnyC4GyK+5F1ANzoPAJAaJceSsBm7r64iZ
X-Received: from wmqd20.prod.google.com ([2002:a05:600c:34d4:b0:43d:4b43:fdbe])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2d0e:b0:39e:cc10:3945
 with SMTP id ffacd0b85a97d-39ecc103977mr5494984f8f.2.1744635864797; Mon, 14
 Apr 2025 06:04:24 -0700 (PDT)
Date: Mon, 14 Apr 2025 15:04:18 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2541; i=ardb@kernel.org;
 h=from:subject; bh=5kYGxg9fXpaFglGiVTmtphQc+Sq6J2GzsAxQOw/HrCI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf0v+6VjzN2/dyZHHk9JWcur+byjI2H+P36rGKeHLOHcF
 o9kjaw7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERmnWX47xv944OTldeEd6s3
 7BU4cUdWs2GGpVehcgj/pVNrfnE4zmD4K6oUXThPcvI/K0f+eRlWzDcaHFuSAla0ypkFnWmw39n MCwA=
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414130417.1486395-2-ardb+git@google.com>
Subject: [RFC/RFT PATCH] x86/efistub: Don't bother enabling SEV in the EFI stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

One of the last things the EFI stub does before handing over to the core
kernel when booting as a SEV guest is enabling SEV, even though this is
mostly redundant: one of the first things the core kernel does is
calling sme_enable(), after setting up the early GDT and IDT but before
even setting up the kernel page tables.

So let's just drop this call to sev_enable(), and rely on the core
kernel to initiaize SEV correctly.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/sev.h              | 2 --
 drivers/firmware/efi/libstub/x86-stub.c | 6 ------
 2 files changed, 8 deletions(-)

I'm still waiting for my SEV-capable hardware to turn up so this was
build tested only.

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7427eb233990..1db906d6924b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -442,7 +442,6 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
-extern void sev_enable(struct boot_params *bp);
 
 /*
  * RMPADJUST modifies the RMP permissions of a page of a lesser-
@@ -533,7 +532,6 @@ static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
-static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..52ed13ec4fe9 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -925,12 +925,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
-	/*
-	 * Call the SEV init code while still running with the firmware's
-	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-	 */
-	sev_enable(boot_params);
-
 	efi_5level_switch();
 
 	enter_kernel(kernel_entry, boot_params);
-- 
2.49.0.604.gff1f9ca942-goog


