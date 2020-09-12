Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65B5267BAD
	for <lists+linux-efi@lfdr.de>; Sat, 12 Sep 2020 19:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgILRvR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Sep 2020 13:51:17 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:43492 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgILRvK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Sep 2020 13:51:10 -0400
Received: by mail-qk1-f182.google.com with SMTP id o16so13071962qkj.10
        for <linux-efi@vger.kernel.org>; Sat, 12 Sep 2020 10:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYxFOPalV05HCKVg+rhR/JkNJLOzrV4hz3RyjrHUNjg=;
        b=T7/S03nTRkrkO3BU+4qcHbC7xsPDBWIyPxGsdM9jDelTQi5gM3FEjPNUQNHDE+a2N3
         JfacLEXiz9goUOOzSPvOSE3mtOttYJLI9sUJ85n85GmyssjafiWrWcTJZoiiDknVy1yY
         s+7Bx2dp0e4rIyjFSatF0tDmtZRZ73Cal7TJly+1AMFr5rMVqM6/QmvW8Pv315sZPs5a
         iXYU3agtYyk8m9Wxr2OBLDXy/v8fISVyFyRyaLE/iXYSUZJFOcwSQuW6mOlfdR5EnX+v
         afIqQX3FqPqxksiScWF4U2Gw6SWQnzG2xHBqdb0DUSRmliZh4icPc5TYxn0NH9bLJYkT
         my0A==
X-Gm-Message-State: AOAM530zbamilJYXVmSN8GB0uyU6p/s2nNlTqXyYrJxTT8YpHcy1T9/Q
        neq7tE9l2uqhqSJPrSuavj0=
X-Google-Smtp-Source: ABdhPJzt7QZGQAQGOFWIDEWKJHAPEL9aatzVYlSwrSIrpjF5lJU2gZPboN+t+daqJfIBGqemaxtMjw==
X-Received: by 2002:a37:e509:: with SMTP id e9mr6190843qkg.469.1599933068627;
        Sat, 12 Sep 2020 10:51:08 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h65sm7337352qtd.58.2020.09.12.10.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 10:51:08 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Jacobo Pantoja <jacobopantoja@gmail.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [RFC PATCH 2/2] efi/libstub: Dump command line before/after conversion
Date:   Sat, 12 Sep 2020 13:51:05 -0400
Message-Id: <20200912175105.2085299-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912175105.2085299-1-nivedita@alum.mit.edu>
References: <DM6PR19MB2636D9FB53FD32BC8F3FFFE4FA240@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20200912175105.2085299-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

---
 .../firmware/efi/libstub/efi-stub-helper.c    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 294958ff1ee6..fdc8d312b2e0 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -346,6 +346,26 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
 	bool in_quote = false;
 	efi_status_t status;
+	size_t i;
+	efi_input_key_t key;
+
+	efi_info("Load options: %08x @ %p\n", options_chars, options);
+
+	efi_info("Hex dump:\n");
+	i = 0;
+	do {
+		const u8 *p = (const u8 *)options;
+		size_t j;
+		efi_info("%p: ", p + i);
+		for (j = i; j < options_chars && j < i + 8; j++)
+			efi_printk("%02x ", p[j]);
+		for (; j < i + 8; j++)
+			efi_printk("%2c ", ' ');
+		for (j = i; j < options_chars && j < i + 8; j++)
+			efi_printk("%c", isprint(p[j]) ? p[j] : '.');
+		efi_printk("\n");
+		i += 8;
+	} while (i < options_chars);
 
 	efi_apply_loadoptions_quirk((const void **)&options, &options_chars);
 	options_chars /= sizeof(*options);
@@ -410,6 +430,26 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	snprintf((char *)cmdline_addr, options_bytes, "%.*ls",
 		 options_bytes - 1, options);
 
+	efi_info("Command line: %.*ls\n", options_bytes - 1, options);
+	efi_info("Hex dump:\n");
+	i = 0;
+	do {
+		const u8 *p = (const u8 *)cmdline_addr;
+		size_t j;
+		efi_info("%p: ", p + i);
+		for (j = i; j < options_bytes && j < i + 8; j++)
+			efi_printk("%02x ", p[j]);
+		for (; j < i + 8; j++)
+			efi_printk("%2c ", ' ');
+		for (j = i; j < options_bytes && j < i + 8; j++)
+			efi_printk("%c", isprint(p[j]) ? p[j] : '.');
+		efi_printk("\n");
+		i += 8;
+	} while (i < options_bytes);
+
+	efi_printk("\nPress any key to continue\n");
+	efi_wait_for_key(30 * EFI_USEC_PER_SEC, &key);
+
 	*cmd_line_len = options_bytes;
 	return (char *)cmdline_addr;
 }
-- 
2.26.2

