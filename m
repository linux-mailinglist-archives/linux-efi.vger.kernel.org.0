Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F2493EF7
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jan 2022 18:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244606AbiASRXE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jan 2022 12:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiASRXE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jan 2022 12:23:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FA6C061574;
        Wed, 19 Jan 2022 09:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C878B81A71;
        Wed, 19 Jan 2022 17:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EABC340E1;
        Wed, 19 Jan 2022 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642612981;
        bh=/AmB+R8lcjTOaUWVStWTJfgQQeNwP0ttFYlVemKo8zo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FiHjmEiEBEtFlJ1f2yV2o1QH1sI9wPNewlUGRpUTRS5XHnehzcMakrrHZz7+3UTfW
         3HMzcE00/KK4yXf9FNuCclCGl7LskHwDKfM39R0FiXQ8CHbAem7WvcWZYF+7UAdT2A
         wqtqJZsbk0+V8dvtd4eWoTDGy/T2O42OoxXteWZeWCHLtY1R1vpwEifUm4QsXrVPkV
         bmiQx6OH+mITGuZVqdttxqbJ/hzmVoTctgnMlJeXNMcOHwN4B8viCAvqKMutAQGqAX
         IJfMUyQNrwlnz2lyUOcExjLy20+Mt95O5VNUm3yPVW37BIhlh7PSYT63H0iPq693Gu
         swYlpltJMZA/A==
Received: by mail-wm1-f49.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso6897676wms.4;
        Wed, 19 Jan 2022 09:23:00 -0800 (PST)
X-Gm-Message-State: AOAM531UXc8RuP66mzOJmUbNsJQ8tWaUymkEnU78XDBA9n0BLj1df0Rs
        tx4f+5KH80t5bpXSl8YMUtke7S3YbsCOrtSgo6U=
X-Google-Smtp-Source: ABdhPJzYEncUKv+J2k0P025BJCluvJy2Isp3uxz1uZU+POwVDgYLA/ypp2CGvDj+1iEqW9QpNbityUTG9HOwpaCSk78=
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr4713576wmj.56.1642612979347;
 Wed, 19 Jan 2022 09:22:59 -0800 (PST)
MIME-Version: 1.0
References: <1642608867-21307-1-git-send-email-mihai.carabas@oracle.com>
In-Reply-To: <1642608867-21307-1-git-send-email-mihai.carabas@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jan 2022 18:22:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG14Tx41JZ1NZXkJVTSai++eb-zfv1Dk5dP1QDoDkDFEQ@mail.gmail.com>
Message-ID: <CAMj1kXG14Tx41JZ1NZXkJVTSai++eb-zfv1Dk5dP1QDoDkDFEQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: arm64: Fix image check alignment at entry
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 19 Jan 2022 at 18:10, Mihai Carabas <mihai.carabas@oracle.com> wrote:
>
> The kernel is aligned at SEGMENT_SIZE and this is the size populated in the PE
> headers:
>
> arch/arm64/kernel/efi-header.S: .long   SEGMENT_ALIGN // SectionAlignment
>
> EFI_KIMG_ALIGN is defined as: (SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN :
> THREAD_ALIGN)
>
> So it depends on THREAD_ALIGN. On newer builds this message started to appear
> even though the loader is taking into account the PE header (which is stating
> SEGMENT_ALIGN).
>
> Fixes: c32ac11da3f8 ("efi/libstub: arm64: Double check image alignment at entry")
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>

Thanks. I'll queue this up as a fix.

> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 2363fee9211c..9cc556013d08 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -119,9 +119,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>         if (image->image_base != _text)
>                 efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
>
> -       if (!IS_ALIGNED((u64)_text, EFI_KIMG_ALIGN))
> -               efi_err("FIRMWARE BUG: kernel image not aligned on %ldk boundary\n",
> -                       EFI_KIMG_ALIGN >> 10);
> +       if (!IS_ALIGNED((u64)_text, SEGMENT_ALIGN))
> +               efi_err("FIRMWARE BUG: kernel image not aligned on %dk boundary\n",
> +                       SEGMENT_ALIGN >> 10);
>
>         kernel_size = _edata - _text;
>         kernel_memsize = kernel_size + (_end - _edata);
> --
> 1.8.3.1
>
