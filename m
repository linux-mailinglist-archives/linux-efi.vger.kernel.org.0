Return-Path: <linux-efi+bounces-1210-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCDD905C3A
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 21:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C4E1C21546
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 19:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432FE83CA3;
	Wed, 12 Jun 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5YzWpmx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7CD83A17
	for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221488; cv=none; b=rKAruzuPy/R3JVVDTcebT56VeYzw8h8riZlNN5mQIHrMbNWyjz/G6AcAdQVpZmmtOpoGVnnCmGDak0XhTZjWc2SpcBxanxJrFZoPEkcsTYHZTy/bFb9qNqQz08xB2JYh6FkPwjc1ErXq9BzuaEu2Hhhym2BQBkxWuyhfLBJw6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221488; c=relaxed/simple;
	bh=OR1d5VyF/7X0e1TsHxZ9Lk78cj+zPyBIY+rt5wIGorQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ia80xgdLUKC0FvLSomgCtzfEMm+NvQnhz689zTV5A7opuWwcshf+kZT0FX7OVuy8+8ajMkSJk5L+1DTXiUF7h4uIyHq9AN7ZCRqUe8IRUdIfmyRTeGkCFIcKz1T3TrcUwb2Et5JJaYrD2QxaA/ZbTMO3E7FlzbtyoFe6QgAIlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5YzWpmx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f61742a024so42395ad.0
        for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718221486; x=1718826286; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DnH5fWF1vZdpxO/xmNthzzpxxZmShkacESefN2gAYOU=;
        b=k5YzWpmxyJIFr7fjvTPmYboZhtgs4Np5p9QLirs4LtpJD+4NLsnn23AvkugL6bE37V
         KE5qjBKGT46/UjOWpRtGeABAvj9ijHclzifBp0NZpmJE0EFFEDl1WKbaUtlnc56xL00Q
         btaRUTTISrF3aCJmZXgYyEMd2OLznCcuxyKuRdzz+tlbxWOV35nGEx768WQfn1p5udOx
         eflPofpM12ADnYqFbT9Tk7qIcPmem1z53MlsUq6ckcZpePbpOsVohzh4pS9HY94DSe2X
         ZAZPh0tyNg5lb1dJk1oQMpxCmkxO4Lhmd+jclgJaKmRus25nFY8Yc9n3XAdkjaMYlxnH
         oHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718221486; x=1718826286;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnH5fWF1vZdpxO/xmNthzzpxxZmShkacESefN2gAYOU=;
        b=MLDYPaDStxGHikUY1LbWyWq52nMj+BinNoqQCxf09RkTcphIppONy1qFUz7NpkqOE5
         s8+cxvcwF1h4S2T+QFE8yjpiYkkXOM86ztTU657/k1to2A4js/6QY4hUDIWyo3T31pG8
         5ZEpoV3TUSUsJoe8XNKtn+Rnv6ScKMzk+fOI1bKl6dM7x+RlrVpsvlVZY7h4j320FMSA
         MfMlNkWFDie4x65LBtfHvPzmUZ0eyea0KYRG56oZmhdKnBUlojYh0KYOEPKZi517FaYZ
         r8FSdlb/ALs3iGcF8rOUAtseS6jowWFAdzX8VU9Jvb3h/eNBSwM1sEfnnbwMZOy3j/f4
         Podw==
X-Gm-Message-State: AOJu0Ywt0aknVvoxb9lmECtV804QN8+6c0yOrdJZ6QEI9fsg9w20N6Rh
	vRGFO+azpDmZLw2LMilDAH7B86O7peX2y5AiERa+mLAAPlmlitFDCnPWxWUIKw==
X-Google-Smtp-Source: AGHT+IFtovkZPw6siRncHj2S+TjHg2Th+7w9+JVXHjCH3C6TPMRJDnE3pfpHjNx+tY7kW9GKIA7AQA==
X-Received: by 2002:a17:902:fc90:b0:1f7:3bb8:c32f with SMTP id d9443c01a7336-1f84ff3fde6mr451775ad.13.1718221485651;
        Wed, 12 Jun 2024 12:44:45 -0700 (PDT)
Received: from bsegall.svl.corp.google.com.localhost ([2620:15c:2a3:200:bcff:f772:74b7:8f03])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7042571df69sm7905262b3a.52.2024.06.12.12.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 12:44:45 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arvind
 Sankar <nivedita@alum.mit.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>
Subject: [PATCH v2] x86/boot: Don't add the EFI stub to targets, again
Date: Wed, 12 Jun 2024 12:44:44 -0700
Message-ID: <xm267ceukksz.fsf@bsegall.svl.corp.google.com>
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
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org # v6.1+
---
 arch/x86/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 243ee86cb1b1..f2051644de94 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -103,13 +103,13 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
 vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
-- 
2.45.2.505.gda0bf45e8d-goog


