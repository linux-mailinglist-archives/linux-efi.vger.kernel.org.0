Return-Path: <linux-efi+bounces-4639-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE44CB399AD
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9FE7C1DF6
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2773630E844;
	Thu, 28 Aug 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nXJyfwS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518E30EF64
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376575; cv=none; b=KbeyCzwga4BT/mVK7KIhm/jQ40C1+6ooPTGms1kZ7McrxilTf4u+NMkRrFODf8zzhMy5n5fm5VKG3QbG5DMoa5bHAXmY6SpEG/gLXczzAy1X53G3eBSthK1pPmgmSy5/bgM6+d7WceA7ZF/rF/mwg0GDl7fvNPzCpL0FryiiiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376575; c=relaxed/simple;
	bh=C8Csp226/YzfeWHSASzw9WJOSXUwkB6EtwTL/bzqdvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8vzCBoNt5Rpt6/T6MuBcI8sIlxTNbZII++RrsMk82dFth9Rh8xQQ87kw6JW8iW/sQbcXZi8MQrcRorC455WbWF+B5znwa3F4PlGRTer7XmLPvRrejj0bPferQYlxrH7f1hT7BwUYTKKEJcRqf9x8c3yjRZCHJlTNODZm72SFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nXJyfwS; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3c79f0a57ddso455769f8f.1
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376571; x=1756981371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=drwOIUdP9CFzwn412iXkc1dycUMYVpFZ2JoqeIstN34=;
        b=2nXJyfwSXjatzWHuohfq8n+XMgDG7RnY7gXEQK6vefylHKrHK3QkhAcTIuZMIXDdrI
         fGqIiU9nMtyX7cz49MzrEnJiUGAQnQb70yvH1p3piHy5CQh9oCfiMHhH0+Ag8GQl2g60
         i1GIYDmO5q5kdc8ymBysGitueqHiPBv7H/Sku/AH9hm0ycP7k2ih4TGSruoZYF27ot4R
         NsmYCQdKTOyhrnJ/xJ8HwUbXX7DxM8w/J9xUvXaVqlcSQeHgPkH0eFkw1T9YPbmuJSRW
         wsxhv+zicYScOkMngImIbfhpT5YmUS+4S4g1cvPm715oRzvXaHaaqzf8kHzwly3/2uIW
         7Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376571; x=1756981371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drwOIUdP9CFzwn412iXkc1dycUMYVpFZ2JoqeIstN34=;
        b=bmGYzn7RyPStJ7mwYbEnQCX94uTfckWlCaJw7N6vhoWOUuZ2EPFKE8HORobWbKwjXN
         XAnvg+pfeRea2zbA6hRtyP8xOaJBp9ylhTVHjAJEBCZtY2e6/2l6OosPlD5b6a8B0sNr
         R32gGubsez6RtRosdsay/A68/q7Cr3FyxjH767uZ7FhpFHZt6q4zHduvkhgNk0fIHMr8
         AREhYlBsS2IPolc8KeaOrfCQTqeLRmfYoA+MvjFE8Fv3NQtqGpU54Urzqv2gSRuXeJ6p
         5NB6nWUI9v1h/LdWOnSA9zUmeSS85+QsqCcBNzur+eC8ibo64cDf+cEkvWbjCsajoSHg
         Ssfw==
X-Gm-Message-State: AOJu0YxLLaocGNTzJkqcUf9uHRVbBcdCDOSmuzsZH7+YVV4I+N+9tjpC
	ht2LRQQbg5YyJZeqGDpTjYFNuS1jRj6WSU7gFP/8YNGA0dR7ykCzmKoEwS0tsnOAHFdAxzzQjw=
	=
X-Google-Smtp-Source: AGHT+IEW9YcvbPIqRSaXTvjHk3oWsIrAjMzazaRVz/Z6Q9LwVhMb6DSeRsnCMsjz2Kfh4d0bChGQfID3
X-Received: from wmbds12.prod.google.com ([2002:a05:600c:628c:b0:459:e068:b510])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:18ad:b0:3b8:fb31:a42d
 with SMTP id ffacd0b85a97d-3c5dc6385e1mr16035040f8f.34.1756376571462; Thu, 28
 Aug 2025 03:22:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:17 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=ardb@kernel.org;
 h=from:subject; bh=/OAv7ZhuG2hKsYziZ71xYvsi1BlIFCdIV4BfD+340/U=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7m3GAjtTV/Os+CMRe44bTTTU3x89wXHmkurnXu0v2
 Fen2nh3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIk4OTP8Fb/6sv/qz1khuVa9
 68/oyB75ty7Y8fmszWox24/kmyuW7mX4X+o6m/d8iRGrLWPZMR2/ykqzrTe2iMT5/f5Ylc+X7mP FDwA=
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-38-ardb+git@google.com>
Subject: [PATCH v7 14/22] x86/sev: Export startup routines for later use
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
2.51.0.268.g9569e192d0-goog


