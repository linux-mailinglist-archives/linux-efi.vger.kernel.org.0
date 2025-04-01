Return-Path: <linux-efi+bounces-3166-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB05A77C31
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDA03A804C
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59E204855;
	Tue,  1 Apr 2025 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="142by7MQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992BA2046AE
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514480; cv=none; b=MHn48tH5cnBWtVEucvZvNYgMqiGNQbbanf7w+8DOj8z+PCnbgJPbp/kcUIeA0n25quh6i3aqCQIEr9eM+BkMazHCphGjS63NFGsiMLKCu1zwz74Q77OrRid5a6RUTDwlfUsNw5ip2hJ34eeg39+fd6u9Aq8fDpxjdnjjHkuFCM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514480; c=relaxed/simple;
	bh=Dja8KUvxraXjphff+I7V+sxjjRAswa3snLgGDyWKopQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pkIMKJ3MaBI+W/dwtwDDLw/OSrOQbiF/aBy5c2L2i30djCedtIzgNjaEU2x6jIJNu9VJYjTfE7skhg3zB0uC//gWIdWpxnwaxrK9IdAng1utkoIQzI1aFixEMap/q+Yyd0pfMBIKI3XqdOfRuaHQG/Y7BLkqnwWHl+nPo7MQ6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=142by7MQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cec217977so32269065e9.0
        for <linux-efi@vger.kernel.org>; Tue, 01 Apr 2025 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743514477; x=1744119277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSnzu6xO+PITgBehw1ovPMVaSeDKcwED7ou+XOmk1EU=;
        b=142by7MQLtDaAxSMOJKuro4MmGKCqEpUgAT0Vi6f9HgCzIFEySs57V3/s3MbafQUQN
         yAlIrSW/4FUtRRldkxq2/XY7WQDuZNUwwYyFuFRscyJN/kFaAvV1cwVqdIeYprF8Agdd
         cHXrYCmB9FNgXkiJr6sHaMjfVN5COWEZ6fSVdnu9PJKU/EA8mm0lOLtDz5Lc65e9bYOQ
         VgBDm3s7LfHZ3tJznHXPTPOw5dQoCDcDlaVMdyNiM7mCweJPbv2t/xJsB5rHOPbFnqXR
         ltKOgcb0fLit5sS9XCV0W4b044YmhkTEUVr0jEji9lv0IyEdf6KpVYkA8vWHWIWeZL+x
         N/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514477; x=1744119277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSnzu6xO+PITgBehw1ovPMVaSeDKcwED7ou+XOmk1EU=;
        b=feASeHcl2UotYq8flJ4YCSzhHenBugXkZPWX5ncQAUW05eTRPO7JrRKa+QiFxVPf4b
         Yz+P3/w2wj+IpWP5hj2MJq+5jip+A012Hvhl9T9xb8xwrdx84IT1dZHLsIvpWGJnTS9/
         LBwB276fsNWqmqumxLDxMVfY26eXlLqlESunk/Et6MOfB7setEqiMT5zcFCMpqBIJ7hg
         4JSdqHO5cMpOxtEZ+oe8pu4j0WYmuZnC1M0VAKODvz9p829VDiUBUwuppgmPcoMqBL0j
         Qsk73iU2J5uDdjmhDKJ9/Io2ssa6eO6RoeuhNIuRTiuhWerEQEmoJgM/6GHaCkpEs2HO
         a0WA==
X-Gm-Message-State: AOJu0YxZtCPD3B/DIKUqK7ODCMjgwA7xVvLZ1H55ArV3GdbPjgUULg2z
	VhpfpfSexNOjPOnlTC7bkVB1rtSvRLxzGqy/1sk2fsmGC1GT6AA2cjfJM4t+dXJaaUCTWo3QXKd
	5kA+VM6X/YkoqzKJmYclNTWlJ4+iUSoQOEj23hkMzM47N5x9DlczSy+T+w8tfTz4eqabXZF0CaI
	+tHchNMdaJJIuDWF505UA0BCxQuw==
X-Google-Smtp-Source: AGHT+IFjiaIDe4SdAmblJ6QP/93wu83vTH7+Yt+H5LymjrIx+mS8SStIVJUrIHaoPRfFDn3l5SseO91N
X-Received: from wmbbi15.prod.google.com ([2002:a05:600c:3d8f:b0:43d:1873:dbaf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64ec:0:b0:39a:ca05:5232
 with SMTP id ffacd0b85a97d-39c120c7ccemr10348788f8f.5.1743514477097; Tue, 01
 Apr 2025 06:34:37 -0700 (PDT)
Date: Tue,  1 Apr 2025 15:34:20 +0200
In-Reply-To: <20250401133416.1436741-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401133416.1436741-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=ardb@kernel.org;
 h=from:subject; bh=2ckatkKp0na78sWZkNAH6LE50dNZokOehx4dKsaghFc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3169gPrqefP6/76BO5ufD00Rt+FpkR3G3ip9W15u1Ze
 /H78YrfHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAirucY/oe8Ujjq1M47N3fz
 tsDpXMYyc2b02j+8ve6NlkKx2uYi836G/6Vi1m3ZXPfZPR+dKrgwecJjptchdd+Ffh/TmX2qP7m GlRsA
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401133416.1436741-11-ardb+git@google.com>
Subject: [RFC PATCH 3/6] x86/boot: Move EFI mixed mode startup code back under arch/x86
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Linus expressed a strong preference for arch-specific asm code (i.e.,
virtually all of it) to reside under arch/ rather than anywhere else.

So move the EFI mixed mode startup code back, and put it under
arch/x86/boot/startup/ where all shared x86 startup code is going to
live.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile                                                | 3 +++
 drivers/firmware/efi/libstub/x86-mixed.S => arch/x86/boot/startup/efi-mixed.S | 0
 drivers/firmware/efi/libstub/Makefile                                         | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 03519ef4869d..73946a3f6b3b 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
+
 lib-$(CONFIG_X86_64)		+= la57toggle.o
+lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/drivers/firmware/efi/libstub/x86-mixed.S b/arch/x86/boot/startup/efi-mixed.S
similarity index 100%
rename from drivers/firmware/efi/libstub/x86-mixed.S
rename to arch/x86/boot/startup/efi-mixed.S
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d23a1b9fed75..2f173391b63d 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -85,7 +85,6 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o smbios.o
-lib-$(CONFIG_EFI_MIXED)		+= x86-mixed.o
 lib-$(CONFIG_X86_64)		+= x86-5lvl.o
 lib-$(CONFIG_RISCV)		+= kaslr.o riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
-- 
2.49.0.472.ge94155a9ec-goog


