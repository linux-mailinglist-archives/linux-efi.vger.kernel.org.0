Return-Path: <linux-efi+bounces-1368-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F4092763E
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jul 2024 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AAAB21B36
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jul 2024 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0761026289;
	Thu,  4 Jul 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBlr5G1B"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E641ABC33
	for <linux-efi@vger.kernel.org>; Thu,  4 Jul 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097187; cv=none; b=HB1C1bQ1K74AS9F3EqJlyqzGnvnKBBbyq3qdIzGSe86T2I1v5PSrJgaWg1XbyR6MdZCPijfX5xEjFkZRLzp2HeDm6jHgHvI28EpVSqX/tRdCQFx8qmeDYymYymmVaYCMmPhl48hK7QQNOB7yqJhqcv9CAYipf2yHom1WB4i8O+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097187; c=relaxed/simple;
	bh=auu0d3/fL1iL/Q7mC7JwLFZ0Ab3Q9PoxsgV+c2FkV4A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uIGmbUn/YN3pr9+/pvh9xLsrcFoekahOOK41ecSp1TYq+cpB4Oa//lyNpaIPIFb11F7/hZbS+JfUvShFzjwvLNmeCqIazdayz2IhS3noEMukWS4xKdZcFo1/wXf22leTS1s4foBmFXI/hPXSdLoUApjH/Q7onrqaaypvsYSuSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBlr5G1B; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4256718144dso6110785e9.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Jul 2024 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720097185; x=1720701985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X3PzPgOQAWXsVCGBV/l/dD+372MMLzVOKKWoVsNAuxM=;
        b=LBlr5G1BHEVrMTTO8PjoPZwMIPfKMZ0mfOPyqvmQbGpecALhhibW64ba3O+difmp/J
         Xd3SrExEPPp55zL4RRIOK5ySsvHPxDJGBMkqFtM36XYvoD6/bd6vy+jgLbGXi6yRNkHO
         M9TP2lGj8Z0hYsrpsdRr2X4yN/RqJl+r0Jf3ZSIOx0ShY5pSdAXPYXdYDAhtVZoXVoWD
         e5b+f6yUeyn1TmexgJ0svtWqSx7JD59ziIezChcZNL8DQxozF4UOaNv8o+ibfxqzQZf1
         BQmMhanRLzeTOQySMqe4GAc1PoSSZC4pWoFjwE/M3BusLfXllsbWYTS3me/cKFA3CzVc
         okXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097185; x=1720701985;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3PzPgOQAWXsVCGBV/l/dD+372MMLzVOKKWoVsNAuxM=;
        b=rRD75Hg7Qw/l+lGkeb9qV9xBwU93sYEdVQsnHjf/AQLwoVUwMQJYlLB3dTk/mM+7DV
         3d7LLid7YQeFB9Cejq+48Uc36KG6PHV07Qm/7OwgOiz3eIMeQoHOzwhgeC7SY79tnqwY
         d/WW1+7uq3e8LJ7P39oYYav1GGDlrstcfBSZ3usQwx9aO/AeqKmcOjWeCpptEU4DrC0B
         20cofWMWsACr3ZfidwyQNpDj1sfID/r9/YAsOj0Z8l47CVQUpo2PWpTziUMuK2oKr1RC
         N8hNuwmXIZP3RHiixHum1HWaqoJeg5U+cD0FAgGkGYpMFNT9DzddMdP1+1FujkqGCD9r
         A6FA==
X-Gm-Message-State: AOJu0YxQb8RicubC6nQFOdxJ8g1qg0L9xdTJHrTdLgnEBxDriF7ccgOS
	6MFQOAz3Ph+8aL5RBxX8QyvT6nKkzWTVs1kOFBGQF9uscmCX7Kr6PQMU9bK6OPnGNdVIL6JOVJH
	2sy0OfXVZhb0LqojmBAEdk+wgiYjpWyBx02E5Me3M4ACJZ9tkM9De/1V+cTE0WGYrIMGy84CXnq
	6aVwLzko1J0cU6bU9QzBFZsS8Byg==
X-Google-Smtp-Source: AGHT+IFINreKUktWhBlOrgCHaphfERCXvxePBsBuBhEhd+V/HSoqoRk5pIa+/vuX/aHn4ywCZ0dJhZ5a
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d24:b0:425:8cbb:6eb with SMTP id
 5b1f17b1804b1-4264eab8615mr575e9.7.1720097184366; Thu, 04 Jul 2024 05:46:24
 -0700 (PDT)
Date: Thu,  4 Jul 2024 14:46:20 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=ardb@kernel.org;
 h=from:subject; bh=SeLgbYfl7PyH676mYz7TJcDFUcEjco1H488xhZCkCBY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1t5pz6bs7qDRWyK1bWGDPxaS258ptRS6HM7Sx/+5lzN
 1/o1f/vKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABP5Ysjwv2rOIa25z2pdrtzY
 3id7XexrCEdaGPNzZwMuQ3vFKa5/zzD8TxN65LY13IFrBc9GP4HajbN/bFvk7NQlvM6yYTVbgdt ELgA=
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704124619.373578-3-ardb+git@google.com>
Subject: [PATCH 1/2] x86/efistub: Avoid returning EFI_SUCCESS on error
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The fail label is only used in a situation where the previous EFI API
call succeeded, and so status will be set to EFI_SUCCESS. Fix this, by
dropping the goto entirely, and call efi_exit() with the correct error
code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 51b7185f8707..a4d0164ba35e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -566,16 +566,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	/* Convert unicode cmdline to ascii */
 	cmdline_ptr = efi_convert_cmdline(image, &options_size);
 	if (!cmdline_ptr)
-		goto fail;
+		efi_exit(handle, EFI_OUT_OF_RESOURCES);
 
 	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
 			  &boot_params.ext_cmd_line_ptr);
 
 	efi_stub_entry(handle, sys_table_arg, &boot_params);
 	/* not reached */
-
-fail:
-	efi_exit(handle, status);
 }
 
 static void add_e820ext(struct boot_params *params,
-- 
2.45.2.803.g4e1b14247a-goog


