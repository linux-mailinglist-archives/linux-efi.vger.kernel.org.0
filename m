Return-Path: <linux-efi+bounces-2392-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E431A9F696C
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 16:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC9B188D3C0
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0A182C5;
	Wed, 18 Dec 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVCEaD/i"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF561B425F
	for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534222; cv=none; b=qAbaQDa6HGJlPb87KAQaYz9uI1+O23YQTdDBTPQJRLbxsnx+4WYzgytTKuk8PR9mzLFYmA+UJrtZqfnm6sQ8bCQrnwDvYkf2/tj6I0DpZAI4bouynb8mEp/h3zPbszlpF+gFl+5F6eqm9tTEE7BQ/6RZAFQX3eHkoXdJYweJBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534222; c=relaxed/simple;
	bh=gbn/sr6lKWzSFEyjMNNuLZ20Ed7uHNh9ByYZj5qat/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fVwhwhrbpJOrkPhnbota1+uyQKyjmsl2Mr/nnD/QS9cfoYqmeW45+eW9O2YXIx7viDYSxru/HVYN1+I/XAyqnRgmi0nJSk1cRhh5J48yfwLZ/IwD1ybZ9n2v6BRfxRUQWTB0Tt4WFJTLqEizgdXMloA2Zgr96Uzo2KuAjP6pMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVCEaD/i; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43625ceae52so37118005e9.0
        for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734534219; x=1735139019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlXVUt3o80MSmJGhEnnWhOtf5ByGllnGOXqBF1r6osY=;
        b=mVCEaD/irn0oekH8w+k1bzHqw4ucbyEQkbEBBXGkAPtG+zZe5Dt0+JY2qZx+AtjDRN
         UhLX5hgK7G6qap97SNSqbI4A9pY1GZu6hA1pZzrtwAjn/GJ5rwKWQr86NGuD2bAphmma
         ozx9nyDzzd/hDNq7XxilDvCzgvmPZ/syVdbKPANs+HUQmO7/WjIGGchtcQErMtN4Z0/E
         X/l1g4R0kDDoGeF0By797JRWz2An+SM/ag7cScdQWrhMpoQYToytlPnBuH6yRKTjYEeS
         w1fTnSbuNMZCvusPz5Qz4dr7FycyDwXjo++oaPqaJ8hqk89ernpTvGxNopyIYIewRQ2+
         OjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534219; x=1735139019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlXVUt3o80MSmJGhEnnWhOtf5ByGllnGOXqBF1r6osY=;
        b=laB2bDQQai/8X0YMQhD6sXys7h6qRxHmgTl40zn4CdBJusl3UZRZYbQsHilb7BJZY1
         YUThLpk5iwZy1IBoi8rqqYCq82FjPVdfFRfB+6EFPk9JDS8bcc6WTzQ6YaE74lbMM1Q9
         XT8ntVKra8dhdQpMMbDDcjXjgE1Ql+VXmsyhpKBn6XkqTRdfzHIMebkVPi+70Kug2DxZ
         +FBOCjwtED7cmLwzUj7zvObIGFS8ehERX24jgo7H4QPKs/v5l08HToGlMawBgSV/bLdg
         AhAEPHqSGDB7532LMThizogbLGOwuz8kYvS78GeApzOjmC1cdKKdGWYxQtQbXBgD4wtt
         29uw==
X-Gm-Message-State: AOJu0Yx8/v3Pn9Rdx5RG8qKmr/S/qR0uyYdwNd4j0Ejht4nqQB/txfOA
	cnskubisvpTkbxivRmulgnQ8h5zMg8CvcSa9sjnK8O88qxRMCHuYvqb6ltVOd/Ax9O+hFcBMe9i
	mNT+6FcMTT0rQEkOCrQP9YlMQP6RaK2h0QzfgSlHRNrXYFK9ihKD0Pk1v0bzK/Ppg87sN4oBAFW
	42ZZvsqBOUwT5NM1gkyn5cIpb+HA==
