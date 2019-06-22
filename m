Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9614F482
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jun 2019 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFVIvT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Jun 2019 04:51:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36301 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfFVIvS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Jun 2019 04:51:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so7530597wrs.3
        for <linux-efi@vger.kernel.org>; Sat, 22 Jun 2019 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qiN85MY5YnTwB3nQ80pJ/FSY8JMCGoluMGY1yE5pzt8=;
        b=H/p1qP5UKrqbgx62rex5GvcEiP0tumRfLfdHFtTeGXRVnhy+Bc0wSAjxZkpJI2kT6U
         vQUfAVCPe9SfCqgFiRYWiEmlDFWx07zJylvpNpmMiWu8esFrF0nsSylVV71EWkolD9xQ
         S6t6QfIx1p643HMzcCMzaomCgLCtYVoT4th99SnrRo5wcclGgqXgD2Mkx7M81nBh7D8c
         FHSNPRsklt3XRZV1fmkYW6h+38Z1j8NhVaQ1GreT6T/aI81iqlGF30NUrqPj0xQozNpg
         HEyFXAK7Eufqhn0jAVrL7bYli/+XrGKo5PABFeIFVThkD2OuAz7cbiOlxuXxWaFMaFBO
         ZJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiN85MY5YnTwB3nQ80pJ/FSY8JMCGoluMGY1yE5pzt8=;
        b=qonbOWqOYU1X4/MySs+indRIJSI1wBZLVrKrFRer++kN38MtJGGLzi5VZqhFBNMz1n
         4LR8evqzQf8BqOjOHa5wBC7D/+ai9Q/17HUMrftuJmFBZMNUeEg1Mtx86wcOLWZKpNvf
         PZIT0FRDspB2UmxVDZzfjH+OfVzNhecdEkRbQhLBnSAtJVcIavlVHuy+HIETahIMtHhq
         1VnJjQMVWhJ7C/roJ333o1fp/jb44EkbLXA40WvfnpNoYQj2HVO8zKqMKHQsrx2dxG7V
         l2LpuN8O/gCxwyuPU2R0fCC9yDm/m9rV/ZzAZG/nOKWo/pJeiZuCweKEc8fMy6m8Tk8p
         8osA==
X-Gm-Message-State: APjAAAXz83gj3PrQm3smtehUciVX7XqxkzByEdz4r40EPWIvJr1E1cSB
        /7W3mfDySvxh0kPdBFhpaiUJPTeAYzVpmoI5
X-Google-Smtp-Source: APXvYqy5fzhYOJSXvdtzGuYRxNq7/S9xCwSYJ5Zg3y0zdEQUs8+GkbOXHTnlZaj2JbCGjTxK/8Hdzg==
X-Received: by 2002:adf:f591:: with SMTP id f17mr2519691wro.119.1561193476680;
        Sat, 22 Jun 2019 01:51:16 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:4bd:3f91:4ef8:ae7e])
        by smtp.gmail.com with ESMTPSA id v15sm4863589wrt.25.2019.06.22.01.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 01:51:16 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>,
        Luo XinanX <xinanx.luo@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Qian Cai <cai@lca.pw>, Tian Baofeng <baofeng.tian@intel.com>
Subject: [PATCH 4/4] efibc: Replace variable set function in notifier call
Date:   Sat, 22 Jun 2019 10:51:06 +0200
Message-Id: <20190622085106.24859-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
References: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tian Baofeng <baofeng.tian@intel.com>

Replace the variable set function from "efivar_entry_set" to
"efivar_entry_set_safe" in efibc panic notifier.
In safe function parameter "block" will set to false
and will call "efivar_entry_set_nonblocking"to set efi variables.
efivar_entry_set_nonblocking is guaranteed to
not block and is suitable for calling from crash/panic handlers.
In UEFI android platform, when warm reset happens,
with this change, efibc will not block the reboot process.
Otherwise, set variable will call queue work and send to other offlined
cpus then cause another panic, finally will cause reboot failure.

Signed-off-by: Tian Baofeng <baofeng.tian@intel.com>
Signed-off-by: Luo XinanX <xinanx.luo@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efibc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 61e099826cbb..35dccc88ac0a 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -43,11 +43,13 @@ static int efibc_set_variable(const char *name, const char *value)
 	efibc_str_to_str16(value, (efi_char16_t *)entry->var.Data);
 	memcpy(&entry->var.VendorGuid, &guid, sizeof(guid));
 
-	ret = efivar_entry_set(entry,
-			       EFI_VARIABLE_NON_VOLATILE
-			       | EFI_VARIABLE_BOOTSERVICE_ACCESS
-			       | EFI_VARIABLE_RUNTIME_ACCESS,
-			       size, entry->var.Data, NULL);
+	ret = efivar_entry_set_safe(entry->var.VariableName,
+				    entry->var.VendorGuid,
+				    EFI_VARIABLE_NON_VOLATILE
+				    | EFI_VARIABLE_BOOTSERVICE_ACCESS
+				    | EFI_VARIABLE_RUNTIME_ACCESS,
+				    false, size, entry->var.Data);
+
 	if (ret)
 		pr_err("failed to set %s EFI variable: 0x%x\n",
 		       name, ret);
-- 
2.20.1

