Return-Path: <linux-efi+bounces-3675-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F4CAB44BB
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD987B07BE
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629AD29AB1F;
	Mon, 12 May 2025 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0iOxz77K"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2B929AB10
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077136; cv=none; b=IGQrDmE9oETXDst5P7jrWzXcUWY92adbGtt6wA5qbPU0S3mdwDnZXsTHAjC1omLZsnAef+zv69GM+ExIIvUMMGb3vcTtalYHR9xrl+6l+rnUtT8xP7SiQLwzov5Gkb8D8kCWWFDPRaz99YsgnSMcofNBR38pBKE+alkSIzBiL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077136; c=relaxed/simple;
	bh=TorHU3D8vzlbLnDF5GG3Z8lBw/d5rL8k173kxpHudfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BSp2zsLHy2yS1WTRmSf5PmKCuBDsj2zrrCxXPW/EobYIo6VQ1GwQaTMkfPJwippHqOg0W6pNdujrGkEozDpee/Cx2pKNyamx7eIG6DDnCdR6Vbeh7HoOPGMPZ2i1L2JGC0u5eKOvtX7LEncQBq3NZ5ufEhXQynxgxQoY8rmU5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0iOxz77K; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43f405810b4so23986495e9.1
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077133; x=1747681933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v439pYe/axTRwHMKr6MQIEHe6JUV+bVOJ6eq2XJ3atI=;
        b=0iOxz77KFxU69GuMWPUbCWgW9VNpO0QySmGBiRoIjTyviRHp6M2K0MgvQ35zf15weo
         1zeX82bJdbPduQ+rjfhWQ5Nnj0SsKJ7YiYN2QJhsU4ipU5dSYTj3Ae6nUBgdxLmNOF/6
         5owS9NRWLOL5L0h3rfifqjogsbRPC9JNyx80So+ww//gwnN5zCT8CFO+PZACAu8oEW0n
         SsIaceHb0dah9IvU7jrdl2jdTffCI7fj1SMvSB36y8WFnupn9clK/t+KUTaqHUjYiNKw
         0IENPyLCL7AiGG31K5WuNpZ9GGSz/v8iaPrxaTrXWwdmoud1eoBzhW0WVi1rts2t6ZAk
         Y7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077133; x=1747681933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v439pYe/axTRwHMKr6MQIEHe6JUV+bVOJ6eq2XJ3atI=;
        b=YLyYYnUOOas9T/hYfHsEw0Eq8CQNEW41cQkjBcqJx9GF+0iSr0S0ZIOn+7LaeDqN4q
         6m+ODfBCGD2hJIgZym+f/tNK+0OA+nCCbCyuKSuhAYMlpMW2Ad5/R531nIb3Lr8S+bxg
         ukFhhSjmAsv0kUZ0b+Iq7aplczkai/DpPPzXPX4qnITxCsTzCVMXpCszUtAXuSc+RfBW
         GBTTIMOc0HBh+TsJWNJ015zlBIW8H2CnUfgLCROaenv+1PriPuGLG/IGVqPTRcE+6ppc
         i6O2A14ew+G0xhLueEnFKcW20hmSz3v9dsI5cgfkqPF+ULUTPismja8PkCJD/DMGH8d0
         CnxQ==
X-Gm-Message-State: AOJu0YwtFhfSqirF0D7TkXIpq8OszBXko/ofJH0aZq3nNWHD4FEoL2Ha
	Y2NWT8bPl9vVIHYVbK1717PiCNWn6MGGkfmSU87BycojcHbFSxOaP+8v8A6fpeYcV2Y8xQ==
X-Google-Smtp-Source: AGHT+IEMZYndVwREXzsaDO3LVik4Mk0won2pEwZv3DWg+/+jysG1MAjNpnGgjDfRCAkMKKBZbMh+CUx9
X-Received: from wmbem11.prod.google.com ([2002:a05:600c:820b:b0:43b:c450:ea70])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e45:b0:43b:cd0d:9466
 with SMTP id 5b1f17b1804b1-442d6d44b3cmr122027975e9.9.1747077133093; Mon, 12
 May 2025 12:12:13 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:55 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439; i=ardb@kernel.org;
 h=from:subject; bh=XkUgHViP3uJKbwSMBnGo+c2h3KHUCLzDm2JV//00rhk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJPdKy5iq787yskwwr2n5uPOiQNaejP9rN/vnp52+nc
 P1bFqXQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSZcPwP7+25rde1Srnw/Nq
 zMt1XAt/JhU/jTE8WWJ39JCikt1FL4b/rhz7vT59+u82febDNTt/9ptGZ4r9N9bUeVTpOWfep6N 2/AA=
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-43-ardb+git@google.com>
Subject: [RFT PATCH v3 20/21] x86/boot: Revert "Reject absolute references in .head.text"
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This reverts commit faf0ed487415f76fe4acf7980ce360901f5e1698.

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
2.49.0.1045.g170613ef41-goog


