Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF41A1C04BB
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgD3S24 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:28:56 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:45406 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgD3S2w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:52 -0400
Received: by mail-qt1-f169.google.com with SMTP id 71so5835752qtc.12;
        Thu, 30 Apr 2020 11:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rj6y60cM8Avu2nH9CmjinY3fkIE+jefEk9hoaz7WPTs=;
        b=OZv3v8nbSlN2cbo3/GgS+XBQ6UmABDqHNDX+d36dG0hWro144dPAFUZr4648hqqC3N
         NPmIit8Qz6TgtwVV55IFcrbMFyRQ7WAg82QnpFIMn2BWJ6rzWtDVulrZwg5raLGhwqiu
         zeTDciA1dEYKUhLaiVii8I3yL6pPT3fG2JYhO5257UqHPdfkFUYn7GbI2rFyeMwdrxGM
         JyjHdCgmWSBL1aX40mEp1PCrczYcXOkT0czWQxt/FiAMeC2sKsB8PC6LvbPrkrZTRFui
         /rliuaDfmgu7/PExhf0ho86GmGqzJUd9OYYq61oADPSZBTailDtYUdc5hEzk8/Py3wfe
         rgbw==
X-Gm-Message-State: AGi0PuZnX2JKDjRAsYpxdpS83kN2BiK4099K+xv9ou/TSqULNkeWprt5
        d0GSGKIgFG3VrzyMgCrDz8w=
X-Google-Smtp-Source: APiQypKny4laBTr2jevkKSB/Ob6Z70JZJ4mzpmbE6ubhSXETj0/l4l9cwtHfanqX4BivAxelvNnYIw==
X-Received: by 2002:ac8:17c9:: with SMTP id r9mr5155923qtk.392.1588271330660;
        Thu, 30 Apr 2020 11:28:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] efi/libstub: Upgrade ignored dtb= argument message to error
Date:   Thu, 30 Apr 2020 14:28:39 -0400
Message-Id: <20200430182843.2510180-8-nivedita@alum.mit.edu>
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

Use efi_err if we ignore a command-line dtb= argument, so that it shows
up even on a quiet boot.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efi-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 72ffd2670f99..cb02e8bb6b44 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -241,7 +241,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
 	     secure_boot != efi_secureboot_mode_disabled) {
 		if (strstr(cmdline_ptr, "dtb="))
-			efi_info("Ignoring DTB from command line.\n");
+			efi_err("Ignoring DTB from command line.\n");
 	} else {
 		status = efi_load_dtb(image, &fdt_addr, &fdt_size);
 
-- 
2.26.2

