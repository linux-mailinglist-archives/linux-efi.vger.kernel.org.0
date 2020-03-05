Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DE17A7AF
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 15:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCEOgp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 09:36:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39874 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgCEOgo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Mar 2020 09:36:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id e13so4265072qts.6
        for <linux-efi@vger.kernel.org>; Thu, 05 Mar 2020 06:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZ2RKPnI2lXvFfz5wxz2/rek312QvCvhMZ2aTBpcLBw=;
        b=Y/zUObpKFvYyyYeHDI8bYmhCm9pwqxO6iHa2sMwEJz6T2HVj+nBTzU9KyfORh3GN29
         xweDiEipIndzUQF2YJFqDRT8AFCyZN/upEs+7lLo3Ul1obaLzwOuQOOR6uwz8fMQ0QSP
         lQm25HGxTvKgnvkOKxLGoZjX4AncLtDhOoOduBpCgGigkZxGyLQCO453/6K688Cdq/aw
         okIn/iyXVVJBfNFYYJEz/mg/WKdpdoaFcMosR2RaimsGRfet1i8xfXv1YUNGSY/zVWKT
         FSIe+/1EgPmD1ub83PiFagmL+mCNfCozE6i3rCoqigXCRZylv07l8fp7d7fK9NPVb3Fe
         ZIxQ==
X-Gm-Message-State: ANhLgQ0ycyS1wvW7DSFfs3ibcR2gmQdKUz1FYl3UsWhD9zj9wUsYkwUT
        6W76+VlKYWyGi2UiwTDmVu3CjZEbbAg=
X-Google-Smtp-Source: ADFU+vuj/PZ63x9g05Vi5isVaxo4I0K4wr7aoTS6aK02+NEQLFDAkxQjO3TMXAqbem1xGoVA+Vir8w==
X-Received: by 2002:ac8:76d7:: with SMTP id q23mr7526518qtr.198.1583419003900;
        Thu, 05 Mar 2020 06:36:43 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u48sm2219090qtc.79.2020.03.05.06.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:36:43 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH] efi/x86: Fix cast of image argument
Date:   Thu,  5 Mar 2020 09:36:42 -0500
Message-Id: <20200305143642.820865-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

handle_protocol expects void **, not void *.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index fbc4354f534c..95b29d8bf8e4 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -383,7 +383,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
-	status = efi_bs_call(handle_protocol, handle, &proto, (void *)&image);
+	status = efi_bs_call(handle_protocol, handle, &proto, (void **)&image);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
 		efi_exit(handle, status);
-- 
2.24.1

