Return-Path: <linux-efi+bounces-1970-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BAF99F4FF
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 20:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73641C23181
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4072E1F8F17;
	Tue, 15 Oct 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ueAvDDbw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52811FAEF3
	for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016163; cv=none; b=XFxdnG3t/4dmgJ7Jzo9zfGl0IjU9kYeAT52y2mN8lVwCyB1xyp5vfQUwHKOVCPN+CmqDgulzvgMJTxJk+RqbCIfqY5c8Y8rNuwWR2PbztWUipGzZF0Ih+mQQi9ZSdEJicROMWikF6gAN4SL3ujsv6+JqQ/d+ukzJVYb8ahdQOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016163; c=relaxed/simple;
	bh=1T6yD1P7ph0N1EELkpHc9HmNiM6TWkRhIMzSNPpxag8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pKXz4bagYvnf6/jWs6v3dpOfGB5usDWUNmssIVGnc8mX9ADHNvmia9P7Ta9juh/94iIVd2P0lf2w7ho0texiJ4ODAmDVyBAiU5GOjXnpD/A2/oak6wJAGDhpFa2T86Mj3h5whK/EwKvGLSFZoY3WZ4TV7cBck251p/UL9aoE8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ueAvDDbw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38fabff35so38585397b3.0
        for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016161; x=1729620961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vb0F1D/URMqrEFjwIj8UXRbubquki/NP7m91+7wn/AA=;
        b=ueAvDDbw79bIL3Hf6xn9SqB96rGdC3WNIVGeUzdilFOsxnqeo+JG0bqL4xbDakBDRS
         snwZ3zijZaDY7CqJstutRKvvNdNNPd1YAuzFmhbUjSzeWKsqkgMW8stm62X79lv9FVsc
         iLoxIwDEyBYZt45vGPNd7lyE4PSt9g9pHdmFuK95WawFFj3kFEIkunf5Kq5hLptDHZ74
         oaWeltIw94nHEFFCqV0UzYj6LpQ5Ze9XSNeHwEDuK8waLKvdnS+Pjo7k3zPzIL6bhi2U
         PFRFT31+7A5+xWmWVTEQ29ZKIGlkEm6u56ZDYjgMynBLuttCjJYYjK1qPxbnBFNJortp
         q0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016161; x=1729620961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vb0F1D/URMqrEFjwIj8UXRbubquki/NP7m91+7wn/AA=;
        b=NNJX7o6JstSEO1IE0DXr2wVKb0kRQ4GsczldFAkyz4Kv7oxhKYjudMxJ87r2KxqRP0
         AhcYbkYzOXEgHR+0pE7KXo8P96ZuKDpz+/vWDOPaAM0s0skvedqGmaH1/N9Nrou5AAnA
         g8EG9ilT7dporD3lHXREcimnYGKmt3dhT4+eHTxBIglZ/qdI2tZp9MfxAfmWMyGuPn/f
         MByOiP24W6vTExJD4/XwahXvXZm68HkeShqdXV2uEBF/gN+UKZpnc8FoozQG0G6i8Q5p
         biYD5W3vQ/GQKYqrMbouB5EW7xTdyTV/BmlbYRcU3nPUdMRzGlBwLcPsOvwW8KOOkOur
         +jbA==
X-Gm-Message-State: AOJu0YxT9HY8gTVg3j8EqedZTM9uG1RRMZ3fGZvyboM0+7RTeUaCDsOb
	B+d/TU/XP8P4WLPyXdyIsvJqNKVBqFLZFtYu2tXZvYSEdVx0EgnD9debHYWYBTnoGwYePyEwHTv
	ruiSX+wybKrDAJlanMndK+aiCW+dLwM3Jv4OznBzm0jYfXPFMHoIOTsupPHIVKStkgVjQ6E2t1/
	xnCLoVpQkrYxqzV1PZx1zyPAchZQ==
X-Google-Smtp-Source: AGHT+IF0ZFpt5BuaaKZZKmArgpOmwAK2y4TVZ0ZMvSmzW3l/nsz2mOo0qLLkWGNat2clvzQKDi0jqUQU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:7406:b0:6e3:8562:ffa with SMTP id
 00721157ae682-6e3d41bede4mr387857b3.5.1729016160512; Tue, 15 Oct 2024
 11:16:00 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:15:51 +0200
In-Reply-To: <20241015181549.3121999-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015181549.3121999-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=ardb@kernel.org;
 h=from:subject; bh=DUEag0n79tEu8RYPtJV8R8SWhGsqbJq47gyRYXEDML4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1vY/iTL6tc/x0yfv/90ClBTt75/3geTTy8iWGhjNmd5
 ZtCJ6g6d5SyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJzFvD8D970vqGxVwcRr1b
 50Zsd57Su/LzvgvJ3xQYDKVrOH2UGp4x/K/OL1PLdl/kekB0cnbZhubNv3f9aWQ3cJlzhPOThvw Tdw4A
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015181549.3121999-7-ardb+git@google.com>
Subject: [PATCH 1/4] efi/libstub: Free correct pointer on failure
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Marek <jonathan@marek.ca>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

cmdline_ptr is an out parameter, which is not allocated by the function
itself, and likely points into the caller's stack.

cmdline refers to the pool allocation that should be freed when cleaning
up after a failure, so pass this instead to free_pool().

Fixes: 42c8ea3dca09 ("efi: libstub: Factor out EFI stub entrypoint ...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index f09e277ba210..fc71dcab43e0 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -148,7 +148,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 	return EFI_SUCCESS;
 
 fail_free_cmdline:
-	efi_bs_call(free_pool, cmdline_ptr);
+	efi_bs_call(free_pool, cmdline);
 	return status;
 }
 
-- 
2.47.0.rc1.288.g06298d1525-goog


