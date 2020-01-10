Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2947513678A
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2020 07:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgAJGjG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jan 2020 01:39:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbgAJGjG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jan 2020 01:39:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so634781wrj.12
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2020 22:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJLJHTUES5IjRBTc4xVBz1voCqcu532N0f/7D6D8Y7I=;
        b=ky2J0zDZHNXmqgWESU1Pp3b9SsOdOCW7HFDfO70Qz2N2wHr19GBPSensIxSKJySwmD
         QRVYr7j4WgIsX2bHjRsnTljXU4lsWS8nymXGl18Ed/KOzJteY1DDwRLLgePqFrkE68As
         ZrNZj4/IebkQEp6v7DJ3i5sRBUUpuh4keRtpx9GKEpz3rIdxfupopoa2ftM24WdolwP5
         2IoNa5Bd8kE+kb9sXQuh9PAIcxUndIr8P+mctWXNIGycJ/fe12JkWV4pM8UNZXkCg+Mb
         hrrUkIzzta16kijgT1dEGHFxAHhB6t6Fj2+0jLPMeQun7Qu81luziV5La6JTbMwwCwRT
         eabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJLJHTUES5IjRBTc4xVBz1voCqcu532N0f/7D6D8Y7I=;
        b=ZGSwB3AQgH523LafKbUd/VMvl/GAW1IWcDUIh1uT8cZirON2EhRa/jdrfji1xAnV43
         34Kv0RzKpplPXUqOSBBBiVGxRIAJJGhD9pL8oG+yaH9qqF80JexmRPeXfwP8a3D7yxBC
         ASETRA+E9amxxdOWvFQA46XRkhLxkiqEPN3sgWCYikhJKdUdtTxvqDOP7r6/m9F0HL4T
         7QJBVrqE7Yv1OnJEwbq/t8L7E1Jt8JsDnRsQubvbXmpn1WWKzNMAZ2CNe+UrbgM+i+kp
         iWXjVjEesOFGkUyJQNFjD1+OmnvCLqSJKx9XjIJmaeJZyhwi61hfwaM6MzyoelFuer8x
         VvQw==
X-Gm-Message-State: APjAAAWt5RW5ABWkcxvFJTSRZTTUl90IW7YxGMH8RCXfiSS2tmVWaq1/
        e1HM4rafWzwNhmWVSW9pkVDLBhR5EJbAT8fNcPf5Nw==
X-Google-Smtp-Source: APXvYqzoaQGbJcLNuCDV67r3l8nzCxvYVGBYWWSum55y+HtleypgahLB71qCaO35ZJ10RIkRTNqZsFGz7T258gkuaMA=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr1522692wrr.32.1578638344524;
 Thu, 09 Jan 2020 22:39:04 -0800 (PST)
MIME-Version: 1.0
References: <1573449229-13918-1-git-send-email-anshuman.khandual@arm.com> <238c9810-dcec-7f4b-7bcb-a339f1f8aaad@arm.com>
In-Reply-To: <238c9810-dcec-7f4b-7bcb-a339f1f8aaad@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 10 Jan 2020 07:38:53 +0100
Message-ID: <CAKv+Gu9tw8UK15DwGN4J8hH5amJ6QEM1RmY5Q2_eoGLLTFNmbA@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix comment for efi_mem_type() wrt absent physical addresses
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 10 Jan 2020 at 07:11, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/11/2019 10:43 AM, Anshuman Khandual wrote:
> > A previous commit f99afd08a45f ("efi: Update efi_mem_type() to return an
> > error rather than 0") changed the return type from EFI_RESERVED_TYPE to
> > -EINVAL when the searched physical address is not present in any memory
> > descriptor. But the comment preceding the function never changed. Lets
> > change the comment now to reflect the new return type -EINVAL.
> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: linux-efi@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
> Hello Ard,
>
> Just wondering if this patch is getting pulled. Dont see it either
> on linux-next or the following EFI tree.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi (efi-next)
>

Hi Anshuman,

Thanks for the reminder. It is queued now

-- 
Ard.



>
> > ---
> > Changes in V2:
> >
> > - Changed comment for efi_mem_type() instead of the return type per Ard
> >
> > V1: (https://lore.kernel.org/patchwork/patch/1149002/)
> >
> >  drivers/firmware/efi/efi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 77ca52d86e30..47b0bf7a2b7f 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -899,7 +899,7 @@ u64 efi_mem_attributes(unsigned long phys_addr)
> >   *
> >   * Search in the EFI memory map for the region covering @phys_addr.
> >   * Returns the EFI memory type if the region was found in the memory
> > - * map, EFI_RESERVED_TYPE (zero) otherwise.
> > + * map, -EINVAL otherwise.
> >   */
> >  int efi_mem_type(unsigned long phys_addr)
> >  {
> >
