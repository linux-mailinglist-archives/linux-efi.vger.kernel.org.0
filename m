Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6EA28A7BE
	for <lists+linux-efi@lfdr.de>; Sun, 11 Oct 2020 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgJKOUP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 11 Oct 2020 10:20:15 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34847 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKOUO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 11 Oct 2020 10:20:14 -0400
Received: by mail-qv1-f65.google.com with SMTP id cv1so7176393qvb.2;
        Sun, 11 Oct 2020 07:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWyWLnrnb2GKJhVjWNu3IOOiUQzNVrzCmOlIX/sAMcY=;
        b=GJPlKJua3KDevZdfJUVtjmT8HhiLLcw0xoUzMvLyiSpdFekrhfV3eB9jeFM5dbcBNq
         0jBWudI373iUP3CPhd7BrWWUyKpKhuSix9vGVF4PhA2YI+/4oYdef8xoHQ3BCyaxTSOt
         xGT0SP1N8zhalQRo5M34YVIf6yOnj3/DGNG8RNrOGUgpP1QADS0pew1wRqriWxr0Yfb6
         jdoQwojmj95dsNXib6i3O2iUeVruxJt8hQHzjM/yad5kYyZF1yvohfFOAzbDBwXDXLDq
         K3a7ucJpIxASeCnYrBsm48xSVfDFkqkGeSubvoOe31MpA5/szTVWK0evvUSYBrQGSWTf
         go7g==
X-Gm-Message-State: AOAM532Gg9zEIbCZ+ZNaqqUfjy6pdXhyQn57Ua/7X3VI4xqxRSy2uD+d
        JaItZJuIX15Vm5uz3Y7vRetvbMp84RoB2w==
X-Google-Smtp-Source: ABdhPJysz1vjU2SOWAzZar8gr++J9DH9Y2B1ACIS+9wquQ1pZUwbr0Mv3hMx0YHqjhwW20fMy301JA==
X-Received: by 2002:a05:6214:17d3:: with SMTP id cu19mr4799236qvb.12.1602426013403;
        Sun, 11 Oct 2020 07:20:13 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f189sm10175147qkd.20.2020.10.11.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 07:20:12 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] efi/x86: Only copy the compressed kernel image in efi_relocate_kernel()
Date:   Sun, 11 Oct 2020 10:20:12 -0400
Message-Id: <20201011142012.96493-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The image_size argument to efi_relocate_kernel() is currently specified
as init_size, but this is unnecessarily large. The compressed kernel is
much smaller, in fact, its image only extends up to the start of _bss,
since at this point, the .bss section is still uninitialized.

Depending on compression level, this can reduce the amount of data
copied by 4-5x.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/x86-stub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3672539cb96e..f14c4ff5839f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -715,8 +715,11 @@ unsigned long efi_main(efi_handle_t handle,
 	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
 	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
 	    (image_offset == 0)) {
+		extern char _bss[];
+
 		status = efi_relocate_kernel(&bzimage_addr,
-					     hdr->init_size, hdr->init_size,
+					     (unsigned long)_bss - bzimage_addr,
+					     hdr->init_size,
 					     hdr->pref_address,
 					     hdr->kernel_alignment,
 					     LOAD_PHYSICAL_ADDR);
-- 
2.26.2

