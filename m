Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756383FEA5C
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 10:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhIBIFg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 04:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbhIBIFg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 04:05:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0426EC061757
        for <linux-efi@vger.kernel.org>; Thu,  2 Sep 2021 01:04:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i21so2357082ejd.2
        for <linux-efi@vger.kernel.org>; Thu, 02 Sep 2021 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VNuAISIZnNWFu8kZfhm0wKZ7ixf3CUgGFSLF/VYbEXQ=;
        b=Bn1xQ7JnxXGGQ5nNAQeS+bhlAvGy4WRICjoAQHYNwEJX9ClOahWYz4pNSZHbOoJNUn
         ltwdw8Ot9RrTkLC/Kzp2JI+J1yVdKRv/wiHTeuHo1ZnyR5G+BrO4odtjvLYNLBj8O+pr
         OFYAB1fMpk3FP8Y/AGPrSQVAXQTuJ+qOY/MKmZ+8pmv8pcSOKd75qeQfYmTvYWboVbrE
         aVWIkgViBRgqPFphn5QhrbMDgG3XlKM2lZsdtMCXNBJiMPnt9HzZPVDV3LaW5MeMCPpA
         t3rei/nObGCcf4Le/nufMknubT3BmN5n5ljoc1vHcTxqY9gkdV1tExWDMO1xye8SIoFa
         cy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNuAISIZnNWFu8kZfhm0wKZ7ixf3CUgGFSLF/VYbEXQ=;
        b=iUkcOOEpM+IAXuYrcF3UxJ14zkQO7FV6yvTlXHH5GCHUvxJM8vr0QF8CPvYevwrKac
         uPkabm0YEUARxXq1TvmWjQ2hj4DrbcHiSWFIe315fFJzct5XsaVix/4AtiGVXZJ+UuN1
         i05uMKRHbJtXCF1SiE3Lt05mT8nWz2/JjfJWP1Et7AjSzdDr96b8zh0kH//ixsi0cwZD
         z5hilh2xq57fkDmliyo88VFf0uey/cGd/0cA2zdsPIQBwvpim+E266qdrOp0FDqw1bdQ
         iqb+cD5gcYjBJpyLcBNR964YAbgTAEr8WXNo0sKFuSj0JrocuDHhyrxVMpwZdHytnsNf
         Adcg==
X-Gm-Message-State: AOAM532ouo2oswpMRDvWcJXP+pVpXVNeSlye2jake6704SueoJN1rnuS
        HoCOyqKH1ZI3Y5yObmsKVC3QTKClDCBbHw==
X-Google-Smtp-Source: ABdhPJzJ1o3jMT7VXy7jjXm8vSkPRaSPAwJF1ufoMThLy+jlIaSdV31efMFG+KNWnSk/c4zsFbfgZA==
X-Received: by 2002:a17:906:265a:: with SMTP id i26mr2470405ejc.522.1630569876556;
        Thu, 02 Sep 2021 01:04:36 -0700 (PDT)
Received: from localhost.localdomain (ppp-94-66-220-137.home.otenet.gr. [94.66.220.137])
        by smtp.gmail.com with ESMTPSA id m12sm537105ejd.21.2021.09.02.01.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:04:36 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org, ardb@kernel.org,
        James.Bottomley@hansenpartnership.com
Cc:     pjones@redhat.com, nivedita@alum.mit.edu, mjg59@google.com,
        daniel.kiper@oracle.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/4 v2] efi/libstub: add prototype of efi_tcg2_protocol::hash_log_extend_event()
Date:   Thu,  2 Sep 2021 11:04:13 +0300
Message-Id: <20210902080416.5461-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210902080416.5461-1-ilias.apalodimas@linaro.org>
References: <20210902080416.5461-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Define the right prototype for efi_tcg2_protocol::hash_log_extend_event()
and add the required structs so we can start using it to measure the initrd
into the TPM if it was loaded by the EFI stub itself.

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
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
2.32.0.rc0

