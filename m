Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6399469C08
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jul 2019 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbfGOUBK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jul 2019 16:01:10 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43284 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732768AbfGOUBI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Jul 2019 16:01:08 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so8819646plo.10
        for <linux-efi@vger.kernel.org>; Mon, 15 Jul 2019 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1gkPgS/LUQWYTDhNcm4n5VtrDpueDO81OkRBGTKoxwg=;
        b=SGpuCm9nyv32QRgah8+1J8biiXF/tNR9HQ4GFBCBrRmNuWoaPEMCoMeG8CznrJ2xBC
         zkbDMbcYm8YcsYwmLzYCmSKjnsTMSvkKRRECL0tqQ36b9oNCLd5cuBcoa4BpCMdF21Fu
         O2tmCsQco516iIqUSW/mBRVF6fBtQAPjVYpsnS6G2E/HLyeMh1D0p0TkTpbvhIPBXbtS
         qtbaAbxFrni0pU2z0i41Fjy8ygJksGW51zsL1JC0ZC9Y3KF+G5b/rSrWYgjlPNfyEXRH
         GI0wIh/cCu2IgLJwz+vjTQ1V+oJarCXW6xl6K2cpPDlePYHuZsHrVGZ78+B3jX0whKqm
         o3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1gkPgS/LUQWYTDhNcm4n5VtrDpueDO81OkRBGTKoxwg=;
        b=dqc9hhY6YamL+YzPWt/4qQrL/aOQc+aNUavwTEEzjovx8HO6CFUap17/lZdVQZ4cyi
         z4pI5DaIiA6ZSKufu3+1uPUTubobevcuPZVjAilWfYserYhPXxpdDu1XxmJZWNw/3qXH
         VX8rWykYrASv/edPiG389ozTdgtZ422yE2R51s3ppURcWQzYU2J40WM6UbHX5+HrN9MJ
         Fqjz/pz40fBkn/sJ8kL8KtuONlk7Va0ZyCk5bC/RVPmN4kAHQidT+w7+nWictp/KlgpK
         /fcMBV0ZkMUeSsXpAicF0cDx1iYKxJ9lcEaFBH5+fpGmChEZXWnpatN45VnF4aW20G9H
         MBUQ==
X-Gm-Message-State: APjAAAVQZaqXSJY01776hYVA7SbCTewebt6mG+UrvEa2JMHCuKcizsCh
        hT2nOjO+zGcXpT/gnWZ2Stdx5l/fG6MlXMCA39wUTg==
X-Google-Smtp-Source: APXvYqx8IB42RsjuQvqr21hPpPSRXnXopU3sD+HW/qRD9CSWBN6XHwG27W8+mPAUWW4oj0dcn2icPxBiU0iXrQYpoIx1NQ==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr28729222pgc.346.1563220867059;
 Mon, 15 Jul 2019 13:01:07 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:45 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 28/29] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
EFI variable, which gives arbitrary code execution in ring 0. Prevent
that when the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/efi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ad3b1f4866b3..776f479e5499 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -30,6 +30,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/security.h>
 
 #include <asm/early_ioremap.h>
 
@@ -242,6 +243,11 @@ static void generic_ops_unregister(void)
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
+	int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+
+	if (ret)
+		return ret;
+
 	if (strlen(str) < sizeof(efivar_ssdt))
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
-- 
2.22.0.510.g264f2c817a-goog

