Return-Path: <linux-efi+bounces-767-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E307B87541F
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 17:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4B9283C39
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4AC12BF3B;
	Thu,  7 Mar 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEINTs66"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186651EB40
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828554; cv=none; b=mCxwYkmCswkdsRO/7p7RU02FVz7yWP/thrQ8lvLh4PZ3Inaa/O9QjJjmD/izq/F7ENvsN0GGqiB58Kwx+Xg3Ibgj/8ycihIwXpLaq4IdouAH941n45RFHoF/dXTdfvm4F7pvcgnKKAOYT+5PDnetgOVuiYvQ+T0KMvbm5EFzh4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828554; c=relaxed/simple;
	bh=nRs7smSFu9gNMmmv6GR83kKT/YuFKakEuv80+1ggkYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iouat1XEpf6tzdSAhH/4ic0LPMnziB25MqJlUQW+joiF8hRHOs/O5mJba6M3YbXvZe28JGCqCpx+bLX10y2MKarPEyyS7JOLLM11StrY0IE3UkWkh72wMsdHq5oTlOq1KCoIUizZTLCkOEXZ2nrKkV93tQv8vJsXSO3lBWlFq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEINTs66; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-412dcaf0bd6so5254615e9.0
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709828550; x=1710433350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YcGpQbIMa731PfgfQ8GqyBdWvH8ozo+871W27IhQ7R8=;
        b=jEINTs662EYmqZPCN08KQPf6ugrYpD6yYIebYg5ixhuuA5kE5R8lXlpTzmz7ER/CoX
         o4VIaKJzb7vnPc5KPaHzbG0yh0rCiVt34WKLz/1xa/s472rsXbFiUTW1reyuwtuXLmQC
         168GIMCVmMZ5gPoUKHNAlc0hdBjwIRFzKRrXQmrPNoQFokcfodhOvfz6qSS59SbIUJH8
         PPaGeYjpTESWP3pChTpIyx7QyK16IY+g5tflRx9r9xOJSyE8SwAhpy1sB47MIC6YbpVn
         3b0EYWx7oX7KiG3ZFxtl8pm/IgzGpT7TAHC9gHe8MogG/sLeJABRrFPSCz1/i6DtiGN5
         YzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828550; x=1710433350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcGpQbIMa731PfgfQ8GqyBdWvH8ozo+871W27IhQ7R8=;
        b=cjXJlUNvGiTns1FyG9yZMGQVVl0FvM06kHSq/GR2H5LVGQlT0Ko+OS2CbbQCLCaNmH
         ake10kPZf5odXQvtDFkpZDfrQ0p/i57SonwxJNLQoD0p1/Fa6r2ELb2NgG7Std+56LGG
         fejf3KR3JeXFBGVagtSsMQpaxB4JRJJXZj9Df/QkNixOcyndgkCgHgiTQAhFaJT5ttFN
         4UpUjr3BPVDrceF8HJe8uTxk7x9zFaIq5aNYU0PV+p3WFGLMUwfAockN59pafQ6Oksu1
         d2fnHOi18CraMeVUdD9PLoNmE4U3mm3BdmMO4fTXuE1xOpW71KED5rOCXJHfoL9AMXLu
         d6Hw==
X-Gm-Message-State: AOJu0YxkVez9ZvemU3eVdfZtRGFYIzuJ/kR65k0wkAjWhrfmWH06mS44
	9GPeo4N+bmO5+tdt8M2aEmTl0i0cQ9iSEIbWowjGK8GXn85WPc6RsnLEnDp/NFEudkilKEz0NiG
	oZhfh05RHN3TTdIUSK8RvHXtDFQkdyXGaQosnWPPnYgAaoyJlqsZaTr+DU0HUg+Roz4oVKqlScL
	TAtpR1dLI4vlZ94dKcFSjim9JSPg==
X-Google-Smtp-Source: AGHT+IEYsQtP5jByJdNtIQoLE4rWxh3m2YZgLVdBL0tKXgx7k3IlXVDr7Sfd232aLxZI1ClBXsvJIXLl
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:9d8f:0:b0:33e:7380:df3b with SMTP id
 p15-20020adf9d8f000000b0033e7380df3bmr807wre.10.1709828549913; Thu, 07 Mar
 2024 08:22:29 -0800 (PST)
Date: Thu,  7 Mar 2024 17:22:17 +0100
In-Reply-To: <20240307162214.272314-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307162214.272314-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4203; i=ardb@kernel.org;
 h=from:subject; bh=AiCD+AShD+1g23OfVNA41j0MFtZc6w00dmlkIIJ6T0E=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXly11cC6cEeBTO2v7g0l0ZkxOv9W6I2j1earIntufpt
 Ecrn7lJd5SyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJfM5j+Kf7JuDjhLd+v99H
 +T/NcnqgtCeHueN85Nkzwd57Dh4qe1fH8D/88m37yqM7K3hnrW6In7aw49XRi/lbX6qaSXsnMWn H7GYGAA==
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307162214.272314-9-ardb+git@google.com>
Subject: [PATCH v2 2/5] efi/tpm: Use symbolic GUID name from spec for final
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


