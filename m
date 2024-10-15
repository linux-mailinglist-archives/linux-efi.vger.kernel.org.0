Return-Path: <linux-efi+bounces-1972-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 953C299F502
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 20:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36094B23419
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58421FAF13;
	Tue, 15 Oct 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8n8Q1dR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367BB1C4A2C
	for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016167; cv=none; b=V4my9rtJUI4lECdOVfjfzL/wGAr3sVoSgard6bnAx/tQ5RluO8MzLavxLm75x7f7Ena8kq334rkmkHe/qxiIh/pZJieeUqATixuoEVbsLOIMJ3NlPg5yypGDIhVN7tZb70YW84c/HCW2cfbDEFk3V6RDT3J97yA42xAGtj+eURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016167; c=relaxed/simple;
	bh=78He2FK+/2krU9RFdYW3YR5nfig5DrBmhR4zYII6dMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VGLURr4FYn0R/5KCzz5Qm4cgozlgoqT8/UvG9C6uqajcLHJATGMhJfPWjWASZgPchHePM4q8sekrjtQS3wMuuQIw+Jw30ojcXguwu1wGYpBHUKx1LYtG4KtfKeLlwF7B29YpHSk9C5Cn9HdqXed0lrrBKDCY2D2TpqJq5Ijl8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8n8Q1dR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e370d76c15so47308307b3.2
        for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016165; x=1729620965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ktKghyxHm11wEF2/2/gDtu+FZZ4Hn4i/DuFW9LgNftI=;
        b=m8n8Q1dRmKqVh0ZPpS9JSCzp0TiTqCc0a8NKt3rp4V3NmeG+9402lQUeJVlXtwlJJI
         MAWTmA64OIQIRwUzIcQwoiSEpRElX7hZQyNItE384Qw5id13Sn2s89uDQnr8ITeAoDfi
         vAB/URkMd776s+o49ywZ5kbJ/TacgCQOnbweMvfPhrW6JZVmizaiLNxA6r15zGRak3PH
         q+ug8GTQ3L+Oy2TGa67ei+uha/p5LTFn8ZGk1D+3ADe6S3hmXvzZl8R3MRjfc7HHDaTj
         c8P5KU/DMJyTPDTHKNrKj4pAIXAM7P3y+ZOshNUZIOUYT9LRb8bxAEFx8Ah7jos5VFxn
         4Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016165; x=1729620965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktKghyxHm11wEF2/2/gDtu+FZZ4Hn4i/DuFW9LgNftI=;
        b=i/5f/YY0M6rMDY9DS2lOrvf1J7K319ZeULvJU8x8nAHtgqg2EtZM5I+X9Oa5i864DG
         JZ9qmOawPvXKcBcLVyRAhwtAhvT787aotNdw5Nuj00fd2nYFRgyUHLbTNnEhdheBkRrL
         Q3j+s7skzitDfHp6dQ3UbritSuuS0WmQp7fN/r0/TV7H+alW5RU/vS0yXReQza74VJe3
         WxURAmmCJxhWA5rUX2pl9vijDy04H7Srh3dCc/F4+6hhyi7L1yvzMaAZIrZbeR8Z8fbd
         HlauQnp8EcqLmQky/BcB6x58X/Bgsh3ul4W3K53C1rlx4OrPw4FD+ZMlcRmXcpb7bPBA
         x6cw==
X-Gm-Message-State: AOJu0Yxya4E5YGSMo7fZv2mlzylsyDeKmShJcNkYGE8bXmdqo4iULLj2
	22ZPzKu/cD0L4xiT31UBXADGLABl/e/GSPmPZ9QPLhS0007swx1EGbLcpwc1Gw3w22X4GemVigo
	XhAa+vZAcOlv4yDICAgJXb5wCnnNAYlZTIqzVOyK8emzvsSGzUeHjLSTU1nNpbBUxxGKARZTayc
	OrjkhbyMOTO60GfMBlaIqzPwQBGQ==
X-Google-Smtp-Source: AGHT+IGdVSOGE1JltzrPFL8pPOOuBkA3cOIa+YxwI0yJGCj1McaAR2LG6j9iMww2m1Vt4Hq6wr/77jqx
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:6204:b0:6dd:bf69:7e23 with SMTP id
 00721157ae682-6e3d41dfebbmr244597b3.7.1729016165114; Tue, 15 Oct 2024
 11:16:05 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:15:53 +0200
In-Reply-To: <20241015181549.3121999-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015181549.3121999-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452; i=ardb@kernel.org;
 h=from:subject; bh=V30wFoEPnYJ8Z+bzf3VNggC2Gnf/7+Jxb1Wv4jziTGY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1vY8R/P1E2We3i8jtsn4/rbpkprLn1ef0TjiNn3Xe7B
 +7fUHOxo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkiD0jw7JcN4esg7vXM78s
 1YlpPWIwP07mqdNlw3mTY69YcvJMXM/IcC4hc+Y0iz3GqnzplR8bb60tDj6bxLLu46QKvZV6pXz CDAA=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015181549.3121999-9-ardb+git@google.com>
Subject: [PATCH 3/4] efi/libstub: Fix command line fallback handling when
 loading files
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

CONFIG_CMDLINE, when set, is supposed to serve either as a fallback when
no command line is provided by the bootloader, or to be taken into account
unconditionally, depending on the configured options.

The initrd and dtb loader ignores CONFIG_CMDLINE in either case, and
only takes the EFI firmware provided load options into account. This
means that configuring the kernel with initrd= or dtb= on the built-in
command line does not produce the expected result.

Fix this by doing a separate pass over the built-in command line when
dealing with initrd= or dtb= options.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/file.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index d6a025df07dc..17bf25dccc07 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -189,6 +189,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  unsigned long *load_addr,
 				  unsigned long *load_size)
 {
+	const bool ignore_load_options = false;
 	const efi_char16_t *cmdline = efi_table_attr(image, load_options);
 	u32 cmdline_len = efi_table_attr(image, load_options_size);
 	unsigned long efi_chunk_size = ULONG_MAX;
@@ -197,6 +198,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	unsigned long alloc_addr;
 	unsigned long alloc_size;
 	efi_status_t status;
+	bool twopass;
 	int offset;
 
 	if (!load_addr || !load_size)
@@ -209,6 +211,21 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 		efi_chunk_size = EFI_READ_CHUNK_SIZE;
 
 	alloc_addr = alloc_size = 0;
+
+	if (!ignore_load_options && cmdline_len > 0) {
+		twopass = IS_ENABLED(CONFIG_CMDLINE_BOOL) ||
+			  IS_ENABLED(CONFIG_CMDLINE_EXTEND);
+	} else {
+do_builtin:
+#ifdef CONFIG_CMDLINE
+		static const efi_char16_t builtin_cmdline[] = L"" CONFIG_CMDLINE;
+
+		cmdline	    = builtin_cmdline;
+		cmdline_len = ARRAY_SIZE(builtin_cmdline) - 1;
+#endif
+		twopass     = false;
+	}
+
 	do {
 		struct finfo fi;
 		unsigned long size;
@@ -290,6 +307,9 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 		efi_call_proto(volume, close);
 	} while (offset > 0);
 
+	if (twopass)
+		goto do_builtin;
+
 	*load_addr = alloc_addr;
 	*load_size = alloc_size;
 
-- 
2.47.0.rc1.288.g06298d1525-goog


