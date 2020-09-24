Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1808427742C
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgIXOig (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 10:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgIXOif (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Sep 2020 10:38:35 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 319FC238E4
        for <linux-efi@vger.kernel.org>; Thu, 24 Sep 2020 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600958315;
        bh=4BpJxN5Zi7zJsuueb5ZlYi8uw5AN3/piBt/blmoda6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GR/cy7pA2QhrDrpf5FKTJODSe/HVZ1BJzu9qnvRkO77bazo5IAaQSI2pKdZ6sBofW
         QJbGE8UO5cAPISc6KyhYr4XV9hLmOMsqargYI1oJqdo2Ut8aLOr1HHZZ/NjWd/lUaf
         1kDVRn6YCBapF7f5OFLbr7bVBFkmhr3ojMkn2zM4=
Received: by mail-oi1-f177.google.com with SMTP id 185so3836113oie.11
        for <linux-efi@vger.kernel.org>; Thu, 24 Sep 2020 07:38:35 -0700 (PDT)
X-Gm-Message-State: AOAM531UovVTVhQhggufbH/bGrOfkDbTl6dDROdHieYy6ooHgWMFqmEV
        6LVQTa92alU2tlMGFWNIPfMkcxQqtHA/n1ULuis=
X-Google-Smtp-Source: ABdhPJxA+xn+NrYT1g9/sLCsgQvP6LeQCOvrf1V7lx547BUfzG8oNGRQa+UPwamstIa2JFIC+P+2Y9yS59/ZyHVDZmg=
X-Received: by 2002:a54:4517:: with SMTP id l23mr2792691oil.174.1600958314471;
 Thu, 24 Sep 2020 07:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <1600914018-12697-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1600914018-12697-1-git-send-email-tiantao6@hisilicon.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Sep 2020 16:38:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGAHzdSaCn9VgZiO8jphwqAJGo9am2GGG6HdZYPu2Mocg@mail.gmail.com>
Message-ID: <CAMj1kXGAHzdSaCn9VgZiO8jphwqAJGo9am2GGG6HdZYPu2Mocg@mail.gmail.com>
Subject: Re: [PATCH] efi: Delete deprecated parameter comments
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 24 Sep 2020 at 04:22, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Delete deprecated parameter comments to  fix warnings reported by make
> W=1.
> drivers/firmware/efi/vars.c:428: warning: Excess function parameter
> 'atomic' description in 'efivar_init'
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied as a fix, thanks.

> ---
>  drivers/firmware/efi/vars.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 973eef2..274b0ee 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -414,7 +414,6 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
>   * efivar_init - build the initial list of EFI variables
>   * @func: callback function to invoke for every variable
>   * @data: function-specific data to pass to @func
> - * @atomic: do we need to execute the @func-loop atomically?
>   * @duplicates: error if we encounter duplicates on @head?
>   * @head: initialised head of variable list
>   *
> --
> 2.7.4
>
