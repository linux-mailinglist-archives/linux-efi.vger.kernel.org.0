Return-Path: <linux-efi+bounces-4222-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5204BAFE225
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98EC189584C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ABE27F4CA;
	Wed,  9 Jul 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FjMb8MvM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD723C4F4
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048701; cv=none; b=fIyb+/LK/0pI7s+Gzxl6TNhMifhpF4UsXBklEJyr4Pi+kROqWhQn7ppCaxNqsb5wncn0cOOOAsb7tsTYYiUO2BZcRcvmo2VeMI69kC+4r/mxbwVvtEmXG6csbr4OPF6NRMR1IB/LnZWuQO4RE5KJHs8DQs5WRavfCYRjjivGZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048701; c=relaxed/simple;
	bh=p335xwuasxivJxSfBt/bfL85xn1YPYtMa/fdyX2hkYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oI0oBfRhoBi2ZHIao48budWnzw1lqXhht6cOQwNbhhmxHMTtzxf6PrOC9XzccnKCHqcpXbacoyWlB/uniUx/PRHOW+QGjq4a8CFpYyxa0J0EpD54hASZZKH89pXxN/yl1bNfnmTOEgdKrYsTghYVFprWwDi7z4LT/k+fU22JNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FjMb8MvM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-450d290d542so31039495e9.1
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048698; x=1752653498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7khiFAj4YK22cn2aUX5ZXvNOvqbYT8yOs+hBn2ZA7n4=;
        b=FjMb8MvMN6Z8d3d6JKvLN2/K3uX1IA/wLMumoeMYN3fuJbIdrayIDh2pr8I1hTTV2Z
         CQT2u9R0Ot1O5ZtwRobMDvbdjOkFiQ4TdebgjP+/u9RjYyGl8YDZjbJuFMxRDe4yLl4L
         HO3v+7dIvaFdHXfVaPh1wLrhnj+9iwjaBg/1vZfoxmkMo8c7c/INKFIZFmfqSARwl1zP
         h0gRhgw6efzfMRZKoZDaC21CsqOX010aSeQDkyLO681MyNvSrALK10wN4oTc3r0Mx+Lj
         gD0nrG92DYAN2DZeNviIQdghvFZXbFMQY3TmdKyF1MBuRzbas6e04dH4ZtCxrZJmBgDP
         /HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048698; x=1752653498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7khiFAj4YK22cn2aUX5ZXvNOvqbYT8yOs+hBn2ZA7n4=;
        b=j7aiV5lwN1fz5DQ9ddk1teTrpf0NOp+sUls5XNLYoxtWm/PwS4uzsSnTHwt1gzGokO
         DHkM694hyTss6mhbtSxsogFTp9OO8WURyH7P5yz03sxv1rvDgdqjFROYH0QCo+GZDJPc
         sWbEsniy+4VIvrkPn6l93zqk/fCxH6K1m8Nf89iiQO6UZQijCi8ai4Vyl7qlb0JRt1M3
         XgrQHfJwbRZaY+y5BcoN0koTSRBYZ/okfmVkq9Dnjz5WUMlk9eZa5ru0oct5wPmbAATW
         IVcGyfHuv7bHfM3z26V1RHNezOawwy46dTi8W7hZS+DuxpnutG2K04ygdFA9Cp/4nP9A
         C4sA==
X-Gm-Message-State: AOJu0YzJDGq3XBGBvOtQS0sMRUlkZeYshRjPEbQl9zCqkSSqZTN+d50i
	EvOO0oaxjYm2Vln7H3GFlA90sz/r91vV8mw8w/wWm9ZVToO7pL6LWpMmLvWRTeITM7bQ0Kkaww=
	=
X-Google-Smtp-Source: AGHT+IF5DUabQ3kFzAcOpaKBVnbx9hhMKiKf3QcPiAI8GaVKBMOAXsGuBglhrmgVGqPExy2SpbhqWBBf
X-Received: from wmbej6.prod.google.com ([2002:a05:600c:3e86:b0:451:deba:e06f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d08:b0:453:5c30:a1fd
 with SMTP id 5b1f17b1804b1-454d532899dmr11995105e9.8.1752048697860; Wed, 09
 Jul 2025 01:11:37 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:58 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473; i=ardb@kernel.org;
 h=from:subject; bh=KBpdtqnvzVD886mHANAPiui8pBP4bXCHS8Bbbn2shFU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+eE7u952lj1TOq6udIjvyT3iy6V1UIOp+F2b3vHqX
 xsFtxzpKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMpYmVk2LODn3Hl7OK5c/SP
 P7uRq8i4XJd9hl1raJDBNKPL9zy4OBn+1/dsfJEpFrLa2LZfc5eFbEJ9womEVh/r2aZf0uweF71 nAgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-43-ardb+git@google.com>
Subject: [PATCH v4 17/24] objtool: Add action to check for absence of absolute relocations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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


