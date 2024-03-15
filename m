Return-Path: <linux-efi+bounces-820-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE187D3DB
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304B6B2126C
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D51F176;
	Fri, 15 Mar 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qv78DlU3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71EB1DA26
	for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528302; cv=none; b=ZrSkw+c8bIE2bOqN6iDfbso+IKWiAGemjj1dSZR2zo9v+gQa7xsWA0iNrfhOL01ufj8SRW4+E9kOV5/JZUzFoHKiYdMCmAJNlD1cFRjdWJ5CSUn0zp4d+5O9XAHm3/6c2W5L5QQo6aRO07S39H2865tGjOUAWJojVoke2lPIbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528302; c=relaxed/simple;
	bh=kB/993s6zM5nsl2ZXYt8C7yUGsnhSABK4nzsJX/jlEo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s8jfYhMBZxArYo/pW51EIMitz/mlDtB3RENyhTFTOqKxNmtLptLorDXwWA7blTyywyrjgblTBUky8jBac5tq3QqNF2owxunBQlv+YjDE3i7paUktyWsouR9I7tD+N4MQFrIgjKgvr6jEZEaERWboG58AgCuZUThLEedIF759pw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qv78DlU3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so4029347276.3
        for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710528298; x=1711133098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kLFV+TJ5jukvAp4sklQYPMZ0aYoTsux/8WqiDKfQ8Ss=;
        b=qv78DlU3cmCsLrkEnz6B+nE5c62qRNUhLiewfxA3t4RrdChC+jN0Zz+V486Fks2JE8
         2y/tLj6fq9EWmSLkud6rgUhUmrK+AY+VLk1NrkEKE8XsO3T0Avg2xkoadcE0bWBWBn0K
         iyxSFrqqokn3ol9BJ1R/dj/Z1oQC9L6NutMkGl9GVyZyFAtTxS9RsTnTkQOLRcqUAqeQ
         rBrmI9AOFxxNFuAph0Z4CXu+rYhSlN6c0WKOXxiO/HT7A9KFrkj99GNy7o8xBS0fOXBv
         vuHJWkEPyDuaT/TAEmHwgrFXSvhOkmTo9YuGlPBy2Wm/YWRfCIF4p3hGYsnsFhdDZGsw
         8W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528298; x=1711133098;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLFV+TJ5jukvAp4sklQYPMZ0aYoTsux/8WqiDKfQ8Ss=;
        b=KSSRejqR4EweRIgFMoq/o4tY+eKnKDPYuU8b9x++KxURxEbY9GqB2YD0t8l9SMMFWb
         utsFX1uqngXx0LWMS2mXAspzb0QK6vdNwyObGENskUKq/Col1cN/qCJUMmnjhuLaEWHW
         zyvNvpSIEQIuBx4YQj+YPXeM3wv8m5WpZK1ZOOa75DACDdCqPxfgfFLcGXM6HdxpCFLH
         w+V30j50VxzUFxojRmsmkzUaJOvh+urcbPXVanWMP2Du7gFQT88WydbtRYDcvJ5oWb3f
         KbxZlb/PFCSSMPlA+6M6RKP5zwpzlrkM+YYMcWv8MLCmZ6DfJwkgUCEJPMtPwzD4CEgS
         4eDQ==
X-Gm-Message-State: AOJu0Yy9ansJZXQ75x4XnSwAE6jU7A8Ygc+lvJHc3BV1as1XKKCT46TG
	1E5P0gF9wnrYjXOUDbGgqAVora1GFGmujEHXGeYZifrn0DwDon9HHNEWmCtBpkwPLiqEG7/Zt2h
	WHPxtbbYjYMnVMCbp7ef6FnZFGe0cjXbhelBIkBqo9z9XWGSrdyA1aUZXcaPcMMDW/QvZ+aOUOw
	uTchTHkEe9uBkxgh645aVCOsgFdQ==
X-Google-Smtp-Source: AGHT+IH0lcRGeHyP7wKRBDhcWMcMJBZKUGFEpnqg7uZPPbhpxrtvVDrfVPTq6vA8J6eEWF0ynjVPEMfH
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1004:b0:dc6:44d4:bee0 with SMTP id
 w4-20020a056902100400b00dc644d4bee0mr194914ybt.7.1710528297666; Fri, 15 Mar
 2024 11:44:57 -0700 (PDT)
Date: Fri, 15 Mar 2024 19:44:39 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=ardb@kernel.org;
 h=from:subject; bh=hNdFm9ohkKR/E9QgoVEO6nYJkzQJEo9BU623OWEdpzw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXLdHET9Xz3fZEnrzz7IPH087OFqreSJ3xNn1uZo31H4
 dqBxEXaHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAis44yMnQ2b9dO+Fl7N/Sq
 M//K6Yt/BCU0c9hOKVzEOM/+eIThjWOMDK1th5f/erunuG3BgaPHWS/zmfo4XzDb88alMvlBh4Z ZBxcA
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315184438.3609735-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Clear decompressor BSS in native EFI entrypoint
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, stable@kernel.org, Radek Podgorny <radek@podgorny.cz>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI decompressor no longer invokes the decompressor as a subsequent
boot stage, but calls into the decompression code directly.

This means that when using the native EFI entrypoint (as opposed to the
EFI handover protocol, which clears BSS explicitly), we are relying on
the firmware PE image loader to ensure that BSS is zeroed before the EFI
stub is called by the firmware.

As Radek's report proves, this is a bad idea. Not all loaders do this
correctly, which means some global variables that should default to 0x0
may have junk in them.

So clear BSS explicitly when entering via efi_pe_entry(). Note that
zeroing BSS from C code is not generally safe, but in this case, the
following assignment and dereference of a global pointer variable
ensures that the memset() cannot be reordered.

Cc: <stable@kernel.org> # v6.1+
Reported-by: Radek Podgorny <radek@podgorny.cz>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 35413c8dfc25..2096ae09438e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -21,6 +21,8 @@
 #include "efistub.h"
 #include "x86-stub.h"
 
+extern char _bss[], _ebss[];
+
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 static efi_loaded_image_t *image = NULL;
@@ -474,6 +476,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
+	memset(_bss, 0, _ebss - _bss);
+
 	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
@@ -967,8 +971,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 			struct boot_params *boot_params)
 {
-	extern char _bss[], _ebss[];
-
 	memset(_bss, 0, _ebss - _bss);
 	efi_stub_entry(handle, sys_table_arg, boot_params);
 }
-- 
2.44.0.291.gc1ea87d7ee-goog


