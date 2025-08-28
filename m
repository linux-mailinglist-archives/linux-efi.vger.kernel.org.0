Return-Path: <linux-efi+bounces-4642-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C17B399B7
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4A77C2066
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116030F80B;
	Thu, 28 Aug 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkgDtfYk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6B30F547
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376578; cv=none; b=HrC0JPr2at1SSKIkZFUZvHEbHFsMwB/MHNBF9yYygziFkOUR5boowPZcJLZzO/F3D+4SaSjqGcUPTApKpGfJ+aN/Pdz6y+W/e3a5hS/DQCiZ6ekyuYbtPEY+N1x6h1et9j3iAz0xT9e43ALaCVJvB7Dxz4x/kv5v9t3nPAolCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376578; c=relaxed/simple;
	bh=zIl8q9uQpI2X7EKwuJC5u9QPpt9qfEp5AIbRjG9/qOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVRuEDN8UjTJ2PN1gQxrRccya37oAfA/gwOzO4Enfr9oo1Sp65Kj7TFkSntE8VKm4R6KASRqm0Y3L3sxjuSL2ayYeUA7chFVulXrIoSZw6IUyu+xdlLZ40aip5LoS8z6kXLzHkOHDuDfLAffrWNbhKq5AB+a78oRdchNdZ3xcj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkgDtfYk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05b15eso4555775e9.1
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376574; x=1756981374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1G/yn9yOCSAcxp41rzAZ4aYvHvF8XH+4CBnHBHHA7Q8=;
        b=JkgDtfYkr6TJ8sOAOW13wk8P/46H2zqEMNJh/G0J1ZZectKYqhPomDZtJudOLCNv9v
         QSpDK9n+U8z0xrHFp9YvKFRgOh5vGHXtZVU7SAXCbq94k8J3iAyBDaRSzrOVIoNhP0Nq
         SC6BexXIbIh9nyqNA2RQCMkoj11BRLsaQ9Yv0ZuiUCyESpWlcJzAlh73XVmijN/3fzJM
         Pvv9vjEAkvdNUlNKrCGjYFSXwZKnVZwAD0QLndZlrJzCkxlLNK1PkoGLBoW9QubhHbul
         C2VN4JvCmhb33jTrCFbPk3AeoIaXBlz1jiG4ErC+QgfsR+E0CSKI2c8KeJrEMFYjLXpJ
         l4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376574; x=1756981374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G/yn9yOCSAcxp41rzAZ4aYvHvF8XH+4CBnHBHHA7Q8=;
        b=WTbDU++sI2+3uzl8sAcDKEh+nwmFfCtz+g6T98FB2CdE07Sqybpo94a3J08eSnwj+2
         5QCgfN9FxZq11oslL5WMWCjDVYldEil2IZ9lmM1fw/2JsU25kl/LhYVOgBwFV3fBcrIS
         ATeK9+t6QBaf9kJpgLRgnLSLbBwhKMsHJOMV89NA06TNrhJR3g/8Iq4y+Rm+52hU45WF
         WLTjt/vMzd7ohdlTmNgBtsYcuWJhVwoghKyBamAc3DUWfZ0hzHDRqj/QaERNqUcTc1SO
         rRmDbHwl3B4ivldO/MM6DMjjNTy7Gg5K5HgBCPK47DXkofCx+UuFFSnG52X1CaTE81Pv
         VTpg==
X-Gm-Message-State: AOJu0Yw8IdmhfY8IEUPjJtTauS8EBrhnpdb7ZGvhdp4qLgy/5BKI7vvS
	J5wp3aDK3GNwtOMppVlTAqi/IEJ11lsWL3vDI2M3B+pm6up61m4h6ejEa0NKvMinU7gbVUOQIg=
	=
X-Google-Smtp-Source: AGHT+IHp24pY4Owf8k/qm9JSaITBLoOezuxyBhsRCmmgmMuE5DWI4hEK3LC7LbHDVPgoEtvUXrOC5BTE
X-Received: from wmbay41.prod.google.com ([2002:a05:600c:1e29:b0:459:dfcf:15e4])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d81:0:b0:3b8:893f:a185
 with SMTP id ffacd0b85a97d-3c5dce05cc8mr17269335f8f.53.1756376574534; Thu, 28
 Aug 2025 03:22:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:20 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=ardb@kernel.org;
 h=from:subject; bh=0iFUpR99/rJ4BsTpi1I0iwnKOpixfxzyxPQTBrstses=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7n07m10S50W+H65Xyc623rP9cNDm4Lf7X/b2Tdy2e
 oIxp/zzjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRiJeMDBs7fm/TqFJT6Cmu
 vGJx18dvzU29+Q6TH87RXXxu55O5Bk8YGW7bT1xSpfRq7ofcq6HHYgs+CC7ZsrSNo0SPU7eN+Wu DOBcA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-41-ardb+git@google.com>
Subject: [PATCH v7 17/22] x86/boot: Revert "Reject absolute references in .head.text"
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This reverts commit

  faf0ed487415 ("x86/boot: Reject absolute references in .head.text")

The startup code is checked directly for the absence of absolute symbol
references, so checking the .head.text section in the relocs tool is no
longer needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/tools/relocs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 5778bc498415..e5a2b9a912d1 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -740,10 +740,10 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
-	int headtext = !strcmp(sec_name(sec->shdr.sh_info), ".head.text");
 	unsigned r_type = ELF64_R_TYPE(rel->r_info);
 	ElfW(Addr) offset = rel->r_offset;
 	int shn_abs = (sym->st_shndx == SHN_ABS) && !is_reloc(S_REL, symname);
+
 	if (sym->st_shndx == SHN_UNDEF)
 		return 0;
 
@@ -783,12 +783,6 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			break;
 		}
 
-		if (headtext) {
-			die("Absolute reference to symbol '%s' not permitted in .head.text\n",
-			    symname);
-			break;
-		}
-
 		/*
 		 * Relocation offsets for 64 bit kernels are output
 		 * as 32 bits and sign extended back to 64 bits when
-- 
2.51.0.268.g9569e192d0-goog


