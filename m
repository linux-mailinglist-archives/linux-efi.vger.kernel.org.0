Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F6D2697C5
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgINVfj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 17:35:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41049 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINVfi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 17:35:38 -0400
Received: by mail-qk1-f196.google.com with SMTP id g72so1950374qke.8
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 14:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdIrGiI764DtooJhQK5mC4q6ZjKL5upO2Y8OscSPMzg=;
        b=F2wQ1YVM/3B1P8JRSVNIWmhP9Bj1msjwCXM2MJ7zIRus8er2CX29dhXRlPAAMQKHVj
         bJKrUeeURDiWYC0/cVEs5tmISgU9DX+zd0nNatRlNfrbsDGjyv8s64L0rMxrxVax5J5K
         aLXReBnLLIUK8CiEcXQzq8+uNQsVaOU7qD75vd+nyVMerFlAyQcjqqBdXBnK19DYU55T
         5qOkAnT9OQPnbmaprMnEUSMcuLsnm2hJmA/QrG3aZaRf+toOfzxZvKZcfHHuzB/9IfSo
         YrDz+0iyrUabdhBD+xfa0FAM4kuXIrsuIaa7dteUuNIPPiWSlcn0B+CdT3ozv6CPGz2i
         Tb8w==
X-Gm-Message-State: AOAM531cf0vz1nJ+xeHfwx8mnwLzO6Ggn1CttCEBeOFGcWVzJGWe7+sA
        jSMTXE3hv2iDw6Ui37oQ3V0=
X-Google-Smtp-Source: ABdhPJzkLyWoRfQX+wyDvITYQxaV0e9V0Vxbth5WtYiLPG+py5yQxuWfl4g9zORuFqfNEcrC8omZvg==
X-Received: by 2002:ae9:ec14:: with SMTP id h20mr14741371qkg.25.1600119337146;
        Mon, 14 Sep 2020 14:35:37 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g203sm15766260qkb.51.2020.09.14.14.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:35:36 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Jacobo Pantoja <jacobopantoja@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [PATCH 1/2] efi/libstub: Add efi_warn and *_once logging helpers
Date:   Mon, 14 Sep 2020 17:35:34 -0400
Message-Id: <20200914213535.933454-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add an efi_warn logging helper for warnings, and implement an analog of
printk_once for once-only logging.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efistub.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 85050f5a1b28..e33b9395bc23 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -55,11 +55,34 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 #define efi_info(fmt, ...) \
 	efi_printk(KERN_INFO fmt, ##__VA_ARGS__)
+#define efi_warn(fmt, ...) \
+	efi_printk(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
 #define efi_err(fmt, ...) \
 	efi_printk(KERN_ERR "ERROR: " fmt, ##__VA_ARGS__)
 #define efi_debug(fmt, ...) \
 	efi_printk(KERN_DEBUG "DEBUG: " fmt, ##__VA_ARGS__)
 
+#define efi_printk_once(fmt, ...) 		\
+({						\
+	static bool __print_once;		\
+	bool __ret_print_once = !__print_once;	\
+						\
+	if (!__print_once) {			\
+		__print_once = true;		\
+		efi_printk(fmt, ##__VA_ARGS__);	\
+	}					\
+	__ret_print_once;			\
+})
+
+#define efi_info_once(fmt, ...) \
+	efi_printk_once(KERN_INFO fmt, ##__VA_ARGS__)
+#define efi_warn_once(fmt, ...) \
+	efi_printk_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
+#define efi_err_once(fmt, ...) \
+	efi_printk_once(KERN_ERR "ERROR: " fmt, ##__VA_ARGS__)
+#define efi_debug_once(fmt, ...) \
+	efi_printk_once(KERN_DEBUG "DEBUG: " fmt, ##__VA_ARGS__)
+
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
 #define fdt_setprop_inplace_var(fdt, node_offset, name, var) \
-- 
2.26.2

