Return-Path: <linux-efi+bounces-3674-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76032AB44A9
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB458188A4ED
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0B29AB05;
	Mon, 12 May 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eC4aub9n"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B029AAF9
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077134; cv=none; b=I2lVqfC9yjSrPUpcJz0WeoZHClWRNyA9GMt5d9o9YSwvCsiU0iBP0A9Bw6YmldYbtpVthNQPttGgwuJp9z8ifS8bXbP4kT0PVaZAupiKZeyqy3NS7oaAQ5oF0Z2LW5Oc7ZYzpbyGr9l/kU/LOhpLyXqWYB9reTQZgXWP1KBT71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077134; c=relaxed/simple;
	bh=CHrRMRKAsr4gnOYZa5wIdBBNkBXn0abGtJEueJ4Gpz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cLSodxcZBPdNGn2Qp8Nk4FCp5kN1tgkSIK+8wjiGRmO7QpnYv4ol4Jm5hoVV4Tk79+EYZowutksoZH4Ftpc41LmnbMZ5DEcq+bnqUXJh1i5tgkzbr41U2UtPO8QOvpVPxCSklkQdejNofSffFwdND0gW4TT8W98VBDNhsBabx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eC4aub9n; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43eed325461so25224535e9.3
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077131; x=1747681931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMcPqHG+OsNqp0sgBphkpu6UJs8frBdc/nbebN6ySzs=;
        b=eC4aub9nKHfgfsoHqIecTQ3qBptbLBcBXsBlpq277Y9UhLZRwg7JdZNhdALUnmE+s5
         61VpL2dtmNTP7SALl7V0Zne66P0WIY570JPJZdCIVqFh9pyRtrPY4y73DvA2P+43ZHHv
         5Rmsl+6WFJdxgYvRbNsWNY37QwDpjGaTiukxUF0ZInoxJASUDCMJbBGT9G6ER0yhxngk
         9Uyfz1PPMTrT9xY0UOErgR5Wyep1VKF43RW8FBzc+euPugBANdX6uVKxOL1E5sc43524
         eLHLgXhkHJNDNkQobeYW+8/xots0bfJeOeFYeCzQwvMSGBWR48MqujlzadHFYnHxVIil
         hGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077131; x=1747681931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMcPqHG+OsNqp0sgBphkpu6UJs8frBdc/nbebN6ySzs=;
        b=P5hbBym6q67Ea6IMNwBuwWTOB4HN36g3yEKfKJ0bUf+Ho7CHbsNADcqrXic/5bezmJ
         m8VdFjWQUeQZArIcK8DMepVRUVWbrzkybXwDYUop9vQn2sn0umHT+LKfyLf/ccDw6adB
         CyHbWEo44THOHG1u5UDcXteHEwzlAwllPPFrmcn7DCWqFmJ98kdAxnTxxidPrXbuCnLQ
         k7ojBRVmhof/eXdUUPo/rdtjSggdRsEvVW2HzdTa1LcG+7pwFfnDeZ6hgP2UUWan4ud3
         b60KYQNOeKx+L4IOIIovFWVc3pKoVDSkf+FAUkbxLl+mpAYlsyQNODRqGxW58/PYLzTe
         smwg==
X-Gm-Message-State: AOJu0YzfIAh9g9ziA+Ko+KKxYDW8PKhySSL/4zg/4lIaDg+n72MGmPos
	4uScchi/SGvSYQe0ARjNus0aFWbqN9UwTdZQ3KQAaPVWUDWlur37SkEojgvRw648sPcz4A==
X-Google-Smtp-Source: AGHT+IEd8TTSTlWt9D6t/Dm415lV8SeKsldgBtS4Gzixi/S65b+SbQhQ70tnJqv5IA+JnbXnJdoYPwvQ
X-Received: from wmqe12.prod.google.com ([2002:a05:600c:4e4c:b0:43d:47b9:bedd])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e45:b0:43b:cd0d:9466
 with SMTP id 5b1f17b1804b1-442d6d44b3cmr122027435e9.9.1747077131179; Mon, 12
 May 2025 12:12:11 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:54 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1670; i=ardb@kernel.org;
 h=from:subject; bh=pQDCAaxpkvazvE2Nd2OxQrPwh6fRRJgnquFDar+22pw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJPSLln7xPleHi5fNPGz/6qt+rtDnvzhN2ldb1iyf/7
 3wdqeTUUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYy04KRYdncbXlqB35J515Z
 WGX6aMWBz7tU5c49Xb6LNWrurcc/vE8x/GJWuxrwLN3NfMaXqlntSxfFmVm8S0zKDz80m+mCTsb idawA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-42-ardb+git@google.com>
Subject: [RFT PATCH v3 19/21] x86/boot: Disallow absolute symbol references in
 startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Check that the objects built under arch/x86/boot/startup do not contain
any absolute symbol reference. Given that the code is built with -fPIC,
such references can only be emitted using R_X86_64_64 relocations, so
checking that those are absent is sufficient.

Note that debug sections and __patchable_funtion_entries section may
contain such relocations nonetheless, but these are unnecessary in the
startup code, so they can be dropped first.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index c7e690091f81..7b83c8f597ef 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -35,9 +35,17 @@ $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
 # code, or code that has explicitly been made accessible to it via a symbol
 # alias.
 #
-$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_
+$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ --strip-debug \
+			       --remove-section=.rela__patchable_function_entries
 $(obj)/%.pi.o: $(obj)/%.o FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,piobjcopy)
+
+quiet_cmd_piobjcopy = $(quiet_cmd_objcopy)
+      cmd_piobjcopy = $(cmd_objcopy);				\
+        if $(READELF) -r $(@) | grep R_X86_64_64; then		\
+                echo "$@: R_X86_64_64 references not allowed in startup code" >&2; \
+                /bin/false;					\
+        fi
 
 extra-y		:= $(obj-y)
 obj-y		:= $(patsubst %.o,%.pi.o,$(obj-y))
-- 
2.49.0.1045.g170613ef41-goog


