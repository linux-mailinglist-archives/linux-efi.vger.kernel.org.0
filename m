Return-Path: <linux-efi+bounces-3569-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B9AA85BE
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8234177987
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE741EF38E;
	Sun,  4 May 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYqZ4xwb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DF1EF388
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352425; cv=none; b=DkId7NS7IgN2bixM3q7nPj+nSOdTPKzIXYdI/Zah92MsJXqppB4R8qWgsgRfiAH2zH1KVK1Y2ZwPZ+lTAsUho5jfl6GRuo8bPqBN969s6OhwSbK7dikpNj+cVN7BMyiX9IHtB1ErUfbzQahW1bOo8DJW75PPtPitrhM0uLoJ6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352425; c=relaxed/simple;
	bh=iwQiKCrnRw6e5t0cbBba0LK388tT/jjrdqhKVRDej5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EYhTk5X0CmvOJSz4yRPtUh9BpTrspMZKsc/mwtgSucDsa8rnEYbdAFqugwcSm24Lo1Fs9etC9pWLh1B63GAAVwh8ckCKUmLcXizLe3d+0FkhervYl05ZJxnLLMe/bQ9ORjVYZZtw0VT7NKJUFT0kr5DC05wQqvXSnuMpl6j/PzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qYqZ4xwb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d733063cdso25243885e9.0
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352422; x=1746957222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=09I89rcrSx0lGt2Hht5eDxGNoY/1U5TFE9afFv+NSJg=;
        b=qYqZ4xwbGYbWZyLbms3wb67/1uPTOjphrcgsmow96gpinHW7MJVOcqy2sqaBX3D/kP
         UTU03PP7LaHT71R8BHnglrLXGpI9x3LFCsL9XSsr4iQENXPlcRMpEROknFvT2RK0f+ft
         FgsSRcuMIWFabqDjeABN4acuQhtaOT8C6dlraYM4Fmza0gJrLdhI2m3MLXaRbg25nTfd
         T4pvpSSTB/60FRmwJBTVpCaE/C++fKIdNml+WATAT7ZM8p4blFLbEd6zo00otzokXfM2
         2NJnjCJ0A1mijAHH9PYJm6louk/nOWw0Feu46MbgIuLmOislMknHyG82zcJuzXI/iXeA
         oTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352422; x=1746957222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09I89rcrSx0lGt2Hht5eDxGNoY/1U5TFE9afFv+NSJg=;
        b=QKKkjLdKjeE+ddezLy+/5HQORl0rPWya6gg/5ebBgSAXyLsxdpQTKhSvTcClJdbpqX
         47w4YjFJIRt2p1wLXSVGoZvvX9g6n0hklAUp8L4dFAngxL055vBLcDB4A4MEmPgTxodF
         voxO7Ilk0KFmwY4cfFcGsSWzymcTVYsORQgRBcK6a/XG1guOTmLYx0CT8OduWNyC+C46
         AxG3pNphJMY5KjTa8O3TFywdeCXQ4v1Hv6TxTM5O/a0Qme0l/p08POYNPnDHAq+/lIa7
         r+UbCyhkTYwjbQJWCE7tfk9M2oHfS3fl1jLyuHL1TcRqHtc7HiWKDF2L/c3EIppbC9RH
         WyIg==
X-Gm-Message-State: AOJu0Yzjrlj5ZlABGpE2cs5BLYB04PActu6oDPQ39md0Z926YJOBjiBG
	n+fWPF7In/YHwVSupQGT9bO3AX29ZfnhVObDx+xMebZpYW/x4JdUj9NVe0T/VXfyGYe9sg==
X-Google-Smtp-Source: AGHT+IEHBRZOthoNCWHQ+QuYQRNm81nOsUZ5ai5bBhDx4UgSm07jqGJS8LMx1Ev6Aa64AbUsy2b67Hgg
X-Received: from wmbbe3.prod.google.com ([2002:a05:600c:1e83:b0:43d:2235:bd45])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:510f:b0:43c:ec0a:ddfd
 with SMTP id 5b1f17b1804b1-441c1cc4826mr41965635e9.6.1746352422181; Sun, 04
 May 2025 02:53:42 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:48 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=ardb@kernel.org;
 h=from:subject; bh=Tkjl/5QM7fobSnvXL0Qey90uzdX00dsND7VqTMhk7jY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4pvD32nLKrTrLjJ3Zcm1/TnFXHT3i8aMvVtNXUri9
 mU6bJvfUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyeC/D/4ofnQc+LPupJH3P
 yf1ASoLTi4Dtq3JCtvk86uBnObP6nxHDP61Nms2R7MeXzFid71bEVrCoc2b24aSVhw2k1F3rF1y 4zQoA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-43-ardb+git@google.com>
Subject: [RFT PATCH v2 18/23] x86/sev: Export startup routines for ordinary use
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Create aliases that expose routines that are part of the startup code to
other code in the core kernel.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/exports.h | 14 ++++++++++++++
 arch/x86/kernel/vmlinux.lds.S   |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/boot/startup/exports.h b/arch/x86/boot/startup/exports.h
new file mode 100644
index 000000000000..5cbc14c64d61
--- /dev/null
+++ b/arch/x86/boot/startup/exports.h
@@ -0,0 +1,14 @@
+
+/*
+ * The symbols below are functions that are implemented by the startup code,
+ * but called at runtime by the SEV code residing in the core kernel.
+ */
+PROVIDE(early_set_pages_state		= __pi_early_set_pages_state);
+PROVIDE(early_snp_set_memory_private	= __pi_early_snp_set_memory_private);
+PROVIDE(early_snp_set_memory_shared	= __pi_early_snp_set_memory_shared);
+PROVIDE(get_hv_features			= __pi_get_hv_features);
+PROVIDE(sev_es_check_cpu_features	= __pi_sev_es_check_cpu_features);
+PROVIDE(sev_es_negotiate_protocol	= __pi_sev_es_negotiate_protocol);
+PROVIDE(sev_es_terminate		= __pi_sev_es_terminate);
+PROVIDE(snp_cpuid			= __pi_snp_cpuid);
+PROVIDE(snp_cpuid_get_table		= __pi_snp_cpuid_get_table);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9340c74b680d..4aaa1693b262 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -517,3 +517,5 @@ xen_elfnote_entry_value =
 xen_elfnote_phys32_entry_value =
 	ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
 #endif
+
+#include "../boot/startup/exports.h"
-- 
2.49.0.906.g1f30a19c02-goog


