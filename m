Return-Path: <linux-efi+bounces-2152-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7DC9CDB8C
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B286D2832D4
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2F218F2FC;
	Fri, 15 Nov 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3J71PUY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431418F2DF
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662938; cv=none; b=EyySxOJE2v15ylgOiJJ/wGxUv7L6bZFybfa7Sv6pS48egfN017YheFsR4BYLfsgZsJqFjOTMpnYrShq09G5R+bEG/Stv2bgy3ID8LGuVHwpUFESzWpJ/PV8gMWlaGxyapY0tPtk6NVCwFe6rJBQRyItqu+ZSuoBHm3BsWEunAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662938; c=relaxed/simple;
	bh=iQh/kUEx5mLTNivlK5u38x0gMayvSDZuosv34V9o22A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DMOIbfEqUFTwS1kAM30lSKpMs+3D4lhgtl2jGmSBFeP8lqLx78+M+usIzh9WYlZnxfc5ovEmwKOgzIv+Je3omLEFT36wYkTtQkaJ0PsyFBpnXGT1A8Md0kFfeOWUhU+w0L4e2SW2PdSykaVDw/MUy0V6GDPdDWdjIR/NUOEmYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3J71PUY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e9d6636498so10224767b3.2
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 01:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731662936; x=1732267736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sekui0Rzn6acjcPm+2mnR/RCVbfrAoOiui+n+xR7G8=;
        b=R3J71PUYuXmb4JrZBAnjfle5CEyveeJ1PCV0i+MYB62ePtL3a1tu13qkDC2AYEM1wJ
         ulMdR7tRqS2cVJIDrHXvGJZdS6smfVYMH/q7EyZTBEc4OYGAkYB172gWsKdswfaZ3wSa
         fAw5Q2v3UEJMr79V+Rn7PjcYbxJPTaUdLSng+ja+CaukuLdlESOzsRCm6HYrEFkUTE0p
         sh1ANCgrVhgLIYUs68PGzxbQ0PnrVy4fGIDjlnN+/2NTLqdaocGlf2KFLCa2eNtosOlT
         HEU7a6H0BZcrWS64g+wvtR54bBhoh4TVmeiQ99vKlDq3/f0BB+kBWJEuiQc7MgLRzBr2
         9IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662936; x=1732267736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sekui0Rzn6acjcPm+2mnR/RCVbfrAoOiui+n+xR7G8=;
        b=mQKC8vDRbBjK7GA2//4b+2Xfpi2se1xO4CfPXokCGyCKW5jzu5y+Zt2pd4XW7xxlTi
         k6Z0gP95qFMdZYuJTVqtdRt2gWLgOC2dBwVplYK5NrV4Hq6txNw+t/7prWREz2lUCd9r
         pvaidpXO8g7WSPBrXON1A7yCog2hCtSyUbxrgjWIDw/KQPmlXnXgWSb4ik35oZGvcu5e
         nZnszuFZuWj2vcS2zPiEAMz0Zj1h7/YG6rY+geVwFHHWHydIlXoClXo3uYAYVdkJWLRN
         34Xk0WOZQ087JCcUhpBlK3JWnEs1tzb2MqYt7EE/h2+csaMkOG0iWt/vLSiF3wNNAXLZ
         nYOw==
X-Gm-Message-State: AOJu0Yz04wEqZkpK2utDca3p51D3SX53hSPwe1s02VReWvSKgOOoA48l
	7soOsbPRdAJRDnsuNZxNqGccvNWXeiHrgKMNBDwjXe0/3kcpt/P2F0CdxcBuby5b90tQHhUrJ9g
	dc0pS9uEPgIrl3754/p4MxZzpLhFVXFLUsYW3fdkayixXSj19TQ3yRZyL4FpE1J/SFEcPvj8iLe
	enH39EqOmW4ebTGdTgh0BdcYnAYQ==
X-Google-Smtp-Source: AGHT+IF1QR6EiyriCz7QfNcUAu7JlB3LRWeTdcwBx5hedakCcuzaCo13aunL9UYQldnFew+tpB3rm25X
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:6585:b0:6e2:371f:4aef with SMTP id
 00721157ae682-6ee55c95c78mr564817b3.3.1731662936179; Fri, 15 Nov 2024
 01:28:56 -0800 (PST)
Date: Fri, 15 Nov 2024 10:28:41 +0100
In-Reply-To: <20241115092838.3080857-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241115092838.3080857-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2448; i=ardb@kernel.org;
 h=from:subject; bh=HAIqdILGN1fACR5AG6BEqTRu8a6kaqqL140MqGyYquM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1cxMNJhc+De7rWljI5bz6XSJNzsx+F9WYzbpyeY2Izb
 UZUXXJHKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmIh8LCPD/VcT5EOWvmwKilj0
 MmOhieKXqKoH8qkpthNnFz+3iFh1n5FhT92NDNfYc+k7zlVtq13ud1Tb5kn34c2XTLu/Rrv773n EAAA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115092838.3080857-7-ardb+git@google.com>
Subject: [PATCH 3/4] efi/libstub: Fix command line fallback handling when
 loading files
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Jonathan Marek <jonathan@marek.ca>, Ard Biesheuvel <ardb@kernel.org>
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
2.47.0.338.g60cca15819-goog


