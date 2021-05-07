Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA8376986
	for <lists+linux-efi@lfdr.de>; Fri,  7 May 2021 19:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhEGRfG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 May 2021 13:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232915AbhEGRfG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 7 May 2021 13:35:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6FCD613ED
        for <linux-efi@vger.kernel.org>; Fri,  7 May 2021 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620408845;
        bh=1jB8POvNckBwLQKb8H6oPrYBS+6vuxrvpipuF3/T+aQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MhaxTWCXpUqf9uYv9JWRMqjhDaS5Az1m5NBFokw/G5twi6wA7g0+TO2Ntww0QXvrY
         Uw6v5N5NyEs50EII1XRVL1CYchHEXsdcEEtKjTtsbSyULDqWWDCUMiIxAgP6gLoZ9/
         xaeDGTTCJB6jxTKssutzMqymJEFGkdhJ5gdAGu7xhPh/3JjeIOqWg8kVKNkoXWOPaY
         qNRC6dgkv8L+N+eiY5jCOlavv0JJDR1UV3oPTXNMCvk4AhkmFulUL6xbxeOIji8tVn
         IWOmjreXvV8HxGHbNzwn4eCa4D+A+A4ChbT96A9vH7CHTb65u173qr+Xgf+JC3UC9C
         kn+e8/fHzsXRw==
Received: by mail-ot1-f52.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so8570929oth.5
        for <linux-efi@vger.kernel.org>; Fri, 07 May 2021 10:34:05 -0700 (PDT)
X-Gm-Message-State: AOAM531PTiWOpDtAfLpHpJRxqYuCNQSrNfAytJJMRYBBhkqKGV3+6gjB
        y5sDNf3gQQCeoQWNyFQ+WLRdlN9k8dGe9u9ArvU=
X-Google-Smtp-Source: ABdhPJzlklPvBSES/BzfeYZSAYyOqJCuTHZ0Dc90D0Kmea5Bb20N9g+fJZpMk0kEAbDfT7jMz4gRqs6ljeL57oW0ZKM=
X-Received: by 2002:a9d:69c5:: with SMTP id v5mr8964475oto.108.1620408845053;
 Fri, 07 May 2021 10:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <8986e4ad-cd60-8e40-b0d5-9165a15c0cb0@gmail.com>
In-Reply-To: <8986e4ad-cd60-8e40-b0d5-9165a15c0cb0@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 7 May 2021 19:33:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEN1qDmUR2XBOhdOMDXkaff4rp4iBUWP6KeNa1uAzdT4g@mail.gmail.com>
Message-ID: <CAMj1kXEN1qDmUR2XBOhdOMDXkaff4rp4iBUWP6KeNa1uAzdT4g@mail.gmail.com>
Subject: Re: [PATCH] efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to be cleared
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 30 Apr 2021 at 16:23, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> UEFI spec 2.9, p.108, table 4-1 lists the scenario that both attributes
> are cleared with the description "No memory access protection is
> possible for Entry". So we can have valid entries where both attributes
> are cleared, so remove the check.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks, I'll queue this up after the merge window.

> ---
>  drivers/firmware/efi/memattr.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index 5737cb0fc..0a9aba5f9 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -67,11 +67,6 @@ static bool entry_is_valid(const efi_memory_desc_t *in, efi_memory_desc_t *out)
>                 return false;
>         }
>
> -       if (!(in->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))) {
> -               pr_warn("Entry attributes invalid: RO and XP bits both cleared\n");
> -               return false;
> -       }
> -
>         if (PAGE_SIZE > EFI_PAGE_SIZE &&
>             (!PAGE_ALIGNED(in->phys_addr) ||
>              !PAGE_ALIGNED(in->num_pages << EFI_PAGE_SHIFT))) {
> --
> 2.31.1
>
