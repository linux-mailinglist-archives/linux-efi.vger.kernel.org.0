Return-Path: <linux-efi+bounces-4450-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3563EB0D33A
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827B6162D6D
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E02E03E8;
	Tue, 22 Jul 2025 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/RbT0m0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47E2DFF17
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169408; cv=none; b=MJdlBrX+Z60O2ctxUuILnzTzhnDsTHpttZ3juAx5TRsjx0UxwrFUWic/3VKHXqYvx+NzAWgNsqxKdkx1e03aE6tpCS4YcvwLXIXTuaSj4NxkQwIgXHPYJ/Z9gePJWJF8f0YOBQ2u4Cx1H9VebT9UnTayu56i0YWnwZIrJ/JXZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169408; c=relaxed/simple;
	bh=MyZTAiJr+Bsb8d3CwPrhu4xTfGVOEyYfojg4l7en/cU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jhFUetMaWS5h1nP0yx0U9dOIDQnTYlAjeMEdXMUuBdIR5ryFM8OZQy5YqVOy4UpDz19bSbYd5BmMTJA6+xeWEiCkSFZ9ouZ3P3z6q7F+92U9tEPsq1KigrXOCSsk2HlFg8lLy9dw/kkW31cGD8978HQl8nP9L6/nXYulPlj5K+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/RbT0m0; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-60995aa5417so4818801a12.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169405; x=1753774205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=52lfpv9ab+7Fp/DJuYZoJNKtIAyZpbxccywOTdHmzlM=;
        b=u/RbT0m0qlPvQb7A7sOj111epPO6OCT8z1sFhSdZi1gImuowA/KNMHHOuEqce/dCuE
         Ox9L2Bqj5PiLyV69dPcfCgZcljiNcWEfyGVVtwfwlEm7v3M1QjsZ7eEhUfqtJRgagn0h
         UgtJc/5XTXAiYaKW2S+57ozuYGZ+/hSV+hM45PPNZSDJS3ohoV0t+H/vHaHD2jTXJWNP
         LemMESt0AhjT/t0W4mYoFnP9v0LU3Z/P0zrUr5ZauFqm4ftjtUfJw975qpMrbWHci4b8
         Ms38dMyNI46nTdLAXJNMQIcsqttW358FoJQi58yA/kcchn6GaDytka0sk5welqxJqm6J
         i2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169405; x=1753774205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52lfpv9ab+7Fp/DJuYZoJNKtIAyZpbxccywOTdHmzlM=;
        b=KAjVY/iXmxXf7p1b7aZLZ3mkIUUE/Rkpr49LMmDx35KbEV9bq7VUhl3NE9f5j6qKXe
         OR9MPMOoMKOhkgzuSOjBsT4BIumzx4s7nh4Gugc2CXcixH4Kep1B7Gk0U3bthKf/ncL8
         2xkQhgQKOM/+shknE6hUXy/US3uRBVmsr15L6MwzkyRRXrqqjZULrI2NYp1qg4mI9Nkf
         7+umcpHy2P4dIT84qM4Ph2Pe/8cUjJhTS1ai4zxKIdqBXobPwIv5IswhzIprY/3+/DyI
         +y0tIWf9KmpGwKBvLTA8B8Y52WJKLPAta6Brs4PKaMsGO4Ib28YZhEgC7AXtjFqQfvxj
         ZyoA==
X-Gm-Message-State: AOJu0YzFvFIT8JFjOS+IvWZ+Emh6PMkwiSoZQ2Y3pT7na4N6eTVxmWSt
	8t5svCU0GFV8cetM/PXzQVwkQ/sRi3tegzNlVgjmnKJ4nooqC3hZmICH1QNUMEZz4dpG2Uj5AQ=
	=
X-Google-Smtp-Source: AGHT+IHy5RMb8PZS2he9xh0aZxXUWnim89SQJ5wJPxOgV1ugy/IeTIYbaDRsSQQ/sT7HMKC1Zo7aa8Ru
X-Received: from edbcz18.prod.google.com ([2002:a05:6402:1cb2:b0:609:7d11:b264])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4406:b0:60c:60f7:ec9b
 with SMTP id 4fb4d7f45d1cf-61285941924mr19981767a12.12.1753169404874; Tue, 22
 Jul 2025 00:30:04 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:24 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4933; i=ardb@kernel.org;
 h=from:subject; bh=EpqpIG8BTEB9OqQVtVUL6zLybgK4ckBL4+6u1Wlvzuc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPedlrJK8P7+g80LhaJuQa6TbQr/ni8tvvKBK5Lfv6GT
 0Vq3gl0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIn8jWZkOP3r7+ToCVKpLU77
 HjD8a5hhbJCzNXHika/zExKT2KzOnmJkePU/5MoVQW3lVNHz+fUdr6aol62y/tI9L0IkvWWxs+Z GbgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-39-ardb+git@google.com>
