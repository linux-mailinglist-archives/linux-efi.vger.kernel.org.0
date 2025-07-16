Return-Path: <linux-efi+bounces-4370-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F346B06C38
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6607850225D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDDE28C005;
	Wed, 16 Jul 2025 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F74jEc3w"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3528AAF4
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636168; cv=none; b=VlKkJBWXAzuXH8BH56h5O9ug+YhBKYOb/KJI8pnKeJFP4V6IRhjzWgBpYGHN1CHWz5YOUF9WAgDXWhCBTSyltK/VokknnvG2GDX4ENHP8FyGD4zz+Z5Fw3IpbGxBCTpB8WOZxK73LqjVIZKcQDLhrzT5/2L4O1YdMRtXFAxZ+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636168; c=relaxed/simple;
	bh=L0nuKM1iOS5J1LrRXwl6oFJ2k3UoNAHOTrQqnHSBepc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n60Hm8YaaI4Ljipi7Tsyt6dZUHfbhfu1sLUIXMJ1/LGB9zYLVs3XM4q6zQ+M7fTvkryXsPRjCSVc174P9EbKChyqbiygRbwh0xPR8QacX0Xi8OI5xd0nieP2KvBgl96X18uVqnG6lUg7iVqtoBRveGDGPVWMH6EyjG4sveYM1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F74jEc3w; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6097b1faec9so5115396a12.3
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636165; x=1753240965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=F74jEc3wcIK2N8yPXlxMSHMyuh6/puUCff6GWNtB9pWnLclBpFSBllM7rwPgd+e4b2
         X9ZVgBoVIyEY2kWxQzd4YKsHfsHJLIikKNLHldOEsOeVt5+R+MpE7noTVulT1VR/iXmk
         GIbgLrsaNTi9cBEZvmffn8UJL78/Y89fHCOS+qVU7gn+Rn2O7S1/ekgB7a1YFGa+go3d
         P8PyyPh+uabQ6YaSJid9OHfaKENIp5Wf0NMQ4DbX/Xks2T/P9Y56lnBDin0qi8URlvpT
         X1c3b7+dwB2boFCd9KCksKuMyarf09FK906pHKCK5KY+CRaZc+AfpdwwfdlxSkshi7wA
         wEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636165; x=1753240965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=bpBY/3zu0OcHziNh2XzVhaUKBCggX0p/88lVl0JzmaNjI24h2Tts9AHbJ2yKGEm90z
         ItryTYM2n/eYXi17E/ysgQTLdYCNbPAr0vf5tcbXT9Yk/lRORMvn2PIY2gzzza8PDYkV
         97P7AbdQR7RpW6dzeG6uNlm3aPuMqtLhNfDQrNeqLEeDsEXcOYfmAGXGG/PNVsRc6T1J
         zcjmmQlhQOh91GOuuvFAw3iLJglqN2Tp05ogl6gSF0cm4p5pe1g0aI5oiHvhgc+376Wd
         jVcJrWW2oerEhvjdigMbwNbqrQ29teKiBOQzZw3869SFTqaGuHnZ/jPetPBfd6b7OBy6
         Rs4w==
X-Gm-Message-State: AOJu0YzNvPXxX2YJEipDO58f4uTjFLzgtw9IeVEPGhn7b2Cofuf1Wrf7
	06IZ42AaK+Yki8uzEYaySJ70CCHy1w0C7eNNZdey8KbDO23cbn6y1UmJUughg4ruzal0LXR/cw=
	=
X-Google-Smtp-Source: AGHT+IHeuPRcXPW58c1Ou6hgXM4/t+lql3E4QuE4F2sGlkq0PPpS3a860Pbw1SAm5G7yBhLu8V/nGGFh
X-Received: from edjb15.prod.google.com ([2002:a50:cccf:0:b0:609:911:afb5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:26c1:b0:609:99a7:f051
 with SMTP id 4fb4d7f45d1cf-61285d039bamr816377a12.31.1752636165387; Tue, 15
 Jul 2025 20:22:45 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:31 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=ardb@kernel.org;
 h=from:subject; bh=L4jffg2+Vf1ZB+P16ZYKMMQDycf2VYvq95i2j0U/b58=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcyq/C0cXRztektL9ZcKnGo7JHEdd62vdf2/PO0vHUR
 9Une/52lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlkhDAy3FN2W9jEsZUx+1VJ
 14yt/m4vrBze3ah8v7As2XPuGcZya4b/bhtMXp/8n9JSZJida7A9i9dAb3VZm4tdFhvDioq86eW cAA==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-40-ardb+git@google.com>
Subject: [PATCH v5 16/22] x86/boot: Check startup code for absence of absolute relocations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Invoke objtool on each startup code object individually to check for the
absence of absolute relocations. This is needed because this code will
be invoked from the 1:1 mapping of memory before those absolute virtual
addresses (which are derived from the kernel virtual base address
provided to the linker and possibly shifted at boot) are mapped.

Only objects built under arch/x86/boot/startup/ have this restriction,
and once they have been incorporated into vmlinux.o, this distinction is
difficult to make. So force the invocation of objtool for each object
file individually, even if objtool is deferred to vmlinux.o for the rest
of the build. In the latter case, only pass --noabs and nothing else;
otherwise, append it to the existing objtool command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index b514f7e81332..32737f4ab5a8 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -19,6 +19,7 @@ KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
+pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
@@ -28,3 +29,10 @@ lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
 # to be linked into the decompressor or the EFI stub but not vmlinux
 #
 $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
+
+#
+# Invoke objtool for each object individually to check for absolute
+# relocations, even if other objtool actions are being deferred.
+#
+$(pi-objs): objtool-enabled	= 1
+$(pi-objs): objtool-args	= $(if $(delay-objtool),,$(objtool-args-y)) --noabs
-- 
2.50.0.727.gbf7dc18ff4-goog


