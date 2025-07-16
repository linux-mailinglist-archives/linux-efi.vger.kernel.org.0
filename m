Return-Path: <linux-efi+bounces-4365-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D292B06C2F
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC316EA00
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533C289360;
	Wed, 16 Jul 2025 03:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJeJ2FM9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9D288535
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636163; cv=none; b=qb+5iYdYamQyAogvW3pKSB6IDeUNEojs6Zhykbr3Y8dusV3bpcfg3OfPMYpszXi1FelmWb4uEg66PT7ziDa1GITWw4H/hPl+UJoo7r4eb6dJKYhvE0opAiRgg3Pzt7DrIJ+9Q4vFAr2tVhtPOdOEMgCVOMcUGvePKmTXGWQ8t9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636163; c=relaxed/simple;
	bh=88wIbnPP1a1dLhlXMR2D52W04CjhXmRtjIuSBBT1WeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ga+depN6NIi7hsNc6BS3QNMNjLey7+Vw0YcTqFaVRzpGMg7hjGM9uq5U8kzVkANREPIi9OSXzDWlBnP4aDf6PJqyApsK5D0NhdD2Xn/IpNkWMVJQybqHnpYCcOJTuCVNN1gkqyzRXtIagZs6Rp9vltMr1bHWxKo4o49hEorJaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJeJ2FM9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so32000515e9.0
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636160; x=1753240960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgqR5avhQu9i9Y4o0xvmYEmE5OaurZWopQxiw2YEL3s=;
        b=aJeJ2FM9fETy7xnWMpSIbYdTcaykDQLVz48CzV495GcV7FEoJBZPRlpTxwLFZygLNj
         nHLkEE380ShGkuswi8bsgaQuR9U9s3gi0eqjKRt/fFGnZ3H2gYEv6rFMvkabCXGpv3IN
         MYkPvSjvB671Ek5zFsRBXGT01+xEEq7u26p7PEVEqgV5VQH/w0aG8Siz46hF24xknNUs
         MBYrSfbqNPdbFnhvsdvMJJFOv6BaoGBVxc3zClWrgGTv1+8cEsuVQ29FUlRGwMLek/un
         rgaanECvG3DnaI23BuhiHJ4ptmEeg3tCgSV57p0NUNvvL/T08kUAiGGUFvYPdT5QfoXf
         AVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636160; x=1753240960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgqR5avhQu9i9Y4o0xvmYEmE5OaurZWopQxiw2YEL3s=;
        b=Sg8iQKTU4YRUyo9zhslXxdJGwVvuUXxYyRiLQyWwzYAimGq92CjbBJwSmfDleHRUMa
         5KQzXNueG2gk5PE4tm80AfZhYE8jpySrcjVokii7mdG9A6vjuBLKPs5WnRkf2ebzpcdp
         s6obV7E+l2j5rpvxVuUCjHszMJd952bgRdFytxBhN+STSNngi4pdmsdBCQu5DexMPYcE
         2a/FinSAAvevEs9Rs4WG12tbkF1NrPOnB6fsGnVWL9/7n+wk6HPdjdEv3j4rKQvypXZJ
         8UHeF/UmZKSvKVdCgTqp5h25dgebAaTCJQaZ/hPiRK6amTFmBkSfjaix6lgGm4MazwP3
         odaw==
X-Gm-Message-State: AOJu0YwD5uMRjBO/IDDUyMqi7oslMFU62I6m3PNbWiD7yIy9RZzCxZrW
	jrwS+m8sSFUdQnv/AasU8JG7FsUEA5P9HGHGIFHIHCRpG+BQY/XLtFSzjTo5M1QjEjEvj9gjXg=
	=
X-Google-Smtp-Source: AGHT+IGNDfT93GRklSDbt/V6sAfbq3BH1L4gJ6IzPmLpDANp7jhdkluNQYfT0JK8YTD3ck/cxXvNFxpd
X-Received: from wmdd25.prod.google.com ([2002:a05:600c:a219:b0:456:ddf:4040])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c11:b0:43b:ca39:6c75
 with SMTP id 5b1f17b1804b1-4562e274934mr9819455e9.16.1752636159879; Tue, 15
 Jul 2025 20:22:39 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:26 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=ardb@kernel.org;
 h=from:subject; bh=/aZ0V2A8zhGGvGqcdFjf+IBZLj2TZ6Tesp02RBGOQMc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcynSSWNjG0OSpmodPnfpsJmdVO9v7Ro+IyR6mOx6pA
 ZbXUg93lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlY9zEyTFwfynm7M295v5Bb
 n1qk2Grm85Yyc81vpJX9qgsRYbGayPC/flrFU51MW+4dlUs2RKbff5KuVah2Wp3/5+R6Z+7p/LN YAQ==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-35-ardb+git@google.com>
Subject: [PATCH v5 11/22] x86/boot: Provide PIC aliases for 5-level paging
 related constants
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Provide PIC aliases for the global variables related to 5-level paging,
so that the startup code can access them in order to populate the kernel
page tables.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 533fcf5636fc..1bc40d0785ee 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -52,10 +52,13 @@ SYM_PIC_ALIAS(next_early_pgt);
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 unsigned int __pgtable_l5_enabled __ro_after_init;
+SYM_PIC_ALIAS(__pgtable_l5_enabled);
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
+SYM_PIC_ALIAS(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
+SYM_PIC_ALIAS(ptrs_per_p4d);
 
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
-- 
2.50.0.727.gbf7dc18ff4-goog


