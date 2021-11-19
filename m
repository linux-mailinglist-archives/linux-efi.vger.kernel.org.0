Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0038B456E71
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 12:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhKSLvH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Nov 2021 06:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSLvH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Nov 2021 06:51:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91EFC061574
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:05 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r8so17653970wra.7
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBpcZaFhz4p6OdqDxzcgAE37Gskr5/xHfO3KYMeY7Y4=;
        b=ctApfwYeYAPY4vALr8d/IVqUOt0XguArk6Of2QK9RXZ9FYSG5bZYN9unmjb1kJ4a/r
         BSLR0hd8rXaDTKE9qjApU5a2W66xQeu4lcgpFNNoppfhyeGUbTzmdfw5VdhYXNRoUpt/
         I66DVG7eulE5wsoQSYD+XsU6sulUFGn1qYCrss80wcH3rW9zs/0zhhIBvKTYgeSsCGVT
         jyPGSap1x0HDPi7o4rPvSPx4vx1nrDlcFjJVnJ9bj0G5/0sIApla0KKFdSrJLcOeEaEd
         H1ZWm8LvojcZW7K3WkHqUrmO3FYF6e/OSEWWZ04EQlPhldoZ9KV0QfgZFL4Qdn2eV+Dd
         EIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBpcZaFhz4p6OdqDxzcgAE37Gskr5/xHfO3KYMeY7Y4=;
        b=zgGhOZaCt/fNP/kZjb9rcNxpt1stSzdu7CRVNqwPr1n8CXAQqwKfLymshkyy4fyZ37
         g4NZWgNECmaxuLnaEJ+EA8Nyz9zGlgk1/Fa7CCrvL4jOHjGVHDqpGLiSIRoY4AmJ77z/
         XlZokT29me8q4irw5nEMXcYvGmRUskvA2C0vLlbJ6gh+kL5gVod/bAHzvvPSqmfoQ1H2
         MLq77rP3uiN2RPuQtbf+s8gGMbiOIyCOmwl4y+iWDmt/z+Vc5fLfRjipPAZO9Aqgb8Tj
         X681aMGz0A447QlLC1LneWNLdAswl/xjjOV4+sdzRQn/XbOLZnl5fzRHgfBVf/gQrfs+
         IwiA==
X-Gm-Message-State: AOAM53111Guuhmdx3gM7JB9kCCPcrIQk/dY2pkOG7Hw4glrlzb0WHC7f
        D7BDFqk9McRT8V8S4SphDsNFLapuOoqr1A==
X-Google-Smtp-Source: ABdhPJzumenuqpyMcUAxEGwXwiGMbXePmzzTRrVpLlsDf8XAXcB/GiqQ/R4V+PKEcd+mqJSNnxd6Pw==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr6652879wrj.338.1637322484409;
        Fri, 19 Nov 2021 03:48:04 -0800 (PST)
Received: from apalos.home ([2a02:587:4627:18c0:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id c4sm2688039wrr.37.2021.11.19.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:48:03 -0800 (PST)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        jroedel@suse.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/4 v3] efi/libstub: add prototype of efi_tcg2_protocol::hash_log_extend_event()
Date:   Fri, 19 Nov 2021 13:47:42 +0200
Message-Id: <20211119114745.1560453-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
References: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Define the right prototype for efi_tcg2_protocol::hash_log_extend_event()
and add the required structs so we can start using it to measure the initrd
into the TPM if it was loaded by the EFI stub itself.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1,2:
- None
Changes since Ard's RFC:
- Added event_tag related definitions
- added a missing __packed on efi_tcg2_event
 arch/x86/include/asm/efi.h             |  4 ++++
 drivers/firmware/efi/libstub/efistub.h | 29 +++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 4d0b126835b8..85f156f8ef81 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -308,6 +308,10 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_query_mode(gop, mode, size, info)		\
 	((gop), (mode), efi64_zero_upper(size), efi64_zero_upper(info))
 
+/* TCG2 protocol */
+#define __efi64_argmap_hash_log_extend_event(prot, fl, addr, size, ev)	\
+	((prot), (fl), 0ULL, (u64)(addr), 0ULL, (u64)(size), 0ULL, ev)
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cde0a2ef507d..a2825c435158 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -667,6 +667,29 @@ union apple_properties_protocol {
 
 typedef u32 efi_tcg2_event_log_format;
 
+#define INITRD_EVENT_TAG_ID 0x8F3B22ECU
+#define EV_EVENT_TAG 0x00000006U
+#define EFI_TCG2_EVENT_HEADER_VERSION	0x1
+
+struct efi_tcg2_event {
+	u32		event_size;
+	struct {
+		u32	header_size;
+		u16	header_version;
+		u32	pcr_index;
+		u32	event_type;
+	} __packed event_header;
+	/* u8[] event follows here */
+} __packed;
+
+struct efi_tcg2_tagged_event {
+	u32 tagged_event_id;
+	u32 tagged_event_data_size;
+	/* u8  tagged event data follows here */
+} __packed;
+
+typedef struct efi_tcg2_event efi_tcg2_event_t;
+typedef struct efi_tcg2_tagged_event efi_tcg2_tagged_event_t;
 typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
 
 union efi_tcg2_protocol {
@@ -677,7 +700,11 @@ union efi_tcg2_protocol {
 						       efi_physical_addr_t *,
 						       efi_physical_addr_t *,
 						       efi_bool_t *);
-		void *hash_log_extend_event;
+		efi_status_t (__efiapi *hash_log_extend_event)(efi_tcg2_protocol_t *,
+							       u64,
+							       efi_physical_addr_t,
+							       u64,
+							       const efi_tcg2_event_t *);
 		void *submit_command;
 		void *get_active_pcr_banks;
 		void *set_active_pcr_banks;
-- 
2.33.1

