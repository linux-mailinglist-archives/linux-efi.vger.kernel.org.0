Return-Path: <linux-efi+bounces-4209-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8ADAFE208
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1248D1C27096
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE47271456;
	Wed,  9 Jul 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQgyu3LC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A926B76B
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048673; cv=none; b=RNrTXAVPfxcGgBVbba7/rfisDbBzEx0a0LKlcb9qPNs1eg9ZFyrYQyEiSoZnr/L6l7g32yMaAhl1L6zv2RlFU6GgQKYgi0byI4Am0YPJyWQo6CzyoECUxrO5+3JIYNQ2uX1tFYUsX0vZ8dEU42vNrevOMDF/O2Wt8TNnvRwSY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048673; c=relaxed/simple;
	bh=qWa4KWyIEFQ8Dd6SQscBjxL/fkGwoddf/ZnfnynGWHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MPCSfMFcdotbSoYL2r0mQHgJz9F6rPr+MrgbJCmdtJI36rDmewpIj957v+dbzEI45o04NU7NhiEMc/fZdMhQgwYnAqHFaNHMBbNqbNsnAxgz08+R8/uSzniKviBnoxAchVEm1a57DMZrpqbyOK7bZnxLdxrd+3FT7uzqkNFYGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQgyu3LC; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so2247686f8f.2
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048670; x=1752653470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrVXr0txl0maG0fRT3Fq2/7vfV6O88A9LJ2P2lv7/Ic=;
        b=DQgyu3LCHuoNkmo6itt2PiNklNpKkwy0fV9tPYnKaj2KsyICpZAkSr2vSsZlMQOwJv
         i8Jq/59B5H0dIhcR30Wl+GbM8zeZ/wlvstX3pKhzSdjmNJ7O+Ef8ROBzm8sF1f3XmyCD
         AKiw8z/imuw87T6iZT4Fwg0dR2nEwosWbr07pQEquJuHhm/qbLyJ6PgULEAgGuxVL8ga
         3nrlIOert/Ctgef9ymeAiABSt8DPiBR347hHfTLQaKpYt+C0gI29UPqYKNREGZe4mRGl
         7VJRIzApIghFJfsdOI2lmabEjLL7ytwrKUGVtuIUkaGqeQ3YJmmEM9f2q8WyWN8CNKM/
         OEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048670; x=1752653470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrVXr0txl0maG0fRT3Fq2/7vfV6O88A9LJ2P2lv7/Ic=;
        b=iKvAqqOYsJLUg0kiEJ9b+ZHPFnfr2jPDbODqZ8sz739rVrThdNqsPf6iElx3izxWHt
         Vim6itWE2reM04rDRp0ZTQuhTiJvYikY9QLwusmlRmwwClqM0abyz64pkt4FkqsFF9Kk
         4UvWFhN19e75GfoJCXkaHbDLwHVXAdglryXurL1RDc44UN4aG6qklWrv3gV2QAnOOIi9
         /GQC7Up3bxBtvXhdy0zXxaeTPrh/cFWaCyY5J/dgZ5mL5rJXK+Y+ekSX5XFr8bvO4PZ3
         yv2C/SqXcWULNmBKvU3mvgbAmggDXtGQlsBSiFFXaJdoh50UW+xxWClJhFeBda4k5b6B
         ddXg==
X-Gm-Message-State: AOJu0YycacrHgDAwgPW0jLVisS6b1CIywPIXJ6uCi55Gq43CNgUElLsP
	rIhvetUnsIhOy2BC6tlVgy+kHRZhBKnTpGBY7LamRbjoO1wJoSyzaWnFTIXiSOgG2OcFC3hwbQ=
	=
X-Google-Smtp-Source: AGHT+IH8Vmqvxj4egjbDTGPQVIFa8wVBPKNO2w2bGXB5J/wC2urVwU0sKZ0Miv3o7Jkqbm3a+sCakUAy
X-Received: from wmpz13.prod.google.com ([2002:a05:600c:a0d:b0:43c:f8ae:4d6c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:3110:b0:3b4:990a:a0d6
 with SMTP id ffacd0b85a97d-3b5e45198b6mr923965f8f.19.1752048670249; Wed, 09
 Jul 2025 01:11:10 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:45 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2832; i=ardb@kernel.org;
 h=from:subject; bh=LUTnKMwKZ8JYr3trlfqDO6e1tedre1n2Ghy/++0ESaI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPeUG/y3u2hSwiu89dm15oqxO453fdvAk5X66qdKmsi
 jh4svN4RykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIfD4jw96LmvOTo/UCz/GY
 /JIx0ZZ1nTF/M5PbwavnZ1hd/1RxQ4SRYdp+kSZJic+6vr9UOifVFDL0eLpcm+f2hOmjXu8cps8 beAE=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-30-ardb+git@google.com>
Subject: [PATCH v4 04/24] x86/sev: Run RMPADJUST on SVSM calling area page to
 test VMPL
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Determining the VMPL at which the kernel runs involves performing a
RMPADJUST operation on an arbitrary page of memory, and observing whether
it succeeds.

The use of boot_ghcb_page in the core kernel in this case is completely
arbitrary, but results in the need to provide a PIC alias for it. So use
boot_svsm_ca_page instead, which already needs this alias for other
reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 2 +-
 arch/x86/boot/startup/sev-shared.c  | 5 +++--
 arch/x86/boot/startup/sev-startup.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index b71c1ab6a282..3628e9bddc6a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -327,7 +327,7 @@ static bool early_snp_init(struct boot_params *bp)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM and request its services.
 	 */
-	svsm_setup_ca(cc_info);
+	svsm_setup_ca(cc_info, rip_rel_ptr(&boot_ghcb_page));
 
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 1bb4b522dfaa..db89a55623f8 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -780,7 +780,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
 	struct snp_cpuid_table *cpuid_table;
@@ -803,7 +804,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * routine is running identity mapped when called, both by the decompressor
 	 * code and the early kernel code.
 	 */
-	if (!rmpadjust((unsigned long)rip_rel_ptr(&boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+	if (!rmpadjust((unsigned long)page, RMP_PG_SIZE_4K, 1))
 		return false;
 
 	/*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 08b8c24fb469..0994986be908 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -303,7 +303,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM to perform the SVSM services.
 	 */
-	if (!svsm_setup_ca(cc_info))
+	if (!svsm_setup_ca(cc_info, rip_rel_ptr(&boot_svsm_ca_page)))
 		return;
 
 	/*
-- 
2.50.0.727.gbf7dc18ff4-goog


