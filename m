Return-Path: <linux-efi+bounces-5340-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A94DC2C555
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 15:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8DD634A3BF
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F7230BF74;
	Mon,  3 Nov 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4QrUr0k"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B72F261D
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179010; cv=none; b=JZgMyXnheigxfq/v57tGplY8K7mWUxAuWTX/xhf/c+L6edh25A+8WCmSwJnSS1eZdCD+SbGz4U2vHOqf8BnfqMta8tlrHVWKK1S6NVAcxacJ7Y2xSZXTsuHf0t9A418pbwllaxCOLjwQsHgVZ0vt8bQn/KiuhERy0kGKJXVHXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179010; c=relaxed/simple;
	bh=nU7SRhisp51jqv6vpBzE4wByVuhH4GMe1baLCOf5/no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlPNqi+MHY9c5mCp7uAT6i54RiuTuSHZ1hI9lxwXR5PGrHzKNP8297Wop/sdn/nADgBNf582re2rVY+D0sP7CbVoT1PgrOJeU7Gr87LXC6g8O0rvG7Mn2HLYzZuMkOULSKQrHQ7IlU7mn8XBFWIQmzgHC4MtlRSelhxG5NKxX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4QrUr0k; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e16fbdd50so3761257d50.2
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 06:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179008; x=1762783808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RffJKsZYwfIeClOJutqJXe8g4YN0czoTWsjwNOQNhJQ=;
        b=c4QrUr0kvtiEEvbenCUDibongxs2H9HPXrYxaf4YD4Ufa8hvjEbGS2EO6sKH3dx7Ug
         2VtpYSbFpGWGt488uCK/HRzjP40kEpgPBCajBOJg+/fY3lJ71AWpN9vfDvvxxQkDM77q
         l5AzGy/xw8f4Bcx4AeJhNQrdcODna5houEPJNXhnuKBNP6ntiPt+K3AEjREyL0LN8/ai
         eyfBKkAj3l+gNvz6ev5X+KswyDMn2c1aw1bEo0Wj2DpDx7VBJj06MNc52O8SqTqsAsDN
         bnCtCxMVP7jJZBQ+ceyc+JELUavAUDxP8WfoWp26pOgDf63wk2yWx5s2/aedwmnZ2zJ1
         sb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179008; x=1762783808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RffJKsZYwfIeClOJutqJXe8g4YN0czoTWsjwNOQNhJQ=;
        b=LV3uFEdpoAh5IQ3pmEmnlfuWgQsMw3pjj4wPjM7PUjXu1zRU2XfNKZlZQ8IvDBc61u
         FaBkA2sZsnOQ+afDyKC6pWr/Os0/C1YFhM6cR/5DB1yGbQxSv7eAwUc6MDH1aKwXuB9A
         nawYnsLhAhc3fZu65mfUMdBFy9qA5nbaGAsj8zleehdSgid/qAD/oa26dgNyc+Sd4kGO
         F4I9dGDfzXGGjbFHs3kMIxW/UAGmbKJ/+KF0UcRMiRfWafEEtzdu1pTQi2L34VcI6dYf
         qp/6/qAI2l5pJwKK/Fq8FpWrivo+lu0Ba6oCOyRkMpYzmjsm5psttbq5n9+qrUouZRYZ
         tdMw==
X-Forwarded-Encrypted: i=1; AJvYcCUUgV0vSMEcpRck9nOgSynD2qcsSnL3amLgY/lSSoG6LN18IjbSNbMQKTSQ4yLsblsreCKWCs84u5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzl+Djctu5BnxxIxYmWFi2azKDd3xdJVTrZq4RPf1D51I+JqL
	/215mTpOhD45pz0IuEJVpIXtINAGsetruzi1nBWhnKwUaRhgdHxSP7Kd
X-Gm-Gg: ASbGnctJAwS2odfl7qr8BDvEtzgvRdAFWkEHq3VQn1Vp+C4J5Uae4+WA1Oind+jjgJR
	VDWH3C4oxZgqcqHIl3KXbySeoQivUGCCmLlQ/jWCj8Ef5j5wzPzEJPmWUuBqtoTKVikwAP4iAS/
	md1VbIHV2fXRP6/BN+qLckhukoM941kSj1JeHBm7knNIH3fcdp778KH8F6Qc0zD9Har2M1gjkbw
	MwqUOQNkcNrZHC+uogysJg0VLNq6hDRWJmgc1jipaCXQpaz38/6GfT6QodeV102CFdWMglZVuUL
	O9Ce460tD32w7fnfszQDDE+RnsNYFOjV464E0mGFacz7Rqa1cfY0nrLN9GCJdi6Ksuxs6Bm8+5w
	oxXFIdBKXEy4o+RwzQFIliL7nc/9DfcrgVV9pj7gijM5DyEltu2Nd0Iy9sONQ8IMQ/YkTCtxxua
	SUB6JCtJcqRg==
X-Google-Smtp-Source: AGHT+IEtG1QUz22cT4bcrn+HqayTfLH7U7XmUZhV5JmnvGzOafUB3S8cEy747cA45LmQRirnSkaaQA==
X-Received: by 2002:a05:690e:d8d:b0:63f:96d7:a350 with SMTP id 956f58d0204a3-63f96d7a4f4mr7403217d50.66.1762179007954;
        Mon, 03 Nov 2025 06:10:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691db135esm935267b3.14.2025.11.03.06.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:10:07 -0800 (PST)
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
Subject: [PATCH v3 2/2] efi/libstub: Fix page table access in 5-level to 4-level paging transition
Date: Mon,  3 Nov 2025 14:09:23 +0000
Message-ID: <20251103141002.2280812-3-usamaarif642@gmail.com>
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
  x86_64 includes not just the physical address but also flags Bits
  above the physical address width of the system (i.e. above
  __PHYSICAL_MASK_SHIFT) are also not masked.
- The pgd value is masked by PAGE_SIZE which doesn't take into account
  the higher bits such as _PAGE_BIT_NOPTISHADOW.

Replace this with proper accessor functions:
- native_read_cr3_pa(): Uses CR3_ADDR_MASK to additionally mask
  metadata out of CR3 (like SME or LAM bits). All remaining bits are
  real address bits or reserved and must be 0.
- mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
  flags above bit 51 (_PAGE_BIT_NOPTISHADOW in particular). Bits below
  51, but above the max physical address are reserved and must be 0.

Fixes: cb1c9e02b0c1 ("x86/efistub: Perform 4/5 level paging switch from the stub")
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-5lvl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index f1c5fb45d5f7c..c00d0ae7ed5d5 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -66,7 +66,7 @@ void efi_5level_switch(void)
 	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
 	bool need_toggle = want_la57 ^ have_la57;
 	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
-	u64 *cr3 = (u64 *)__native_read_cr3();
+	pgd_t *cr3 = (pgd_t *)native_read_cr3_pa();
 	u64 *new_cr3;
 
 	if (!la57_toggle || !need_toggle)
@@ -82,7 +82,7 @@ void efi_5level_switch(void)
 		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
 	} else {
 		/* take the new root table pointer from the current entry #0 */
-		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
+		new_cr3 = (u64 *)(native_pgd_val(cr3[0]) & PTE_PFN_MASK);
 
 		/* copy the new root table if it is not 32-bit addressable */
 		if ((u64)new_cr3 > U32_MAX)
-- 
2.47.3


