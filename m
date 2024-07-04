Return-Path: <linux-efi+bounces-1369-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E1392763F
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jul 2024 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2911B228B9
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jul 2024 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19541ACE96;
	Thu,  4 Jul 2024 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIHOU8u3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274261AB51B
	for <linux-efi@vger.kernel.org>; Thu,  4 Jul 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097189; cv=none; b=TeQ11hOpicMxfGZRZGFodp9/ujmBCvSf7ge6YNfrUcBTZZnNaWs4UluDxyjMHegt4Dr9JR53O7cOmK/9DQMcAsigy2APObRcbPgDt1fOizU/Vx9G3DPCw78Q/FFb2u3KssDt+8qGz3rXPZx8O5di99uw7PHfBtcLTqpPvoiNXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097189; c=relaxed/simple;
	bh=HU6IGe2+cbS5qwz6Ym2l9BvqhzrUzAKPLu9XEKmlQ+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aa+5QQB9IgOp4cgYEqoW9DMiXbl0h6gTEseEAWCWajkw+chEIR6xkOgnon7RG3VLSKtRPqV3K6868tAACaXxeiuthRPuaxZ5v1fZktBRw0tjATkkba2IBdogW4vSSMkS6Ej2fFciy7bAUJUsb7tBANo1ZBd5Eo1OIfb9xu6oYnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIHOU8u3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-651e54bb41bso11272537b3.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Jul 2024 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720097187; x=1720701987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kp9mB2z9fkkSnWzx2SaeHdTtcLUq5enQshYr4vg0rNY=;
        b=uIHOU8u3Jpqg3i0q6lrQ8XRpWH2n1oVSRF/pXgpAAo8ruLfw720UI4KdKMSo9wQIL5
         qcSbfQ3Pqs7jFisO8JGVHUBkj7JPWhVFSTZio1z5WGqD13t7wzqUoRqjn0wTZrV7lvEm
         EwkbfKfUlT9bNvz0DMPk6TCO+8aV7dOidXvFEIUic1HGHKfee6qqTDupxqssHj8pnkE3
         77rV6Q2Q3RwN5SopHeDsrRiThG6NJGzuSWT1DzoygjtD7Dmd745lo/J3rdBOhS2va0dO
         Wrmomg5nkxgEY+Km517rCJWLUzoUFmyzwMceLqgbIfbey1BzNU7hWOXDHS1eRFbMQVE2
         xVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097187; x=1720701987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kp9mB2z9fkkSnWzx2SaeHdTtcLUq5enQshYr4vg0rNY=;
        b=KWFT/AWnVpDXLz7MOd3a+8XSm/bySj4V7ZTvvFuXF99jaDiDwhq3mhd7QfrfkhvUDW
         qvnBC5UPM0eZ5jfExBUOqCd1ZLO5wdy1g+Xnrdohsxzd+xa7Lm4rz9ePdye4fULDeQi8
         md8Ff4sBEFoiiHyOB61iVMz9kyMfqbJkfloORnAr+tP0k/qOlBg5zoQ/P5u7MgIYAI3K
         J0UPblYlbmV6dzf0e0TWTqYRCcHFwbTC0POfr6tTosBe9CkieRx93hZICYhXhhAVYWzM
         zOeNJpfCU2x+ifP7SMm4cngN4Emw/fQ/x1kGU0YsNErIIUadkNPxvCq/zfLxT1uXOFrN
         aH+Q==
X-Gm-Message-State: AOJu0Yzx0YeBzKuMF9g3GTIw+7zZVAJzoF8IphsxzqkAyjnbclvKiuH1
	ILVe5yCd7SL+ZsMDvRyoy1a+JH5S4EY9KoVAPRcO0UTeMwcEUQX2NrqKy5ir5yJV7mUpBOKouqW
	1rtGAcfIiQwl4NwPjbJASepbS5zJIdsjvT2jxkYAGa0QSPxbsPLSyQeockxqq4WfmIOpSbrrVGE
	8xRo8W5hvwlY2tVRz3xMefEUWnsg==
X-Google-Smtp-Source: AGHT+IEFexQ1gfl9M3yUIoeAkncyveegIvy4gbGUtxLCPHxflGYlviUjFkAKOYuQbcZkOkppaZLCSCec
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:4d82:b0:630:e8a:8a15 with SMTP id
 00721157ae682-652d2809e31mr186297b3.0.1720097186894; Thu, 04 Jul 2024
 05:46:26 -0700 (PDT)
Date: Thu,  4 Jul 2024 14:46:21 +0200
In-Reply-To: <20240704124619.373578-3-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240704124619.373578-3-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=ardb@kernel.org;
 h=from:subject; bh=wbypBLS4acZUXPbYk30a96QrEw+Gpc5WvloZv82Jpew=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1t5pyoWOG8ALc1KzqvPeh8PFk2V0Hyw7Hnrk9uVG9QE
 jbv39XcUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYiaMvwP2RZQ5HozLae0wYb
 2bmeCEwpXzbfW0Jm65fS+JkhalYCOowMh+p+LJl7iP/KeZY4qQe7pE5siV/S/fRTYFDHxeuV2mF VvAA=
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704124619.373578-4-ardb+git@google.com>
Subject: [PATCH 2/2] x86/efistub: Drop redundant clearing of BSS
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

As it turns out, clearing the BSS was not the right fix for the issue
that was ultimately fixed by commit decd347c2a75 ("x86/efistub:
Reinstate soft limit for initrd loading"), and given that the Windows
EFI loader becomes very unhappy when entered with garbage in BSS, this
is one thing that x86 PC EFI implementations can be expected to get
right.

So drop it from the pure PE entrypoint. The handover protocol entrypoint
still needs this - it is used by the flaky distro bootloaders that
barely implement PE/COFF at all.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index a4d0164ba35e..1ed94b251c58 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -541,9 +541,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
-	if (efi_is_native())
-		memset(_bss, 0, _ebss - _bss);
-
 	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
-- 
2.45.2.803.g4e1b14247a-goog


