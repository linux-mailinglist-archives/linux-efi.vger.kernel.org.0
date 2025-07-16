Return-Path: <linux-efi+bounces-4368-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F74B06C34
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8FB502883
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805AA28A724;
	Wed, 16 Jul 2025 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6BOr5OS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019A28A1D6
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636166; cv=none; b=Htgd8Xb6/pDem7Ljf7A+Bf5B9LTBNt0em5z3WqQkqgfNRMHuoezOnx9pF8ND7T7srl/Z8sOgaI2fdm5ub26qijhItBElLd++vPs0M4oroCQb/lZDDJK2OkBpSRmCK76NshM/q6jTezLwnVkmJ4rGUcMQHeYI/t+Q9NsdM6cLrmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636166; c=relaxed/simple;
	bh=AziSCYrqEKp3iXhsTCzhbJczPEzyYFFzm0EbdakEq+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eAy0BkAKReL4n7rgMA7j1Q0jcB5k2PLalgZ6pXwhOJQDzy3BkeL1u+80tk9EGcCHl3kOWpVDIYaISm6VP+0Rr6GUQEXBjPmjXNp5GpYAcfLSbJFNB+451N5ZTFUP39TImYemUNPfAk34wPjU3fjesBo/PzjW2DxEglwHsdPKwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6BOr5OS; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ae70ebad856so311953666b.2
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636163; x=1753240963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mW4f9PE0jE0e9wTTI8oFMDAAeEX2PGjVbeFJW21fiSw=;
        b=D6BOr5OSEEp8RjKo8O9GIPnwLbToRM/OKdGFf00h/4gCbOOqOwL7pVWKfCtTjczNmy
         VGqh2g7cZUvFvFVJqxJ7ArEvZ+b/BacZ7TyMdk9RK/o9jX2QWrHrmo0F+LBtbzBVnLjr
         miNPk9zU9ASM5PSoWNIIG0AIV9F29YEGzjrCXFmeii151VtusED8az1fBzRNyWF58JdZ
         TRx3QdgcccGWkgefsYoaTHlXsXvnMWLwfFd88r46d+n8qDR+nWQSgO2eZpFBq32xrYnZ
         JTMbprJDOUIBAnxf1Yet77oBP4bk3S6AG6cbAZ+GZ4qx4f7mtp3aATKVW8Pptq99HhRg
         p9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636163; x=1753240963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW4f9PE0jE0e9wTTI8oFMDAAeEX2PGjVbeFJW21fiSw=;
        b=RoCIpA5EIJwPuImvOv/5KBm1EB/fdMqrsY/BsYOv4oF3/+WwWeTKWLWKzY7BP+F4qZ
         6qVwyK4kJicxrpIN3ChueOJlrk/5mwoOVfXSZK1OvTC5pIcDPttB1Y8uN9zKKdWMtPTc
         b2g6y+mkVVgrG1Xg3dWOWPN+udaOjEGXjk2hgl9+oF3A2OvGi7Dq0MqkcJioDLgpBGoD
         Glhovsp+tvtyo31uB2629mSvuw2MZO4hD2ut5mm7xqQ2SV1AhIw+wWz3xQBa9iicweEa
         AzZztXNTQ9hHBS4EaLWp4o2Hqv8pXqh5f865XZSoGkyN+yE13CaOlyb4a4mXEt+y59UY
         wEfA==
X-Gm-Message-State: AOJu0YzpeeVnRnT6CMlKOPHFVb8pwoxx+krIPfVcKTITnnb9Ln+0wnT/
	XEEaz3CH00rH+nAK3VrCD7aXyOVMwOOryzTCENLCOqx98iw568s6GyB4FP7eOv//OEFNUa8IZg=
	=
X-Google-Smtp-Source: AGHT+IE7qRfZXV6AQa5Rrh4wuwhw8RG3x5M0O419fRKdLvQpXtzHUAeYhnuO3NVA7apJKno6n8plR4nk
X-Received: from ejbgk8.prod.google.com ([2002:a17:907:90c8:b0:ae0:c308:ee88])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:8913:b0:ade:484d:1518
 with SMTP id a640c23a62f3a-ae9cde5aba4mr66713166b.26.1752636163052; Tue, 15
 Jul 2025 20:22:43 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:29 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=ardb@kernel.org;
 h=from:subject; bh=kOQMYaSiu+ZXQWR7MbRw268I2y+/O3YrdyRKP8LesAE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcykXG+eT+JN7tv3asvLFOzmjptq3W1+Z/fMx1+qvN+
 U+mUxczdpSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJLGRmZHihb5b9iGv9tVe1
 0Xd/cDQqv83QvRnMJyOetS0vU+TeGluG/yWawrdaVtyYF3p+GfuhRxoWzNv/7PoWIxJx4IiTlEi YMTcA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-38-ardb+git@google.com>
Subject: [PATCH v5 14/22] x86/sev: Export startup routines for later use
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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


