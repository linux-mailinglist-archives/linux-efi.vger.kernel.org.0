Return-Path: <linux-efi+bounces-1124-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D578FB82F
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 17:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E5F1C23A6E
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083554903;
	Tue,  4 Jun 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulayhAhK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508623236
	for <linux-efi@vger.kernel.org>; Tue,  4 Jun 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516602; cv=none; b=OVCcuDLFC+V4CZjkz3FE6Xk7UNv7Emf4YVKCsRaaAbScBTEMd9/EUkI4E2P6NQ7QkXTeCgEfIp/E0//R6pSak+Y5v25XcYMagB2D+++7g++4YLDlGbAJElxQSugWdjbwXOjCPlSDLEoCu+hMHO2HZ7OOpPj3jw4/EZxjlxYAhN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516602; c=relaxed/simple;
	bh=tDbPAXcapOZ9dMwjsFGkyWmyz3tDIsEsvy1DQ5y4Cqc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pOO/8L12Tsmq3yapbkibJf+POjssz8uEfcUD3oTGfkkRvSpKBinsCXP8ybGw2LMb651pg8PlRB1sPrvpyGUYgPwWp3NSiJ2pn2Mh3Lyw8wxzIZuyGiWqvUTklSXKXJMGHb8LO6hXNUzxGSKk3z1fwMVm3jKloEC9eq7n7P7qOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulayhAhK; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-421179fd82bso34349075e9.1
        for <linux-efi@vger.kernel.org>; Tue, 04 Jun 2024 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717516599; x=1718121399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z81hPxCGmKqYcb2AOCHcD39YzTsc81AMZa+e9UjPdA4=;
        b=ulayhAhKqFFiXqnwLx+mELBM4OElPd0x0ivlLFoph67BIK4PwyEZJaEFK4e8sfIPPe
         EJLsZUI8tCcc16lKF08xLuIAozB8NGrd2YGJXuF7n2rHc04bcKVYibUMaWNVptwefG0E
         v0/j0sn/6Kv7kUpJgxw6ROkU/SKcbP0MPcIt8dANnsVeVYZwt4BTUa4pcSgmy1LbFgf2
         L4UaaNI/+4k9DhdgbV8TWCBihsIXQ19lIx4PpNJ04/jiLEj7dPEdiVnw7KEgUgE8N05w
         L62b278w2lSt8lihPonocnC5278JNLh4pfzabHqMMyGw/ZsndPwD9O6FXH6tHGkriDxc
         +nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516599; x=1718121399;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z81hPxCGmKqYcb2AOCHcD39YzTsc81AMZa+e9UjPdA4=;
        b=U8MbxN9Fl5xLJeg86gfbZ/jZsLv9h6cePcgRRnEp3uf2dj7t2biMSGoKt/FbjgBA5J
         dUvVDDdNPpNl+kFg+Xb59CAewJWuZZeDczLbKx8vSoVqmOS7xrXLkob9RTtdo5SIDztH
         zytd//PAsjRmHp6/aHfOkqKLf+MP/+NS1xA1OdgqFwe3FU1mwfxcukGFWchi2bANdnfN
         1f7AM0DSIWjxMiuwIgtP6uIKQqm/r7F+crq0PDnc1k5a4vaeChPX+AIA5kFMUogoRSYT
         C9vGT1PKZNlZ0YFGgU7mdJHeIwLHxcqYr1yJhpaXInc16XDwUVZpgGNJucBmG5MgaCyA
         /CVg==
X-Gm-Message-State: AOJu0YybWBbj0qFkynpJCG+noKoe9MJ5WJwpsdqYvCBRVePqRvmFg7fQ
	gcxCQ60SDEI7ZWJ/pOMDkJTILQGwakRo0RpDBTJROjpyiK8FRvBRecj1KAMVOgtTColq9cNvZFE
	XmUBtCL07wQ+Tfmju3yxAqOC06ZdsBkDdWvycBzPmr1is6v6aVbiJS2YZ83LgJpLa9rIpTXEAWS
	D3VJdakkVLCs7ydM1fZZGstOZudw==
X-Google-Smtp-Source: AGHT+IFe8jdXuv1aeWH7MA6yhiyWDlgI8y8inLlUvWwyqVv/uZ8Z/4ucJ/ukXR0gHdrKnKLOMWTmqhkg
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1c18:b0:41f:dfa4:52b2 with SMTP id
 5b1f17b1804b1-4215633fb75mr445e9.5.1717516598483; Tue, 04 Jun 2024 08:56:38
 -0700 (PDT)
Date: Tue,  4 Jun 2024 17:56:26 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; i=ardb@kernel.org;
 h=from:subject; bh=B0UDgfaXLRjwJ5HFYpQ93lnEBVODOyfsm3LZgpoPIDg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS3eUqsiuu3BPdGJj5gE+0Onf9uodjnvQLLKo9knc/dej
 dq0641lRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI5FuMDBfVrScI35XKnXfD
 pcz/9Iri/Z/4OB95MG2Z+DH2wvOpaXcYGTbOuTVPxIOv8v2l01djCt0C7XKOqggtn+D4bcWx+/O +nGECAA==
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240604155625.2197275-2-ardb+git@google.com>
Subject: [PATCH] efi: Add missing __nocfi annotations to runtime wrappers
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI runtime wrappers are a sandbox for calling into EFI runtime
services, which are invoked using indirect calls. When running with kCFI
enabled, the compiler will require the target of any indirect call to be
type annotated.

Given that the EFI runtime services prototypes and calling convention
are governed by the EFI spec, not the Linux kernel, adding such type
annotations for firmware routines is infeasible, and so the compiler
must be informed that prototype validation should be omitted.

Add the __nocfi annotation at the appropriate places in the EFI runtime
wrapper code to achieve this.

Note that this currently only affects 32-bit ARM, given that other
architectures that support both kCFI and EFI use an asm wrapper to call
EFI runtime services, and this hides the indirect call from the
compiler.

Cc: Kees Cook <keescook@chromium.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/runtime-wrappers.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 5d56bc40a79d..708b777857d3 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -213,7 +213,7 @@ extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
  * Calls the appropriate efi_runtime_service() with the appropriate
  * arguments.
  */
-static void efi_call_rts(struct work_struct *work)
+static void __nocfi efi_call_rts(struct work_struct *work)
 {
 	const union efi_rts_args *args = efi_rts_work.args;
 	efi_status_t status = EFI_NOT_FOUND;
@@ -435,7 +435,7 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 	return status;
 }
 
-static efi_status_t
+static efi_status_t __nocfi
 virt_efi_set_variable_nb(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
 			 unsigned long data_size, void *data)
 {
@@ -469,7 +469,7 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 	return status;
 }
 
-static efi_status_t
+static efi_status_t __nocfi
 virt_efi_query_variable_info_nb(u32 attr, u64 *storage_space,
 				u64 *remaining_space, u64 *max_variable_size)
 {
@@ -499,10 +499,9 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 	return status;
 }
 
-static void virt_efi_reset_system(int reset_type,
-				  efi_status_t status,
-				  unsigned long data_size,
-				  efi_char16_t *data)
+static void __nocfi
+virt_efi_reset_system(int reset_type, efi_status_t status,
+		      unsigned long data_size, efi_char16_t *data)
 {
 	if (down_trylock(&efi_runtime_lock)) {
 		pr_warn("failed to invoke the reset_system() runtime service:\n"
-- 
2.45.1.288.g0e0cd299f1-goog


