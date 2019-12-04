Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA9113390
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 19:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfLDSRu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 13:17:50 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43302 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbfLDSRu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 13:17:50 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so214493qvo.10
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 10:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofs7prmxLlh429JEbrQMC8jYGExN/xhN9sTNWJH71+g=;
        b=R0pVhn4+YBcKDMsaEV+0sBAVr2lNZfcQdpDGeThDxmzz2HgbLoJdy7LFjKg3qbxSDz
         defRn0xMro+NLM9NYxdRocIGT3z9ilIWzWUhdrPgParHYH57aHclENMVkGQ7maN4bY9D
         9f+Z1r7SOR0BspLsd+DsK1/fLmKnNbEGF+VCO64rI5dw1Os3AIPAIMWXvzWjb+7Fl9Zk
         w2lRUN9JJypDZWGVC46iKBIbCw94oDJeb8SVBG4i6IZyC6bXyS00R3CiLfhoQF3si/MQ
         qZ0SjcuIJZFZKJE02kcH0lyQVuYP+v4ZdIPZokEPPjsGrZPNK2W4CDsrFiDPiW7BqzdJ
         EHmA==
X-Gm-Message-State: APjAAAW1RuNJ113gVwiCFjeu+68m0+Ow5ifUL9SFeMwb8bnKf+pSIXNP
        SMJ7gGjSgplS0SzaaSzkQL65CA+V+Ck=
X-Google-Smtp-Source: APXvYqxtkFyjZixH5+Vv+xd+SUfQP7cn/ILwEuv0JnhBr2GVT4Qtdctkux/FjBnixbh7E8WYog7Mqw==
X-Received: by 2002:ad4:4e44:: with SMTP id eb4mr3999941qvb.101.1575483468218;
        Wed, 04 Dec 2019 10:17:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c6sm4072506qka.111.2019.12.04.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:17:47 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH v2 2/3] efi/gop: Return EFI_SUCCESS if a usable GOP was found
Date:   Wed,  4 Dec 2019 13:17:43 -0500
Message-Id: <20191204181744.14326-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203214728.19264-1-nivedita@alum.mit.edu>
References: <20191203214728.19264-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If we've found a usable GOP with a framebuffer, it is possible that one
of the later EFI calls fails while checking if any support console
output. In this case status may be an EFI error code even though we
found a usable GOP.

Fix this by explicitly return EFI_SUCCESS if a usable GOP has been
located.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 62e8b7cff72f..245a5fbef3dc 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -198,7 +198,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
 
-	return status;
+	return EFI_SUCCESS;
 }
 
 static efi_status_t
@@ -316,7 +316,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
 
-	return status;
+	return EFI_SUCCESS;
 }
 
 /*
-- 
2.23.0

