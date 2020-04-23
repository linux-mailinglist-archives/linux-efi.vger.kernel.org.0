Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C631B5B2E
	for <lists+linux-efi@lfdr.de>; Thu, 23 Apr 2020 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWMQ6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Apr 2020 08:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgDWMQ5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Apr 2020 08:16:57 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4358020736;
        Thu, 23 Apr 2020 12:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587644217;
        bh=U5EcyJ4LAn+9tG4HUQGnWOxyVrEOqSnXbGZQjRBnVM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YSz9I4Hg0vhedotjh1JhX7J6tShH1/TBbRuE3PJraGlmGq1ybu0HGKWnJBWDZ9Qpd
         Rior/+hBjaqRsP3a7b9/cLkCxloz5uT2EyzcZk9/0cHma6auWkFQ0D98MLaluhvdF2
         lf+9XmR8e5S5++ubDqqY6en7mYq0jej/66vlSvqE=
Received: by mail-io1-f42.google.com with SMTP id u11so6148845iow.4;
        Thu, 23 Apr 2020 05:16:57 -0700 (PDT)
X-Gm-Message-State: AGi0PubRlmK4wBWm4X983IrbAx/cjtbDQPGIIU8NFAHEQMFrRP9gWTHV
        lzSm7KorrRjBYN5ea+Au0tQ56svY1R71m2+WF1M=
X-Google-Smtp-Source: APiQypJgcYYnNF9+i/ZUlfaQMKdUjHUmKXoDUpPNNGFEVVKm4tNUPY/qiqlS2CrCHCqaVVrHvrBSjOetHLLKQqyKzsg=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr3315558ioh.203.1587644216688;
 Thu, 23 Apr 2020 05:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <1587643713-28169-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1587643713-28169-1-git-send-email-zou_wei@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 23 Apr 2020 14:16:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFdaGNPc284T+2hs4oGjmwnjbvCdD_Y2xfwTfbOygGwyw@mail.gmail.com>
Message-ID: <CAMj1kXFdaGNPc284T+2hs4oGjmwnjbvCdD_Y2xfwTfbOygGwyw@mail.gmail.com>
Subject: Re: [PATCH -next] efi/libstub/arm: Make install_memreserve_table static
To:     Zou Wei <zou_wei@huawei.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 23 Apr 2020 at 14:02, Zou Wei <zou_wei@huawei.com> wrote:
>
> Fix the following sparse warning:
>
> drivers/firmware/efi/libstub/arm-stub.c:68:6: warning:
> symbol 'install_memreserve_table' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/firmware/efi/libstub/arm-stub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index 99a5cde..8a26cc1 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -65,7 +65,7 @@ static struct screen_info *setup_graphics(void)
>         return si;
>  }
>
> -void install_memreserve_table(void)
> +static void install_memreserve_table(void)
>  {
>         struct linux_efi_memreserve *rsv;
>         efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
> --
> 2.6.2
>

Applied to efi/next, thanks.
