Return-Path: <linux-efi+bounces-689-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5EB86FF53
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9921281121
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85313364CF;
	Mon,  4 Mar 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KaYtpMil"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4436B02
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549064; cv=none; b=oqPgyC/FERFYF9ZkpXaCPzlL/Fk0M5j++oUB3qF0YZxbZZ+oS7LFi3JXAsHdmSy6iFVVQD/Sq6ttbU+p1vVvyN6BegO9OW5nvLp+S0jm+MKs+yLcPAi76rvnNQhDqtLVw9bVSVHxKBWT8qRD8p6OPVf+8owtsORj/NyIWsX68r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549064; c=relaxed/simple;
	bh=VVhdioOphzTA9PdgdT1aZk9Erf/HsszlM5PhQ4qdocQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K8veGIRI/gclfCEjJ9+Uvwj/F1Gnw7saW8bojsuo++ggBUW3NGntOod4Oz33tGtXo909s0Z7P33lT/odyjTp+eP5mcDRNJatpNAm6NlC8A/HRqEywmRiMIf8SFPzMVF+prgV6mJ2PKaGkVYxxU2m74OjeF+JWKaruLg4T3E2oR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KaYtpMil; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6096493f3d3so54104847b3.2
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 02:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709549062; x=1710153862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB9BYcBxd51GsXGosNFX5daYhYq4BEI2v6YX0r+bKnk=;
        b=KaYtpMilVtJg4gVwcrxVLZRcLwH6fSfQc0tXOk/gyp3SlG3LTaI8IsGrJkm15LtcYw
         MVEgzwSEe7CN48RW9zAwbYbALcIA51UDTEdWlb38oJMtSrhzfzbUzHKcsXuxOtgcARy2
         sIf+qoPn3Fj7e4CVS+RREnKrUuwJatPJrTnnb3/Bfc6QcgZu+DRCJJboQs7HEgfqqW4v
         uNpjX+y9fGKY7FFdemVGZt0T7PCkuS+DYHZ2Pio3yTU4WF8NdSsawUwuZIhaD1OtgRww
         yHO9/R5tyj6xxLLWUhTUQfwUZ2JjzGbngMgJQMPeH4fHQxE4E9uyoMa4oITy0uJF220n
         0uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549062; x=1710153862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB9BYcBxd51GsXGosNFX5daYhYq4BEI2v6YX0r+bKnk=;
        b=gwxhGi6+jcgLFcLv4FlH1L+hK4vkrWSyBvDdruzWQ+UtmogDJgT0OLH/3xu0+44C5F
         08a12IWaKWZeXW8UD0wBsE7AoxVZ+jZvnl2bodJ8LqJY/YczofI5I9HA0ve58ztPUuVU
         TmtJXpoab+iq4JE+bZAx3GLBpcae7uWFl+MGceMFGpDBzf47b2nALaLzntc3RcP3ezF5
         GET65Wp9pWj/RSzxcOaVOeuzo09CdhQJb4Y9G5enEm+A5v9kcdfDOJrOx8SdvUHUQLQQ
         LWRLPfZNFUjsCU04Hb8uk6RWViYnJCpsDagUqylIFEZ1oxT40g0ZRsEgTDD6t3NPvIV4
         7y8Q==
X-Gm-Message-State: AOJu0Yxa1de4oWK7dK3s9buIj3q4p2LiRivBH0G7llJ52a5QugyYhoZX
	WUSWYF4Xk72D55/fFAverFUBZphgHpYeBnm83JfoLw9unnM16DbhAR3cBxdmoHK2c56ehxHDTjH
	AnzR131LA7ItwrT59BlcCu1OTNCyR8nFKtvdAVPSJRS2DQmLDmPwQ1NBO0ZuYcKo2qkXv91YgAD
	IhWT6NJQmVXPr0KMBSGRlv2RWFNA==
X-Google-Smtp-Source: AGHT+IEh0Y1celsmfHJbvT2yoGIO6YXPE30dXTAqGpSknauBkrJ/Kgh3XI3lye1cnFXnuSlD+284678V
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:9b97:0:b0:609:3c53:d489 with SMTP id
 s145-20020a819b97000000b006093c53d489mr1852594ywg.3.1709549061921; Mon, 04
 Mar 2024 02:44:21 -0800 (PST)
Date: Mon,  4 Mar 2024 11:44:12 +0100
In-Reply-To: <20240304104409.2326422-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924; i=ardb@kernel.org;
 h=from:subject; bh=AOuCJuHy1QOC0jeM/cJGLY/9Zjk5me9HEaE3HQHVYw4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXp0j9z/v6JD2GP/O7za8a/pUzbThhtc4pduPX8pounn
 KZP/djR2VHKwiDGwSArpsgiMPvvu52nJ0rVOs+ShZnDygQyhIGLUwAmsqaM4Z+alUZXyP5uQeYz
 Re322uEF+xmrBEuyvqqaXjzwyVjUyYHhv0/CObXJfDqsKoV7VogvXjnTevbKhhzr+6eZPoVmayq r8AEA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304104409.2326422-8-ardb+git@google.com>
Subject: [PATCH 2/4] efi/libstub: Add Confidential Computing (CC) measurement typedefs
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
index b2c50dce48b8..d621bfb719c4 100644
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
+	u8 event_data[0];
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
 union efistub_event {
 	efi_tcg2_event_t	tcg2_data;
 };
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c74f47711f0b..2f57fec2e629 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -400,6 +400,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
 #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
 #define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
+#define EFI_CC_MEASUREMENT_PROTOCOL_GUID	EFI_GUID(0x96751a3d, 0x72f4, 0x41a6, 0xa7, 0x94, 0xed, 0x5d, 0x0e, 0x67, 0xae, 0x6b)
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
-- 
2.44.0.278.ge034bb2e1d-goog


