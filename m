Return-Path: <linux-efi+bounces-4636-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BD6B399A5
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE8468074
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0462F30E0CC;
	Thu, 28 Aug 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWSujQ75"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F030DEA4
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376570; cv=none; b=JRov5qpIf93AP/xjl6RgEZq2GXahGQsw/Xwqiy+kDthbXxsj2LsX/QhItQi7c9Mymg2HiKnwtSwA1j3F39QiF1wiqruJtY+ydY3VM92NGWYWrkMNyXCOSNzqAQimpApjpYnxy032ccVP/lUzDF76ItBL2ur1UNOu2Tnslq2/1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376570; c=relaxed/simple;
	bh=L5OPBMNERIorebPLCitdWWYXRB3zMTwpP66dKgU4iUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCIHFihFEC3T6OVYukV1gpKXIKzBH03EtjSrp+9cn1MM05VfM7lRA26vD06DC+cvIHZgIVuk3GPnIL5Mz2Zsh5drwxCkno8EbDg5eAPtiyVLQP5ro0rYmYNweuGZm6BpgIkwUlcP+merilckihsX5cBCUm+9RI/CdTO/2IRXsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWSujQ75; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ccd58af2bbso585229f8f.0
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376567; x=1756981367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XaJpL8jKywahQIGYh+IMsHL6Z6ULbMaLruj54BTvvjY=;
        b=RWSujQ75q+NBFQ9d2bRhpu65w4xBvL6BlKi/S/jw38SlVnf+sbx8Bs5dneoP3O/6Vj
         5rhzqvBF0fH3O9EJvld2D5QlpARb0D/858OJllhwwt1bQ+mPQ7W4T33G2LqAC1sVcY9u
         /4TbriojqaUwquj0zkRVX1DDwVQDGnqaasJviEjNRgCU6/9DOKWrUD08JlhJyVjo/jLN
         wiyDcgX0EzULC5KXU7ZQdCQ8BjaJS6odA1SCHp/c/KEV+yIX0Nh2Ea0kvxfLr9J+RS1O
         m2551K/bxObt8+vcGHnrnsOaNgkVoZBZfR9CAtzUtrbtRVI3xT21zu9lHoEqShue18AN
         XLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376567; x=1756981367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaJpL8jKywahQIGYh+IMsHL6Z6ULbMaLruj54BTvvjY=;
        b=xFg2XBs7RGY/CDrUYklcUQr8QYCfT4jz6wUX0R3v+nGnLye58jLiw2lNAmJBvyP9zH
         D6ip2ozGtAZP6/jbrf+hQ5nghl2nvm1H/KT1KiifnTDEmBaCNK5I9WUFhZdoCBZppsRn
         kYUAzOAJX29Qtk0kn0xdSQi8Qo6eN164VH/tic3Yno4u1UbNLJdrUvEGGwwWMsTLDGmV
         aipXi1cIC3tRc/iYJnxMfAcBP7r+ilK+IK5bVyMzgLMFPUb3E7MlgOc5O/twCPuJx+m2
         KH4QS4YdPdrZnswowQ/unmEXqmgRMIMjO2iTS+U3MeHGqHSpc/mIDYftTxBaOJuVzIQ8
         QtzA==
X-Gm-Message-State: AOJu0YwYSCyePY+y13+tJC2foHuHTZwPdPywSjB3N8xOjuRm9jIGK+UG
	Po36FSivDIkfHMNJeXDE/d5xTmrHceeAwOGIaAYUsjID5FKyJhC3Uqpljez4rwkpAp3/7vnFRw=
	=
X-Google-Smtp-Source: AGHT+IEhFhvZFfYqgoI+yglrrAcVCrV8WmuhsfzoUM7Gzcti1M88OdREtqQfEeL9jz0hSC/a+wtRFaO6
X-Received: from wrbfi2.prod.google.com ([2002:a05:6000:4402:b0:3a5:7a8e:97ed])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:50c8:0:b0:3cb:fee1:de33
 with SMTP id ffacd0b85a97d-3cbfee1dea7mr5302998f8f.7.1756376567632; Thu, 28
 Aug 2025 03:22:47 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:14 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=ardb@kernel.org;
 h=from:subject; bh=C7hRv/57XB72AG4RPN24KyXGqFt68aWMEWowtuf+WwU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7o2eS1HPc8Q5dfKzTqQn3O8qsfLhsil4nXNuXsIqL
 Qmj7awdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJShowMTwo/unWkb1e5+HOT
 lSCnXfHCpxG20b6/p75RTdCQSTHfychwIihNPCbec++u/a8XZTpFPtC/ISixt9b78dRb6dWvvjm xAAA=
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-35-ardb+git@google.com>
Subject: [PATCH v7 11/22] x86/boot: Provide PIC aliases for 5-level paging
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
2.51.0.268.g9569e192d0-goog


