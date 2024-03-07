Return-Path: <linux-efi+bounces-768-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1438875420
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 17:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42231C21EA7
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3947B1EB40;
	Thu,  7 Mar 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBU2Mc27"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868531E878
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828555; cv=none; b=WMVgNpGPFbI3MlZuAo9tGXErSe0x2/86UQCROai5dGVgwO/di+T/oR169GPVax2cHBVizv1XeMYZffcVQ1Dg9LXm9qVDJM+QiSNYUPSOKi//Syo6s0Q5LLfJyK3mhqrysBsYG8aWh4zluNSyRvq0+jOZFuv4WlN1txOlWU7bzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828555; c=relaxed/simple;
	bh=1v5qDaflI1flKXQvcNnTLi+DdUuCqFGLba7GP8djNmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XxAf1BQsvM8k3tK/PpiEX1jhCh1J7RdgrRozgzM3602UWAdTCxYhuzwH0/TWq4kCcACQDDvH6Nl7eezhhYyEJYrD4E0UmPq2C3mjOvHw0lOtFTDBODsxTKZ90sns6arZgYIYZP53g6EWxGF2lDv1gq2Mlr4FZ9Xjhi3bCF5s15c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBU2Mc27; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047fed0132so16936877b3.1
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 08:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709828552; x=1710433352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=brWE58VkfvSmOu5ITgNbNdxBlUJvRdpQgw8XNQfzcrQ=;
        b=LBU2Mc27f2VZjREYtUd+Hp7xV8pjv9Q09a88L4uswFddhAV0LSgN0lW7C/HYQciFSd
         4hamb3STI/qTh6c0PsUk0LAOkJ0+HqRNanqHvCl+oon1l6KKJhhkZVCO7jvHEjxPVgjN
         t9/BbBzinpzSPzKYqxs6TK3y1ilIS+tMAjITF84Kdfv7C6QVwYRv7pOV7AuAY1nA3H2q
         6QZQuSVRsNadM9ymNlPtE1A3uFzUHIO/QIK4ulC1W6XpTFTCyd4CmLQP+nP01IEOS9sG
         wTY36EMBGCqBuNfiX8fvEi7ngedA7Wzs+SzHHYfHKocnDT4ZAG8Ub2uhemK4EFdxgl1U
         PeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828552; x=1710433352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brWE58VkfvSmOu5ITgNbNdxBlUJvRdpQgw8XNQfzcrQ=;
        b=NAyNCOABMcNj4rXItgg2F8GolFJ/MuVEcBEUxIxU6QLZd+eqNovX3r9qkMZFkzd1P5
         e8bBX+RNkstgG8i6bUBI8yowIzd1VS3vdk8Mt828oK640FsQGQJy6KBoo7vKbEv1ol0K
         WDMdVPHH1AuWtZm1v7WI4fwh2OLcaZUePDAutMYNLN7RAMfA+eRja66WIupQYyVmMJzW
         aLpqkaMr2op6gFZ4LGhGFu7q4Xu/4EpbigmtGLVKEXubIitagsSrFZzQVs/LN7WZC3/q
         OVbxrDsAe8txpyHjsyvYswHAge14b82fpn/PJcvFEuzKXkl0TamB+umO/yE5e05SID2G
         LyvA==
X-Gm-Message-State: AOJu0YxvqkS3oMAg22p1+fJ9a1qMvTAF1aGykDz5r94IxMDb8EbSFWHV
	oIGm62nIT3LS9TLFy1ajA9agcaejLdEcTQGJbTSSIcZQkqFDF076XxaW9Fy3Yo1joCODfgUdjZJ
	Zmc/bnCWzGrHwuS6Vlf5yHJjLx1jagDJ9ZXCEah6nZsfa2p9xkrYOk3obOvwJ7IO1KOP2feh+H5
	BT50QF5QJW/sI70wV27sfy1babog==
X-Google-Smtp-Source: AGHT+IFWASN387DLEosD5gjIT/FyNLTFzQJi0kuM9OoomWialMcEfVeyb9OU0suFf/qXQMvzNP0/vgSz
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:729:b0:dc7:66ec:9038 with SMTP id
 l9-20020a056902072900b00dc766ec9038mr826012ybt.1.1709828552450; Thu, 07 Mar
 2024 08:22:32 -0800 (PST)
