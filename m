Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB55BA7ED
	for <lists+linux-efi@lfdr.de>; Fri, 16 Sep 2022 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiIPIPl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Sep 2022 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiIPIP0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Sep 2022 04:15:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25443ECCF
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 01:15:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z97so30350926ede.8
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=K40d2mrYgHvgluOaXYDh2LpxT57QNOcAFYOkw94EuFE=;
        b=Y2KCz63nhGpVNgSFanDV5uO3/sl/0FuKWe281efsPoUjZiM5kKWgDg8m24+3MT3/up
         u7n4+Q19/YWixtHghMcVmt5Cj824oOF/99k422IgQbdq4Qw8pjF6TPf8MuEAvjB7cUcW
         Fz/AAzld3PvR+pvhvh73pKI7p+Abs4wJbjwernnnh83Nx4PJv29JNf2dumH0Sft9amWM
         zrr25GClfOFuvl/pI/v8Cpzlvuh05QpzpMTXqEaVt7l41MPeO0hZ/46+fgI0Kaa5hXef
         rY0+t9ybF/9NJx12ZrtufnU1qv+ccvbziTsmZkybYpzxXODRddzct8XUeqkyDtW9Qu0k
         o4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=K40d2mrYgHvgluOaXYDh2LpxT57QNOcAFYOkw94EuFE=;
        b=Y1n22OA7MHvMUzy5gkz/af/u4ZKBwbwhkCJdOiLomQI2kRtBikv7lylEdvgYeHnXOq
         hzlo54H1idJWLOvuxtYGAz9L43pJ0nopKCJbQSKlBK2kpVslzkLc913xNU5D4v+wZ+ne
         wLaV/89Sg2BJxxgr5XJkPeOTMYmSIaEpYlOa0trFOTL1yJ5II5lbFSG1Mv405aNzPOrq
         S/7fK0/Vp5kt1Mip0TnW+XXYN3ltIg58eXisC+8jEwhJ9DRcq+IQwlNTFI2zPBJ4g6jb
         wizr8vefRNaN6T1LWPoS5gILJlbW4dI2a19A1CTxef3ufyUgVL0NKEIf2HYQ5l1GVDnV
         hHUQ==
X-Gm-Message-State: ACrzQf18jIVeeyavtlMFxD1MiWq46xWJMhN9TCR3Mk4NaedyFUZedqeg
        2yMHJuQTbiBd3WdpfGxJgfGTnA==
X-Google-Smtp-Source: AMsMyM5Nu4hMbfR292kZnvFQpsvNTWeDstLsxm/4X9iJgJWyqK0tmlnoSU8DgU4dSQ5RF8jMETPPTA==
X-Received: by 2002:a05:6402:3550:b0:451:473a:5ca3 with SMTP id f16-20020a056402355000b00451473a5ca3mr3046477edd.48.1663316114174;
        Fri, 16 Sep 2022 01:15:14 -0700 (PDT)
Received: from hades.. ([46.103.15.185])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090676ca00b0072ed9efc9dfsm10060464ejn.48.2022.09.16.01.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:15:13 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     ardb@kernel.org
Cc:     pjones@redhat.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        jroedel@suse.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Baskov Evgeniy <baskov@ispras.ru>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] efi/libstub: measure EFI LoadOptions
Date:   Fri, 16 Sep 2022 11:14:35 +0300
Message-Id: <20220916081441.1993492-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916081441.1993492-1-ilias.apalodimas@linaro.org>
References: <20220916081441.1993492-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI TCG spec, in §10.2.6 Measuring UEFI Variables and UEFI GPT Data,
is  measuring the entire UEFI_LOAD_OPTION (in PCR5).  As a result boot
variables that point to the same UEFI application but with different
optional data,  will have distinct measurements.

However, PCR5 is used for more than that and there might be a need to use
a PCR with a more limited scope which measures our initramfs and
LoadOptions.

So add a measurement in PCR9 (which we already use for our initrd) and
extend it with the LoadOption measurements

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 21 +++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3ef4867344b9..5b03248527c6 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -370,6 +370,27 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
 	bool in_quote = false;
 	efi_status_t status;
+	static const struct efi_measured_event load_options_tcg2_event = {
+		{
+			sizeof(load_options_tcg2_event) + sizeof("Load Options"),
+			{
+				sizeof(load_options_tcg2_event.event_data.event_header),
+				EFI_TCG2_EVENT_HEADER_VERSION,
+				9,
+				EV_EVENT_TAG,
+			},
+		},
+		{
+			LOAD_OPTIONS_EVENT_TAG_ID,
+			sizeof("Load Options"),
+		},
+		{ "Load Options" },
+	};
+
+	if (options_chars > 0)
+		efi_measure_tagged_event((unsigned long) options,
+					 (unsigned long) options_chars,
+					 &load_options_tcg2_event);
 
 	efi_apply_loadoptions_quirk((const void **)&options, &options_chars);
 	options_chars /= sizeof(*options);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cb7eb5ed9f14..e3605b383964 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -741,6 +741,7 @@ union apple_properties_protocol {
 typedef u32 efi_tcg2_event_log_format;
 
 #define INITRD_EVENT_TAG_ID 0x8F3B22ECU
+#define LOAD_OPTIONS_EVENT_TAG_ID 0x8F3B22EDU
 #define EV_EVENT_TAG 0x00000006U
 #define EFI_TCG2_EVENT_HEADER_VERSION	0x1
 
-- 
2.34.1

