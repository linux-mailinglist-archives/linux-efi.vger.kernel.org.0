Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEDD4A3D7E
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 06:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiAaFtO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 00:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiAaFtO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jan 2022 00:49:14 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E05C061714
        for <linux-efi@vger.kernel.org>; Sun, 30 Jan 2022 21:49:13 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r144so15308750iod.9
        for <linux-efi@vger.kernel.org>; Sun, 30 Jan 2022 21:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjH4klO7py2Z+V/vcb3V81RRbzsMHfDg3b+RxTgkE64=;
        b=qmBUTklOW69CaueK9hznp45EZM1PWA51NMfi1P7lSV8rV1uZyi5CxLMiYTZVAqh9yH
         m9F+dhggyCBykMVzVLr3+QIdOWe7qoIZUPv9fIa2mlyN0BbmjwHNMRJ2Lfpkuhttv5C3
         v12J6P+c3YsIXsdi5woCXN8b88N4aUtELFE86iU3NeOU3m2GmYLaafLy83g3ovD3fxwF
         hnp1eXbjrcOpTIZfQ/wIP4sJqr0jZz6oKWon9ojhQxgMEboEemmD5YyOfQKIR1exF4OX
         MAqjlRbevCNdgBVHzwSrK72UdWLFgwH95tpl7aPgvWR6Sv9m8o//SsegTWTQPfL422lz
         wFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjH4klO7py2Z+V/vcb3V81RRbzsMHfDg3b+RxTgkE64=;
        b=YR6SduKC2e0DOuMjFgdD3xL9Ner5jzFJB588UzVzFuxezmU63ppQ4xTfkknPJwoQeB
         lcrwFiF7htD3yHFkxmABOh+5hO5aeXJuWFuZyrMmLP1wqpJerVyQdVAHY4p+Iek7YQ6p
         Km3vJNmWeAHOW8s9YlFqCwLJnkGBpNmw9eZyCL0xBY4y9bKsoESp3GTSYEc0/TnR7yeP
         pzSkxeMIy9NKgyc3GMn7AHUlCnAro4jZcQQZBAssZiC96U++xtsIZI90WuhwcSKeHerb
         j/osgko7DSFYWG8FZar87EnruLn/MIR4f/RK1D9+4Cr2jUY2GPOKolk5yinpVJGMcgE4
         2aSQ==
X-Gm-Message-State: AOAM530i9LCPH2hjCaZyamoWml56+FDZVfkz+ZjotPftDrryEraXbTBe
        PWrtMZHAvQTzxLgSKgJnJ+9/Z3LYHclVkr+DGidGlF3zlLg=
X-Google-Smtp-Source: ABdhPJwphz/Le7Fq6KM1u9uvyBm52sxWEZ+UkOptqn5nWm4MZfNyl3tGibIVUYBC0OArI2AzcaIxYo3afJWl7G+3ZuA=
X-Received: by 2002:a05:6638:2656:: with SMTP id n22mr3711056jat.107.1643608153293;
 Sun, 30 Jan 2022 21:49:13 -0800 (PST)
MIME-Version: 1.0
References: <CAKsu7qySyxVLMTjf9FG5=g1f0oP_CV61Ae-NunFK5MH-7iE8hg@mail.gmail.com>
In-Reply-To: <CAKsu7qySyxVLMTjf9FG5=g1f0oP_CV61Ae-NunFK5MH-7iE8hg@mail.gmail.com>
From:   arshad hussain <arshad.super@gmail.com>
Date:   Mon, 31 Jan 2022 11:19:02 +0530
Message-ID: <CAKsu7qyvAahUOc_1uzzaW=jMi6DesGMyFhoq=VOxD=3yfAhxNg@mail.gmail.com>
Subject: Re: [PATCH] efi: Move error message to warning
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Husein Bahrainwala <huseinzb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There was a typo in the previous patch email. Please review this version

Thanks
----------

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
Signed-off-by: Husein Bahrainwala <huseinzb@gmail.com>
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
