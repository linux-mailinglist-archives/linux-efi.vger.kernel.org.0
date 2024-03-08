Return-Path: <linux-efi+bounces-780-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 955BF876074
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C61F25456
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B37D524AD;
	Fri,  8 Mar 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNoKYZi0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE82CA78
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888299; cv=none; b=aeKF96qHsbCQrc4sI2JSC1YIErjUZ7TK5nnuJ7MtvnN2RNHX4L/zTAcdmQR68/DqZogYBYeHUp+QBR01hkPq3Dvpqo/3oWQiYlQaWFXrbzj+yKtKr2XT+inm+aGOwtT8KIIMVwAQvTW0moMWNiuQ7/VkaKo4elJXrn9n7MUwbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888299; c=relaxed/simple;
	bh=ZcucMX5mq2a6BwH0D/cusrLTxDOdKxlLW7MGJi8VLE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UTAgRKiO7312FjB/a1NJN0X/d+hb//fhxMJwMP3rDlX38pDzzZFsDp5tCN7g9jvdDrOzAj8h0D6rr0sb1+dcMLCY20xApV4gozRBWprzEZtb72m46omRjZMOPXWHbX2KnRcsmIHrk0HZ8vgDMo+92YuIIlv4DO5YKYdsuJQIH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNoKYZi0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609ff5727f9so13195597b3.0
        for <linux-efi@vger.kernel.org>; Fri, 08 Mar 2024 00:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709888297; x=1710493097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hibYjnoTAQJKGkpG55AdXZoClPOELJdGWiFJyJon9Bc=;
        b=jNoKYZi0mnwN7UpHUfs8mXVyQNKB0c5cpSs1fX1mzx1JEDkQG0gkl//KDRhT1m0aXg
         mSLR6oG+5O4Lrf3SoGKMZRpKdsWGUMyWWzv/tW1QwFYhbXzLyLBlP5j036YPJUhEQYPO
         zbkdBbzj1aVavKa8RgvZfNNzCCF6EFJOW+O/dTCaaRisQmaLuyKoenPM/emvwDlUCcco
         dv/8z2WKSSCOiJ2NHSJbcnylX3SLuEpglyyYLD589OaIk0bRAE6/LFnQSE/MNHc4+2HE
         x7QalGPFGyp0j/ce4s6nQP4pgv2T/H3uzmeQXNcZKuEIO60DG3bXlt4I7QlrpBcIo8RL
         sVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888297; x=1710493097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hibYjnoTAQJKGkpG55AdXZoClPOELJdGWiFJyJon9Bc=;
        b=uxTc34wHh4H+ODb9Y4+f6umi/98FGN9STbestYrkjoPq5Ms62b3iiV3JlN7gUTyIcY
         ZVBA9FuqYH3NL1hWvQTl+A4mYjZ3ObxGH8aYJg/jXVdsKx7IzX+Xf08EATcvX24sWIiu
         oCXH0KQjDN328e3MRc2lDZz8vFlr21A1tJWjFI21k9/qM+yEp2SeN5Cu9Hr2TlZL9hey
         YRH8D0dr03KYYs7YlmsIo/F57FLd8F+GfAxLGpRM93LyMNrRlxtZe7A63VcjYtzfe+x6
         Dzfayvkwypq/wADPm6Df4WiPbbUk5oraiTzu0ri+vOjRMVV5VI2+tvRrxCxru7WS9hZ6
         9oXw==
X-Gm-Message-State: AOJu0Yy8OCA3pxTkw4BVAWqvFZnCR+NPt4NcAeIiaSVOCof89XFsnoIF
	LQBd5AsAfUq/1xrc3pSWQapaWaZjVmgPwzQg91Ss4eBLzsql6+U3TENT+MzuK87VSwxCyUhPdn+
	0ayEr7OVhFT4I7konfcMrRtWYP5E3zQVXW/5OEiER4PKMBdpWdtsOrT+BFXbXF0gmv/P71V9lVG
	pYQilSLPv19E+mROf+YEvPkDwDCg==
X-Google-Smtp-Source: AGHT+IFSpPUVDHYYrRWfbGe1qEKv/sD1EPkEAUVifru3htIcgLc87Y6H0g+a/irQq3LPRJOpY6QLN908
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:49c8:0:b0:609:3a77:176d with SMTP id
 w191-20020a8149c8000000b006093a77176dmr848240ywa.0.1709888296702; Fri, 08 Mar
 2024 00:58:16 -0800 (PST)
Date: Fri,  8 Mar 2024 09:57:57 +0100
In-Reply-To: <20240308085754.476197-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4350; i=ardb@kernel.org;
 h=from:subject; bh=mvU60GL5Usdocug8kxtz1ucuM+i40QO6xkfjpRWgXd4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXVZdE7q+saFDp8PZ9a3hB8vuczy4pckwp+ifqjSRoRa
 +b0/dfoKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPZdpnhr7CLdIt6b1HdNua2
 B6/na6Rsyrl50WClYqbvjIkcRqLPfBj+e7xhaXJmc2T+tHRXge827Q0qN5f+qXFMc3p24fVSp/M bOAA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308085754.476197-9-ardb+git@google.com>
Subject: [PATCH v3 2/5] efi/tpm: Use symbolic GUID name from spec for final
 events table
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The LINUX_EFI_ GUID identifiers are only intended to be used to refer to
GUIDs that are part of the Linux implementation, and are not considered
external ABI. (Famous last words).

GUIDs that already have a symbolic name in the spec should use that
name, to avoid confusion between firmware components. So use the
official name EFI_TCG2_FINAL_EVENTS_TABLE_GUID for the TCG2 'final
events' configuration table.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c         | 2 +-
 drivers/firmware/efi/libstub/tpm.c | 2 +-
 include/linux/efi.h                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4fcda50acfa4..f6cfd29308d9 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -597,7 +597,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID,	&efi_mem_attr_table,	"MEMATTR"	},
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID,	&efi_rng_seed,		"RNG"		},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID,		&efi.tpm_log,		"TPMEventLog"	},
-	{LINUX_EFI_TPM_FINAL_LOG_GUID,		&efi.tpm_final_log,	"TPMFinalLog"	},
+	{EFI_TCG2_FINAL_EVENTS_TABLE_GUID,	&efi.tpm_final_log,	"TPMFinalLog"	},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID,	&mem_reserve,		"MEMRESERVE"	},
 	{LINUX_EFI_INITRD_MEDIA_GUID,		&initrd,		"INITRD"	},
 	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 7acbac16eae0..a880f7374c27 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -128,7 +128,7 @@ void efi_retrieve_tpm2_eventlog(void)
 	 * final events structure, and if so how much space they take up
 	 */
 	if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
-		final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
+		final_events_table = get_efi_config_table(EFI_TCG2_FINAL_EVENTS_TABLE_GUID);
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;
 		int offset;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c74f47711f0b..464fe16411b8 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -386,6 +386,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
 #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
+#define EFI_TCG2_FINAL_EVENTS_TABLE_GUID	EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
@@ -411,7 +412,6 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
-#define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
-- 
2.44.0.278.ge034bb2e1d-goog


