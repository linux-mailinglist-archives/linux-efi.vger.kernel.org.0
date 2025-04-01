Return-Path: <linux-efi+bounces-3165-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0480A77C34
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A35188FB73
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7A92046A8;
	Tue,  1 Apr 2025 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3NJwlJO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B10204597
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514478; cv=none; b=BOe+R0M7n4HJb4ap5327h5TvO0NA14dy3ghd+jytIi6N1izhaPSC1ajstAtCrzRmOrGR76bELwAiAhyovkikmtR7g1idzNhoGJqk0In/Is33nFhCbXInFkCpeiTbN8L94UZSjtxnonEkwOUvE4RjvwRcxRJr9ppEIbacnRt7/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514478; c=relaxed/simple;
	bh=jVv82q0VAwBPvYZ5/rIuosPXebvdrL2vHJ8IsDzi2y8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ch2HvKQNXAKLVwzmcLx/vwxVc9X4JVJJ7TYha96ySjtr8BC15wHaHN7SKTO6Q3WYOywgNIHLVmo0aKrAdQ9UgYPtMx0bh3A4Ebneon3CXo5zVCJPrXNAWSo0ADUDJAzhwZ1TGgGHdE56G461N+xgYy0ZoqjupHGiV+gmkfhYjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3NJwlJO; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-391492acb59so3625358f8f.3
        for <linux-efi@vger.kernel.org>; Tue, 01 Apr 2025 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743514475; x=1744119275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KkkgdoQS7XsAFt9UmFe68Xk/ys+reCGu9v6By+aRdFc=;
        b=G3NJwlJOSAQKohRI0zN9krFZa3FmDcluaJKAgvN1g8FyI0ApEtnH0LBhSZrGffrpea
         Tu0/n3UMX2doH+oIWFJ4tWXAfznTW8lms1NaXFQ6ld/yraNm+B/+EkvPMgytkUIjDvyn
         6SDKgV5Ru82mVumNNfVj6BXeXBZUXbFeRjxoYQYkdAS400Aut2hE6OzB7b3gs5xfw1Dd
         oe0M+HpNP1rj1vVZsHVwvDgO12DjJSfUMt4nBc+6ZbwYFiNi1yaif3imZhC/8I/XIT1P
         kdfh6MR1o25QdbPMKg/abyXJyoZOgqtcHZKWsPzc4HI3mgVxGka+J+McDzV9hcwWK3aw
         AQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514475; x=1744119275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkkgdoQS7XsAFt9UmFe68Xk/ys+reCGu9v6By+aRdFc=;
        b=Qjq9dm6qf41oMarhS1spe214f8UPLAjbT08qSTA61qo/SlLjYMWe85VhefHI+Db0x5
         3b+P0Rtjv8Z4xBRvqVnIVZCmaHoRoXvkyI4x8HPOgljittiZbDqvM1Ldej1GyOUngGbW
         Y0shGNwkriEcpw9cGWYQ8WsdzdqfMVARKpjSgMyZKG2xdXz4cowMEJWk9NEFdKh3f8oT
         aOGG+lXPaJpGqQV0vff/o6uDIoRIVjWCSCEV/5An/o+3WrzhOSv13Enr/qWOwwwjDvJK
         PaAGbnnf/VADMi1QxPLkOHp6MVN4Smyt2hPo9TJ7jpUECEjHDxsX4SE0Um9orhbJMSlr
         TeOg==
X-Gm-Message-State: AOJu0YzLuVCPnTN5m8BAM9rMucLOw0S5w4dNBZew0KancXeEfKYCUVRU
	IOxCMVeyoN+uMnUX/u9/zrpkWybPBH9AiiQcSoT+zfDBJVvje36aF/OWIuB9a1xIWw95lzWOQgF
	jJ15C39watQTlaWoQ1xWorH9rCt7brDAAo2cpFGMt9N95ElxRNvw0vBsRZqJbUfIjD1TKOyFSAO
	4CfnV/nrDdmI9LzoIncMfZBVer0A==
X-Google-Smtp-Source: AGHT+IH1Rwf0SPfvTDMLTXKr8r2VF8laxDRTirFJIzh3OocUBKb+W0dll+mMOctsSfKR+qI/IAtXpqrI
X-Received: from wmco22.prod.google.com ([2002:a05:600c:a316:b0:43d:40ea:764d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:250f:b0:39c:1f10:d294
 with SMTP id ffacd0b85a97d-39c1f10d4e4mr4825842f8f.26.1743514475045; Tue, 01
 Apr 2025 06:34:35 -0700 (PDT)
Date: Tue,  1 Apr 2025 15:34:19 +0200
In-Reply-To: <20250401133416.1436741-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401133416.1436741-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642; i=ardb@kernel.org;
 h=from:subject; bh=Rg+9UesfDX7KMCl1WWKPr+VDxB1ApETGwnITWSbmCXE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3165iHHY4uD/afSnKPszOfHrj0WLV0h5/xr5jp/9fL/
 hfe86qio5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEOJmR4WbK2rN+i8pqm1+u
 5Ty+lHNTx/7ty24JfU27l7xzopd2+3OGfxq2ZvoFgR7zv5R8WvRAlHmLamzcifaAktn3uVdt0Hn iwgkA
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401133416.1436741-10-ardb+git@google.com>
Subject: [RFC PATCH 2/6] x86/boot: Move 5-level paging trampoline into startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The 5-level paging trampoline is used by both the EFI stub and the
traditional decompressor. Move it out of the decompressor sources into
the newly minted arch/x86/boot/startup/ sub-directory which will hold
startup code that may be shared between the decompressor, the EFI stub
and the kernel proper, and needs to tolerate being called during early
boot, before the kernel virtual mapping has been created.

This will allow the 5-level paging trampoline to be used by EFI boot
images such as zboot that omit the traditional decompressor entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                                  | 1 +
 arch/x86/boot/compressed/Makefile                  | 2 +-
 arch/x86/boot/startup/Makefile                     | 3 +++
 arch/x86/boot/{compressed => startup}/la57toggle.S | 0
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 27efe2dc2aa8..c8703276e3e7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -287,6 +287,7 @@ archprepare: $(cpufeaturemasks.hdr)
 ###
 # Kernel objects
 
+core-y  += arch/x86/boot/startup/
 libs-y  += arch/x86/lib/
 
 # drivers-y are linked after core-y
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 2eb63536c5d0..468e135de88e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -98,7 +98,6 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
-	vmlinux-objs-y += $(obj)/la57toggle.o
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
@@ -107,6 +106,7 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-libs-$(CONFIG_X86_64)	+= $(objtree)/arch/x86/boot/startup/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
new file mode 100644
index 000000000000..03519ef4869d
--- /dev/null
+++ b/arch/x86/boot/startup/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+lib-$(CONFIG_X86_64)		+= la57toggle.o
diff --git a/arch/x86/boot/compressed/la57toggle.S b/arch/x86/boot/startup/la57toggle.S
similarity index 100%
rename from arch/x86/boot/compressed/la57toggle.S
rename to arch/x86/boot/startup/la57toggle.S
-- 
2.49.0.472.ge94155a9ec-goog


