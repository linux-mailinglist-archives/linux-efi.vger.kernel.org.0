Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AD37767B
	for <lists+linux-efi@lfdr.de>; Sun,  9 May 2021 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhEILqM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 May 2021 07:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhEILqL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 9 May 2021 07:46:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1043C061574
        for <linux-efi@vger.kernel.org>; Sun,  9 May 2021 04:45:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o127so7604721wmo.4
        for <linux-efi@vger.kernel.org>; Sun, 09 May 2021 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JM6tzI8U43hdDrmMeAqAWUx/ZtfoircetzM39x0T+Qo=;
        b=qNlILJi9qtznNp58d1C9Yi3Qrf2oTMG/j3cbuOTcAfBlasYf8y5w5lVGH1LcEfa7Ig
         xxWl9fq2CxE420DFEBsPsb52o4ZTE+9spEj20rc9ee9W61lEC99IK8J83WV2tSKpjyn5
         zIkR0eRPPP8bzb8WHVPmQ7l7j2Qve0hlOvWNpdEfKmVa1b9LMifV+8mWhoWFHTL0g1hx
         yySsPKoRZyPTPubpbQ6BqHtPFKRryENFQEDTv6630a9N+7ELN17xfslLD68q9aj3NgT1
         4/zhPY5iJh9HuuTHy7T2u+219GNHPU73NnXvc/iErXFuPnqBv9dl9yPBgZHcpluquWUY
         aIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JM6tzI8U43hdDrmMeAqAWUx/ZtfoircetzM39x0T+Qo=;
        b=esnig6Fbaj/eMzgdqrSus370JQOAxYNlMxoPld3dq707Ng1vpcpI5tP1JiNgOLX/ne
         Nms1azWGkg/F18rqeZ1cVPAOO5EOkHzHxv2vT399XOtZjvLWBcOQbhIEQX9TgVbtJBUi
         Sct0uQFHzYwxJZ1RiaNP/qh98GAXU4BfNRSom4+RdlplYFIi0wdJJCZzRHdTL3POM2gI
         uX9bpgYngU115O2Tkf1QRMM+dfJt8iLJLrTuCyx7nuF7UNXErvYBP8CAcUSss9UgA0KF
         YR2fR+G11QU9fJoJTuYR5Rf9nsu9Pt57vgR7aksvk6eUFam5Bx81Kv11x2hRHLFLMZ9Q
         OvEQ==
X-Gm-Message-State: AOAM5334gACMdgNjKN2ZfohtuSEGC/zD9CCwh6qac1hhCOZ5V4E8kTro
        e9EZEGSn906VLzJsSDiUozxHUTVGbTBgUg==
X-Google-Smtp-Source: ABdhPJyFKdjLQeXkDxpdfeDM2C9sBq7Mx2ncUZqrD28zIdmjHRSiOz9xld9sB624oCY4RVnRPTIOAQ==
X-Received: by 2002:a1c:e409:: with SMTP id b9mr32165742wmh.189.1620560706479;
        Sun, 09 May 2021 04:45:06 -0700 (PDT)
Received: from apalos.home ([2a02:587:466e:1389:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id c8sm17650244wrx.4.2021.05.09.04.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 04:45:06 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 1/4] efi/libstub: add prototype of efi_tcg2_protocol::hash_log_extend_event()
Date:   Sun,  9 May 2021 14:44:51 +0300
Message-Id: <20210509114454.185583-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210509114454.185583-1-ilias.apalodimas@linaro.org>
References: <20210509114454.185583-1-ilias.apalodimas@linaro.org>
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
2.31.0

