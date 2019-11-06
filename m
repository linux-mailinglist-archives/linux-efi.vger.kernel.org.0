Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9FFF193A
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 15:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKFO7S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 09:59:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50785 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKFO7S (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Nov 2019 09:59:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id 11so3851145wmk.0
        for <linux-efi@vger.kernel.org>; Wed, 06 Nov 2019 06:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AztCruFmGDbTmBcQ0023fAUHrEaxCmrC8iOrMdlCg2U=;
        b=PlNMzzRRH/iayy6MI1T+y2CGJaF0DQx5hmkZUxE2okn7WcxLQWfroOkv+tkBh+S3xD
         OCs0HLc+OtK3IRxRtzUQdd9zMb4dM3z9GoCeRATMZHUs8S6A85QimVLxAElX+jTLr797
         OWdLyPE+jMReBhTqAldFeA6f8Yje4SmKJccarAJwVkJEOFmFyfG11CA7mI0tUTBFY4mB
         47Iu7B4Sz/HUZfW66WARDF6N1FlaDAAmIn3KMb9nDZW6orTBbEHNtK81YNMxXmOBiRrW
         o7uwXz3ia7M+FLX9BI0InntyWkwTdf7bRRV0/Cc5qXasT/SFPAH+F5SbFlPB+dNb2VlB
         TtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AztCruFmGDbTmBcQ0023fAUHrEaxCmrC8iOrMdlCg2U=;
        b=nWJdNmSrdxDa2QjtOWFIsVODxhXPuOvvf3XINjhgupUMZ9SCSJRllb4C1N3nx8kPxF
         qhtmjM71NqgWl27PQwPFtW/+NmmjQpUOLNdaemCRs//bs2CCr4vO3ygJS4VHxPPxJuzq
         /LHrr73CUnWx7Q2uP1tHdO9OZckYF1SoeuA1iAzizA9HHi8pqVdm7iZnyfCGtBqrUcyI
         lyYTkw8XACbed8s0r0Y3PgDR3Ri+qQAXIgNAAtFfdex3HIvuU8IRsByZ4OS3Bh8IRQwC
         SJUY3Mpyx8yxnRfQhDOvGaw1bH0aixvMPx4eZANrshp1F5Xer1K+UsZdAsyk3BhD4a6j
         OC3Q==
X-Gm-Message-State: APjAAAWgYmvz390E77fyx3hDhVBXGM13QCaTQtMiDYFja+M26GMewUnh
        R988MJUZFtZ9XNklbrokkuY0Ffs/2ww1kdnH5gkY0g==
X-Google-Smtp-Source: APXvYqxdtojD2WI8ktRrMSUybjMyQJIG8WOkv8nzde3Eo6Yw91887HRCbdjg81bzeK/nMUXMLBGCLvx6qX9JEPG4eV4=
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr2916863wme.53.1573052356828;
 Wed, 06 Nov 2019 06:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20191105082924.289-1-kong.kongxinwei@hisilicon.com> <CAKv+Gu-V0S9EZeCjna5+P6v53evV-6uuG0rAShUA+uWb=NgH4g@mail.gmail.com>
In-Reply-To: <CAKv+Gu-V0S9EZeCjna5+P6v53evV-6uuG0rAShUA+uWb=NgH4g@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 6 Nov 2019 15:59:04 +0100
Message-ID: <CAKv+Gu9X4vCiS+BABs34t05MdF6GaFJr4jBTeaamngx3s=sPBg@mail.gmail.com>
Subject: Re: [PATCH] EFI/stub: tpm: enable tpm eventlog function for ARM64 platform
To:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Capper <steve.capper@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, zoucao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 6 Nov 2019 at 15:56, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 5 Nov 2019 at 09:29, Xinwei Kong <kong.kongxinwei@hisilicon.com> wrote:
> >
> > this patch gets tpm eventlog information such as device boot status,event guid
> > and so on, which will be from bios stage. it use "efi_retrieve_tpm2_eventlog"
> > functions to get it for ARM64 platorm.
> >
> > Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> > Signed-off-by: Zou Cao <zoucao@linux.alibaba.com>
> > ---
> >  drivers/firmware/efi/libstub/arm-stub.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> > index c382a48..37c8f81 100644
> > --- a/drivers/firmware/efi/libstub/arm-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm-stub.c
> > @@ -139,6 +139,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
> >         if (status != EFI_SUCCESS)
> >                 goto fail;
> >
> > +       efi_retrieve_tpm2_eventlog(sys_table);
> > +
>
> This function allocates memory, so calling it should be deferred until
> after we relocate the kernel, to prevent these allocations from using
> up space that we'd rather use for the kernel.
>
> Does it work for you if we move this call further down, right before
> the call to efi_enable_reset_attack_mitigation()? Please confirm.
>

Also, your S-o-b chain is incorrect. If Zou Cao provided you with the
patch, please credit her/him as the author (using git --reset-author)
and move your S-o-b last. If Zou Cao was a co-author [which seems
unlikely for a single line patch], use Co-developed-by+Signed-off-by.
In any case, the S-o-b of the person sending out the patch via email
should come last.
