Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3236D18C05C
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgCST3F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43795 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgCST3E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id l13so2894727qtv.10;
        Thu, 19 Mar 2020 12:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W439qqnj3amgmXthHTe3CXz0LpqU3anmtZjYuvrxKAY=;
        b=NGk/kRwQ9F6uZMN3zi+HJkoYpLmxmb4iPuVTowlkNTUvC6IlL1qg8lLE5lAe0SKzyq
         gaQvGAPdiEeitnT5A+NoMJsZTP2BYWu5mBdLE5LnqEgQy16qfOg6/yyFPHQ2BkcRYeqa
         w4NVAZSkBdfoG62gBJlcIzerRpG4gnE88KAXj92fySn14D3LdALwkiCLoiZay3w438gn
         s7y7ssF+WZiLmBddh8DcosoVKaz5ejyT1jg+TJaiHiVyVo+HshwkAqJo77A/oYQEMyOL
         HsvguBCzu5eJjVX146I3upQMZiEvBL9LFkWgeg0xuD+UBR6wWoo8JVTBeeenLOP3jnif
         PVdQ==
X-Gm-Message-State: ANhLgQ1pg0ue72PzfrZknbHOWS8xwPweYT89PsTo3LVVEYX9u3no3cQk
        3musThcMquUkJzwXXUYTJOTThK5Z
X-Google-Smtp-Source: ADFU+vv2rZC8S3Xibsy0gfbEvehVorQzB7d2Dc40cA7mCyolrmT2eL9E62Ej4GzZLvkFNj9UcXGMLg==
X-Received: by 2002:ac8:108d:: with SMTP id a13mr4830196qtj.230.1584646141848;
        Thu, 19 Mar 2020 12:29:01 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:01 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] efi/gop: Slightly re-arrange logic of find_gop
Date:   Thu, 19 Mar 2020 15:28:46 -0400
Message-Id: <20200319192855.29876-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Small cleanup to get rid of conout_found.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 92abcf558845..a7d3efe36c78 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -99,7 +99,6 @@ find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 
 	for_each_efi_handle(h, handles, size, i) {
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
-		bool conout_found = false;
 		void *dummy = NULL;
 
 		status = efi_bs_call(handle_protocol, h, proto, (void **)&gop);
@@ -111,25 +110,22 @@ find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 		if (info->pixel_format == PIXEL_BLT_ONLY)
 			continue;
 
+		/*
+		 * Systems that use the UEFI Console Splitter may
+		 * provide multiple GOP devices, not all of which are
+		 * backed by real hardware. The workaround is to search
+		 * for a GOP implementing the ConOut protocol, and if
+		 * one isn't found, to just fall back to the first GOP.
+		 *
+		 * Once we've found a GOP supporting ConOut,
+		 * don't bother looking any further.
+		 */
 		status = efi_bs_call(handle_protocol, h, &conout_proto, &dummy);
 		if (status == EFI_SUCCESS)
-			conout_found = true;
-
-		if (!first_gop || conout_found) {
-			/*
-			 * Systems that use the UEFI Console Splitter may
-			 * provide multiple GOP devices, not all of which are
-			 * backed by real hardware. The workaround is to search
-			 * for a GOP implementing the ConOut protocol, and if
-			 * one isn't found, to just fall back to the first GOP.
-			 *
-			 * Once we've found a GOP supporting ConOut,
-			 * don't bother looking any further.
-			 */
+			return gop;
+
+		if (!first_gop)
 			first_gop = gop;
-			if (conout_found)
-				break;
-		}
 	}
 
 	return first_gop;
-- 
2.24.1

