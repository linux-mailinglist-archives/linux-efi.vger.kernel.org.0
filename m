Return-Path: <linux-efi+bounces-699-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC351870039
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4111F23BFA
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5232C383B4;
	Mon,  4 Mar 2024 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njz5WTwT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497F37718
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551237; cv=none; b=IKppVB/S4EJ1I70v2HG+qgnrwAILBxFSg3NcsFYDdY8LwSzrMi8Z9QfOv3DtGSV2qtie6hqSLxnHPKGa9x7lQVHoPBbqJ38Lzc+tgSpU5huaqgeCrUU9SuKK1h0iu6vgLl5HpcbbSqyUYmbJzTK9ol+4NMIM8yI58XFWFag1Bjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551237; c=relaxed/simple;
	bh=nc3yv9vSe7W8oX9ypNryMk2uuXxCuXX1190k7PyASdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E+aAuR3ZRhtnpNVv3+FP/kK9y/vLN11k2g40rd9vEWVLbDqWpdHEA67R3h1+reFL3W160BAd0x9ApT0GYVu6rUdf+PZjQoydmPCUnk1d8g0SccCqTcahQ1rZZzqDv8lY7TK9zkQjRWEz1fiZ4Wos+mk10PpFKMi+CsV+UzzN8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njz5WTwT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6099ec81e2dso22000867b3.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551235; x=1710156035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=boAOdLB13m5baTjp0KeGHT68NglbdhYPJKK+DDLhf7I=;
        b=njz5WTwTPirvOv7ny849ilAUr+HvJZRvM6Vq/pUPtQQtaWJbYNxNaq9+1ABEvs3wMA
         +QXeMSpNmfAzY8VD7kNTs1V7LVLG73RP3fIjofr7SD+bY3oVcx5zb7xw8QkvdHEgrWFG
         JqjhRtbeZLZBnbwX64SyF+MUzULD/ZDaD1q1zhW2+bO0Y0JrSK2nSYxHMF4HUyU+cWSX
         XlO+dsUqFXsaTsZerzqvGK82QOcpEJEjuZwM8q94Pz/yMAl6f7SoUw+X3UJwm5OtjAA7
         rCeNiacKKlgG1bM0FctVZLUHXYv2wJy/ad4I6BbjpNUBtMnfFzHV3NKkP8E+jwXuinc6
         MY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551235; x=1710156035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boAOdLB13m5baTjp0KeGHT68NglbdhYPJKK+DDLhf7I=;
        b=WZuXQDJs7V29xKv2iWdiEfD9FTgNt05k2h6b2z0CSTW1YSUvBxAbclAASPPK687PKK
         81VfdKkfqCZJx0MJdZQ5lHnHJ2Es6rHQLX1mAYhLbKxwb1qgWRAG0zNavgasNwmk3SaV
         HXL4cv+DePFhCTBxB5Cj+rImqTt4DXVycg1RYWjhRfxBe7TYxGvQ04o1UslC/n2ER9D/
         OplzpTEub5AUc8CwhLDZFxDFJuYobB6BFfzvwZnbqp6jNl+y3WXiO3Bc45VSBCosxaBL
         rnZpMBJASohjngjwpYe94mrpv+pgXLmKQgQexoowN6f3CdGpH6jWJ9hTaK4/UPosz++B
         jHTA==
X-Gm-Message-State: AOJu0YwdCEa4w2iFim/ndpbEbJzt+T32arLB7J+xYty2b1gyuejkPjKY
	OoO/n75APcf8kN6pLX6Tx9E0ctAKN5pUC/kSEU4gmv25bS+onzgQ3gF7h2CwbYYEr9tBww==
X-Google-Smtp-Source: AGHT+IFhBHs0+QiaDmaQQa5r7u0RTJU4CL8YLKUjmhRKvmGUN2IqqWkORsqzlrkv5TrTcnj3B+cqRXlw
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:9949:0:b0:609:2fba:12a0 with SMTP id
 q70-20020a819949000000b006092fba12a0mr2621976ywg.3.1709551234793; Mon, 04 Mar
 2024 03:20:34 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:45 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3758; i=ardb@kernel.org;
 h=from:subject; bh=3td9ZQtrGoE5RQr3hLiRl84FZti+/Le62H16smm2+LM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpukD+vAMub74LHFzqu3OSYWBH4JmSJUcva+4v3L9D9
 mLVArGijlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRR5cYGT5dbd3+jskobOs9
 xy3sTv08HLYdZx59fMXBoR30X/PF1WRGhkMl1oW7Fx+/sjx4/6bcXK7tTvtY2UJsTnXP/ZkyQfp dHB8A
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-27-ardb+git@google.com>
Subject: [PATCH stable-v6.1 07/18] efi/libstub: Add memory attribute protocol definitions
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>, 
	Mario Limonciello <mario.limonciello@amd.com>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Evgeniy Baskov <baskov@ispras.ru>

[ Commit 79729f26b074a5d2722c27fa76cc45ef721e65cd upstream ]

EFI_MEMORY_ATTRIBUTE_PROTOCOL servers as a better alternative to
DXE services for setting memory attributes in EFI Boot Services
environment. This protocol is better since it is a part of UEFI
specification itself and not UEFI PI specification like DXE
services.

Add EFI_MEMORY_ATTRIBUTE_PROTOCOL definitions.
Support mixed mode properly for its calls.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h             |  7 +++++++
 drivers/firmware/efi/libstub/efistub.h | 20 ++++++++++++++++++++
 include/linux/efi.h                    |  1 +
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 233ae6986d6f..522ff2e443b3 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -325,6 +325,13 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_set_memory_space_attributes(phys, size, flags) \
 	(__efi64_split(phys), __efi64_split(size), __efi64_split(flags))
 
+/* Memory Attribute Protocol */
+#define __efi64_argmap_set_memory_attributes(protocol, phys, size, flags) \
+	((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
+
+#define __efi64_argmap_clear_memory_attributes(protocol, phys, size, flags) \
+	((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 002f02a6d359..6f5a1a16db15 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -419,6 +419,26 @@ union efi_dxe_services_table {
 	} mixed_mode;
 };
 
+typedef union efi_memory_attribute_protocol efi_memory_attribute_protocol_t;
+
+union efi_memory_attribute_protocol {
+	struct {
+		efi_status_t (__efiapi *get_memory_attributes)(
+			efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64 *);
+
+		efi_status_t (__efiapi *set_memory_attributes)(
+			efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64);
+
+		efi_status_t (__efiapi *clear_memory_attributes)(
+			efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64);
+	};
+	struct {
+		u32 get_memory_attributes;
+		u32 set_memory_attributes;
+		u32 clear_memory_attributes;
+	} mixed_mode;
+};
+
 typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
 
 union efi_uga_draw_protocol {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4e1bfee9675d..de6d6558a4d3 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -390,6 +390,7 @@ void efi_native_runtime_setup(void);
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
 #define EFI_DXE_SERVICES_TABLE_GUID		EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
 #define EFI_SMBIOS_PROTOCOL_GUID		EFI_GUID(0x03583ff6, 0xcb36, 0x4940,  0x94, 0x7e, 0xb9, 0xb3, 0x9f, 0x4a, 0xfa, 0xf7)
+#define EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID	EFI_GUID(0xf4560cf6, 0x40ec, 0x4b4a,  0xa1, 0x92, 0xbf, 0x1d, 0x57, 0xd0, 0xb1, 0x89)
 
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
-- 
2.44.0.278.ge034bb2e1d-goog


