Return-Path: <linux-efi+bounces-1181-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64958FF685
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 23:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266C62874AD
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156BD6CDBA;
	Thu,  6 Jun 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brhWhJEN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A64AECB
	for <linux-efi@vger.kernel.org>; Thu,  6 Jun 2024 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708495; cv=none; b=FT5GtRU3WCCNU+cbfM5IvnDJGDaJuvk+vFCSCjjXlXow0MVRJ1CHmgeCd3Q4QAPUFblJdPTB9HMxOIGQBJXse/YRbNAIjy+W9QoptklKnV/Sg/hdE+JMVIVI+CM+LZZeoZpcEG6DYAPWUYlOljCc0vNRHNMxcfVYcuY/jm/j4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708495; c=relaxed/simple;
	bh=uASrRaaNIPleT81KqJeH7ZqkpA5crPcBqO/J9DucjOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZVChTZZtoXqLB6jBgGqgMP+POCRLM0Vvi2QobsbLd7V66mn0/TZMDTzNEmZ4ReHmGgKjLhgOOjV7R7c/IcbYoknoNIqumqkWJperOGkLvwJtlAzIjuOQaniW5MhrYHOf5aeLLHjGOCgLr3vUVdRBVmIABAhOSOomaOC2U1DGwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brhWhJEN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f66ad03847so13405ad.1
        for <linux-efi@vger.kernel.org>; Thu, 06 Jun 2024 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717708493; x=1718313293; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=94HPMGFdkkFtMhK+L0rsETIDjOUrIR1+Un6FLl7ojx4=;
        b=brhWhJEN5XL6qTvVEyWsHSIRfLCMm2fK6BiT4Dn+268KKTq848J9yg/kSQZ/BJ8MNz
         mCWfKNf2MnlcgqkdkuXS6tbwY51DHX87y3ibpzbVsIG5IXVJnFRw2eRez6xFI8RCVhIk
         1tjr5ckHzzAPCTzqQdwDrQka/UuHIALlnjyVJfkydlXWQwtdYqnh/0m4TOHsJoPcS6ZU
         vepHs4aNMeBkrqTx3/yEbYpEYv+9b58UYXCkExjNKsE1BZgdY26Rwo0F3DT1vsgAs2xy
         JbpAfG5SiSocdJNxlt9ZjlKWUgiDs9gs/DRaRvCggAVWi0MZVgvvS3+iZPWlqkSEeZcV
         +0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717708493; x=1718313293;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94HPMGFdkkFtMhK+L0rsETIDjOUrIR1+Un6FLl7ojx4=;
        b=EsNqoe0Go2+e0Y+kTJj/DndcWFSZ8LHn4ffmV4VhAB/dRw8kPJSwqmj9UGrQ1jedoR
         gkTFaIPjlgn1Llw2lvHmAyNJncrH5uUOihmMQGsDgdPaqOXvTgL5GcL4VO37NBr7iCbj
         IiGf7MpYMVi3WzP4dWfLk0ynRYkxvXm2UFYc6fDKGjZlG6Y6B2UafyLlbiP40NrUjk0K
         ysgspFBk2AXj0m9pzLRsrtBGhmc4L38z5wW18IqcFc0oWJqspxFM9hyqyrDnYmX5GcK5
         yGqhOmoOtsb8NvAtBoMLPVJ9A8RfJC4/WzZa2ZkIcP00urkwu/4lEHLNXvZv0n0BaZ/d
         FPPA==
X-Gm-Message-State: AOJu0YyGo/5IrdRb+ttO1EWNLUfdYMw/qOBc+gEy29ias+yG0kqT9B7t
	fToN+7hXhBzhNV/bTP8LWaX2UzM8ACRIFKFqQUd+GL2kpNIj7ivguFR6hxxmlQ==
X-Google-Smtp-Source: AGHT+IG4YSrUYEJsYDnDX8bP4L6bxoj6p28U3Wcy8nnxdH71kno/GxSa+3YuyU+Ltch68ibCOLDx8Q==
X-Received: by 2002:a17:902:ce0c:b0:1f6:4131:c4e8 with SMTP id d9443c01a7336-1f6ba654f9bmr4987435ad.26.1717708492569;
        Thu, 06 Jun 2024 14:14:52 -0700 (PDT)
Received: from bsegall.svl.corp.google.com.localhost ([2620:15c:2a3:200:6b67:c4ee:d9da:ac15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ee168sm19878885ad.257.2024.06.06.14.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:14:52 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arvind
 Sankar <nivedita@alum.mit.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/boot: Don't add the EFI stub to targets, again
Date: Thu, 06 Jun 2024 14:14:50 -0700
Message-ID: <xm26bk4dlqnp.fsf@bsegall.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This is a re-commit of the commit da05b143a308 ("x86/boot: Don't add the
EFI stub to targets") after the tagged patch incorrectly reverted it.

To summarize: vmlinux-objs-y is added to targets, with an assumption
that they are all relative to $(obj); adding a $(objtree)/drivers/...
path causes the build to incorrectly create a useless
arch/x86/boot/compressed/drivers/... directory tree.

Fix this just by using a different make variable for the EFI stub.

Fixes: cb8bda8ad443 ("x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S")
Signed-off-by: Ben Segall <bsegall@google.com>
---
 arch/x86/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 243ee86cb1b1..5245c8fedc17 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -103,13 +103,13 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
 vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+efi-obj-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
-- 
2.45.2.505.gda0bf45e8d-goog


