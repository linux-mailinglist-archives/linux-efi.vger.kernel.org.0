Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E44F1C04C1
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD3S3G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:29:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38840 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgD3S2y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id k81so4062674qke.5;
        Thu, 30 Apr 2020 11:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AMrosFd1f72Qq3WfrgWyCQT84wdVtOTpaMD31DP6+8=;
        b=ElldIPtabJ8fg6dJmHkVPI249OjOjF24ePjhOo9qL14A0Tgnf1oBr5L8Pn3TgZfVgY
         MJMr6+/4mFMzwYZ4KV93kmkbn4f/tp9TuK0cThBbnU4NOUiaRYIEGgP5mZc2ngwuSZO2
         mVTwUD/yCqWwJxUJRdBLvl6/8/edOxv/AzQ4XblXcLPdJ1roDGwD3VCM6KAobvlUDCop
         Wp84ccfFh7JyeAJaSRloj+HP9mvBslGRBJUFfHKfZvYz1mRYO1ZOu9w7mUeWJCBbGscg
         Yc9xbaZGQ37hp8dHwCbzmAhVUIrcGCaLRvyLHquUzeo/lJwK1c82Z17JDTXXDvJE3Go6
         rbYw==
X-Gm-Message-State: AGi0PuaWeompHexudMCd2JVRjaNJ5Oq+JrOE+gs8iofL49BoRY4KWqOB
        ILZ32XX8hdQ8H5XLnOFIFDY=
X-Google-Smtp-Source: APiQypI+9d3becN2aJEn1PCKzErog4aSwYsGKYpSla2kXVJaZPtbTIV+j5yY6w5zTkKXvysmklb3jQ==
X-Received: by 2002:a37:4ad8:: with SMTP id x207mr4421744qka.427.1588271333463;
        Thu, 30 Apr 2020 11:28:53 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:52 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] efi/x86: Support builtin command line
Date:   Thu, 30 Apr 2020 14:28:42 -0400
Message-Id: <20200430182843.2510180-11-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430182843.2510180-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200430182843.2510180-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for the x86 CMDLINE_BOOL and CMDLINE_OVERRIDE configuration
options.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f1a134596b53..c84c5678e3e1 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -680,7 +680,6 @@ unsigned long efi_main(efi_handle_t handle,
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
-	unsigned long cmdline_paddr;
 
 	efi_system_table = sys_table_arg;
 
@@ -739,9 +738,14 @@ unsigned long efi_main(efi_handle_t handle,
 		image_offset = 0;
 	}
 
-	cmdline_paddr = ((u64)hdr->cmd_line_ptr |
-			 ((u64)boot_params->ext_cmd_line_ptr << 32));
-	efi_parse_options((char *)cmdline_paddr);
+#ifdef CONFIG_CMDLINE_BOOL
+	efi_parse_options(CONFIG_CMDLINE);
+#endif
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
+					       ((u64)boot_params->ext_cmd_line_ptr << 32));
+		efi_parse_options((char *)cmdline_paddr);
+	}
 
 	/*
 	 * At this point, an initrd may already have been loaded by the
-- 
2.26.2

