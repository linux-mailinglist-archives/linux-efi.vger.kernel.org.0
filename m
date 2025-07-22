Return-Path: <linux-efi+bounces-4448-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DEB0D351
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7EC3B0B62
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69C02DF3FB;
	Tue, 22 Jul 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnNX+jio"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773C2DCF4F
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169405; cv=none; b=OVuf/Ocbh3R2veaean0mEDozDJIHURYLix1UnpnT7zrtsKJbZY3jym48EQiJtawK3yUxGGWQT7BPJMMxkuToucWoNWK9bPyXRWEEB8hljV3XT2EKNBaRKU75rmMJ3ZAKOFltpu223F+0ApRWSbty0SH6pujUt0XswOPcfIqN9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169405; c=relaxed/simple;
	bh=88wIbnPP1a1dLhlXMR2D52W04CjhXmRtjIuSBBT1WeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q7lD0oy4qNMHaCNK70W5LknDcWWtD6qykZisiTNALGrMeOsygWeU4CbcIVb404h5X8sqBR7hieq/CMp+H072KEmKjBDrv6ZmrZ0nYaGna6SOxes6hp/tgKAXwTV77GoRromZ7KhpB8kUeylRR19J0Qh7+NPH+zCSRx9OABZKKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnNX+jio; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so1915495f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169401; x=1753774201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgqR5avhQu9i9Y4o0xvmYEmE5OaurZWopQxiw2YEL3s=;
        b=OnNX+jiokZaqpVdU1aKIN0BR4txptgQkcC1UbbEhuabFZvvq4OTIGbWS8Egu3C8R6j
         8V5ySX9uHjJrXoaWthVQuG/qrcEIg7bKi8LARmxoV3Ge1VDdRxAoSkVppHjsCU8zK6bX
         ix6FGs5rm8c4/goBi8Vou9aYTUXMNT11nSMrcD1Nf9eiOMhhLqTo3Fn/rC63LG0lyMTZ
         vTprentHoy1Q5RIM0mcRQHpIHpBaWCkLL8nP5WMt3O98+G80gZaqcvJM2lGvXtmpTssR
         6LOGgp++Jz+xtjGCkZ2wWv2oN2pzsRuTh6LOyIuv0tyG2UDea3/WE/HZehK+StWPavEK
         BXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169401; x=1753774201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgqR5avhQu9i9Y4o0xvmYEmE5OaurZWopQxiw2YEL3s=;
        b=uG6vI6Jm3LgLpAg4Z4hheG6Kv4fEgE3LjqHTB5onsk050uBYKlVidodQ9jjQBkITj4
         kmpzSvnJvBCrlpxavhgKCCeaaEmfLlcR0P9ocm5fQRCFv5HFHAAncdIRg6jYgZFLMw2T
         Mb/Zl7yB0ZSo0ZPwRjSNR4vIGa17J7NzM2uER+ul27G3+vVr9x6oMkcZ5a8EYa55leRZ
         KzvNWXcBjcW4LHGiJ4lvy6KmG2BDjFNWpm+vIdccyWR2fkmaflcITJS52BbEb4T4yuzp
         DGRE7LuBeLU/sxjIJeKvCH9jzmaRItmz+xZlSQ26oD+F7MupiamlNKf9fek2fraQt9Qo
         /ghA==
X-Gm-Message-State: AOJu0YwAM6qUXfGJzMyzeKI1USoyhCd0B5DPHkC6GKe4UilN2QmM1fFf
	/K5fSx3GNYo5zG5G7zwkwqbPcu6TOCLnXzDtBU980Nk2stTvRORzOVAebRDALp/HIaDLYZ4pYg=
	=
X-Google-Smtp-Source: AGHT+IGCqMKG4sGv9H7gbMZ1XZ+2/FhEzlXHBTMD/rugj0ALKPXeNFjqm6AE32QViBixAzLnaDHRef5G
X-Received: from wrsy4.prod.google.com ([2002:a5d:4ac4:0:b0:3a5:260b:656e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:18a4:b0:3aa:c95b:d1d9
 with SMTP id ffacd0b85a97d-3b60dd643f2mr15394927f8f.6.1753169400968; Tue, 22
 Jul 2025 00:30:00 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:20 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=ardb@kernel.org;
 h=from:subject; bh=/aZ0V2A8zhGGvGqcdFjf+IBZLj2TZ6Tesp02RBGOQMc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPetnmSWNjG0OSpmodPnfpsJmdVO9v7Ro+IyR6mOx6pA
 ZbXUg93lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImo3WL4n5ie0SD874F4qHnp
 nZi+R29O/5rpojvV9ejC+s0zlp6yqWT476lyaD57svt/k5YpbFcPHDweZp14d9bThI8V5cd/xK3 fyQ4A
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-35-ardb+git@google.com>
Subject: [PATCH v6 11/22] x86/boot: Provide PIC aliases for 5-level paging
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


