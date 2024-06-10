Return-Path: <linux-efi+bounces-1195-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EECF902AF8
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 23:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA71C213E1
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A871150997;
	Mon, 10 Jun 2024 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESLLrWpF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA7142620
	for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056397; cv=none; b=X2SrlBVeW8sF2GhcrFfbUmGwdEJbeMToGBj1eFeWjY5cYb8FS0EIRkOhaqZmUqWLlSnQp0X+7RQKB5LavJcjb3E19vM2h8x/Um6Md2kbVTm9lD1N7n/dXTMd65N/jI0CnU6gdZSRdByXgZx6NTwTBEQDTuL8sn17lBSqe0zO6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056397; c=relaxed/simple;
	bh=ors6TGSS555u8w5/BEBTLpSfFApESPLcCaFdpXWpYs0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oCRNAT4gbD0bBtcqi1qzl1sTEqqjW8rtnidqCewgtCPAx7UYbxtWZunFuVKv6QX6qgBwn7FOEwGSHAnqCltOff/FN7trsrslmi45v+tmsP4vIDmUM3+NNvEbvKv++FZKxhmeWicPBZF7hK+XFcPxqeNzFw+N5axV7/VK5JWlxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESLLrWpF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa7a8147c3so8287358276.3
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718056393; x=1718661193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4mCI2SDvI0ySmsy+W9lu2Ic0O4eT4GjqwlrRyOh3Xz8=;
        b=ESLLrWpFraTCSm9FQ3eERhJZq+BywcM1TWsxKEjohvOgoqq8Nb0GJopZTAqupIDXIG
         Xf+Irn/w5WjUXB9BvBgKxsqQdXPIwC0VXbF3Kci5+zRY0gjWSYKoik1OSLh4VrZxItjI
         vzAr90quxzB5q9tpAEjTNUZUXQL0JKHewGmE88MfyzZyfIDLJ2Ju2W+St3BxRGKoPVxZ
         8Q48HRyj12U/lICpyh3XBte823atdm47XJeOwCAl3yF8XP84f21UDjzLkjn7m74jIYy9
         Bm2PzqCFgHgb1BZBDSEaL/Tj56R0j3PP04kfKj/RGL+UMl9uwg/dXhJCvEpudKc+GxSd
         QPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718056393; x=1718661193;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mCI2SDvI0ySmsy+W9lu2Ic0O4eT4GjqwlrRyOh3Xz8=;
        b=q6hDFMuSrkI8GJWp/3u7zcF1a9SYA5YRoUJXViyXHDmc5FQus2P41c5uDuCmP+d6td
         M40ihKL0uA3Cph8dvvYGY+0KFLAdQkY8thF49M4i+Hp+N1heroHvpTQNKd7G++LlyuHj
         Upd6hRLXr+lZc9wYIhui2UBJatapI8CM0GC2ZAZa6tAfizZ7OXDih8E+e9dcUwjKIpfm
         ZDHq81p9DqiX8peCoUq3K1SpAiUdj5/mxRRSTZfyZnPeC6YbsFv01ApKhP0C5rBxG2Wd
         aZg7wSlDk+uYJWBi2yG41IK2rDIvaCp76QYU+y2C+U8fFKH9gHlWz5HHtwb3V866RbHr
         3fGw==
X-Gm-Message-State: AOJu0Yz/nnvFYxeGs205eJxGuLZlioLVS2GqrP060L/wAaToRm1u7OEn
	NMgaHUnGXxIIyK/Ky8pPtd/PbIJN4WoGfT+5NPOa0rzSm6lmgYo0r+3tgIvWQ84dOb7OEKBsws5
	3BQbpGHm9tDoVfjHLbQXEibcCCnYVjD0hEytgXG99ooBQJtCRFvkurLqRe+BJW//BYbk206AVV3
	ijy3Qb/mhjOQXj/T1k7TNQ0/pUbg==
X-Google-Smtp-Source: AGHT+IFfw4APt40gKUvG3P+8u2c2+PmD0+iyEMKYP3eMZU3yHew8hEdIiLxMFNiDFAne9mOfSGBSzomc
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:705:b0:dfa:b2ca:7a9e with SMTP id
 3f1490d57ef6-dfaf6593aeemr3314791276.8.1718056393544; Mon, 10 Jun 2024
 14:53:13 -0700 (PDT)
Date: Mon, 10 Jun 2024 23:53:05 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=ardb@kernel.org;
 h=from:subject; bh=9lNJlZV3K+4RHtLXB+jyYM8MXsRuPV6IplOEZmb8vPA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS299KD8oyMTWFf0K719wcM18WzSUsH5/ze+mWASof277
 Ma5F9PfdpSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJRBYx/LPYXamqtScg03Pb
 /6ul0/+HN08+61H+esIrq927xfTeVzUx/M9Y+6QvOmfHDI7GBQX+z/KuSvfs2mmi6rDKSevw7rf v/PkA
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240610215304.2953611-2-ardb+git@google.com>
Subject: [PATCH] efi/x86: Clear BSS when entering in mixed mode via compat entrypoint
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Nicholas Bishop <nicholasbishop@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Nicholas reports that since commit

  df7ecce842b8 ("x86/efistub: Don't clear BSS twice in mixed mode")

booting in mixed mode via the compat entrypoint is broken on firmware/loader
combinations where the PE/COFF executable is entered with BSS containing
garbage.

The above commit changed the logic because clearing BSS in the 64-bit
entrypoint is too late when booting in mixed mode, as at this point, BSS
variables may have already been modified by the program, and so
reverting it is not an option.

So instead, fix this issue by moving the existing mixed mode BSS
clearing logic to the 32-bit startup routine that is shared between the
different mixed mode boot protocols, so that it is called immediately
after entering from the firmware in all cases.

Fixes: df7ecce842b8 ("x86/efistub: Don't clear BSS twice in mixed mode")
Reported-by: Nicholas Bishop <nicholasbishop@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 876fc6d46a13..a4035c426229 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -152,16 +152,6 @@ SYM_FUNC_START(efi32_stub_entry)
 	call	1f
 1:	popl	%ecx
 	leal	(efi32_boot_args - 1b)(%ecx), %ebx
-
-	/* Clear BSS */
-	xorl	%eax, %eax
-	leal	(_bss - 1b)(%ecx), %edi
-	leal	(_ebss - 1b)(%ecx), %ecx
-	subl	%edi, %ecx
-	shrl	$2, %ecx
-	cld
-	rep	stosl
-
 	add	$0x4, %esp		/* Discard return address */
 	popl	%ecx
 	popl	%edx
@@ -264,12 +254,24 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	/* Store firmware stack pointer */
 	movl	%esp, (efi32_boot_sp - 1b)(%ebx)
 
+	/* Take the address of _bss in %edi */
+	movl	$_bss - 1b, %esi
+	leal	(%ebx, %esi), %edi
+
 	/* Store boot arguments */
 	leal	(efi32_boot_args - 1b)(%ebx), %ebx
 	movl	%ecx, 0(%ebx)
 	movl	%edx, 4(%ebx)
 	movb	$0x0, 12(%ebx)          // efi_is64
 
+	/* Clear BSS */
+	xorl	%eax, %eax
+	movl	$_ebss - 1b, %ecx
+	subl	%esi, %ecx
+	shrl	$2, %ecx
+	cld
+	rep	stosl
+
 	/*
 	 * Allocate some memory for a temporary struct boot_params, which only
 	 * needs the minimal pieces that startup_32() relies on.
-- 
2.45.2.505.gda0bf45e8d-goog