X-Google-Smtp-Source: AGHT+IElZoDBtrV078cb504PgSiVgLf/jzQIBTrfLTI3yRr6HCB+vv7sFozB63FztHxOEuvBcRNPEYhQ
X-Received: from wmbfl17.prod.google.com ([2002:a05:600c:b91:b0:434:fc6f:e8c3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:468c:b0:433:c76d:d57e
 with SMTP id 5b1f17b1804b1-436553433ebmr27744215e9.5.1734534218766; Wed, 18
 Dec 2024 07:03:38 -0800 (PST)
Date: Wed, 18 Dec 2024 16:03:20 +0100
In-Reply-To: <20241218150316.1583806-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218150316.1583806-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3423; i=ardb@kernel.org;
 h=from:subject; bh=tH1lCvrU4ctbGRiyycueYH4HRv9gwLP/NbEyTuvF2dQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3piRU/Q+e6qE1WGt+dZ75t+5Uc/2cmz8J4i1mfMrVN3
 4e5y3N2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIksfsbwm6WiznfjvikBDDYM
 ysEfzi+d6Jqx6us6DZ6NYnw37jbKtDIy/DWQfH3R+33fxBkf2OpPni0s+rxg6ufZt9zV1zUFtgh xcwEA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218150316.1583806-10-ardb+git@google.com>
Subject: [RFC PATCH 4/4] efi/arm64: Use ELF payload for EFI zboot
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Instead of a raw binary executable, embed an ELF build of the core
kernel into the EFI zboot image. Given that the memory layout of the
kernel executable is described by ELF program headers, this removes the
need to rely on symbols injected into the build to describe things like
the size of the text area, which are not accessible to other consumers
of the EFI zboot format, e.g., the kexec loader.

Given that the EFI zboot loader only decompresses those parts of the
payload covered by PT_LOAD program headers, stripping the encapsulated
ELF image is not strictly necessary, making the EFI zboot format
suitable for distributing the bootable image and the debug symbols in a
single compressed image.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/boot/Makefile               | 4 ----
 arch/arm64/kernel/image-vars.h         | 4 ----
 drivers/firmware/efi/libstub/arm64.c   | 4 ----
 drivers/firmware/efi/libstub/zboot.lds | 6 ------
 4 files changed, 18 deletions(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index b5a08333bc57..cfd76bcbb81f 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -46,12 +46,8 @@ $(obj)/Image.xz: $(obj)/Image FORCE
 $(obj)/image.fit: $(obj)/Image $(obj)/dts/dtbs-list FORCE
 	$(call if_changed,fit)
 
-EFI_ZBOOT_PAYLOAD	:= Image
 EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
 EFI_ZBOOT_FORWARD_CFI	:= $(CONFIG_ARM64_BTI_KERNEL)
 
-EFI_ZBOOT_OBJCOPY_FLAGS	= --add-symbol zboot_code_size=0x$$( \
-				$(NM) vmlinux|grep _kernel_codesize|cut -d' ' -f1)
-
 include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 8f5422ed1b75..7e1c3f1f1372 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -140,8 +140,4 @@ KVM_NVHE_ALIAS(kvm_protected_mode_initialized);
 
 #endif /* CONFIG_KVM */
 
-#ifdef CONFIG_EFI_ZBOOT
-_kernel_codesize = ABSOLUTE(__inittext_end - _text);
-#endif
-
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
index f6c8e1992e54..b339fa34d2f2 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -88,8 +88,6 @@ efi_status_t check_platform_features(void)
 #define DCTYPE	"cvau"
 #endif
 
-u32 __weak code_size;
-
 void efi_cache_sync_image(unsigned long image_base,
 			  unsigned long alloc_size)
 {
@@ -112,8 +110,6 @@ void efi_cache_sync_image(unsigned long image_base,
 	asm("ic ialluis");
 	dsb(ish);
 	isb();
-
-	efi_remap_image(image_base, alloc_size, code_size);
 }
 
 void __noreturn efi_enter_kernel(unsigned long entrypoint,
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index 9ecc57ff5b45..143597d0e5dc 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -2,8 +2,6 @@
 
 ENTRY(__efistub_efi_zboot_header);
 
-PROVIDE(zboot_code_size = ABSOLUTE(0));
-
 SECTIONS
 {
 	.head : ALIGN(4096) {
@@ -21,10 +19,6 @@ SECTIONS
 		__efistub__gzdata_end = .;
 		*(.rodata* .init.rodata* .srodata*)
 
-		. = ALIGN(4);
-		__efistub_code_size = .;
-		LONG(zboot_code_size);
-
 		_etext = ALIGN(4096);
 		. = _etext;
 	}
-- 
2.47.1.613.gc27f4b7a9f-goog


