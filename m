Return-Path: <linux-efi+bounces-5089-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC98BFE5FE
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 00:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DB724E99F3
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 22:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5548305E19;
	Wed, 22 Oct 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qur18Nyp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C72737EB
	for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170895; cv=none; b=eB1HTijsYFNJijz6zVKjyIZZ6/gTcjSkjwJqmPBTeSrIMQsWHmzalrur4X1Wo59ipR0N2tdEKOQhp5OgX9ynzVGs4ymTU9g8l/TnJ2IhiBnH5aPntOW6nFd2xV/77xvaX+NztyuUpXErLeMQ+P2hcyfw9bH+0b2T7G86/F9S/jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170895; c=relaxed/simple;
	bh=KQIGFzmAYRyXSdbUX+RgCwLRAv32pLKb/020FZ7a3nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMNELSLR7JIyUmtLyKqwzJxkk8yZJU6/cgHj11UXCX7tNgCGsr0KiCeBA7phUYqhl0fEYEQ6jvemacWOq7DuN7ETVrJCXKvdrsSll26SVLrhF73aOlTH0Q6xLTHeK0zh00mp2Hhorys4nKhjYpFdTShhG+aOytvQ2kzBtkZxw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qur18Nyp; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7847ee5f59dso1140517b3.2
        for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170892; x=1761775692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6blalMI7pjK/QAa4S2qPt6VbRmiBWwvMB4K+MYA4ruU=;
        b=Qur18Nyp6yFRnK9gy6pJ6fYthLKSTx2Qs4gG3QZ+z57j5K9AHZoLtjr59a/Hd1aLFE
         yPfrvNSw7swd6Xr+GNPT8efjByhLbXRkOapGuLACr2z3RjqHZpqbbYmmYxDWaGuvRDlH
         yWRQ4UbVOuuQnm4nnZlVvc60Y9AwIIL5bT1wFv0GrA+zz4ZgM1mXNN8iqnTOjPVaTTZu
         68vDiJ976VV45R5Lk7/Cn939HwVdqkB3ATkXRP/VD3t0ZKxdYhhhMeBvxD1HGKVbNxbn
         /Exu8KGb/kiZY/bCe3KJgeZj8VnfkMw5fbwgKGYBUNQN7omTt0+ykitoL2dGB8q3OE7n
         NfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170892; x=1761775692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6blalMI7pjK/QAa4S2qPt6VbRmiBWwvMB4K+MYA4ruU=;
        b=XCIHI+1LsWXcrxkwNWJfaGLvfTj2lkkwCo3F52TIkrhtRCV7XHn9k78ZLd6Mjt6Gl5
         g0SmYI2KSpnDwhzHNliEl6PWqAlIEp4HzCRM1lC2Pt232XHE1x40fn9uhjWCkLdUT9R8
         aCHiR5w8RccAY7w5VEHkv67Ky1PIL+rqr4ktmHnD5qjBjapD8dQF9+BD4I0jWOhEdkj2
         q3tQ6LuKzMNoW8Okt4mLTAa3JCtb9KRn9pjXZNQMz3nf8/sVU6ZgQj+274XEc+bIUkVS
         jIVMuG4bG6Ft7l5K70vw1SRIa25CgYI1rUzUkG9sAVNLqW/l3hvaGf7km00htjNnjmMp
         4eww==
X-Forwarded-Encrypted: i=1; AJvYcCWEGChkN94c4RRsLOogslMN176iNjxUUB2sga1FIZPc8Rs6psjuvCv68wLBNuhksxBQzwl3xD+B0pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuL7mNIAi0sgVrDWurRr+G3MfXeyqfoyt9OWrJke3v0Wbvl6tJ
	FThoR6k1zKmIQ9i+QQfI8U3O3QzvrThvpz1XHXClHCvXhI1IZeMuRoJG
X-Gm-Gg: ASbGncuQpMpil9Pu1XBDXQBllb6YK7N8QNmfmCcxpvT0LI3wiFCC7FWJVxWgruV+3gT
	KG48wxfobvV/i15K+WN0h0fDO80UXl2KGWpubMPATtBhCOhv1mDTMciKouE/lSaRjBXfafaeAqG
	rYcx4EvJWKdo3DxmvW5J+lp3PwK7N5sytdw2mFSHDB8EhKTmXqJ43ytaaZxGyb/kPhQ7xUf30yf
	E4zf2SfT6Q6ZEsGiGatkhl4uy1rvs/9RRyGRhiNGU5c0aH06hCdt2hVM+ScWxkily7ni4ZCtrjq
	mJIPfCvxtQArdB+LNnlC0rolNE/ux9lZRWWyCywhbcifj+z13gFr35LPeciVu6nDvEUQvxis4d9
	CMEXFmTE/oZHDV0FQ9Nf0OLXc+Ky2XGB7hcCWvZvKSsrkduj1DQKOjfiBahcRKLnOPgqkBlt1Yz
	5su+ueRqAFPg==
X-Google-Smtp-Source: AGHT+IFXVrPvL1VuTTszR0uDwutiZjSZ0W2IvbJne6I1t9VPd3VOIWg798lMRuSLVdauJ8ly3LMvDw==
X-Received: by 2002:a05:690c:60c1:b0:762:fb09:da8c with SMTP id 00721157ae682-7836d1fff8fmr199848707b3.28.1761170891761;
        Wed, 22 Oct 2025 15:08:11 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd5e6f40sm1272807b3.21.2025.10.22.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:08:11 -0700 (PDT)
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
Subject: [PATCH 1/3] x86/boot: Fix page table access in 5-level to 4-level paging transition
Date: Wed, 22 Oct 2025 23:06:25 +0100
Message-ID: <20251022220755.1026144-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022220755.1026144-1-usamaarif642@gmail.com>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
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
- read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption bit
  and extracting only the physical address portion.
- mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
  flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).

Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
 arch/x86/boot/compressed/pgtable_64.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index bdd26050dff77..a56449938b7ec 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -170,7 +170,8 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 */
 		*trampoline_32bit = __native_read_cr3() | _PAGE_TABLE_NOENC;
 	} else {
-		unsigned long src;
+		u64 *new_cr3;
+		pgd_t *pgdp;
 
 		/*
 		 * For 5- to 4-level paging transition, copy page table pointed
@@ -180,8 +181,9 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * We cannot just point to the page table from trampoline as it
 		 * may be above 4G.
 		 */
-		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
+		pgdp = (pgd_t *)read_cr3_pa();
+		new_cr3 = (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);
+		memcpy(trampoline_32bit, new_cr3, PAGE_SIZE);
 	}
 
 	toggle_la57(trampoline_32bit);
-- 
2.47.3


