Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737AA52CB6F
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 07:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiESFPa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 01:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiESFP2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 01:15:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831C994E4
        for <linux-efi@vger.kernel.org>; Wed, 18 May 2022 22:15:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id a19so4063731pgw.6
        for <linux-efi@vger.kernel.org>; Wed, 18 May 2022 22:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8kBvwTpuQCpGlgQz4UivyYiv6vdmLNO0fD/1W/RRFw=;
        b=DmBnZP61PAdCkSbyxB6731F3+Vdn1dSA9Sp5nkK8wvdhIt8HWTOjm5x4Mjcl+DwJRJ
         6qi4/MNdtmICF7v441vBd+kfgY1hSqD6BcYMh4Wt6Ut73OGvDCbVGkMB/mqvV4IX9Z8P
         wHF8IH5QKPm3PjOgrKZDDnAVMkVns3cbPcpdFCA026fMVycwV6LbahiaFXX2Sf02a5J9
         cUPTNdGE1R4RDnsQ2Q4GfiUhtCY0/To4feEeTpbb7FMKGrnK8CcZxKDUWJzN2mIBu4/X
         U8UxfTlBEMuDYi2y0aWMohyNvzuHuhRFR4bpey+egKHnyERcewpdIouqxrVpfPb0hlPj
         eNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8kBvwTpuQCpGlgQz4UivyYiv6vdmLNO0fD/1W/RRFw=;
        b=Elg3t5qPilENGku2AmzPiX5/zaIhgYdjiZxzgiohRcTq9g+GjVG93u+t9iL3dAjCRC
         Ix0ImeeSh1a5PXBjkPN5sWZ9vjTE93lNyJx9xljmIsuxh2uW5VcMOMefoeG6Wd68FRVL
         aJKL6Qze5Sv6+53FZPi+039AHNc1jVAnC8vJJOSzOmudUQc3keQshPAMK5nMMiwAOodj
         /ReS6eIqlomAC25XThXyzryA4BW+BPzQWAcpIY3oV8ByMUymvwjHt4phS2FMPLE1O/tG
         bMl6l2OhaH1rUqdtm3gfmQTtRNlvEc1OCzwnVFB+02/7b6QvPjuB1vo7klWxskTCScKy
         LwIw==
X-Gm-Message-State: AOAM531SUtgfA3/dRV+BoG5Q0sXIdLfpWgLibc/wl4+4aqEIOmAM01cj
        wdldOGnPxHfXAViFWIPKP9OPuA==
X-Google-Smtp-Source: ABdhPJzkBOnhHrE+4Bc35bpaxBRCk3/P09SRAJ9yBIozW4mar/09Moqazi4KrJGhMgoyYrxap1WNqQ==
X-Received: by 2002:a63:fb02:0:b0:3c1:9513:2e11 with SMTP id o2-20020a63fb02000000b003c195132e11mr2558308pgh.258.1652937326393;
        Wed, 18 May 2022 22:15:26 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.10.235])
        by smtp.gmail.com with ESMTPSA id j19-20020a056a00235300b0050dc76281a3sm2929007pfj.125.2022.05.18.22.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 22:15:26 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Abner Chang <abner.chang@hpe.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sunil V L <sunil.vl@gmail.com>
Subject: [PATCH V5 1/1] riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
Date:   Thu, 19 May 2022 10:45:12 +0530
Message-Id: <20220519051512.136724-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519051512.136724-1-sunilvl@ventanamicro.com>
References: <20220519051512.136724-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch adds the support for getting the boot hart ID in
Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL. This protocol
is preferred method over existing DT based solution since it
works irrespective of DT or ACPI.

The specification of the protocol is hosted at:
https://github.com/riscv-non-isa/riscv-uefi

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/firmware/efi/libstub/efistub.h    |  7 +++++
 drivers/firmware/efi/libstub/riscv-stub.c | 31 ++++++++++++++++++-----
 include/linux/efi.h                       |  1 +
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index edb77b0621ea..87aa66e8ef43 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -720,6 +720,13 @@ union efi_tcg2_protocol {
 	} mixed_mode;
 };
 
+struct riscv_efi_boot_protocol {
+	u64 revision;
+
+	efi_status_t (__efiapi * get_boot_hartid)(struct riscv_efi_boot_protocol *this,
+						  unsigned long *boot_hartid);
+};
+
 typedef union efi_load_file_protocol efi_load_file_protocol_t;
 typedef union efi_load_file_protocol efi_load_file2_protocol_t;
 
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 9c460843442f..10c59295f379 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -21,9 +21,9 @@
 #define MIN_KIMG_ALIGN		SZ_4M
 #endif
 
-typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
+typedef void __noreturn (*jump_kernel_func)(unsigned long, unsigned long);
 
-static u32 hartid;
+static unsigned long hartid;
 
 static int get_boot_hartid_from_fdt(void)
 {
@@ -47,14 +47,33 @@ static int get_boot_hartid_from_fdt(void)
 	return 0;
 }
 
+static efi_status_t get_boot_hartid_from_efi(void)
+{
+	efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
+	efi_status_t status;
+	struct riscv_efi_boot_protocol *boot_protocol;
+
+	status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
+			     (void **)&boot_protocol);
+	if (status == EFI_SUCCESS) {
+		status = efi_call_proto(boot_protocol,
+					get_boot_hartid, &hartid);
+	}
+	return status;
+}
+
 efi_status_t check_platform_features(void)
 {
 	int ret;
+	efi_status_t status;
 
-	ret = get_boot_hartid_from_fdt();
-	if (ret) {
-		efi_err("/chosen/boot-hartid missing or invalid!\n");
-		return EFI_UNSUPPORTED;
+	status = get_boot_hartid_from_efi();
+	if (status != EFI_SUCCESS) {
+		ret = get_boot_hartid_from_fdt();
+		if (ret) {
+			efi_err("Failed to get boot hartid!\n");
+			return EFI_UNSUPPORTED;
+		}
 	}
 	return EFI_SUCCESS;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..9822c730207c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -380,6 +380,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
 #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
+#define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
-- 
2.25.1

