Return-Path: <linux-efi+bounces-1466-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B47A935294
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 22:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7088B21C27
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 20:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6291442E8;
	Thu, 18 Jul 2024 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVIyR0/L"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF714389A
	for <linux-efi@vger.kernel.org>; Thu, 18 Jul 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336310; cv=none; b=eDPklLnmtuDjTCunBqxCDpDsPJF4QkBlnI5wjO0nW0f9FceGsMhst7yteZBqt5n2Z/TPDP3Sorkxe9PycTan3T/G4KqpOUzntBsOtb/yt3e5nAjkb754bU/SmO4x+RIqHJCUpt86jCV9/koGLc+eNdwA5ICNr69qAtT7d41w1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336310; c=relaxed/simple;
	bh=0mKCFRwuwiKbWaYC69b30DRT8skWZ9rqLAXUYLdwXOE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pz0TUXoKUS7h/JOAwAHq59sbznQhbYwFAeHpjdIJvExD+D+v9o7MAswJbw8skDpMqSK57HZzwmLWkg+Ofy9qvXlSQZVmQYrRaC9pSLCvLeeBXMF40vnyAwqvD0NrMtmc0GitmciC9bHhlq3o2PDENfG7YvSwkKgqPxp0K+Ma82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVIyR0/L; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b70c4a269so31258037b3.1
        for <linux-efi@vger.kernel.org>; Thu, 18 Jul 2024 13:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721336308; x=1721941108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fGRCU4E9k0xNfzk/OdkUUUbOzEknb3JQXqzPkvgdc68=;
        b=hVIyR0/Lc0MtqHaRczNhN41/5/wa64dWPRZSNw+QU9Cz9n0hRWfRO9GTo9CtbpQN2i
         e0vi56F/pgwUy76q7tH9LPi17B5Bly2DYUjuQAOLM2WEr7Fqrz7mek0Pofw9Ym98dbG6
         6rK4/bd2qqfnqpb4BbUe9pg6ffa6L4u9KkvcgaamLu5fcwtludGDyCtOokh0YyIv8A2d
         b5KFD79hXYrnCqWcetn6RAtBuxvUsRO038ZNmid47icu7LUxB+SB4fsTeHPKikuCZ4QC
         SZRS/HxCkPu8VKEzy+TNR1XIaw01SKb3nMpLPIeRcnbXSYOuxJWFxs8+Rsc59kLJpj0E
         lvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721336308; x=1721941108;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGRCU4E9k0xNfzk/OdkUUUbOzEknb3JQXqzPkvgdc68=;
        b=Z05BjoBSSbJJ4Gtu/+TeeDzPQ3QIAQh5F3BMGwF7qosayGOyjpgX7lvHvSXufp781/
         DTDzDU4fgxX3Wtm0PQ1F3f83vwTDJZLR2x8vywFrkrWhMPJAC+Ppxd99cYgzmTT0v8j+
         eiO6RzuuoXHcRKQhkBt/wtaZVRUe27iy63UfpFLTIFN0pI+AzprouidlDiJzVE0WtGtM
         Tl2qYUvlQ1ZLALqSWL7LUcnSAIxIJWr1/kOlPAdDZxhWI3Ygt7eoyXE8jee8N+MFqQW2
         aGGVvAiCnk+5f5DbIWd3qad+FyXWX63gClysbcubCQ1i7cr9/bGs8LNaMAUaZqBTm18/
         HP8g==
X-Gm-Message-State: AOJu0YyBedrZLaSfRcYiv0icNXhDR+AQgMeMCUeWifWTXDVE2xUcLc3s
	FksPazXBTGKXD8/mPLWpxiWtktFa/ndAD9omO/qxByBhbv8Cdss0r9oRjTgfJUZGBSN+joy4OM3
	7vteGJf3YaZqsa2Qfvv1dG5UFAaEsbs3ZvTXjvAqJL8oNvOpvfqz8dCea00wxJHDtwEA6/QUzIN
	UCEGiI3Id+BysdnlU85KRGpPGgvQ==
X-Google-Smtp-Source: AGHT+IH8cLeGUL42wNFA1ZDLBOmZxj184nvXO8BkJ3f5n7frYxfrtoRUrkH/UzlFbdtguKG85ZVOdIPU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:110:b0:65c:1db1:9235 with SMTP id
 00721157ae682-666005395bbmr344067b3.0.1721336307647; Thu, 18 Jul 2024
 13:58:27 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:58:07 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486; i=ardb@kernel.org;
 h=from:subject; bh=PYtmNnqM5abSQt0q0r9MUZrjCKwoXBTw5SljvuhTZsw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIW1m4/2Zlvu/X7vTXvMiT0r2b5Xk6tTl8+Rd7t1luvViG
 t90g5SPHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAinx8w/I/0+pQV+ONYid1J
 g6K+ms0xmUWzOITW/751judn8eXv6hoM/9PWb01OTShP1p38svTNcfXUoy8vWPiuKpyYOrnyokf +AmYA
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240718205806.2888909-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Revert to heap allocated boot_params for PE entrypoint
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Christian Heusel <christian@heusel.eu>, 
	mavrix#kernel@simplelogin.com
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is a partial revert of commit

  8117961d98f ("x86/efi: Disregard setup header of loaded image")

which triggers boot issues on older Dell laptops. As it turns out,
switching back to a heap allocation for the struct boot_params
constructed by the EFI stub work around this, even though it is unclear
why.

Cc: Christian Heusel <christian@heusel.eu>
Reported-by: <mavrix#kernel@simplelogin.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 078055b054e3..e117c6b6c7e9 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -534,11 +534,12 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg)
 {
-	static struct boot_params boot_params __page_aligned_bss;
-	struct setup_header *hdr = &boot_params.hdr;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
+	struct boot_params *boot_params;
+	struct setup_header *hdr;
 	int options_size = 0;
 	efi_status_t status;
+	unsigned long alloc;
 	char *cmdline_ptr;
 
 	efi_system_table = sys_table_arg;
@@ -553,6 +554,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		efi_exit(handle, status);
 	}
 
+	status = efi_allocate_pages(sizeof(*boot_params), &alloc, ULONG_MAX);
+	if (status != EFI_SUCCESS)
+		efi_exit(handle, status);
+
+	boot_params = memset((void *)alloc, 0x0, sizeof(*boot_params));
+	hdr	    = &boot_params->hdr;
+
 	/* Assign the setup_header fields that the kernel actually cares about */
 	hdr->root_flags	= 1;
 	hdr->vid_mode	= 0xffff;
@@ -562,13 +570,15 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	/* Convert unicode cmdline to ascii */
 	cmdline_ptr = efi_convert_cmdline(image, &options_size);
-	if (!cmdline_ptr)
+	if (!cmdline_ptr) {
+		efi_free(sizeof(*boot_params), alloc);
 		efi_exit(handle, EFI_OUT_OF_RESOURCES);
+	}
 
 	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
-			  &boot_params.ext_cmd_line_ptr);
+			  &boot_params->ext_cmd_line_ptr);
 
-	efi_stub_entry(handle, sys_table_arg, &boot_params);
+	efi_stub_entry(handle, sys_table_arg, boot_params);
 	/* not reached */
 }
 
-- 
2.45.2.1089.g2a221341d9-goog


