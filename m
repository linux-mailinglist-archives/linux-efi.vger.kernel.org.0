Return-Path: <linux-efi+bounces-4454-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E07B0D363
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053CA3BE907
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1312E174A;
	Tue, 22 Jul 2025 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfot8Ue/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAB2E0925
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169411; cv=none; b=TzgrbJIs1H0ShLzm2gKtobLjZOMVg5QflbDyOGr8tVNv3WoXoi4LRi2H+b8xp5UtLc4fBnjXX27Tr5Eba7bp+TUXouU6bYxwENGe4VpJOEyut/ZH/7q8NgVbX6/HZ80UJw+wpipFgtn8q6rJLoS1Rbpd3gL1vufQ5utw0CbBvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169411; c=relaxed/simple;
	bh=qi/XSlH/3m0Py+I72AmudGPp6EWjqjC8xYfnH6HfggU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z5bNiBg9qxsEqq0EU/uWxMMdUcvdkK0BITpIK2gukuCxbYG/63RubEiAbB3Khp1JqZc/3EGA6HaWedxoTaO0MH1obm+7YLBcmcvsG1NJBbYU7ekBAzTynINTrc95rrF1DIpYWCNDU2xdyi3344KX5wwaYpe/q93iPVIas0nSVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfot8Ue/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-456013b59c1so30893385e9.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169408; x=1753774208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHREQvw4opT+z1wL8T5wjMmNHsYkeJcC/ePiz2KgcJA=;
        b=gfot8Ue/zHTK4+15kIeIwxJ25lvTOj0IhtyUqz8SqSdoOY3EIq3MO3rDgVxgHAOWfS
         wyJCsj6lF6qx6i0H+cHpppDWN0xtWPJqZ6cQNgN3gCzJ1wyhDviqFhPkJS+I6UamsUIW
         mnUpKgA/JL9J3oJwNX7qQucmU4RSQXm3LUVGSnWsE29C9DFDq58zP7Nd42EAf9j6JF83
         c4LLa755njee2HQMYIGvqRpRIIG5P5Kvd+uwvqoz+9f7Hh4yJkPYVD5VUPojEj7jL6OF
         xDb5ABKFbpBAh5tT7SxcHgEG9eBcM0X1zXMJ0Ru3yFGoZakmGfsM/YtVy5yCq5iQGizs
         JgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169408; x=1753774208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHREQvw4opT+z1wL8T5wjMmNHsYkeJcC/ePiz2KgcJA=;
        b=tmia6JVaAtzdCDKETjpJ7iZ63yog5r/Uy9hh5h2z7lxgN3+EwjmeMPnFdu8saX/WN0
         cbRMVIGuJNK1pi9NLuhllY3QSO2Ks5R3PT8xoeNJm5mzegJqosd02snpLvrVSRlogXMJ
         ZNce5qnJEl3/ALgaBLQY/t9eb9VgdK1WDhNFDUdgWiFk48PHWQcGY1PI4IyXiUK6hfps
         W4ZL+hP255bruPrrVmkO8ep6NmM7Ns+65k7DSdH0h+5Y9/H3YeZn1Whz7/V1LkbrpHyt
         q8qvca9HJmF/xMt7MqUE2HUFIykpt/o6X4MmL7AI+aws8LvDPHjvVeiEay2+jMOlrpE7
         7lSg==
X-Gm-Message-State: AOJu0Yx2lPyub7CFt/RhaIDz7YSXbHGgmKOyxacuZy+QCELnm1yv613d
	nY0N/O0i75SRQUPfefwBoiVEDSZg/ltpCJkeS+IxfpdxJXlMv7Puc9lnzh4JtKy3UmueJc1P9Q=
	=
X-Google-Smtp-Source: AGHT+IGtTAwtrVkEXe4/+Avmxv1YumQI8ZJGkeN8nTyEw6Kzmo+/2fxJfm3J/QfwTU9abxwdnRUnL0d9
X-Received: from wmcq26.prod.google.com ([2002:a05:600c:c11a:b0:456:293d:55c5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4709:b0:456:f1e:205c
 with SMTP id 5b1f17b1804b1-4562e32e598mr202752595e9.4.1753169408066; Tue, 22
 Jul 2025 00:30:08 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:27 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=ardb@kernel.org;
 h=from:subject; bh=N6Uq2lVfV25Jk1mFXhfGvG4B+EmaRioUjXHyXI14Co0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPedun2HZmrn0YdLv3GUvkjNmKXRvDZ3VM+ii77lLF5k
 4iTRvmGjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRnEmMDLdyBb9b3tpcZLhu
 67rch5YM16y+Ol30bfM4Wm7dvKdkmQMjQ78gr/zzE/pKIeb+y44+OSa88JB67JRd3xRCJ++ZfT5 EiQcA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-42-ardb+git@google.com>
Subject: [PATCH v6 18/22] x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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


