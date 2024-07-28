Return-Path: <linux-efi+bounces-1502-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D201B93E949
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jul 2024 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F771F2177A
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jul 2024 20:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B9678291;
	Sun, 28 Jul 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAVlKJ+S"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2277F13
	for <linux-efi@vger.kernel.org>; Sun, 28 Jul 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198655; cv=none; b=BQeqPaxf5iyG7Kq2u+9iXZlOPQIn6Bvdvqm5+rDeXh8878q+ms6/AKvG/oUiBzdWVI1avTytwK6iZTi/QN/zo+jFPbe93DddmvPTbdW5LmOuhtkQ3jQjAezasg3oa+PdYj/fPVC7bTiWY1txpw2swm/fu1eZXM37TYbRxrRj3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198655; c=relaxed/simple;
	bh=FBqzozWJhNvJ4oM6y6ThYCUCO6Sc4TGcBQGQrbyCu+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KNj1YhlKLTMTQSsx/zVxgEDF3c+FQXrDqKUGyXJdXbxQm2y7BqDZT4ZZrcYfqJDQDHOxKtO1OY9lAqooUJx1ogZB5qHl2XPdcWMVMHO3WWEPqkAv6CpYj9s9khqltSiYnV2VJZ2rmGpr2WT05SzzWh4NJXvS2p5Y3Ei+pdC1vV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAVlKJ+S; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05e3938a37so2698952276.2
        for <linux-efi@vger.kernel.org>; Sun, 28 Jul 2024 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198653; x=1722803453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHGeCL3vH0qLBFDWm8avFROR6jr66E4NssJlgZilgo4=;
        b=HAVlKJ+SJ0zr2QU0Hj8jIIqFPWrKyHppDOHwHx0bYw71kSbxvOi3wzNGlfIldXotVY
         XJn4QUqdeqqVQZ7aV8FWy1AvyABNTrsSIon8fGaLifNKG3jpdFsqbicdAOgbEQRbftfn
         5UhiLxdmlMs5fBykUeB80RsiSKur/ydE6sFCwaDE7vuAjlFw/2fKwcAg8Vp//FZ9Cpuv
         n+dylMmRXCxKHoyVV3HstJvQXrE5x17xbL9C52iQu8ER9uTENgITIch54+NqnTng4GcX
         dD2gl07jrln7rJVH/QFxi5qAxXCsAkEAjUlNTffGJd4gyMepzFg68ddzIl6NeZDJB1WC
         KUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198653; x=1722803453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHGeCL3vH0qLBFDWm8avFROR6jr66E4NssJlgZilgo4=;
        b=fbIyFP6WPX1BrrHz9f6w6McS0vFpazhPMh81Nn+fjrK9xNsDuyWnCmMnZGBfJfUNUQ
         hMlBcEd9DruXgQMO90zu/FifG7jt17KsMmAbx2eqTC5UcQO2UtAKkPo4mNPKCGVfGrpV
         Jxlct9oK1HpD4JnRSj+LL79wfePsXBysA8C70tMSmE28SKmKxfgMC5030HBWJxM+1/EV
         MS1ayILODUHPZ+eCoco+GCC+4ews0fRf7AV0Fhnxmivy/wz6Rlf4n7kNQ1uEwOD+Zp2O
         4bqDsl48TNU4Mr4l5OU98i9CmHCrJ8rDWZNTcBTZU8VjfTKuVknhi+zJII0BJoO/77RL
         7FKA==
X-Forwarded-Encrypted: i=1; AJvYcCVZkq5wPwzEJoiyK8fP49vQ8GyhIUKVPFo3Bb5aYWEPe8c8TV6nHie19PbwsBE99tXkECmZ+tURhlpL7182iEnD9txR+YzyEyD9
X-Gm-Message-State: AOJu0Yxx+rS7Ks//2ZmR/alixuhgq8KweXXmkA7qVN++yw7WkUX5cVpI
	FJlkYmAqOjhumATiHz8DLhM/+fUpR0Uf3VSsauWHuEdMK5t3NEdHE9gTHpgvi/6ZFw==
X-Google-Smtp-Source: AGHT+IFbB1GtuSWiJ25Z5CJHBsZeUzd/7OcS+ZwDnzKKXYJCUjO8F45P4dz+nwWaMnszX5UCfblv1II=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:6902:1248:b0:e0b:10e9:88f8 with SMTP id
 3f1490d57ef6-e0b545590famr362781276.8.1722198652426; Sun, 28 Jul 2024
 13:30:52 -0700 (PDT)
Date: Sun, 28 Jul 2024 13:29:55 -0700
In-Reply-To: <20240728203001.2551083-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240728203001.2551083-3-xur@google.com>
Subject: [PATCH 2/6] objtool: Fix unreachable instruction warnings for weak funcitons
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	John Moon <john@jmoon.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Mike Rapoport <rppt@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Benjamin Segall <bsegall@google.com>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"

In the presence of both weak and strong function definitions, the
linker drops the weak symbol in favor of a strong symbol, but
leaves the code in place. Code in ignore_unreachable_insn() has
some heuristics to suppress the warning, but it does not work when
-ffunction-sections is enabled.

Suppose function foo has both strong and weak definitions.
Case 1: The strong definition has an annotated section name,
like .init.text. Only the weak definition will be placed into
.text.foo. But since the section has no symbols, there will be no
"hole" in the section.

Case 2: Both sections are without an annotated section name.
Both will be placed into .text.foo section, but there will be only one
symbol (the strong one). If the weak code is before the strong code,
there is no "hole" as it fails to find the right-most symbol before
the offset.

The fix is to use the first node to compute the hole if hole.sym
is empty. If there is no symbol in the section, the first node
will be NULL, in which case, -1 is returned to skip the whole
section.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
---
 tools/objtool/elf.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3d27983dc908..fa88bb254ccc 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -224,12 +224,15 @@ int find_symbol_hole_containing(const struct section *sec, unsigned long offset)
 	if (n)
 		return 0; /* not a hole */
 
-	/* didn't find a symbol for which @offset is after it */
-	if (!hole.sym)
-		return 0; /* not a hole */
+	/*
+	 * @offset >= sym->offset + sym->len, find symbol after it.
+	 * Use the first node in rb_tree when hole.sym is NULL.
+	 */
+	if (hole.sym)
+		n = rb_next(&hole.sym->node);
+	else
+		n = rb_first_cached(&sec->symbol_tree);
 
-	/* @offset >= sym->offset + sym->len, find symbol after it */
-	n = rb_next(&hole.sym->node);
 	if (!n)
 		return -1; /* until end of address space */
 
-- 
2.46.0.rc1.232.g9752f9e123-goog