Date: Thu,  7 Mar 2024 17:22:18 +0100
In-Reply-To: <20240307162214.272314-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307162214.272314-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931; i=ardb@kernel.org;
 h=from:subject; bh=8Do1tMdDVHm6ro61VFSQzGVzzJldNBeK41qZOtuu6kQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXly92n5t5ZdkZu6sz16d+mpDrLFid8ydz+ROiPwO67F
 7Q+FCS+7yhlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATMZnI8D9t5U7HjqpDkZ8Z
 GFnvyyZ86Jp1d6rD44CfhSqCanF3zqkzMvz2qebb73DyvbD0wZM7U19O+qOmue1RVt6RLzwvt9t Uf2QDAA==
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307162214.272314-10-ardb+git@google.com>
Subject: [PATCH v2 3/5] efi/libstub: Add Confidential Computing (CC)
 measurement typedefs
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

If the virtual firmware implements TPM support, TCG2 protocol will be
used for kernel measurements and event logging support. But in CC
environment, not all platforms support or enable the TPM feature. UEFI
specification [1] exposes protocol and interfaces used for kernel
measurements in CC platforms without TPM support.

More details about the EFI CC measurements and logging can be found
in [1].

Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
[ardb: Drop code changes, keep typedefs and #define's only]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 79 ++++++++++++++++++++
 include/linux/efi.h                    |  1 +
 2 files changed, 80 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index dae635cc3d4f..72181c04420c 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -875,6 +875,85 @@ union efi_tcg2_protocol {
 	} mixed_mode;
 };
 
+typedef struct {
+	u8 major;
+	u8 minor;
+} efi_cc_version_t;
+
+typedef struct {
+	u8 type;
+	u8 sub_type;
+} efi_cc_type_t;
+
+/* EFI CC type/subtype defines */
+#define EFI_CC_TYPE_NONE		0
+#define EFI_CC_TYPE_AMD_SEV		1
+#define EFI_CC_TYPE_INTEL_TDX		2
+
+typedef u32 efi_cc_mr_index_t;
+
+struct efi_cc_event {
+	u32 event_size;
+	struct {
+		u32 header_size;
+		u16 header_version;
+		u32 mr_index;
+		u32 event_type;
+	} __packed event_header;
+	/* u8[] event follows here */
+} __packed;
+
+typedef struct efi_cc_event efi_cc_event_t;
+
+typedef u32 efi_cc_event_log_bitmap_t;
+typedef u32 efi_cc_event_log_format_t;
+typedef u32 efi_cc_event_algorithm_bitmap_t;
+
+typedef struct {
+	u8				size;
+	efi_cc_version_t		structure_version;
+	efi_cc_version_t		protocol_version;
+	efi_cc_event_algorithm_bitmap_t	hash_algorithm_bitmap;
+	efi_cc_event_log_bitmap_t	supported_event_logs;
+	efi_cc_type_t			cc_type;
+} efi_cc_boot_service_cap_t;
+
+#define EFI_CC_EVENT_HEADER_VERSION	1
+
+#define EFI_CC_BOOT_HASH_ALG_SHA384	0x00000004
+
+typedef union efi_cc_protocol efi_cc_protocol_t;
+
+union efi_cc_protocol {
+	struct {
+		efi_status_t
+		(__efiapi *get_capability)(efi_cc_protocol_t *,
+					   efi_cc_boot_service_cap_t *);
+
+		efi_status_t
+		(__efiapi *get_event_log)(efi_cc_protocol_t *,
+					  efi_cc_event_log_format_t,
+					  efi_physical_addr_t *,
+					  efi_physical_addr_t *,
+					  efi_bool_t *);
+
+		efi_status_t
+		(__efiapi *hash_log_extend_event)(efi_cc_protocol_t *, u64,
+						  efi_physical_addr_t, u64,
+						  const efi_cc_event_t *);
+
+		efi_status_t
+		(__efiapi *map_pcr_to_mr_index)(efi_cc_protocol_t *, u32,
+						efi_cc_mr_index_t *);
+	};
+	struct {
+		u32 get_capability;
+		u32 get_event_log;
+		u32 hash_log_extend_event;
+		u32 map_pcr_to_mr_index;
+	} mixed_mode;
+};
+
 struct riscv_efi_boot_protocol {
 	u64 revision;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 464fe16411b8..2493d3d4429b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -401,6 +401,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
 #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
 #define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
+#define EFI_CC_MEASUREMENT_PROTOCOL_GUID	EFI_GUID(0x96751a3d, 0x72f4, 0x41a6, 0xa7, 0x94, 0xed, 0x5d, 0x0e, 0x67, 0xae, 0x6b)
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
-- 
2.44.0.278.ge034bb2e1d-goog


