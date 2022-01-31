Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D0F4A3D79
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 06:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiAaFnw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 00:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiAaFnv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jan 2022 00:43:51 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED3C061714
        for <linux-efi@vger.kernel.org>; Sun, 30 Jan 2022 21:43:50 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n17so15344930iod.4
        for <linux-efi@vger.kernel.org>; Sun, 30 Jan 2022 21:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dSQA6YIC7NS85JzEAYysawlupOe+DbrucpjQ8TclmuQ=;
        b=qAdZgPGtXl7a9V0MGC8i/n12XE91DUALNaJBk1lholx+SBndnpAfCoKkV0i5QgrvMO
         06heFF5Ysd8OiScmVKu/B7N0Lw2CQZRr2Rrg11S+4EVF1HeCaz5HMbFUkngBXJgFd4qG
         /+7NqGHuBjVNAT9R1VGrSeGqVAvyoVoKDyW0QxlioAR419TgHkh2LQflTN4yVMeXVLbX
         E8wFnHzOc/XyxtbRAjAuumNHIdy9yed5idEx4gKB87b5116Zw/FJdAzbD1cW82pBEHRG
         ovAMs/bspQXDDzytHdvBWCPvH/IZixYvhpcmwwjADn70kv5cM2PAsk4ANE/+754GMGL4
         Mf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dSQA6YIC7NS85JzEAYysawlupOe+DbrucpjQ8TclmuQ=;
        b=ddOLYl4OJH2snPiYlZF1/jiv6TjmkpyTyiwND04ydGVpNY05PV++BflVtzETkpKTqN
         Y/rBDq/js2TKiL7TEkykmD72K/1sGduQRm7qsGryadDS5TL1CGzlMGNGdDfymeijJaB6
         WSKY9QcWvkW6wZMJT/VYIQfABizzOKfYkO96/bstIUowDsv0TweN5PdB+byIZAf4CpQW
         wQd0rx/6Yeg/dzEZ8QdpnWEx9bDaXOwDb9EO3UuIopNDD0kPMmbpGP4Q1wm1fagBmCrj
         gr+zmKb0/sEoN4qb8RIbhxQJBjsjak4itjT0H2ECGDC8HB4wrbB9a6eQnxVXSEnQQHjq
         Q1cg==
X-Gm-Message-State: AOAM531blWrDL0DvykkC9HIxX4BKcFu9fAcAK3zDqe5+bX3qc0WjkdII
        LOx83d+fal1ciLIi3SeBCQBSQcB984g+nItxGCw=
X-Google-Smtp-Source: ABdhPJwdWtiQ5604IMAsGu3kpMehnGDCmlF3keMyqV+En4dVenpZ8TxoyIdmIUph5fjWt28mjraA1KcKHhh/56id97E=
X-Received: by 2002:a05:6602:1652:: with SMTP id y18mr10380361iow.187.1643607829926;
 Sun, 30 Jan 2022 21:43:49 -0800 (PST)
MIME-Version: 1.0
From:   arshad hussain <arshad.super@gmail.com>
Date:   Mon, 31 Jan 2022 11:13:39 +0530
Message-ID: <CAKsu7qySyxVLMTjf9FG5=g1f0oP_CV61Ae-NunFK5MH-7iE8hg@mail.gmail.com>
Subject: [PATCH] efi: Move error message to warning
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Husein Bahrainwala <heseinzb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Error message "...kernel image not aligned on 64k boundary"
does not seem to be a real error as it does not
cause any functional issue or stops the system from
booting or working. Move this "error" to "warning"
as this error is not handled at the moment. Also,
watching "warn" message instead of "ERROR" calms
the end-user.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Arshad Hussain <arshad.super@gmail.com>
Signed-off-by: Husein Bahrainwala <heseinzb@gmail.com>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c
b/drivers/firmware/efi/libstub/arm64-stub.c
index 2363fee92..5ed09be49 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -120,8 +120,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
         efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has
bogus value\n");

     if (!IS_ALIGNED((u64)_text, EFI_KIMG_ALIGN))
-        efi_err("FIRMWARE BUG: kernel image not aligned on %ldk boundary\n",
-            EFI_KIMG_ALIGN >> 10);
+        efi_warn("FIRMWARE BUG: kernel image not aligned on %ldk boundary\n",
+             EFI_KIMG_ALIGN >> 10);

     kernel_size = _edata - _text;
     kernel_memsize = kernel_size + (_end - _edata);
-- 
2.25.1
