Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75407CC4B8
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343637AbjJQNZ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 09:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjJQNZ2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 09:25:28 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC1AF0
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 06:25:26 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-408212415abso2817965e9.2
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697549125; x=1698153925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFV+sNLUOjiZNacNJ94AXPlpngZJzJdSda0rmHrbDhQ=;
        b=Ci9ebGHlok2KYmyKFFpfru9NNjD2W6fYTzDRanSUuqrdrt6fhWoo9VWfFYp82MdEwD
         EOMiZbFqoyOMjRMUQ4vCZzebWA80RtDPSIfGWHdpi9tpeZgd3RkG09jlojU3s2v8AbKQ
         NKmfKNacfw0sppIPREigVZQZyEtZ9ht1YjveA3b8SEo1e4K0tyaPYHe4H5XNUEmWdiya
         cCCeusS4tXkFS3LO1lh7cYoUIK+DzC4JrioEqgrFxAswRF5LfprKIicZbDjf+e/QR27A
         LMieooSiB7sBcZ0m6m69A3HuIfjGlAHDobZIW/GTzixQYB0NzMS8hq2HXAeh5fpENA76
         PKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697549125; x=1698153925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFV+sNLUOjiZNacNJ94AXPlpngZJzJdSda0rmHrbDhQ=;
        b=fyPX+jTG9Vf5QQX73fD+4IhwBOzadq7xBrmE5Mk1RLMnn3yEgxFvdlF23dJf5OuJRW
         5eBgLEkQDRqzVsFJz8tMUkaz2s0plLGm6RaqtAoZ8dLkhdvbgE1NF/US+VzU2BcyxhO2
         KgsQlUX+C9NMcqonKnumYGJaDhT0n6q0Th3S0k2AulQBJrOHTlxIiKo51ukru5vaS77w
         I7t0QJKfW1bZv8Xtt1Xa1EFzqO9fo5KhgQ7+sVWQHKXmEPr6yT20R5HxmwX/TImaUfSe
         dpAqjZTR31dVEBo4lFNPuklH5mHCGmecP03Guq2DeiBugTVYaVjIEMyndpKYzgN1//7h
         0SZQ==
X-Gm-Message-State: AOJu0YzryCF9/nX5r4hwOkfUu4AwrlwMlVL/XDzpFhRF/E3nIZyIqFEV
        y6GOVOfbJ+uUUVjtHzil0hO2PmhsCqh5GJLqpm99Gp+M/yzfk1JxgA5C8ooKOJ/emXmq3dZBWmI
        y26H9PBtKtQGInTHCcq/pp2Do3Qy4qYehfmshIgVfBpxJehbSRmR5LJz/BLCO
X-Google-Smtp-Source: AGHT+IF1v1zBgKEkteeDpKLZ9bVoMzmImfkOVs7eHL2NjTOvz3ZFwg9/pKnYm1prT8TRwQUwrNvjfwKi
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:210b:b0:402:f536:3170 with SMTP id
 u11-20020a05600c210b00b00402f5363170mr28204wml.1.1697549124910; Tue, 17 Oct
 2023 06:25:24 -0700 (PDT)
Date:   Tue, 17 Oct 2023 15:25:13 +0200
In-Reply-To: <20231017132510.3845531-4-ardb@google.com>
Mime-Version: 1.0
References: <20231017132510.3845531-4-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=ardb@kernel.org;
 h=from:subject; bh=2D4FfO69EJw6e2QIOnjZiyJDDSm7LFecjZu7i9HWUp4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIVWv29Jl+5Fv4kU6mpfP9itsFeWY/cplSQyP+65W4RVxR
 t5s/qc7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESKnjH8FX71/sBW5Qie3Jsm
 HocmHrA+9ObfvAytbh75pXUXruo/X8bwV0DsmBGT2xXH5p1xxVc/OF2t4Xw/jWt9lnqV9vcdl8+ asAIA
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017132510.3845531-6-ardb@google.com>
Subject: [PATCH v2 2/2] x86/boot: efistub: Assign global boot_params variable
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org, mingo@kernel.org
Cc:     x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Now that the x86 EFI stub calls into some APIs exposed by the
decompressor (e.g., kaslr_get_random_long()), it is necessary to ensure
that the global boot_params variable is set correctly before doing so.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3bfc59637dd1..2e374ce099ab 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -818,6 +818,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	unsigned long kernel_entry;
 	efi_status_t status;
 
+	boot_params_p = boot_params;
+
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
-- 
2.42.0.655.g421f12c284-goog

