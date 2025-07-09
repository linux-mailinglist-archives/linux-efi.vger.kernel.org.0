Return-Path: <linux-efi+bounces-4225-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6950AFE226
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E417B886A
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4334D280CD0;
	Wed,  9 Jul 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmsns526"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AF280CD5
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048707; cv=none; b=gdAvswzZ6LsFpv3mH/KlJJDbjNYYte29yIYLIY2qu7omEuWYcYG37GtuBBt8v66H1nmiDWjrd+OXpCkfkBugkjeP77vT7ld0Vm4bZxJORWkuAKwvh/GXU6cKHtU5XJlLWNp23UXlJIHshJ1OFqHPOY0+FMtNowArNrtfTV84yqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048707; c=relaxed/simple;
	bh=qi/XSlH/3m0Py+I72AmudGPp6EWjqjC8xYfnH6HfggU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bT0XrdphGDOJUBP7HNuxi4Kfwk/NtMUttYS8avGSDBZIg/6UExFiyv8HkIQMAJQlc8yaTkifRSwwBB9Gj5p7vWs1p25SMhQTxsMx/Ozi3gJF7DGCojc4fuuN5XUKdUSPPyEtPjCA08aTP0ejxRytZNR8y274vgi9FrStsnoJCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmsns526; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so29360705e9.3
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048704; x=1752653504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHREQvw4opT+z1wL8T5wjMmNHsYkeJcC/ePiz2KgcJA=;
        b=lmsns526Vn841vt125Re8EpFuomcLyrhwrWhhY0oodEN2h4psd9OUH5XcIm5JDinBG
         oDtUvjK3MGFAWNVcUqvTp1XvkDQtuP5r72PCDiScIb993jsFbsMWLjBn1KdNhwXiRnkF
         q0ScSNVooEdVYRIp4KmqQbEn09S5+35b5PY62n1EeB6+chCCGoa81h4Qb9ctOqhvV6fM
         cmH9WbhNL9fqzKHAuxNyLRYlToe2lsQMmsS3U6OV4oDa7+bfZ8PGn60jJtJp8fhISOTo
         2FsSQIdoRcYML2HVVXG0pW9oDdKPsL0ZUx4JdwBijzRJrGrA4yw4svOmtP5OzNsDbx5W
         V4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048704; x=1752653504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHREQvw4opT+z1wL8T5wjMmNHsYkeJcC/ePiz2KgcJA=;
        b=MOtPqpX6euSYgA+fzjWUZr2lN+iiFUF45BiZ5Bxpe4UvLbi6XLg59pgKIDoLT9YmIL
         iKw/bu68+TiGboK4p0DyUV2G+gtGLWaZyGwLEpY27T4ALeOXrnx6YU2cb8KtjxnP9hg8
         fraDPOkYFanrF5SABV9xJH/JSgEvdOBZUdB+/skZKxR7QmqWtO9rv6TwI4GhhsZ0uXOL
         UYthVmp2ub7oAcaJBobmSvyhvK844t1zd4tk0J0nTe6fD49N5YQ2KGZ57uOgC93ik76e
         GJQ2BhPAzkmHn+0xW6tXb5COZ1Dfjj0d92LOQ9X5jcC8+8JRjgztwqLTvkUoNuCyCih6
         x9jQ==
X-Gm-Message-State: AOJu0YyN7gVcvN3Q3179xXPSsm2ILYCEmed/xuNXxoc+uex4tPh5MIKo
	+uOP/5ciBbGr9ZvvlQa2S2clFjAEFeHGaRrAR2PyBX3ZPvpXBheuec9kiiOVVE23JihrLuWvlQ=
	=
X-Google-Smtp-Source: AGHT+IFnk8h8lBB50G/cuaeMT5OTtpgPGVLvIZYOcvSH0WdrMvNgDjuEnE6eplN0N6G86HVwp/VovBxt
X-Received: from wmsz10.prod.google.com ([2002:a05:600c:c16a:b0:453:9528:81e3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3154:b0:43c:fceb:91a
 with SMTP id 5b1f17b1804b1-454d53584f5mr12455985e9.11.1752048704221; Wed, 09
 Jul 2025 01:11:44 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:09:01 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=ardb@kernel.org;
 h=from:subject; bh=N6Uq2lVfV25Jk1mFXhfGvG4B+EmaRioUjXHyXI14Co0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+cP2HZmrn0YdLv3GUvkjNmKXRvDZ3VM+ii77lLF5k
 4iTRvmGjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARF2tGhr+vezeYaOm1VX9x
 4dg4pZmxcc6G3M8qNxie3N7ra+t5uJ2R4ffiR9/bgsTP2T7kT3vH/OKrNc8rw/dlOiUzl7Ps/ar izAEA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-46-ardb+git@google.com>
Subject: [PATCH v4 20/24] x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Using core-y is not the correct way to get kbuild to descend into
arch/x86/boot/startup. For instance, building an individual object does
not work as expected when the pattern rule is local to the Makefile

  $ make arch/x86/boot/startup/map_kernel.pi.o
    GEN     Makefile
    CALL    /home/ardb/linux/scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
  make[3]: *** No rule to make target 'arch/x86/boot/startup/map_kernel.pi.o'.  Stop.
  make[2]: *** [/home/ardb/linux/scripts/Makefile.build:461: arch/x86] Error 2
  make[1]: *** [/home/ardb/linux/Makefile:2011: .] Error 2
  make: *** [/home/ardb/linux/Makefile:248: __sub-make] Error 2

So use obj-y from arch.x86/Kbuild instead, which makes things work as
expected.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kbuild   | 2 ++
 arch/x86/Makefile | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f7fb3d88c57b..36b985d0e7bf 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -3,6 +3,8 @@
 # Branch profiling isn't noinstr-safe.  Disable it for arch/x86/*
 subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
 
+obj-y += boot/startup/
+
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/
 
 obj-y += entry/
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1913d342969b..9b76e77ff7f7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -286,7 +286,6 @@ archprepare: $(cpufeaturemasks.hdr)
 ###
 # Kernel objects
 
-core-y  += arch/x86/boot/startup/
 libs-y  += arch/x86/lib/
 
 # drivers-y are linked after core-y
-- 
2.50.0.727.gbf7dc18ff4-goog


