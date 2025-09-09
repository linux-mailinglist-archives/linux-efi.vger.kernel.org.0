Return-Path: <linux-efi+bounces-4712-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAC2B4A487
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 10:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C5417FFE3
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC36724886A;
	Tue,  9 Sep 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZjNfI8u"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF6246763
	for <linux-efi@vger.kernel.org>; Tue,  9 Sep 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405211; cv=none; b=cTMAETxOJpiASklwVvVP5+tSUyqvnaSMtWZcnvkAUMP7RCDNPjDk4UKWxftC1twubfgELauPWknKqVli+oaaTki2IOllAIgEozYoBNpou7R5lYLpf8UHP5MvFYsSmiTUGQaBEg8wkRXZ/Jdy4IChb+hET9rERWgdpbB26jbXhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405211; c=relaxed/simple;
	bh=Radutzz8E8EuU7gMVj8q9wIgxzGfs33yWguzFJb9z88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=spXvD4j3Qi7u/SdWzRv95mCwIrM+8bgy4e034XOC4H4tQnU0pXJgNbH3WUWqHsivzvum/S0pag4AmxiQVWYjzRRy47WF9yQuByg75gHPPcrQqHQEkNmD36OMeSW6Df0Ce92QRSKpb0XiZ/VRYJOPaY8ozRaQQYj04O1dqovEMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NZjNfI8u; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b96c2f4ccso31279025e9.0
        for <linux-efi@vger.kernel.org>; Tue, 09 Sep 2025 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757405208; x=1758010008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gIYMwnegjvJO/DJAEuqEQ2WuvgmAGBZauOlQiaZuyVw=;
        b=NZjNfI8u8t3CXiDNGBI3Z637BE4V7Um+4Lsv6h7wXKn2mBNom8iB/JIa/mr1BSe/el
         VnoIQ4KZ3gw0HsFmc6QuYiZiPWfw6yQU92HRrY42bqD/fLHgXOxwxmEucj5/VQEts/gq
         C7+u8SNjCCmNZ0ErGBVxDxsKMULkDLypXi+HYANVwQgB44dBsBV3rw2tNwVPbVcuX5bo
         WGkRKzR4rgIvI4EE9dbo4hbCeZ9Uaj/JZ4hYSDiDZplO33ZhdsRPf80fyZ/UK+Rlya4d
         wHnPJj1XhI4KHEIC4aLlHuOsynQGQpKSYlpz2eaUT6c2Rzld3s5AhWR8x7DZgpN0jheg
         HTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405208; x=1758010008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIYMwnegjvJO/DJAEuqEQ2WuvgmAGBZauOlQiaZuyVw=;
        b=N61HRviXulcSk0HzH9bepRjSInQGa+SjRh6EPi3oErXl3Et0/PetIqMkJd8svy0wIp
         dmVS4/HlS/lGQLwZ3YXybq6mmIpwQ+caaVFjjG0KmSytqb2y7CbXV+btED9+K4QvF0DT
         lfDUmCLkO+OuYYDp8LgnyAqvEyi865eDPPAlSbD5ZeIcwING1TOXJM3T4C3PNwwMvh5N
         S+ULl4L6MnmyP3/OtUAWw07jval6hKYCgyqESnhWm2F8S/pR1MCT+Vp8e7RoKdLgzpdD
         EVNY+vT/zKykpjSuaFcFoZUzTN9uxSG/MIJzF3mYNd55IIczmbi0TOzbvHGWp1P23Iux
         YKdQ==
X-Gm-Message-State: AOJu0YzesO4N4e9hvwQTovv43M4tyRWsU9RVqvXK2l+hO3+WF4wCfG8/
	wufgoQVE7T51jG2Ak516GnXWDMrxuS3ghhZMTrwhKENwHNqInn17RoFRtYPeAaG6IblWm62uhFN
	vjEAYHFFIVPGeuDq9Ina+LwT3addaEA1vS+CgtFZ2E2DixIx0ZIfOynHBzu4kCDeOKZR/F8X+Ef
	F4ZblQ35B9KPGQtS+IEG/r0nFFJYojzA==
X-Google-Smtp-Source: AGHT+IHJm6oIsPFaA/H7FFpzZiwRaWMizREym7EFTHfuKxm+JVkgAyIeXLgmXB9jLd3AId1sF48xuPXw
X-Received: from wmsr2.prod.google.com ([2002:a05:600c:8b02:b0:45d:e074:65ac])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d24:b0:45b:7185:9e5
 with SMTP id 5b1f17b1804b1-45dea7a561dmr41447865e9.5.1757405208317; Tue, 09
 Sep 2025 01:06:48 -0700 (PDT)
Date: Tue,  9 Sep 2025 10:06:35 +0200
In-Reply-To: <20250909080631.2867579-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909080631.2867579-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=ardb@kernel.org;
 h=from:subject; bh=81pcKoS/mmPNH4toQqB1IJqgCUIxbpQJFeBBrqPQD3s=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWP/A26JWxN26L9i5b073+nE2ttflc0jZgre/DaBpSh5a
 t3/pzo+HaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiN/YxMjxiYipNmXLPlVXm
 7lfZ6wy8iy1ZtNce+LGeX37jvPcVjwIZGXY9fXB16V6LIN9LbCZF6zZUmqh+vWZ3J+NdjPTey0v n1jEBAA==
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909080631.2867579-8-ardb+git@google.com>
Subject: [PATCH v4 3/3] x86/efistub: Don't bother enabling SEV in the EFI stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

One of the last things the EFI stub does before handing over to the core
kernel when booting as a SEV guest is enabling SEV, even though this is
mostly redundant: one of the first things the core kernel does is
calling sme_enable(), after setting up the early GDT and IDT but before
even setting up the kernel page tables. sme_enable() performs the same
SEV-SNP initialization that the decompressor performs in sev_enable().

So let's just drop this call to sev_enable(), and rely on the core
kernel to initiaize SEV correctly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/sev.h              | 2 --
 drivers/firmware/efi/libstub/x86-stub.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index d7be1ff3f7e0..b017e1dab705 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -462,7 +462,6 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd);
-extern void sev_enable(struct boot_params *bp);
 
 /*
  * RMPADJUST modifies the RMP permissions of a page of a lesser-
@@ -588,7 +587,6 @@ static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs_cas(pgd_t *pgd) { return 0; }
-static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index c4ef645762ec..354bc3901193 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -938,12 +938,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
-	/*
-	 * Call the SEV init code while still running with the firmware's
-	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-	 */
-	sev_enable(boot_params);
-
 	efi_5level_switch();
 
 	enter_kernel(kernel_entry, boot_params);
-- 
2.51.0.384.g4c02a37b29-goog


