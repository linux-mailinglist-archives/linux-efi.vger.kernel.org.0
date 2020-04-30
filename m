Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B3E1C04C8
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3S3O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:29:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35913 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgD3S2v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id w29so5897487qtv.3;
        Thu, 30 Apr 2020 11:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94wAFMFaMaSvZGl5ZBqxA0PT7iUq3+1Urv4C9UV7BRM=;
        b=jq0vfmKyGUyEuJbfuwTiM6BU5t/YHBap/TTzkPHj4OBF6RTCSumae8H199fcDsGqdU
         KPa/EE/r1kAIU7tVW409nMdSpxqtDXODPpPNN5f38xxyYMnSXAQQoYBZPtYHA8wlueoW
         CxkBMjFpdOStATjPCu+NxpTcO77lrZd3RpX6+WJ5VbOp912kCTzZ4ZJAQNFRzw7JoegH
         sOuABgsMJJG/R8700rPJKZ7c59y8aI4fqXZ+D/PHd9SWa65QUAqH4dDZAYIi+MaNgvkT
         tQG1r3372jQf0+h3pt2C8jdqg1bHPlx4wFN2t/MLdNQimG/aKsQBIyEOpdq0A8arwjfA
         XPBg==
X-Gm-Message-State: AGi0PuaDhti/9y88t4du8bZ6ZqOnxosW4uHwLG/hr752v+NOUUJXnnVP
        8hnc/wYqSve/RE9KN0KMGU7iMfkktPk=
X-Google-Smtp-Source: APiQypKYpPbIyD4ANh9B4MxtpjS6ebCbYVfKIrYIpeH/ublhD/01JsNcjKb7vNn4TSfof1d3h0sURQ==
X-Received: by 2002:ac8:4e53:: with SMTP id e19mr5155151qtw.277.1588271329940;
        Thu, 30 Apr 2020 11:28:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] efi/tpm: Use efi_err for error messages
Date:   Thu, 30 Apr 2020 14:28:38 -0400
Message-Id: <20200430182843.2510180-7-nivedita@alum.mit.edu>
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

Use efi_err instead of bare efi_printk for error messages.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 1d59e103a2e3..09adcf51b75b 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -119,7 +119,7 @@ void efi_retrieve_tpm2_eventlog(void)
 			     sizeof(*log_tbl) + log_size, (void **)&log_tbl);
 
 	if (status != EFI_SUCCESS) {
-		efi_printk("Unable to allocate memory for event log\n");
+		efi_err("Unable to allocate memory for event log\n");
 		return;
 	}
 
-- 
2.26.2

