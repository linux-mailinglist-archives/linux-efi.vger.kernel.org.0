Return-Path: <linux-efi+bounces-1971-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC999F501
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 20:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E81F23E8B
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF91F6680;
	Tue, 15 Oct 2024 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLflK2gD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E041FC7CB
	for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016166; cv=none; b=eQDBjI8hYCGpwthJ8rAIdTLCGQm31xBgrJbZ9KoTx1JAZ6Xn0hXmBoFRMn2Szgxi9v7j4jR5BoO2lS8+fRCCx1sgK2pCBrPYhoac/fxJIbcupan+tavvlyiCSnfepOEF9NOgZ8ezmHj3vnDyyyLgJb76o60A9mrfOsiwbvXG4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016166; c=relaxed/simple;
	bh=b87ayRd+0jao6K4vPna/+mdAOtmUW7+XZCwmRq9oWHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HXLMYYFVJNp6VlDTlWGVVt7uDhpofGurMqGMfEFD/3vZ3jvA6PZFxeD0ou2FgIGmKl0aHUu+JF9d2bgaYB/hURgG/Gj/YPdvbE8j0jfgJAA63j7pVcZ+CgeqtImy+rnVp5zaCHjlKpUoKLs659ZfG7cfwm3nMVKm2Piah2DsfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLflK2gD; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37d531a19a9so2190047f8f.1
        for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016163; x=1729620963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKrdOQ75FBbO4ANdT3ghwOB3kXgMXiavZjOJcy1MRlY=;
        b=pLflK2gDgsKbsFdmGuoSuohLZZPdQA54Ih3EG1BRUXrr7WlE3NqUNhEeJBVmwREVVe
         wPzMTKn58X2nal66er7g3HbTzxYwsSKAvtWf+ynKjuV3JFxQT0S5KGIH0XcLzM98Lhj7
         NaOh955Ik+m9qaqLy72nruHm4cqB6a1KkUyHMcbrPcfMbsmU2g1E43bHCHebUi062mVC
         +0EmxvfFpNc2b1lyQAWO7cqnDhGYogPPNspQZsYFiaxQFRFYyXxGLnERt7lUMRqqmt8G
         MCnFerytUpRqYm6hUY27i7X2gn/3KYFPymrfPU/I0vi4plO1M/f7KO8LVWEKACVhQE3J
         kxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016163; x=1729620963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKrdOQ75FBbO4ANdT3ghwOB3kXgMXiavZjOJcy1MRlY=;
        b=TGuLiB+3KqQaC5VrTO/vXs224w5mmNfAnFa9I7KlLefTfjfkEjoP+ANWx7fOcVFeT5
         rDmVNS2Xxv/LTw7AWs5qfwdWNsnvnqoqfkpLcPp+67V5+MIuRsu6yBl/lYFTlWKWcVSG
         fvwcWQrb59cWbZOWQOzO2saEB976WDCpLpzjrhXzEXyrVCubd2ShwEgDN1FrqUY4fN70
         F2EQL8F9/YzuMtUpuRqMPsj5kilFSHmlhMJiblG7w0aHRx9npD/4N9/g6suZqRpHoRXq
         aZ2dkCiF6UtWkA7B9Pc/lBfOxmQ5xBai/9eNsVdwzgoI0jS17rI2CavOS3v+7dXp4F/F
         qlNA==
X-Gm-Message-State: AOJu0Yx0kcGyZWMe2wUNo8YMY2lCZiUCJJQKWlFtZg7ujeoOZEf1vasm
	yt4R6p0tKhddyytcjJxLskODUd6fDZN6BCZeQK5/1j79xdhIfRG8B7edkhx+eEsLPjRW5J87rb0
	b4dhHMpTWN2dvyP3OAShObxVRVpA7xJiaLjwhrfvxJuQdyVYF/OtUF8DLWiWafInIvFK81cuq1k
	ohsxF+6Bev69D/xpfiqrzs1vL2ag==
X-Google-Smtp-Source: AGHT+IGpNnE4p3YkPK1YBjXCrg3zGTzNO+hBUhMMCkB+ZIw+PmhcSBY1oNo6mo0U/IO5rcDIJ/hrtAt6
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5d:45ce:0:b0:374:cc7a:d8e0 with SMTP id
 ffacd0b85a97d-37d86d86799mr502f8f.7.1729016162780; Tue, 15 Oct 2024 11:16:02
 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:15:52 +0200
In-Reply-To: <20241015181549.3121999-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015181549.3121999-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042; i=ardb@kernel.org;
 h=from:subject; bh=Nza7TziAGAQU7OPBsBI793/ZBkfITFZBS2q5EcAgC4g=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1vY8T7syw8gjN0QgN0F+6RilqvZTtb/tjWPRuX1+6zD
 DVZ+PFERykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIQQbDX/Elz2rvyVRc+Rlx
 /d+VzjoF7fgJOn7cMyRn2S48sqJhZxIjw37bmN5JJyU9jN6W3mH/l99tezBnJ7fAjKamu8ndS2o 1OQE=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015181549.3121999-8-ardb+git@google.com>
Subject: [PATCH 2/4] efi/libstub: Parse builtin command line after bootloader
 provided one
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When CONFIG_CMDLINE_EXTEND is set, the core kernel command line handling
logic appends CONFIG_CMDLINE to the bootloader provided command line.
The EFI stub does the opposite, and parses the builtin one first.

The usual behavior of command line options is that the last one takes
precedence if it appears multiple times, unless there is a meaningful
way to combine them. In either case, parsing the builtin command line
first while the core kernel does it in the opposite order is likely to
produce inconsistent results in such cases.

Therefore, switch the order in the stub to match the core kernel.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index fc71dcab43e0..382b54f40603 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -126,28 +126,25 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 		return EFI_OUT_OF_RESOURCES;
 	}
 
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+		status = efi_parse_options(cmdline);
+		if (status != EFI_SUCCESS)
+			goto fail_free_cmdline;
+	}
+
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
 	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
 	    cmdline[0] == 0) {
 		status = efi_parse_options(CONFIG_CMDLINE);
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to parse options\n");
-			goto fail_free_cmdline;
-		}
-	}
-
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
-		status = efi_parse_options(cmdline);
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to parse options\n");
+		if (status != EFI_SUCCESS)
 			goto fail_free_cmdline;
-		}
 	}
 
 	*cmdline_ptr = cmdline;
 	return EFI_SUCCESS;
 
 fail_free_cmdline:
+	efi_err("Failed to parse options\n");
 	efi_bs_call(free_pool, cmdline);
 	return status;
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


