Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A42819D6
	for <lists+linux-efi@lfdr.de>; Fri,  2 Oct 2020 19:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbgJBRkG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Oct 2020 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388321AbgJBRif (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Oct 2020 13:38:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4359FC0613E7
        for <linux-efi@vger.kernel.org>; Fri,  2 Oct 2020 10:38:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so1723938pfg.13
        for <linux-efi@vger.kernel.org>; Fri, 02 Oct 2020 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ITw/V5vvWbmjAkuPXqZiQMYCEzK7qNPFAgC/5GybC34=;
        b=mnMnlTBePU+ZIOCMpEfiJzwA0U+m1TsFSW5jtKCdhoXIMbDSLBPviw1u+W9/ozY6E3
         /ObiQ6ze428VgPCEIz+x9+eJ7lGcPJtEkPMsTMOa12g2pvNDu2c8GeSX6nbMuKRT8p3z
         zdX82s3sdcApmphDrUQvIa0QlEOYLHZbS5P90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ITw/V5vvWbmjAkuPXqZiQMYCEzK7qNPFAgC/5GybC34=;
        b=YRRXa9yMM9Kx7kRC7utr91nwmbHpE3BhAdIuHiuKlktRTch/knh2Hdoai2kAJl/sub
         DePq1SUjG6LnpdKIXq5m2WQau4e/w3baWUyEQ0p47Nl/uvd6oIXs2PrGs13si8qiCCyX
         QsUF03LJ9a6IlmVNAvKvlFljrJeOdPLajIMQsjltNAXbtaE4es56YKRvScgLjptmx2oW
         NZBIVsvBASHsbteFmxmaqBbtlCccNi+4X+aeCV0oy6Emte2BZZ0q1/KDgGV07EFzBZg0
         0bTjgXEV/fUJBGzzToPx6cYrX5kQntKPpiDIg0tjYC9Yk/mZRSSkDtAyZR5N0ezTqA3a
         P16A==
X-Gm-Message-State: AOAM532kdy+PciHK+s7hqUI3r/bUlogq1YzjIN6BrvRNXKN+vTUkXh7O
        7o+czuWnL14oXAYFlMhOP6Bu+g==
X-Google-Smtp-Source: ABdhPJwjBHjCgXl95SNKnk+LoWgbNy0ZNrd7Ms1/liceqETgNqR70ddLYqa8sjgokcAf8zr+gSU8xQ==
X-Received: by 2002:aa7:941a:0:b029:142:2501:35d1 with SMTP id x26-20020aa7941a0000b0290142250135d1mr3970058pfo.49.1601660314475;
        Fri, 02 Oct 2020 10:38:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 124sm2478687pfd.132.2020.10.02.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        stable@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/16] fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
Date:   Fri,  2 Oct 2020 10:38:14 -0700
Message-Id: <20201002173828.2099543-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The "FIRMWARE_EFI_EMBEDDED" enum is a "where", not a "what". It
should not be distinguished separately from just "FIRMWARE", as this
confuses the LSMs about what is being loaded. Additionally, there was
no actual validation of the firmware contents happening.

Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firmware_request_platform()")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
Cc: stable@vger.kernel.org
---
 drivers/base/firmware_loader/fallback_platform.c | 2 +-
 include/linux/fs.h                               | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index 685edb7dd05a..6958ab1a8059 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
-	rc = security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
+	rc = security_kernel_load_data(LOADING_FIRMWARE);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7336e22d0c5d..3fb7af12d033 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2858,11 +2858,10 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
-/* This is a list of *what* is being read, not *how*. */
+/* This is a list of *what* is being read, not *how* nor *where*. */
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
-	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-- 
2.25.1

