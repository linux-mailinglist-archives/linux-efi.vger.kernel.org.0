Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557AD22D11C
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jul 2020 23:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGXVgq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jul 2020 17:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgGXVgp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jul 2020 17:36:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCFBC0619E7
        for <linux-efi@vger.kernel.org>; Fri, 24 Jul 2020 14:36:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f9so120433pju.4
        for <linux-efi@vger.kernel.org>; Fri, 24 Jul 2020 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/04RayDpwyA5vDbPSxe5f4ljhOo+lc314fSygLzjhJk=;
        b=G+1xDfQLQfOkEGi9h7UsWjc1zUgJyBvo+3+m4LgnDSzN055MEqcuXAaGGInXmvkUMH
         EZ1BL/XKDtMU3+a3prtBrk26Lv4UGOX3WcTbeAmSuqW9pTN4Ly2HnxPi07LW2r6P7GxJ
         2Zk56Knz9bfkGixCGqcYL5FsOmA1yCLQYZMiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/04RayDpwyA5vDbPSxe5f4ljhOo+lc314fSygLzjhJk=;
        b=bzkpZcuFdwnXh4q0Us2EDk+Fv05d5dNGoVi2reED9/Ciqig4ISggDBxA7qzxxeVEJv
         o8dOjYMEqnklBc1snAaeR03OFQjXFRYvcS5ABRWUbb4uM60EQH8nt5jQu/XDG2zgmm/Y
         TDFQKIWIzbLq+Q0vblQUcDRIh1QdVteS7yLygWmLUEqAleKgkovThcAM9r8txMaR4Jn3
         TGduG4Z1Zo391Je3C4/UIFvdlixeHixl7FOHIyOhXtCJBu63E9JWPwxO+6CS3sSOUPjH
         CoYyPAl3qntWVshfgylqhL5Gmc0dJozBNC2NuzGLJn0nxfQBkCAZRCYyF5gtrXi35MqC
         vpOw==
X-Gm-Message-State: AOAM532au89htCMRA4LluWA+x4eaWv86LQ1LUJZijBnSGwuUk4GZ5Bt4
        Z3M+jKctD25cAHF0YdAem+LGow==
X-Google-Smtp-Source: ABdhPJybX0hse+un0+9u1VVNDSN/bl2TKboJFPcM9i6sjtO8vm74oKTwOn3TjA+5wrO11RoKgfqx1g==
X-Received: by 2002:a17:902:7c0c:: with SMTP id x12mr10020502pll.103.1595626604507;
        Fri, 24 Jul 2020 14:36:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2sm6759688pjt.19.2020.07.24.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/19] firmware_loader: EFI firmware loader must handle pre-allocated buffer
Date:   Fri, 24 Jul 2020 14:36:24 -0700
Message-Id: <20200724213640.389191-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI platform firmware fallback would clobber any pre-allocated
buffers. Instead, correctly refuse to reallocate when too small (as
already done in the sysfs fallback), or perform allocation normally
when needed.

Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firm ware_request_platform()")
Cc: stable@vger.kernel.org
Acked-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
To aid in backporting, this change is made before moving
kernel_read_file() to separate header/source files.
---
 drivers/base/firmware_loader/fallback_platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index cdd2c9a9f38a..685edb7dd05a 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -25,7 +25,10 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (rc)
 		return rc; /* rc == -ENOENT when the fw was not found */
 
-	fw_priv->data = vmalloc(size);
+	if (fw_priv->data && size > fw_priv->allocated_size)
+		return -ENOMEM;
+	if (!fw_priv->data)
+		fw_priv->data = vmalloc(size);
 	if (!fw_priv->data)
 		return -ENOMEM;
 
-- 
2.25.1

