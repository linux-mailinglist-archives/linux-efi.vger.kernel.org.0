Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A57818C51E
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCTCAd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:00:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38050 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCTCAd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so5433397qke.5;
        Thu, 19 Mar 2020 19:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yf/d6z5fDqSiUAa0pPPTXtMy3f41r+NjRTZ8TYCHO5A=;
        b=e9Iygy4geKUotzBX/2+dB3UpBzBrYMkIJGJ/7rj7Ksc5CjEz28EzGeXHFkDwC9hoXd
         YDa4CASBn4VZQKNgcxrU2bmnau6lmsG9VX8GvV7rpDvUeIpCGOlYcueDtGlZ+a2brXnZ
         Qq/+YMorIVSL3kVbq4eyp+j25cVO1YCjjIZ0RkIZMiEAb3hwCqEkNR+3hAeRt1w4YA/p
         Eigns0bOYhYnn7oW4WcNqRczx3bXLrLvMyndomJurei0DlhoDyY2evFTs+KESP5/WEJF
         2mc9Hz+JdhDVHkuvOhEPiDMz9n6nbBCQtvCfQvZFE5uPPMehjaim8K7aMq3730zZ4Z5U
         l6Qg==
X-Gm-Message-State: ANhLgQ10b0MHbDDOhVwR9nKNbfq+AGw9PaXp3Ux1iZ+qck7ghFCZ9Fn3
        a5bRJIxWkBvsNL9gqKHrPGo=
X-Google-Smtp-Source: ADFU+vtt/Sx6SqJLN4iufYHoPs3cWTH/LCL5gNED0gillyPbwcyKMaavk/JzY0ZpKFKYBX0+47DZUA==
X-Received: by 2002:a37:664d:: with SMTP id a74mr5736603qkc.256.1584669632091;
        Thu, 19 Mar 2020 19:00:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/14] efi/gop: Move check for framebuffer before con_out
Date:   Thu, 19 Mar 2020 22:00:16 -0400
Message-Id: <20200320020028.1936003-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the gop doesn't have a framebuffer, there's no point in checking for
con_out support.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index f40d535dccb8..201b66970b2b 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -113,15 +113,16 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 		if (status != EFI_SUCCESS)
 			continue;
 
+		mode = efi_table_attr(gop, mode);
+		info = efi_table_attr(mode, info);
+		if (info->pixel_format == PIXEL_BLT_ONLY)
+			continue;
+
 		status = efi_bs_call(handle_protocol, h, &conout_proto, &dummy);
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		mode = efi_table_attr(gop, mode);
-		info = efi_table_attr(mode, info);
-
-		if ((!first_gop || conout_found) &&
-		    info->pixel_format != PIXEL_BLT_ONLY) {
+		if (!first_gop || conout_found) {
 			/*
 			 * Systems that use the UEFI Console Splitter may
 			 * provide multiple GOP devices, not all of which are
-- 
2.24.1