Subject: [PATCH v6 15/22] objtool: Add action to check for absence of absolute relocations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86 startup code must not use absolute references to code or data,
as it executes before the kernel virtual mapping is up.

Add an action to objtool to check all allocatable sections (with the
exception of __patchable_function_entries, which uses absolute
references for nebulous reasons) and raise an error if any absolute
references are found.

Note that debug sections typically contain lots of absolute references
too, but those are not allocatable so they will be ignored.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/arch/x86/decode.c         | 12 ++++++
 tools/objtool/builtin-check.c           |  2 +
 tools/objtool/check.c                   | 44 ++++++++++++++++++++
 tools/objtool/include/objtool/arch.h    |  1 +
 tools/objtool/include/objtool/builtin.h |  1 +
 5 files changed, 60 insertions(+)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 98c4713c1b09..0ad5cc70ecbe 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -880,3 +880,15 @@ unsigned int arch_reloc_size(struct reloc *reloc)
 		return 8;
 	}
 }
+
+bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc)
+{
+	switch (reloc_type(reloc)) {
+	case R_X86_64_32:
+	case R_X86_64_32S:
+	case R_X86_64_64:
+		return true;
+	default:
+		return false;
+	}
+}
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 80239843e9f0..0f6b197cfcb0 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -87,6 +87,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_BOOLEAN(0  , "cfi", &opts.cfi, "annotate kernel control flow integrity (kCFI) function preambles"),
+	OPT_BOOLEAN(0  , "noabs", &opts.noabs, "reject absolute references in allocatable sections"),
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
 	OPT_GROUP("Options:"),
@@ -162,6 +163,7 @@ static bool opts_valid(void)
 	    opts.hack_noinstr		||
 	    opts.ibt			||
 	    opts.mcount			||
+	    opts.noabs			||
 	    opts.noinstr		||
 	    opts.orc			||
 	    opts.retpoline		||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 67d76f3a1dce..c34331ec1d71 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4644,6 +4644,47 @@ static void disas_warned_funcs(struct objtool_file *file)
 		disas_funcs(funcs);
 }
 
+__weak bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc)
+{
+	unsigned int type = reloc_type(reloc);
+	size_t sz = elf_addr_size(elf);
+
+	return (sz == 8) ? (type == R_ABS64) : (type == R_ABS32);
+}
+
+static int check_abs_references(struct objtool_file *file)
+{
+	struct section *sec;
+	struct reloc *reloc;
+	int ret = 0;
+
+	for_each_sec(file, sec) {
+		/* absolute references in non-loadable sections are fine */
+		if (!(sec->sh.sh_flags & SHF_ALLOC))
+			continue;
+
+		/* section must have an associated .rela section */
+		if (!sec->rsec)
+			continue;
+
+		/*
+		 * Special case for compiler generated metadata that is not
+		 * consumed until after boot.
+		 */
+		if (!strcmp(sec->name, "__patchable_function_entries"))
+			continue;
+
+		for_each_reloc(sec->rsec, reloc) {
+			if (arch_absolute_reloc(file->elf, reloc)) {
+				WARN("section %s has absolute relocation at offset 0x%lx",
+				     sec->name, reloc_offset(reloc));
+				ret++;
+			}
+		}
+	}
+	return ret;
+}
+
 struct insn_chunk {
 	void *addr;
 	struct insn_chunk *next;
@@ -4777,6 +4818,9 @@ int check(struct objtool_file *file)
 			goto out;
 	}
 
+	if (opts.noabs)
+		warnings += check_abs_references(file);
+
 	if (opts.orc && nr_insns) {
 		ret = orc_create(file);
 		if (ret)
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 01ef6f415adf..be33c7b43180 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -97,6 +97,7 @@ bool arch_is_embedded_insn(struct symbol *sym);
 int arch_rewrite_retpolines(struct objtool_file *file);
 
 bool arch_pc_relative_reloc(struct reloc *reloc);
+bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc);
 
 unsigned int arch_reloc_size(struct reloc *reloc);
 unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 6b08666fa69d..ab22673862e1 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -26,6 +26,7 @@ struct opts {
 	bool uaccess;
 	int prefix;
 	bool cfi;
+	bool noabs;
 
 	/* options: */
 	bool backtrace;
-- 
2.50.0.727.gbf7dc18ff4-goog


