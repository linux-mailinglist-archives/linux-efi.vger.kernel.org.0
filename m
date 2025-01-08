Return-Path: <linux-efi+bounces-2536-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74263A0644F
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 19:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444297A40C8
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69231201016;
	Wed,  8 Jan 2025 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adCRRusW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4A201002
	for <linux-efi@vger.kernel.org>; Wed,  8 Jan 2025 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360572; cv=none; b=gLDtF26qO8VNg6G+BA3iccbR7IpLy1Lx1l1k7tNXtyN07zjKnKOFDi1C4QnIIs9Isqsi7G5nM7MJlI14zACB1pUaP1j3RmJAz71xbSeqdW/JrEkG+SZMVL/4lXvZERHRECb5BVyRB25xEUgHC1Wgd2+yNjM3F7Neyz31GPQcbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360572; c=relaxed/simple;
	bh=SLVCqnZOPTlF7lPP3mZgvL9YfZxpx7l4xVoZ1DQSXfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cSxUCKNUUu4Ge/P3PXzzE125a5IVhAMYQk9Oz+luIxb5OJduya1PTQ22TFQD/lil9lkzNQQMqooQKUP7BZ8zJZBCxCihZAag1DlR9Qo7haamPNLQfTSGbYtEVJZCcEJt6VQfosei3yeLIASffR4/FP+1H9KfKz9JVJasp/IXjuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adCRRusW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43673af80a6so837225e9.1
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2025 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736360569; x=1736965369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hbPTlmytNWKUoOoC51RgPxgmKvrqZNo9QyU8n/XLuQw=;
        b=adCRRusWLWSZaVtsoVgxdHQF568L54ejTRzp8WJUk8QibHMFs+5Q4RtKmphgtwZGJT
         ly3zMR6LU3FwF5nlU2qQ+AqNyKAUOVCzSj+XGURr6L5cSLCEMTaeRcbj45EZ+cSRoFyo
         p7TNSrqnDSAvdOeIp6c4iWd/6l3BY0+ANk7cwZ2UVf2fbCZkCciGjr5dbuvYGBNF+Lxn
         9inhUGFmWC018UtMKuqk2hBf9MJajFpyEVmbb+k2bEixpjDcunveofuJmpwJflKT4zfS
         vfnsSQ6VJKhmnvvvPwaKDG3nJKgRb+3feGlZe4RI+x0sIQMTD7P+nVRos7ZWu/dvQUgz
         FPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360569; x=1736965369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbPTlmytNWKUoOoC51RgPxgmKvrqZNo9QyU8n/XLuQw=;
        b=P5BkYGOUtfYQLiwzD7sAMGsFCOGE9PHs5IHhALU8c3SeHmpbPP0Z1LQlhlNu20PqyM
         SAPIB1QzRkHzwCc30VuUDt02iQrMSyQ3rz3iYkajDD74+1grKQwhDsyNtCEqvIn3y9RE
         NeRZXTyh5VpwlYX65ld0AOZAW+LCRTE5pTtW42bdEmyJOK9qCMKDNSz5IiiHvuBz+rXI
         VGN/UnLaGKhJbRc/8NR2hYhlJnenTMXc9QcFMs7qccFh0dDnQKKbFtvdibarF3T7KL0c
         hIhyXwA6wQZzvNvYNjsQAJPda0Ek4oFwvp3Ngwb8qa0NP/tcxyjddFvc7P4yUbAmxfjg
         UE/Q==
X-Gm-Message-State: AOJu0YwGgkD8aPBXDfrhNxS0Uc7WFQ8ZjmYK1C7u+suhl63b9UwGvXOJ
	YC/ldnxZjxyxm1wRNQRmdt3V3CyG8CgkA03CrZWNv0I+6eM82KMsZWFS+pnvpLi+nWebMbY30sW
	CfipZfMs6lHeXu9YKpu/Ic/0/l/jg/T4QSAjCPWDFnD5/s1hU4/d7m4a5FBM/JIA7wvVKLWVLyL
	J/zaJr+CgSvJ1JcfMa7rBOXQLATw==
