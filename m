Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7764C8F4E
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 19:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfJBREF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Oct 2019 13:04:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39546 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfJBREB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Oct 2019 13:04:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so7729228wml.4
        for <linux-efi@vger.kernel.org>; Wed, 02 Oct 2019 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ba3w9kcbGuMtfRQk+/aw/wvXJx7RCk+NpcTgMqWmzhU=;
        b=wzK2Kr+8eqFEvQyxP/6nAjwnHPAGzZ8Pr5KF1g4HtEl208yl3hYOPNrU07OMhhzVWi
         MJKwplxNEH4QgfCZUR4dvDzREYAmCwTg8QcRqVIc+N86yPlchCpdJwH64aDYPis9zk8m
         TdMyTqaPHvXe6DL+R17NO7Ew8ajZCG6HeEYnB+26TI7BCFOg37ZX69Ifm9cCZnNvptFv
         dh27JTl0lOOYsJXWAQYHiDsnQ/ysVdZ3EghjNhZgsmHbWK3V+X6gAGNnlR3zit/Lp1L8
         mebYi0KthRj672fvFN5LuLKZYDX6z4czZY0Slv+AbT5SR4PFSvdKM/FhltbeInqz6vfK
         msew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ba3w9kcbGuMtfRQk+/aw/wvXJx7RCk+NpcTgMqWmzhU=;
        b=mp6AsvIgTprkG91g6/gOTpa0Yf08DTvbA3MY+UIzrAR4aqg26Xjrlo2V+DjBARI9Ii
         75OnlGWAMhDdSazJR5z1N08Iiqd+Zg2vOW5fzr0mC7KIp4WMU15CGmz4CowpRkGxZ7Nm
         vxrvPtCGr1u2mCjtOHehN/poaBMFRlAgZzX1t2StmAN6I0CreA1OQN5eoTVCUt+NT3gK
         YctCKPEDbIe+eQyNVKQD+P/rF0IFHFANlzMUin5Su7zBMu6iC8bYxU348kpRaL/R7IPs
         l+b4DvE5xVdZxJHj4uAxf+MQmPzxiN/TpExmrB6iJYu0GeDyapYOLa4WX/Jama/NDkjs
         fkpQ==
X-Gm-Message-State: APjAAAUnBTMRUPIFMirBaTUEe3ArPoOEnhkHbZ8+nqJF+LTaiNENmhKe
        fAdRCGpKdBZlKkmKQGu3EpfX/gGCzqPTKHXp
X-Google-Smtp-Source: APXvYqwXbGLwgYQFbrU4EXNJ7vjxZWidobcE/CUTFY2F3Qa/HMp0yBUXkU17d/wY4mHe9PxlJXUcgw==
X-Received: by 2002:a05:600c:2115:: with SMTP id u21mr3610780wml.168.1570035839244;
        Wed, 02 Oct 2019 10:03:59 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:58 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 7/7] efi/x86: do not clean dummy variable in kexec path
Date:   Wed,  2 Oct 2019 18:59:04 +0200
Message-Id: <20191002165904.8819-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Dave Young <dyoung@redhat.com>

kexec reboot fails randomly in UEFI based kvm guest.  The firmware
just reset while calling efi_delete_dummy_variable();  Unfortunately
I don't know how to debug the firmware, it is also possible a potential
problem on real hardware as well although nobody reproduced it.

The intention of efi_delete_dummy_variable is to trigger garbage collection
when entering virtual mode.  But SetVirtualAddressMap can only run once
for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
a good place to clean dummy object.

Drop efi_delete_dummy_variable so that kexec reboot can work.

Signed-off-by: Dave Young <dyoung@redhat.com>
Acked-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/efi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index c202e1b07e29..425e025341db 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -917,9 +917,6 @@ static void __init kexec_enter_virtual_mode(void)
 
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
-
-	/* clean DUMMY object */
-	efi_delete_dummy_variable();
 #endif
 }
 
-- 
2.20.1

