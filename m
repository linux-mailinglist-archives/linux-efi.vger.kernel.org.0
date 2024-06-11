Return-Path: <linux-efi+bounces-1199-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27F1903EF5
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 16:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6DB21288
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF5417D890;
	Tue, 11 Jun 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lr+nlNB0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76B17334F
	for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116796; cv=none; b=JosE9DgMgRy0CEtnUKoXCgCaTVUgmsCfPKauJJOJBP3DnJtGCjyWx19E3DzDFWIQ6nybB1lEfNGDo0094zzWO7dzMyLwmnv4D6rgdPeImlpGushEjPEQa+awmBI+xq0htoMnEC4n5t+Bn2yus6on0b6ovwSUDyapCZ/RU0Op7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116796; c=relaxed/simple;
	bh=6y4JoZ/MqNNslq1QX24m6fM3qcrInTLYJa3wT+O73oI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nJ72F/j0FW1//ykBhrbmjU1reFNKJCHZds0Y1LKkarUkwM9BveY1A1edfz6X4lyL8J+OdCXjYzJx/2hh98nn5zwMMdxCCAgdwO0B4XBnBDbP384N+Ifc4dTYG5NRv/NPedfDm/yiMJMPBcIi6+a3cor9LTzztVNMOThA9inNfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lr+nlNB0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4217b3d2044so11208565e9.0
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2024 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718116793; x=1718721593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fc256L0bMylY8a0w+xKmgylsEKgdKE56YCfKGKpXuE4=;
        b=Lr+nlNB0XsrpK7FUNiwTgI5Mqg2v+gJ1vjNEZ7XiHuqgkAKgu17HJMxvV3GW94mOZF
         IQW9SLYDi03zFsY8ZMlfJFajuFKkplBjShA0tt7i6IF97hAAyuafG0nLNT41dRtAx1xX
         QbUXvOjgJC5lRusQ4cDRRtQGJMYe0C7k3KZQbobRs+lhO+rQOgU9CaJL8ZOvsVgc+Apo
         xDeRbvP/8y19UBZtfnjcwxtD2VzpFxdNdS7AvbGiQqyVIdoHI/oaKQyICoeps3baLzMN
         WtD4QSJ22aG6CP8JKgt6P+UiXRbKv7pHye9EqiJhIRiweIaIpoV2T163JGv4Qh2iIQgV
         NfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718116793; x=1718721593;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fc256L0bMylY8a0w+xKmgylsEKgdKE56YCfKGKpXuE4=;
        b=jhxrhs8bbEXvW+0xsr/nUSORz0CWbXbOJEtScL02gVpk+MQbX+MHcwXo/JQDTqJMNg
         0oViBoZnyOWybJk+QWQxSzmgnMgori8nh6fQOhRPccGPw9pjyoyrOmiJSw4giWNIRCxB
         Gj1CrfddySCrOhk5tiJlSkhNrK8zz0C6uAqEO0IDtPz+RmWktqITetv+qFR8r/EGf+HX
         AXNtPnw8sx/F5wmgthZ1cfGsElf9ewHs7hkqtO6su6yNX7v77/xdgywMzqP8XLJGAX4F
         UbAYORt5Zx2a5owkrvMQIb2MjOXbRCm3nEv1e6B2mDFLgTiye6y/TdukyDE4e7ZHtf2M
         P82w==
X-Gm-Message-State: AOJu0Yyx32K5Rt9zBuR1Bw1sTtp3hUdllgmpjIQdvK1LuSRjWyet+q3z
	EqqWL5kG6OvtCHE/U6eUtfR1GdLizOKeDtppkiIcs8phUO0rEp2q4M+srPKOgMY4CDz5K7illOD
	n5G01DHdDCHPp+Gup76a8s09Qd5Sv+R5RLh9qkOzvmHr79fUtNpUGqndacAO48Uvm833KXLrLN4
	xzTPgKzXG1steksftVu6o3aMfdYw==
X-Google-Smtp-Source: AGHT+IHFaEk7D2N6ufvwGBSbFGg2CmMFoFz7/tCVFPZ81qAdg6othaAt/SV1WPdmIanVciVFJcMYSctJ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3c9d:b0:421:29c8:4ecb with SMTP id
 5b1f17b1804b1-42164a29553mr533825e9.4.1718116793115; Tue, 11 Jun 2024
 07:39:53 -0700 (PDT)
Date: Tue, 11 Jun 2024 16:39:46 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879; i=ardb@kernel.org;
 h=from:subject; bh=MZFu/VXbkFBp/U/HQ7BeXGxfD05oODBP3aH5tLVjkrk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS0jcZP8LaYoFqUw96UPNfWvzypbdL+tte/+40exzw7Kp
 rVvXMDSUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSqMjwz+Z2F7OBS8TzCb8W
 zarxeOV4fsfDB107r2so/U/Vm1TKoMHwP2/hW4NT0/+b716w7fr6EK5fCfZ/eBa3CBtoz1hQINU Szw0A
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611143945.3676904-2-ardb+git@google.com>
Subject: [PATCH v2] efi/arm: Disable LPAE PAN when calling EFI runtime services
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

EFI runtime services are remapped into the lower 1 GiB of virtual
address space at boot, so they are guaranteed to be able to co-exist
with the kernel virtual mappings without the need to allocate space for
them in the kernel's vmalloc region, which is rather small.

This means those mappings are covered by TTBR0 when LPAE PAN is enabled,
and so 'user' access must be enabled while such calls are in progress.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
In the end, I found a cleaner way to incorporate this into the existing
plumbing, without the need to rely on a global variable to stash the
TTBCR value.

 arch/arm/include/asm/efi.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 78282ced5038..e408399d5f0e 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -14,6 +14,7 @@
 #include <asm/mach/map.h>
 #include <asm/mmu_context.h>
 #include <asm/ptrace.h>
+#include <asm/uaccess.h>
 
 #ifdef CONFIG_EFI
 void efi_init(void);
@@ -25,6 +26,18 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md, boo
 #define arch_efi_call_virt_setup()	efi_virtmap_load()
 #define arch_efi_call_virt_teardown()	efi_virtmap_unload()
 
+#ifdef CONFIG_CPU_TTBR0_PAN
+#undef arch_efi_call_virt
+#define arch_efi_call_virt(p, f, args...) ({				\
+	unsigned int flags = uaccess_save_and_enable();			\
+	efi_status_t res = _Generic((p)->f(args),			\
+			efi_status_t:	(p)->f(args),			\
+			default:	((p)->f(args), EFI_ABORTED));	\
+	uaccess_restore(flags);						\
+	res;								\
+})
+#endif
+
 #define ARCH_EFI_IRQ_FLAGS_MASK \
 	(PSR_J_BIT | PSR_E_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | \
 	 PSR_T_BIT | MODE_MASK)
-- 
2.45.2.505.gda0bf45e8d-goog


