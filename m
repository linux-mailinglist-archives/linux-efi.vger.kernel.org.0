Return-Path: <linux-efi+bounces-781-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9EF876076
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539DB2811BC
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B5951C36;
	Fri,  8 Mar 2024 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYDLiFEc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED443CA78
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888301; cv=none; b=KnaQ5yQY3jtBn3jVNBn3VktFetredEi6OKa+1EH9LDF+8nV0tKL8mXSzdY5T0aYfWQjhuaB/NBUkMkgQwlGcvrnra+9bPE3047vRftRXOrnNI+7Q+RzhsVpXZM2Ck2FvwiNpaZTh1N/5aJqlbIqtxeO6osxcvKZTb9g9Q+YRiMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888301; c=relaxed/simple;
	bh=qeUU3cLSOG8fi/kUWFl6N+cu1zCz63m/aRKgGG5DNnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OVor0tqz21lqBhLLq6lq8QQEFND6j2ojYiPUCOjx1FsB1gkWF3ARc4V0n/IhboLw7Q5SjHsAnu+2Zc24ZsUp4kPXSgS52h5VMSF3RbnWFW1WlSWEA7ESEia1r4SxJ0h3MR3n5V8VWq258ZpUNmGng3wPt0HuVNVKZzc2MdNgO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYDLiFEc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0b282961so206047b3.3
        for <linux-efi@vger.kernel.org>; Fri, 08 Mar 2024 00:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709888299; x=1710493099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIQ1lQ7HJ3wGUhnC48+LG1Rxwr4R8ALtSb8OzlOuk30=;
        b=xYDLiFEcHXtV0ZOR2uAmHfn5ohYrnwaThXUtsG2PqzxOvoigS/7Xk08Kr1YWgJtzRp
         MWc/IjMtm0OY4ebmTxb8bcknfbaDDQK6Zh2XFQG2SG672BouacNYja+Xpv9twOkvw6oz
         fWiVtanvmCXAK/Q50KNJU01+Xfhay8OgSdMDyS7MapHVt8Jew8IQqpa+Ib5sIZ/+WBod
         L18J2zXGtHBDMpAdNFUc7AWMkprnq22Xu3ardJbH4v59xdRzDo8wOeKjyCdALiTvL5zK
         RNhZFTUOVz8xRk4NhFpf/YxJVux2B924G0vv65oqQklZ2HZfasGoIQnm+TeHKrNWvBK+
         UAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888299; x=1710493099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIQ1lQ7HJ3wGUhnC48+LG1Rxwr4R8ALtSb8OzlOuk30=;
        b=uuNo0sfwTkd7N6zp3JtTLjRkie+G0ITTGcWhKxoFb63K0kCbsVTuJZsB43V9BeA1Ht
         c2vVbCgUPOu+tYdYjG34IKwY9DzRqWC6z4bv/AzsRtU1ezDl+BoT+RmfkFWbkdOQ/wAt
         tCSjxPm6BT98F7Fq1fh1UBS59y5CV00Cma64Sfkt0cKjf05s9KMfvGUS/usuEOxhpueo
         x1o80dzFPk+w26lxAub5K+q5SimHJGG3LgFtDqh6u5gfIQTQsJ+cGpeOSzNCNI1KMUZ/
         OqXU5/UplQgw1HajLv98HrvsskWynoCiqhjunvl0zkER3V0XI9mBQ0aV9MWyIBaw9dS3
         Nvow==
X-Gm-Message-State: AOJu0YxE7/kSYmRdSjZrxyaz3kyxHRk6OZUjR++A3epMpAJ7zZfXQhiv
	16iSpypiar2NHtTb4G0DdZhJyzFHqZgO590d94Rcanfukw73u7m2Lxb1SarVE17fbUAy/rEMXac
	e9bctwYY4LA7ZWPCkItYxMPJxwB3Ss5aTm35e8W47875YIthOkAKCQmJnBm14WkhAgETnlq6nbQ
	jFrq5JTHn2NXfxxiogWBKzVcXyow==
X-Google-Smtp-Source: AGHT+IGWd8msjy9M8sUnHaRMMd7Ey7RhyBzGBt9BzhDRr3tuD6IMtFG403wDF45nJidgPpyGw3Y24MMd
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:b10e:0:b0:dc6:d233:ffdd with SMTP id
 g14-20020a25b10e000000b00dc6d233ffddmr5471197ybj.0.1709888298935; Fri, 08 Mar
 2024 00:58:18 -0800 (PST)
Date: Fri,  8 Mar 2024 09:57:58 +0100
In-Reply-To: <20240308085754.476197-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931; i=ardb@kernel.org;
 h=from:subject; bh=xs8je5+D1+AnoMgfr65iIYE4FVB1ZUgCYnKloAmK6KE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXVZbHixZxbdKe4v7tX3nz2SuXx+ub/zEsZ3tUmVh1aI
 PLcUi+9o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyETZzhr5C+ze+mrPxqEf/U
 BR/ebDVOKb2jF98Zn/+/Mrdi2uL+BEaG2W3d7ZzVpR8X9Gf3RMwOyvpzpIKTT/pRpJ/M/ezrDks ZAQ==
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308085754.476197-10-ardb+git@google.com>
Subject: [PATCH v3 3/5] efi/libstub: Add Confidential Computing (CC)
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
index 043a3ff435f3..6b020aadcf94 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -882,6 +882,85 @@ union efi_tcg2_protocol {
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


