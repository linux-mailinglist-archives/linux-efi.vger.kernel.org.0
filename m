Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2C3A7A5A
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jun 2021 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFOJXQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Jun 2021 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhFOJXQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Jun 2021 05:23:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111DDC061574
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a11so17483062wrt.13
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JM6tzI8U43hdDrmMeAqAWUx/ZtfoircetzM39x0T+Qo=;
        b=JEgNgp2mpvlz9jc2z2cTxpQJ/Lg1JaeXRI6HLKc2o8lfHFAR/NSiIRlyUipj1Y0Hu+
         zWoA5n14+90mV43Gx77sMQSX5Bu0ZQbxTUa1icKj0Ebm/B8wOiXTpRP/T3BlF9npxXPn
         QzP/6UH4wjBKwJYZmR00AirYJqyeM+bxv3Z5RfgjEcdNKSd2PEeKbXl/TZKbxwT1o6aD
         I1/htrFdauzs85pLsb83mBePR2Ii9fBPUcU0OfS7vyOVaovzVeqovs08iIlawkdXqykQ
         hl6xIP2GLfCVIORxsYvlqv7QhERZUgkgydHlGYrT5FDFH5ayMbGIMdX+GBLRKVjyhz/6
         /llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JM6tzI8U43hdDrmMeAqAWUx/ZtfoircetzM39x0T+Qo=;
        b=dHJ/lf/Tbf03uNTsXDQKKfVI7T1SORTSOy2D93fRnNZ8YC+S0dDxyvl0LkuTVlkTsy
         LPKbkMgc0uOlwAoyX3pwMX7FLsQhK4pQbXG2Z8DYgGg2K/+tSd8lw7qamvjFI0qKg1fA
         fUYdyGBNRcsXVLTKL7y89DMiUnG7GOT1mkaLhDLhb3bD7/c6LyIqEc+4jV8dfwMyR8ix
         7B5zRzYwY4M2IVmrLPxbXsZPmMspuFflaSdgfIEuaeszx7hzKDBI/tu0NBzyHcWx91gj
         EhAY7nxv/3HEdBt2NuILN+7ivbi1tt588as4k6DrX+aULPXaPiwYfqi+sFtM0E0GTaI+
         haOg==
X-Gm-Message-State: AOAM5320ST0+FrZ2xnq7LaPdzpsv/hXO39yQyPPRoWTVQa0fmbD2mEny
        /EKwHb+DREQQ26Gk01bCI+uzZbZOAtABEA==
X-Google-Smtp-Source: ABdhPJwMOiIxpUOqcmAQBbHXr5MBpqHep0FJPbZ0YT7QaxXmXbE3DIaZ4/iAW9NEHRDyYKo9WgTmpg==
X-Received: by 2002:adf:de91:: with SMTP id w17mr24341724wrl.352.1623748870693;
        Tue, 15 Jun 2021 02:21:10 -0700 (PDT)
Received: from apalos.home ([2a02:587:4680:7ec2:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id h15sm18280113wrq.88.2021.06.15.02.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:21:10 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/4] efi/libstub: add prototype of efi_tcg2_protocol::hash_log_extend_event()
Date:   Tue, 15 Jun 2021 12:21:02 +0300
Message-Id: <20210615092105.288331-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615092105.288331-1-ilias.apalodimas@linaro.org>
References: <20210615092105.288331-1-ilias.apalodimas@linaro.org>
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