X-Google-Smtp-Source: AGHT+IHeeTo02Cq9pv4ZYdtm9WaozBbVbAy/bjSMvFSfPhrOeYQ2g+MbjsQ+TZ3pNbbAu93U9XKU2qof
X-Received: from wmbfj5.prod.google.com ([2002:a05:600c:c85:b0:434:a9bd:e68c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f06:b0:431:12a8:7f1a
 with SMTP id 5b1f17b1804b1-436e26d018emr38216315e9.16.1736360569091; Wed, 08
 Jan 2025 10:22:49 -0800 (PST)
Date: Wed,  8 Jan 2025 19:22:22 +0100
In-Reply-To: <20250108182218.1453754-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108182218.1453754-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=ardb@kernel.org;
 h=from:subject; bh=u33yVDr1ep+Jh3oT0UHzraXfOa6OSpZltgKwiAbbxx0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIb3uUPw8xvXzlghpXuQ+v01pw4aENanzzu18Jbhs1u8ld
 jd6cuebdZSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJXKhh+Gcdf/TU6QnhAgzR
 N4LXCDyft+csb3XP5MelGd8/bYkLvCnAyNCVYntw8/9F9fWZ7yNrjV+tnhkayPBcJXlp/s20CfO /5XMCAA==
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108182218.1453754-11-ardb+git@google.com>
Subject: [PATCH 3/6] x86/efi/mixed: Don't bother preserving 64-bit mode
 segment selectors
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, kees@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Commit

  e10848a26a96 ("x86/efi: Preserve segment registers in mixed mode")

added code to preserve and restore the caller's data segment selector
values when temporarily switching back to the firmware's GDT and segment
layout to perform an EFI runtime call.

At that point, this code was shared between the boot-time and runtime
mixed mode implementations, and the issue this commit aimed to address
only affected the latter.

Since commit

  96738c69a7fc ("x86/efi: Avoid triple faults during EFI mixed mode calls")

the runtime version of the mixed mode handling is entirely separate, and
relies on IA-32e compatibility mode to call into the 32-bit firmware
while retaining the OS's GDT/IDT and segment layout.

At boot-time, preserving/restoring the values is pointless, and the data
segment selectors can now simply be zeroed after (re)entering 64-bit
mode.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 24 ++++++--------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index c010aba7a0d0..066f4365af4f 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -83,17 +83,10 @@ SYM_FUNC_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
 
-	movl	%ds, %eax
-	push	%rax
-	movl	%es, %eax
-	push	%rax
-	movl	%ss, %eax
-	push	%rax
-
 	/* Copy args passed on stack */
-	movq	0x30(%rsp), %rbp
-	movq	0x38(%rsp), %rbx
-	movq	0x40(%rsp), %rax
+	movq	0x18(%rsp), %rbp
+	movq	0x20(%rsp), %rbx
+	movq	0x28(%rsp), %rax
 
 	/*
 	 * Convert x86-64 ABI params to i386 ABI
@@ -135,14 +128,11 @@ SYM_FUNC_START(__efi64_thunk)
 1:	addq	$64, %rsp
 	movq	%rdi, %rax
 
-	pop	%rbx
-	movl	%ebx, %ss
-	pop	%rbx
-	movl	%ebx, %es
-	pop	%rbx
-	movl	%ebx, %ds
-	/* Clear out 32-bit selector from FS and GS */
+	/* Clear out 32-bit segment selectors */
 	xorl	%ebx, %ebx
+	movl	%ebx, %ds
+	movl	%ebx, %es
+	movl	%ebx, %ss
 	movl	%ebx, %fs
 	movl	%ebx, %gs
 
-- 
2.47.1.613.gc27f4b7a9f-goog


