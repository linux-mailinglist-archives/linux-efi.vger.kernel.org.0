Return-Path: <linux-efi+bounces-1813-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE1986329
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 17:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7503B2304A
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73541922D9;
	Wed, 25 Sep 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QheHwjD5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42021922D8
	for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276557; cv=none; b=DGj6he+9PvQQf8Fw3ZYX7Lo75UaCrY6LgWBKRofklXlVNt22jg4HFX4DQUrg4tE8c4KjB34ZHd2/kwVbzwFvZIJCidx+XYYmHShWRz/dRooCHqEqtyoab4ZmgpJFI2rtjXGC2ZkH7oGh9w4AzzZwG6kXPaec6BuST3gKr8XUZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276557; c=relaxed/simple;
	bh=CMurddgdDXZCJtwTh7sicisjqXrlKeRuIZ1TFq/8oX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nf/DjyxgkouOy2beuJA6g3MbzDfUp5mRw1XhsevSnc48eaxqlxoMo2EEWpiCaL5bep/8bRxYafpG2O/NIjWrwkaZlAtqc+YAIe2TsZmIJZcsliA0eSNnIdc0RpqmZH4BKqzhntR/fgHvdgbJxo0Dca6OUaw+vmZ3nrMs2hIb9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QheHwjD5; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-37a4d65df57so1279649f8f.1
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276553; x=1727881353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ1cTLWN/qm1UuyAwDsDiC37ecAWh5CqzUoGN/3jT3Q=;
        b=QheHwjD5gcp3pQg1btz606WQxjCEVHcr1ocQck8aZdG3CSc99pWkXkDgo0M34zSU0I
         dtwwyONfaMKeysdhicSDnH3SgJC/XbwybTtvx43xSJPonNlHzlXLd01XPNTmd8BGYbJG
         1kE6Nv5tPc/5Z0Y+DESalkSnexq3RW330glSb5cKl38X9bGlfHo7gzPgOoyTLbmLCj4/
         zFo4liVFFN1L0oEl2QIwtVmZNdsZn5WijD/a20yAXU8VO4mg9O8c3GMQc6OVRtfiYf3v
         niyirVOUBznJP8RSQBAHP8REttly+HIqe6ErgmXiFM4hq27L91W2t8t6hxUkCVEAs23F
         JjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276553; x=1727881353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ1cTLWN/qm1UuyAwDsDiC37ecAWh5CqzUoGN/3jT3Q=;
        b=A/dYYu0X/jRBbwBdbtCQB1u6Mn6pEY+hFOIvCO3MhSLePhAaFacg3wHCC6TjhvSxPq
         iNhp/jRoVusk5b8TjZ33bWVUZiyLDoknLyiBhX9Qin3+1r073sMKGBLP674rQOL2orfq
         uJRmIghnj6d91nx6+9VuwjZINzi2qBUytQKBldLjCOP/I0pu5XmlZjXXS01epxzGOYa7
         cDRAotra/2dcUapuAbeJjoUsylX0cgLVW4JLXTq6EtklUYlTSn81z1VmncgMuuL5fj/r
         pIRMsLRPNUVoADgrGvxplabBbrDbQaeWyFodKUDV0Ig1fMdcWimml3YzcOyvyQsC+wh/
         NRRA==
X-Forwarded-Encrypted: i=1; AJvYcCXI/e4gqU1vJHbFQY5o/6OKAuJ/EtOBTpJpClyycCddmhZ8UXS25GCbvgQiNijVF0niEwCVg+e94Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+v4jadNqbljtwSLUkiST7Ga6UhUq1vRQtJMZlyE4zm+/q43Cr
	pXlDMqXToDcFrjVMun1em89XUQaTKUp0ndytlEs5BFZ913RlcVitLz2MPhOFilBiNn9prg==
X-Google-Smtp-Source: AGHT+IEbuxsanqyADq8Deat2AYN/hrx0yHWhBh+K99NJ5NNzbtyXWGf28ibYOumK1/7kTAhssaq/BKmU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:6000:1948:b0:371:8d08:6302 with SMTP id
 ffacd0b85a97d-37cc2466282mr1755f8f.2.1727276552813; Wed, 25 Sep 2024 08:02:32
 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:17 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=ardb@kernel.org;
 h=from:subject; bh=Gk3vl5lcNVlUG5WaXx6+kW7e4vi5Wc78FqbNjCEkOO8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6pHFHOXq05/1nFnPcudQmJ7wpr7dLDufJIa/O8C5x
 Txd0oW5o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExENobhf+k7pXk1KeYh8xfa
 vazOipusdTSTNTQtS+jqxsxgKQvlywz/y0srlXSWbHHluXU+4voFET+GHMONjSy3U2vjQqX5RWI YAQ==
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-47-ardb+git@google.com>
Subject: [RFC PATCH 17/28] x86/hibernate: Prefer RIP-relative accesses
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Replace some absolute symbol references with RIP-relative ones, so we
don't need to fix them up at boot.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 0a0539e1cc81..1d96a119d29d 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -39,7 +39,7 @@ SYM_FUNC_START(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
@@ -70,7 +70,7 @@ SYM_FUNC_START(restore_registers)
 SYM_FUNC_END(restore_registers)
 
 SYM_FUNC_START(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
-- 
2.46.0.792.g87dc391469-goog


