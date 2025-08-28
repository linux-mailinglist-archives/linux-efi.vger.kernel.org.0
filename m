Return-Path: <linux-efi+bounces-4640-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3361B399B0
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7926A3BD55D
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF930F552;
	Thu, 28 Aug 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbOAADjo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CD30BB9D
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376576; cv=none; b=VU3FbXOy2n5lKg/8D1WqAJp6ilj3Ze5UVvhAlc29vB4YV56zJZpor6zV5y2Z2Fw/knbqYoObqSr3XHBneqU6AmMXgPIiiI20W7nBVgHvnFNg322MUJQUgvtbzZ38oYqS3MojyhWvwGpWDPyYKFy6+OvVHbSwTeONHv+m7nGejLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376576; c=relaxed/simple;
	bh=CXktk/3ktYtlDoKQDE5CsLePB7sfd59X2JWdEHn1/S8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gHXc9qgkbfgiG3UgeZEPHScVR+8OqTucDC9Po0aaOHHxqcem1ZMX7SQkje4yrB7cvIm/lcFGuwtOt34EDoXICcGmqZS32rYPl4PCsy5t2ZGTBNhyfqSqsNnG00foHE7krGTdm0EPkjzZRDGNfUno3JQVX+e7REs/XwbVwk2Qj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CbOAADjo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b74ec7cd0so4933455e9.2
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376572; x=1756981372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gC5W6X2xpozBVwR+ZZENH3Rw9CsJdIRSiecoK84WE7c=;
        b=CbOAADjoK1QJxNmny+zrd8EQemd3IJEmSq8HGVULuuYy/jnPgznAJJ+HL5YBqQPX6r
         /IfjMz9o4sgObn39IUylKO4lzjbC77ULI33RTLCzJT3VDG77gQbHiVJjIsuWnSqTS9Do
         5SLZIQkRLuPtX4nUDqNeRwj0VxsBOLbDHgKeS12zrH2R7FGXOKVBjgxUug0a7OomkUPm
         169Y+XPX/daM29u4cMNc0CMkHL+m9LRkOZOF3gV9Kn9LQjWuzJ9+Ww6m40CtR6GBOpiz
         B3LPCW1nCf2wEYp0Djq6v1jyFQj/bmCi/w9l0blP3g0ivdT3vkxLvHer4B4QYjW6qCzK
         tkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376572; x=1756981372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gC5W6X2xpozBVwR+ZZENH3Rw9CsJdIRSiecoK84WE7c=;
        b=hDyDtgpXGufDYWhbPXcXGEO0go5xybBxcMf+qn36QHv6XUcVb2S9IUPDAHe3rz2NO0
         EAGuiyGxOt9q8U4bBaxe3CvKHBsEaEGhSd2UlybFdukfsIy7iODyjtnwaN0ZZLItxneM
         45MZ2Cx6nOX0JRiaWFek9+LDziN8AvJVKY4zM40jm9KDg4Lg9wqH6AFKOBC/EIj62rnb
         nqAff12ZYjn9sJ9fnMLTVARVGqGAAvhSV+l5MPQMPSmA7lqtXICrbViuC5bXqBTVz1TO
         YmT4DsUkahEyCKrcttHTIwyGl6gG3QPHbuORlFtPOqq7BpYxQ/Ro8ndqmSWNi1HeDgmx
         tkSQ==
X-Gm-Message-State: AOJu0Yxv6rlu6yIUerahnPzsg0wGaiaoEg5Hf0VDfiAA0c29UEt/c7sU
	d3LQkF7sW9zf1/04fRVja4AdDdhXy7LNttjK9IIDB9u3xbani2YizTlWopXwgViT+Rh1CUQ5Gw=
	=
X-Google-Smtp-Source: AGHT+IGk5A+c9ZauwvIFtJFV0781AhxX/ojz6Gd3Fd9wjXDV4PD/3u0/o0sJsZPaWeQJQH/IVgYLIVEo
X-Received: from wmbbi5.prod.google.com ([2002:a05:600c:3d85:b0:45b:6360:6457])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4715:b0:45b:47e1:f5fb
 with SMTP id 5b1f17b1804b1-45b517d8ffamr189159875e9.36.1756376572416; Thu, 28
 Aug 2025 03:22:52 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:18 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4933; i=ardb@kernel.org;
 h=from:subject; bh=/Ow2c7Eh7WXOHbGjqlPO4UMCNa4pimfe+LzGDv+GZcI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7p1mc4s3vt2/9GvucSq5Hf3owe5e63hxZznzLeUq3
 59vFX91lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIls52D4w3+sNpfFQezhc2+v
 L5O/79/0NPNVbtqRnGLhg7kX3r/I3MDwz3qJ3Eleb7+dPcFzghnD3veXXHX78YCP72rN0i0ztxQ fYQcA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-39-ardb+git@google.com>
Subject: [PATCH v7 15/22] objtool: Add action to check for absence of absolute relocations
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
index 79eab61cd944..aeefc749e237 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4686,6 +4686,47 @@ static void disas_warned_funcs(struct objtool_file *file)
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
@@ -4819,6 +4860,9 @@ int check(struct objtool_file *file)
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
2.51.0.268.g9569e192d0-goog


