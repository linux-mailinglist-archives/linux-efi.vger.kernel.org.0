Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE27F1D87EB
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgERTHh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46422 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgERTHf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id f83so11405313qke.13
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHBX4hPresxM5fC6Xsnz+DDSTanyDon83nVA6k6j82E=;
        b=l1hfLGcgxDwqEwhsJoK3F3IF6324pKbWPs8UWjuqOHLlOy5zZa+wxuNMVcwv62D6MR
         EPILtbkska2815hEdHZVcS/ZJ0ZOWVXZW1fmBAMxe/RhOk4oEYuXSNXAgUElCLuGyGHW
         biZq1MaITmj/OaExi7DHSZ3D7dZZARHChSJcRjN+BjHf9VoflMCjXJz8em11AgKAZERf
         rGF3S9off01QVByoiqCb3qbz3NWbDVYvec3R4mxpt2o9BKjQXJdBzGD82qVMACMJwlcx
         oxrKOHEzmaD7tSHkrww7hnLlPv+wR/BRCVmFS+w3UnOCR5qtenIAwVAQ8NNd1G9BWGId
         HIXw==
X-Gm-Message-State: AOAM532JKAJcBAJrpv7PZ1LvC/Ph51oXBuZRjNBRlLPK8rvqB/6p/VwC
        0daqukr3agr6mWTffcM3RcGhgIPD450=
X-Google-Smtp-Source: ABdhPJwWMkqJhKyjKT3PKAcfQOCk6p3G0nyugZifCchg4PFkgCrs1aiZYrnJyLzRnCNYEJ8yafqB3A==
X-Received: by 2002:a37:66d5:: with SMTP id a204mr17002799qkc.188.1589828854209;
        Mon, 18 May 2020 12:07:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:33 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 22/24] efi/libstub: Use %ls for filename
Date:   Mon, 18 May 2020 15:07:14 -0400
Message-Id: <20200518190716.751506-23-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_printk can now handle the UTF-16 filename, so print it using efi_err
instead of a separate efi_char16_puts call.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 933536c5236a..2005e33b33d5 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -46,9 +46,7 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 
 	status = volume->open(volume, &fh, fi->filename, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to open file: ");
-		efi_char16_puts(fi->filename);
-		efi_puts("\n");
+		efi_err("Failed to open file: %ls\n", fi->filename);
 		return status;
 	}
 
-- 
2.26.2

