Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6461E51C4
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 01:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgE0X0F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 May 2020 19:26:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39422 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0X0E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 May 2020 19:26:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id k22so6029925qtm.6;
        Wed, 27 May 2020 16:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHGDLlJ9WIIzUBMSyQD34/Snx/SdTvbpspVS+Y0RZqY=;
        b=VvV5PZ12eNzIgDTcuoEan4zVx8CA7LaheTeBAC9EA7h2vPmcdFF1bjDEDXnR84uuOI
         VVdvcWAI8UDb/FeB67eMomsdYU9mczaHaSKyyO21l+tiDfLgaFBCQCnwM0D5QfgY2WMr
         JthuCIp/mfHtJF94c8iHV/u/h3QulLr6cXVdZngi5vHG6mk7yJreO5qBg2vkH0fiLJJM
         1q/Vweasrr6/hRWSAQwvZD/jabtxGmN9Q8Li/P3Kxllcpwmtlj8ZEf9MdkwCf5MgHdNm
         4/e1oVekOVsB7NAF8/Bjg1uVYn4ywUQbpJH2fsa7wvoGL0Mv4SV8HHyv39KEsqQEJ4wC
         yOtA==
X-Gm-Message-State: AOAM5330LUsV2LUc60W2vngp9QCMBWyGWh2lGS58EECdtC1/azc9LhVW
        08tJFiSZob74ku3kCjZZ+JaspSwH
X-Google-Smtp-Source: ABdhPJyDu8rY7TSjnZYSXdD4Mv45PCk+AV/KskfzGF1jAZUPjgxn2p7EURuZxdnKpqn4b3ui07g30A==
X-Received: by 2002:ac8:4c8b:: with SMTP id j11mr375549qtv.58.1590621963529;
        Wed, 27 May 2020 16:26:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y66sm3774883qka.24.2020.05.27.16.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 16:26:03 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/x86: Don't blow away existing initrd
Date:   Wed, 27 May 2020 19:26:02 -0400
Message-Id: <20200527232602.21596-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAPcyv4hO1XEMHPLY-W6g_=TK2Dv=rLgJoVeKrBEHP63zTeq-sA@mail.gmail.com>
References: <CAPcyv4hO1XEMHPLY-W6g_=TK2Dv=rLgJoVeKrBEHP63zTeq-sA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit
  987053a30016 ("efi/x86: Move command-line initrd loading to efi_main")
moved the command-line initrd loading into efi_main, with a check to
ensure that it was attempted only if the EFI stub was booted via
efi_pe_entry rather than the EFI handover entry.

However, in the case where it was booted via handover entry, and thus an
initrd may have already been loaded by the bootloader, it then wrote 0
for the initrd address and size, removing any existing initrd.

Fix this by checking if size is positive before setting the fields in
the bootparams structure.

Fixes: 987053a30016 ("efi/x86: Move command-line initrd loading to efi_main")
Reported-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/x86-stub.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 072b7cf40475..ceb8e16c8b75 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -774,10 +774,12 @@ unsigned long efi_main(efi_handle_t handle,
 			efi_err("Failed to load initrd!\n");
 			goto fail;
 		}
-		efi_set_u64_split(addr, &hdr->ramdisk_image,
-				  &boot_params->ext_ramdisk_image);
-		efi_set_u64_split(size, &hdr->ramdisk_size,
-				  &boot_params->ext_ramdisk_size);
+		if (size > 0) {
+			efi_set_u64_split(addr, &hdr->ramdisk_image,
+					  &boot_params->ext_ramdisk_image);
+			efi_set_u64_split(size, &hdr->ramdisk_size,
+					  &boot_params->ext_ramdisk_size);
+		}
 	}
 
 	/*
-- 
2.26.2

