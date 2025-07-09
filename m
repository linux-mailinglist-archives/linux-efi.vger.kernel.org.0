Return-Path: <linux-efi+bounces-4221-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 654CAAFE221
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7713B188523B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B40927E07F;
	Wed,  9 Jul 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+JVEFqa"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382023BD13
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048698; cv=none; b=BcJxwxaWitXhshNsVm7pD5pAsT+p8NNW8FyeS5qlS+HbwRx4D0T08e+BkrcXgPig+6JtyrmLaSkVivX46GVUIhBi3VLyMJMG4OooY8qu3D1l6trTOYY0Jozp3c57FAxDQzcYpsxHEFc4VPN2aOLQK5tft3pPt4gneo08HQbG5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048698; c=relaxed/simple;
	bh=AziSCYrqEKp3iXhsTCzhbJczPEzyYFFzm0EbdakEq+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CoazaE4RRsJjcguYSvT2qyiY5CkC/ZJMdrsrKzd9ihWRaWVGyD3BDJgJsiAqCCKcjRVnNnLsBt/Em4HDG2j9eBUDmRcg24T5hn/CjJUXLUy83W33eJ0p7G7Dt7/e43/fqhYuPQZDo+DGhuXC+Pg4lg3I/+C3vLQkQzX9WzdpAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+JVEFqa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so29359965e9.3
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048695; x=1752653495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mW4f9PE0jE0e9wTTI8oFMDAAeEX2PGjVbeFJW21fiSw=;
        b=k+JVEFqaybvE0aZt2r5CsggaffBbtBhEZYT589UpZJ6w1huwiHLf4p4U4Kub4sMAkX
         iaBucYTihe75rsl84YPPv6L0rH25hObKedme6OeCluQ78a0Cv/mu8IV/QvLfZ0t/XuCJ
         FWq7Pt2RV0Ote8D/1G54gF/1hQFxCK5u+5emNzNv2OsxqDznZ41qhamwvkXnHTVW5jXR
         C12Gy0Affi5izfMpKhMQwJ232lJy6JfBCTcAnEfgkCx91Izo9P4T8k3RApFsf5om56j7
         DCfPo3zMVVNBF7tv3OfzqdacN9ChjuuT4vdgjvOlc0oL0nFeFAZaK0xt/V9gc8s7hezF
         ZPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048695; x=1752653495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW4f9PE0jE0e9wTTI8oFMDAAeEX2PGjVbeFJW21fiSw=;
        b=OKo0RpNVLkChnV6pTEd8D8LJ4oXMFxZ8kLVYTEB/izNwWA1W97HbTOfgZ9Og4Kjyvr
         BOIcT1vQLA2jLG8qkC4Tk4FVNahvjBG5yb7mk3offNJVda+kIWQe6jWw4rHOSxoOj7hi
         jD/DPU2GDcBIXzkha8entAozS4F3ma5Sh4KBRjw4P37KTuBgtaOLwFsSzMEFtA6x3ntI
         HZj93jH76u1dgV1KqEUhpv9ttsm/MjPUTrh9iWnvIkIZJgZD3qbcq4T/PqmIN04N5g1L
         4qHzmzxIWF5RdSSRxCij2MtLtPVHSD12QlAdpnYUL8pC11rKNL7+bIJSGHIAC/Nlip8r
         Y6CQ==
X-Gm-Message-State: AOJu0YxLkdlWZb6Bf05MLJlGEfcNNJLEZ4jv8ODqFjJVlufUQIpbqmmy
	67XnvstPs5kHRd5QODOnGZhfkzQsEqcA/umX1fa0FK46QNLIJpEhCjI+OlGaxieZGHX2Kw1TNQ=
	=
X-Google-Smtp-Source: AGHT+IFYnMWunOkuwZilhgJj8CBhve/N6rClwHekltMlTHywqNLrvtHoe8epebqPwqikRuScN1ldq4Iw
X-Received: from wmqd14.prod.google.com ([2002:a05:600c:34ce:b0:453:86cc:7393])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b88:b0:441:ac58:ead5
 with SMTP id 5b1f17b1804b1-454d53f34bfmr14215915e9.31.1752048695741; Wed, 09
 Jul 2025 01:11:35 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:57 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=ardb@kernel.org;
 h=from:subject; bh=kOQMYaSiu+ZXQWR7MbRw268I2y+/O3YrdyRKP8LesAE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+Y6M88n9Sbzbf+1YeWOdnNHSbVutr83/+Jjr9Feb8
 59Mpy5m7ChlYRDjYpAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATeZTEyNBzosrq8PFTS/dk
 qy1K7WH7de3V8dzX3dnRGdryNiFT9MIYGd67Rhms+RsQlJ3PlX/mdfsJ+ZO/6isKP66u4tJTaQj Yzw8A
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-42-ardb+git@google.com>
Subject: [PATCH v4 16/24] x86/sev: Export startup routines for later use
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Create aliases that expose routines that are part of the startup code to
other code in the core kernel, so that they can be called later as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/exports.h | 14 ++++++++++++++
 arch/x86/kernel/vmlinux.lds.S   |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/boot/startup/exports.h b/arch/x86/boot/startup/exports.h
new file mode 100644
index 000000000000..01d2363dc445
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
+PROVIDE(sev_es_terminate		= __pi_sev_es_terminate);
+PROVIDE(snp_cpuid			= __pi_snp_cpuid);
+PROVIDE(snp_cpuid_get_table		= __pi_snp_cpuid_get_table);
+PROVIDE(svsm_issue_call			= __pi_svsm_issue_call);
+PROVIDE(svsm_process_result_codes	= __pi_svsm_process_result_codes);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4fa0be732af1..5d5e3a95e1f9 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -535,3 +535,5 @@ xen_elfnote_entry_value =
 xen_elfnote_phys32_entry_value =
 	ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
 #endif
+
+#include "../boot/startup/exports.h"
-- 
2.50.0.727.gbf7dc18ff4-goog


