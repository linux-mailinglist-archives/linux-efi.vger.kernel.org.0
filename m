Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380E418C516
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCTCAi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:00:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35117 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgCTCAh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id v15so3772884qto.2;
        Thu, 19 Mar 2020 19:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbeHQl1XqMr+8edKb2icuORkyf9Hpoc/AyZgQ5A8vls=;
        b=FNJMDwQ44xJ5MsQOOvmIvWs1MaSlxNlj/UXIAAq2E1wu6yg8zTVNhBnd5eGt4nIcaL
         JdJn+ta795AnhyrRoT+wq2n7XxLUU7ILa3y2wH6/0vdb3HuJRqZqaGlmAjUBlmeEgBy3
         7DIncZuK3/RnDzfbDfDs2zXdnakXIvfhy4sRH/aoyPTiUQic+eJ0KfipnvJmtC1Cmpfa
         oDVnfaveXfpmMsuMK1RnJvGX/t3VkNWpgTrXyNMxn02xmu16VwDEtdCPrrlqA352nvg3
         Kav1v/EzQDN/dCdfGKz0PmB81XGl9Y5ZGjix7NoUEy6Ogd4sOgTXQmyvUnx1wc7v0SnJ
         EmSQ==
X-Gm-Message-State: ANhLgQ1JlccI077y6GhKQBn/ZIcn1PL05HkQ7U5SntQxibZToRgPDZzD
        K3TNT4pfbaM/Qpu2W0YX4Pw=
X-Google-Smtp-Source: ADFU+vu1dvYJMVVcqtaiWVGPXAKD+ciFIpxS2oh0TdRW1ME68Umtjs4YHnwukrJ1k+jXDOTVN+w5CA==
X-Received: by 2002:ac8:5210:: with SMTP id r16mr6139776qtn.173.1584669636272;
        Thu, 19 Mar 2020 19:00:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:35 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] efi/gop: Use helper macros for populating lfb_base
Date:   Thu, 19 Mar 2020 22:00:21 -0400
Message-Id: <20200320020028.1936003-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the lower/upper_32_bits macros from kernel.h to initialize
si->lfb_base and si->ext_lfb_base.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 0d195060a370..7b0baf9a912f 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -158,8 +158,8 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	si->lfb_height = info->vertical_resolution;
 
 	fb_base		 = efi_table_attr(mode, frame_buffer_base);
-	si->lfb_base	 = fb_base;
-	si->ext_lfb_base = (u64)(unsigned long)fb_base >> 32;
+	si->lfb_base	 = lower_32_bits(fb_base);
+	si->ext_lfb_base = upper_32_bits(fb_base);
 	if (si->ext_lfb_base)
 		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
 
-- 
2.24.1

