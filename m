Return-Path: <linux-efi+bounces-4369-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CF8B06C37
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30461AA754C
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63628B41A;
	Wed, 16 Jul 2025 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wy7hDKte"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95988288CA3
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636167; cv=none; b=fef4a2UCcfX4jMdNYiXuiDHskLwXojQqgR/DOrBTKT+4Ti0073+YBdtL/smmtdVBWPoZOxAtb9VzbHEhiWbHl/3ZavkIK3/f19wn+ZKpdsptwXiQG/2sqC+oaDK8i3sxHl/kjX04NZ8LPy/9YGSbwCRRkjI9jrgKf/9Q3kfgSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636167; c=relaxed/simple;
	bh=p335xwuasxivJxSfBt/bfL85xn1YPYtMa/fdyX2hkYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S5gPl7TtYMBmhPmJMd8jQ0dkWOOH9sqrqSE/GfBgt0qoRRWWT8VZG8t0gf3fSN3UKb4pdinS8Rm6WJdYPJhk6Ue0g/Mhih0NzYpq1rfhEXtTn7WvtlukozNx5E4Uu9phN0Oo+6q6msJLHp8CIGikt/fs0BSA6j3d907Nd6maLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wy7hDKte; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45611579300so21327845e9.0
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636164; x=1753240964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7khiFAj4YK22cn2aUX5ZXvNOvqbYT8yOs+hBn2ZA7n4=;
        b=Wy7hDKtewLa95R3bMrcRvGcCPLYFSF0VfKW+F53l793YvqyerPrAby0ee2/iOMC2DT
         N1/Hbhz5lIgeyxBypAxInJ55x7jKQ+UZvDLDdgkIdTYD/3R81KmZtzQ2slO9x+dcJMhe
         E6e11Ei46rjZmdedUsowQysDqjvMnbwoSP4bLP5cpKR8dxgjnETlX3Fkwtr8XZ1+nOP6
         WVcEIfRvJRxG1av08OAgiL5Jm1sQIhVpMbWsLkodQJSvTl0D9COXsMDI2Wr4wlc1SUsZ
         1cFcqayq1ZTYnWV8GFW/GYHKiE4CjdJwf+2LQn03B7aKHKTshRldenPi0OrhXrjwpKG3
         XXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636164; x=1753240964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7khiFAj4YK22cn2aUX5ZXvNOvqbYT8yOs+hBn2ZA7n4=;
        b=ntjBnXyvkrooGwspxKgcMpX+lYGCBKjsx/Dx+Zv0ZzlfgiIl6yXgcUE2b30pfDZXQD
         IA54WPalRqdXyldOGJCli2PXFdImf3QQTuBV6xkSvFS5bSK7WdprnfhwQ7EElG9kDEV8
         L5fh7AOa8QnPb5JFh6jk/EeOqwl4qcy+bU+9wwOG4i6n+ukCgH8YeQJCowBvZj6DECXa
         2G+YrQQf0uyu7HoSTIrwQPfhRSK3kQAx1ohDJJnSrM8gaMtSEO6qvxy2kfa+h2l9yWN+
         Y1Q9M74Rs2xhEMf9dy1qAwkVSC1pnDC8PUBIW6FgxXq7I3I/+Uh4X3LH/fe6EOEzLcDm
         zLlg==
X-Gm-Message-State: AOJu0YwuKsj4ZTan7rRznlTE5ps9aGEXQYE3lP4Ygt1819NrvCmpI3ce
	bNAzgPiYG4ftT+4fnHz75V4kE+hKhL2ivg8SEMPj4C98kdpEOn4ru0UMxTTU+xRM3XutATGI4A=
	=
X-Google-Smtp-Source: AGHT+IF2AGaO+mQScvryfHxDgCsObx0+rN9u21M6fulSWt9WhnXfRhnsuC2XAjckP/jNJ1QVu3osBtif
X-Received: from wmrn36.prod.google.com ([2002:a05:600c:5024:b0:456:24b4:ebc3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64e9:0:b0:3b5:e084:283b
 with SMTP id ffacd0b85a97d-3b60e4c1e2fmr532728f8f.17.1752636164149; Tue, 15
 Jul 2025 20:22:44 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:30 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473; i=ardb@kernel.org;
 h=from:subject; bh=KBpdtqnvzVD886mHANAPiui8pBP4bXCHS8Bbbn2shFU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcyvOdXW87y54pHVdXOsT35B7x5dI6qMFU/K5N73j1r
 42CW450lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlcl2NkWLHfR8zSbMtj3lkx
 N4vXhU9TrDDWiFybKS+TG7XeMCj+KsNfKc2PZy547Cr/qT6Bd0mtQ7BeZ4tmsOPj6t1Mk2beOzq DFQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-39-ardb+git@google.com>
Subject: [PATCH v5 15/22] objtool: Add action to check for absence of absolute relocations
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
 tools/objtool/builtin-check.c           |  2 ++
 tools/objtool/check.c                   | 36 ++++++++++++++++++++
 tools/objtool/include/objtool/builtin.h |  1 +
 3 files changed, 39 insertions(+)

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
index d967ac001498..5d1d38404892 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4643,6 +4643,39 @@ static void disas_warned_funcs(struct objtool_file *file)
 		disas_funcs(funcs);
 }
 
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
+			if (reloc_type(reloc) == R_ABS64) {
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
@@ -4776,6 +4809,9 @@ int check(struct objtool_file *file)
 			goto out;
 	}
 
+	if (opts.noabs)
+		warnings += check_abs_references(file);
+
 	if (opts.orc && nr_insns) {
 		ret = orc_create(file);
 		if (ret)
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


