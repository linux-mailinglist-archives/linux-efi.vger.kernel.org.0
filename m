Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFFA49C844
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 12:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbiAZLGe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 06:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240457AbiAZLGd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 06:06:33 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A80C061744
        for <linux-efi@vger.kernel.org>; Wed, 26 Jan 2022 03:06:32 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p125so20862612pga.2
        for <linux-efi@vger.kernel.org>; Wed, 26 Jan 2022 03:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKOxeAFs8Emmc3fhmzQkKbSXzeM4KV2nj8OXlHcTbRc=;
        b=Qs/qsEDDuKtEoofAiibv7eMKY8JF2iTOALoGwBLBm6gTRvPztMZOI/oV09l3bECE8S
         HbbIzy2bkijESpND9yJcLDqsqolSdFiF1hs1ZBPi13J603abakFE0qPy8gNJIHwfvsiK
         SD/GoLAZfU+COhAKph8wK9wbP6JXUfEoYqg+9GHhBnEfjo+0naD1VmUf8xo0BP+mqijJ
         tmpBm+qAg1CJE/n2T1kyoGCVy0K/I6yH3u4s7yxh04kEZRrZp0hgoeNY/7Qz6XS8rPTA
         Et5wcAMS/ZxXwK31nlkDjx6Xh2UnI8nXTuMQSN6xJyrYRCcK7gooOkt/nowwXctIXhZn
         eBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKOxeAFs8Emmc3fhmzQkKbSXzeM4KV2nj8OXlHcTbRc=;
        b=00O5hnmKOSPSjwlDgMfOmDdix4kOL/ZYFJlLNDm9BgkNtYVAokkyIoEOR+8OIFZp6w
         lGF90J1sf7HMen4Uqf5OHG6dTM76qTfZ1sKp7F0XZyBUTh1XZBpeYQ2RemSEMTQbeiLc
         zMoJHb+0bO0JzhQrbWx18+6aydFJ756ERK4+WXO1C7twTBVV6Or/1x8QkvJhqWVtJSN7
         LV9BfWIzQmqlJDv0QUKCx945CwVq/GTkoobX+DtqP3uFRFXXTmNwn3BccmOqfnEh7IqX
         RpLyT0gAYmX9jWeFVv4GB8bwU0G/7Nmb6AWR2POydGZ/q/bXJAyZzJcxpLA3RwyIGjqX
         EuuQ==
X-Gm-Message-State: AOAM530UqP8OdLQSYyYbXV8i1Qpfur52bFOrrHFLjRDmswTEkt6HrVF1
        2riQuL6qdeVOVOTiccAf/JQSew==
X-Google-Smtp-Source: ABdhPJyrozMJzK7uXJz7QXVrc55G1XxvDHKRrhDehcrXchiGbxAxGQWWo8T0lVPkuVswCE/5A1+B5w==
X-Received: by 2002:a05:6a00:cc2:b0:4c9:f07d:6abe with SMTP id b2-20020a056a000cc200b004c9f07d6abemr10317842pfv.17.1643195192179;
        Wed, 26 Jan 2022 03:06:32 -0800 (PST)
Received: from sunil-ThinkPad-T490.dc1.ventanamicro.com ([49.206.3.187])
        by smtp.gmail.com with ESMTPSA id r11sm1811792pff.81.2022.01.26.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:06:31 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Abner Chang <abner.chang@hpe.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH 1/1] riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
Date:   Wed, 26 Jan 2022 16:36:15 +0530
Message-Id: <20220126110615.33371-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126110615.33371-1-sunilvl@ventanamicro.com>
References: <20220126110615.33371-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch adds the support for getting the boot hart ID in
Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/firmware/efi/libstub/efistub.h    | 15 ++++++++++++
 drivers/firmware/efi/libstub/riscv-stub.c | 28 ++++++++++++++++++++---
 include/linux/efi.h                       |  1 +
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index edb77b0621ea..0428f8816942 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -720,6 +720,21 @@ union efi_tcg2_protocol {
 	} mixed_mode;
 };
 
+typedef union riscv_efi_boot_protocol riscv_efi_boot_protocol_t;
+
+union riscv_efi_boot_protocol {
+	struct {
+		u64 revision;
+		efi_status_t (__efiapi *get_boot_hartid)(
+							 riscv_efi_boot_protocol_t *,
+							 size_t *);
+	};
+	struct {
+		u32 revision;
+		u32 get_boot_hartid;
+	} mixed_mode;
+};
+
 typedef union efi_load_file_protocol efi_load_file_protocol_t;
 typedef union efi_load_file_protocol efi_load_file2_protocol_t;
 
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 380e4e251399..c7add4eb5453 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -46,12 +46,34 @@ static u32 get_boot_hartid_from_fdt(void)
 	return fdt32_to_cpu(*prop);
 }
 
+static u32 get_boot_hartid_from_efi(void)
+{
+	efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
+	efi_status_t status;
+	riscv_efi_boot_protocol_t *boot_protocol;
+	size_t boot_hart_id;
+
+	status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
+			     (void **)&boot_protocol);
+	if (status == EFI_SUCCESS) {
+		status = efi_call_proto(boot_protocol,
+					get_boot_hartid, &boot_hart_id);
+		if (status == EFI_SUCCESS) {
+			return (u32)boot_hart_id;
+		}
+	}
+	return U32_MAX;
+}
+
 efi_status_t check_platform_features(void)
 {
-	hartid = get_boot_hartid_from_fdt();
+	hartid = get_boot_hartid_from_efi();
 	if (hartid == U32_MAX) {
-		efi_err("/chosen/boot-hartid missing or invalid!\n");
-		return EFI_UNSUPPORTED;
+		hartid = get_boot_hartid_from_fdt();
+		if (hartid == U32_MAX) {
+			efi_err("/chosen/boot-hartid missing or invalid!\n");
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

