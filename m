Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F512E70C5
	for <lists+linux-efi@lfdr.de>; Tue, 29 Dec 2020 14:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2NCd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Dec 2020 08:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgL2NCc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Dec 2020 08:02:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB15D20867;
        Tue, 29 Dec 2020 13:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609246911;
        bh=jxRpIBnA/TEFkDnlujeZKbR7yvaeen/RJzbWpxWgWM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kopjODYjeXAmGXlUnbd4m4aCDTVFEJduxJVBUaBVXJ+j7qnjkzjuR3SttK0rbGIPX
         frB8RJ3sAI+Vxj3XB12K27KpeLhiXqV9ezF5h+gTAeqmGi0U1fv03cGeIGiUxjx/Yc
         Moqin18iQ8pSUMzIg/sGLqFUpY4qfNiBlqIlCuf6E9e00LcdEfGHsturpizJOj4SdL
         ScH0Zs8r5hLaQGwES1ewuIWhCc4WbYeLSI1dQUTOT90igNksAYhCuavZGJVx6oGEG+
         a7FzuQwwX8B+uyKvAwqswtwhRuU+8yy3b1RZPrjNCD4jL4GQd0mtk61gMHUXFPQlcQ
         gOzxmZcwQV33Q==
Received: by mail-ot1-f42.google.com with SMTP id i6so11777315otr.2;
        Tue, 29 Dec 2020 05:01:51 -0800 (PST)
X-Gm-Message-State: AOAM530bM7jNoy2Nxo7kwoDgHoEGTwcObhlRvC1Jc+wHkLsPbeO8RhI/
        eYaV2Lgm135s8R7VcoeBEoz1GqpZpbt1EXzxZFM=
X-Google-Smtp-Source: ABdhPJygobuwVqLYHz+mRLLv/+yv9CqwMo2io2KJO1VT0oj3eyR6h7lf/PPz5ghGQBVZWrHxCoB5FIHqCSGRNRYmb5o=
X-Received: by 2002:a9d:12c:: with SMTP id 41mr35377364otu.77.1609246911170;
 Tue, 29 Dec 2020 05:01:51 -0800 (PST)
MIME-Version: 1.0
References: <20201127192051.1430-1-xypron.glpk@gmx.de> <bb31dcbe-cf19-64c5-daa0-5eb84f1a3583@gmx.de>
In-Reply-To: <bb31dcbe-cf19-64c5-daa0-5eb84f1a3583@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 29 Dec 2020 14:01:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXERVcY5myjAxSgqVf99Pr10utyoQF4N=06508cXd9EEPQ@mail.gmail.com>
Message-ID: <CAMj1kXERVcY5myjAxSgqVf99Pr10utyoQF4N=06508cXd9EEPQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ivan Hu <ivan.hu@canonical.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        fwts-devel@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 26 Dec 2020 at 11:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/27/20 8:20 PM, Heinrich Schuchardt wrote:
> > Since the UEFI 2.8A specification the UEFI enabled firmware provides a
> > configuration table EFI_RT_PROPERTIES_TABLE which indicates which runtime
> > services are enabled. The EFI stub reads this table and saves the value of
> > the field RuntimeServicesSupported internally.
> >
> > The Firmware Test Suite requires the value to determine if UEFI runtime
> > services are correctly implemented.
> >
> > With this patch an IOCTL call is provided to read the value of the field
> > RuntimeServicesSupported, e.g.
> >
> >      #define EFI_RUNTIME_GET_SUPPORTED_MASK \
> >              _IOR('p', 0x0C, unsigned int)
> >      unsigned int mask;
> >      fd = open("/dev/efi_test", O_RDWR);
> >      ret = ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> Hello Ard,
>
> the patch has now been admitted to Linus' branch.
>
> Could we, please, have this patch applied to the 5.10 long term release,
> too.
>

If you think this patch needs to go to -stable, please send an email
to stable@vger.kernel.org containing the commit title and SHA1, and a
short motivation why this patch needs to be backported.

If the stable maintainers are willing to take it, I won't object to it.

Thanks,
Ard.
