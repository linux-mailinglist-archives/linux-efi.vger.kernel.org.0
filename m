Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818143CBA41
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 18:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhGPQHU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 12:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236232AbhGPQHU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 12:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5FC361164;
        Fri, 16 Jul 2021 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626451464;
        bh=qt751I4RwKqXaHuRncO99dJuNHhGZqBke83Px+pHWDU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X4jjLqQCObWspZhSMwq/05luguE+nCMH7oakcTaWVg93BBYyh2XtZTITjnqmhksXK
         4B/Frbb4BABVGqu1Jg0knj9NRO6ewf4XszPZGCtFRUqRfRR80DVnGzUTATtN44GSJH
         FlXvf93ptBza8SFolcFD6MUzXlDNWc7wZWnixXAvRnv805BcujvaBuQBjL4S84hJ7K
         dvf0iRAO7X0K6g/MejxUgcRsbe1c80SbBUa6DD6tb85DghNYw+ePKUONQzkzC3E6f0
         3rD0rws4AEt73L13NCWyn7kvwq/y4jytygsSK44gulD0UUS8jt0qxtLj+PZgRBV3hw
         i73FXrei+xoQQ==
Received: by mail-oo1-f44.google.com with SMTP id i11-20020a4adf0b0000b0290263e1ba7ff9so24673oou.2;
        Fri, 16 Jul 2021 09:04:24 -0700 (PDT)
X-Gm-Message-State: AOAM533fPMA+PTy+DoIfCTkf3VKrVKZab32L+zU/YU1ZVLHHxlvIXixq
        QRYBz8oyYyapiR7MKSVVz9zW5+jwrTp0iLkMJTk=
X-Google-Smtp-Source: ABdhPJw6aBdbGdXwxfDQhL0w2B1aHgkbeA26YHrDT96N1lBUoVHBtFzZH4O8KumXoz02zE8L0djrhZ4+udbc5OXhjfA=
X-Received: by 2002:a4a:e923:: with SMTP id a3mr8143205ooe.45.1626451464224;
 Fri, 16 Jul 2021 09:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210708094654.4157-1-msuchanek@suse.de> <20210709163846.3e753oectgbt7wh7@kernel.org>
In-Reply-To: <20210709163846.3e753oectgbt7wh7@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Jul 2021 18:04:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEDa4pzBjQ8hzipOY=VbErvELLyiU7z_SGy_Bd9OKxcYw@mail.gmail.com>
Message-ID: <CAMj1kXEDa4pzBjQ8hzipOY=VbErvELLyiU7z_SGy_Bd9OKxcYw@mail.gmail.com>
Subject: Re: [PATCH] efi/tpm: Differentiate missing and invalid final event
 log table.
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 9 Jul 2021 at 18:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, Jul 08, 2021 at 11:46:54AM +0200, Michal Suchanek wrote:
> > Missing TPM final event log table is not a firmware bug.
> >
> > Clearly if providing event log in the old format makes the final event
> > log invalid it should not be provided at least in that case.
> >
> > Fixes: b4f1874c6216 ("tpm: check event log version before reading final events")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  drivers/firmware/efi/tpm.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > index c1955d320fec..8f665678e9e3 100644
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -62,9 +62,11 @@ int __init efi_tpm_eventlog_init(void)
> >       tbl_size = sizeof(*log_tbl) + log_tbl->size;
> >       memblock_reserve(efi.tpm_log, tbl_size);
> >
> > -     if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
> > -         log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> > -             pr_warn(FW_BUG "TPM Final Events table missing or invalid\n");
> > +     if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > +             pr_info("TPM Final Events table not present\n");
> > +             goto out;
> > +     } else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> > +             pr_warn(FW_BUG "TPM Final Events table invalid\n");
> >               goto out;
> >       }
> >
> > --
> > 2.26.2
> >
> >
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>

Queued as a fix, thanks
