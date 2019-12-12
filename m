Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251DD11CC34
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 12:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfLLL3l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 06:29:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35736 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfLLL3l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 06:29:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so2357327wro.2
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 03:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ff8kvOfcfOALIXUfCGutvVAMj040ypLju2A+AM62xIQ=;
        b=IGCBs4Mtic+oNWAalr3NAUX9KkFEXH95aNjxZKTqfQvu1rukRuG9kRUJwZ704Eb7Mz
         Zm/QIC6HFquwOlt+/EmM345M//ObhIHoGb39N4l7CAoH2Xjb0Iczo3lSGQNmK5GBrnfx
         /kZuuFyXKKfhfmF0UdRdSRAplj42XL/DX3GMTdMCJohjQwEZQkII40HAI21OalRatJPy
         rPz5CQuy9EzjKQK87gPA3kCiAw43KpujvitzldU0DqRL77SoVC4ETisqGSKsUXPygayN
         V4TTk9Sm46p/AGBpab4Ng78kfpfjQagMzbsrKnB3QCdOdWJLYUHSet3Fskx0fXZGNxXN
         909g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ff8kvOfcfOALIXUfCGutvVAMj040ypLju2A+AM62xIQ=;
        b=g5pqwWVVAHgxJdflMLCtJiaQeY4fPq1teXE5ofShWumJp9DOzKS07oN3WMf0LlAPtA
         jpLrx7Ik8OPpt9ulIWubHA3GgzLe0IzP1GxrlOC5w1JsMCbFhV+yXNq+rmgVbHnEXm7F
         yuvuuhkc7albr+ed/AFkGL2hRaVFZXaoVPdFt/WduiZZ6t5GVwst/BEFXWu6I6yP5IFr
         adAQMEVFzssgd+IRSffGohwkZy/CYDr5A8zJXVrbERqdTIGY1LRKR+hAuv6a2FALvheR
         wIWXbQhMT+1Z64vRTzrfBUXo8vQrl5jMkM7fqM15Ci2eMqlnFgUfVaGAkqQgdHfzt9XF
         +Img==
X-Gm-Message-State: APjAAAUQ7+cVUUMk5ZB7qHu11RYUIDHFdjxVB65fBRnkNa8o0LjE12yc
        2Xevid3VmWi7grqXgGd/ctp5ibAKi/bU9wEtKpjLpw==
X-Google-Smtp-Source: APXvYqzZ9aUK7/9Y4feqnEh82MKoyACLWQxNPBsIcpx0tCdePX43OW82PGyfMQUiM8WlaTyXNHAlduXvDivJBQ2SCUQ=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr5912115wrw.246.1576150179035;
 Thu, 12 Dec 2019 03:29:39 -0800 (PST)
MIME-Version: 1.0
References: <20191212103158.4958-1-hdegoede@redhat.com> <20191212103158.4958-3-hdegoede@redhat.com>
In-Reply-To: <20191212103158.4958-3-hdegoede@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 11:29:37 +0000
Message-ID: <CAKv+Gu9AjYVvLot9+enuwSWfyfzqgCWSuW3ioccm3FJ7KFA8eA@mail.gmail.com>
Subject: Re: [PATCH 5.5 regression fix 2/2] efi/libstub/helper: Initialize
 pointer variables to zero for mixed mode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Dec 2019 at 11:32, Hans de Goede <hdegoede@redhat.com> wrote:
>
> When running in EFI mixed mode (running a 64 bit kernel on 32 bit EFI
> firmware), we _must_ initialize any pointers which are returned by
> reference by an EFI call to NULL before making the EFI call.
>
> In mixed mode pointers are 64 bit, but when running on a 32 bit firmware,
> EFI calls which return a pointer value by reference only fill the lower
> 32 bits of the passed pointer, leaving the upper 32 bits uninitialized
> unless we explicitly set them to 0 before the call.
>
> We have had this bug in the efi-stub-helper.c file reading code for
> a while now, but this has likely not been noticed sofar because
> this code only gets triggered when LILO style file=... arguments are
> present on the kernel cmdline.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index e02579907f2e..6ca7d86743af 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -365,7 +365,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
>                                   u64 *file_sz)
>  {
>         efi_file_handle_t *h, *fh = __fh;

What about h? Doesn't it suffer from the same problem?

> -       efi_file_info_t *info;
> +       efi_file_info_t *info = NULL;
>         efi_status_t status;
>         efi_guid_t info_guid = EFI_FILE_INFO_ID;
>         unsigned long info_sz;

And info_sz?


> @@ -527,7 +527,7 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
>                                   unsigned long *load_addr,
>                                   unsigned long *load_size)
>  {
> -       struct file_info *files;
> +       struct file_info *files = NULL;
>         unsigned long file_addr;
>         u64 file_size_total;
>         efi_file_handle_t *fh = NULL;
> --
> 2.23.0
>
