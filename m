Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD336FC4D
	for <lists+linux-efi@lfdr.de>; Fri, 30 Apr 2021 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhD3OYC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Apr 2021 10:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhD3OXt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Apr 2021 10:23:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A703C06138E
        for <linux-efi@vger.kernel.org>; Fri, 30 Apr 2021 07:22:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n127so26130060wmb.5
        for <linux-efi@vger.kernel.org>; Fri, 30 Apr 2021 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GqIH6yuJO1H3N6Mw3R5Ju23equ5X7EiZ7ii9zwrqrJ0=;
        b=JZp8GVEIhKbWG/wCbS+EZXzUQXGjgV41QrsTCfchG6583LNk1dclaNtRJ2IkpCGf+4
         hERAcyBfR/kAupAc61sKp6zeTxPwCmUjUmHTLqR9gzRmgsjVIG4m+eghp4GILNQzyV0g
         DUfB+aEUIPYgToLFsPeYBooJzr5EB2Fu9xUZCpd8Jnz8OImG9NMYgs5xuxRkRXpHm4XH
         672fbCjl0p9LjT/yN1Q+hkfnk8TpwTWrnIcd6Cs1bqUsePM3wTCdhJLK8ETOvW7l6HCc
         np9FtINwDl/bOzr4kHhekekd5idhtgcj8hFybVUHgDwpcIR9KkpNL9zVPQvWtNo/c4hU
         E/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GqIH6yuJO1H3N6Mw3R5Ju23equ5X7EiZ7ii9zwrqrJ0=;
        b=QfWT2YumlJ50OCH5IgHodq9LGSbnZOTmQIbSzkipoqdGCG0D9PzYfGgZNzvpBgYgU4
         F8CQJOEN+J9R0a0lHz6gfKdakJBtDfuZoQybOjn8FgpSag22ySZ6SyXzKodqTsk5+4Jq
         i3y2izLdurqcZ0IRsXcn1ADUky4qDCDx5ODL2DiYkVE804qUTpQ8+J2gB1jCB+2utzXM
         PU82nZT3qLBT7j3/ZJO+g6w6yYlT8cL1tX0PnTMsU/0gDL98nsidA5NqEKiTfk9zIUeJ
         8qxL7BOoyi9BF3GUtTWjrKTbuBKjx3Qs7wpsGdPjlVDagsLt4atwc2ryvy2xeNtLI2M8
         g48A==
X-Gm-Message-State: AOAM531YaDJxxQq8Mkkb3vc/X0ZbcDzeeU2b/h1yclmveDyqRDn0jTnR
        Rip9/NOR+/W1QCA1pjD1VV2DIi42dGnCEg==
X-Google-Smtp-Source: ABdhPJyCwsSCGMJVIxx1sPvkhDJAWDvvOUmAjTGq0pQODVNKUHUpHpr1pKfmvck9V9Y0KFYtHom9FQ==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr3954414wmp.164.1619792577645;
        Fri, 30 Apr 2021 07:22:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:ad00:f6bf:8c3b:84f1? (p200300ea8f384600ad00f6bf8c3b84f1.dip0.t-ipconnect.de. [2003:ea:8f38:4600:ad00:f6bf:8c3b:84f1])
        by smtp.googlemail.com with ESMTPSA id a142sm13912820wmd.7.2021.04.30.07.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 07:22:57 -0700 (PDT)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to be cleared
Message-ID: <8986e4ad-cd60-8e40-b0d5-9165a15c0cb0@gmail.com>
Date:   Fri, 30 Apr 2021 16:22:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI spec 2.9, p.108, table 4-1 lists the scenario that both attributes
are cleared with the description "No memory access protection is
possible for Entry". So we can have valid entries where both attributes
are cleared, so remove the check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/efi/memattr.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index 5737cb0fc..0a9aba5f9 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -67,11 +67,6 @@ static bool entry_is_valid(const efi_memory_desc_t *in, efi_memory_desc_t *out)
 		return false;
 	}
 
-	if (!(in->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))) {
-		pr_warn("Entry attributes invalid: RO and XP bits both cleared\n");
-		return false;
-	}
-
 	if (PAGE_SIZE > EFI_PAGE_SIZE &&
 	    (!PAGE_ALIGNED(in->phys_addr) ||
 	     !PAGE_ALIGNED(in->num_pages << EFI_PAGE_SHIFT))) {
-- 
2.31.1

