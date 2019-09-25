Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BABE1CF
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIYP6J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 11:58:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36909 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfIYP6J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Sep 2019 11:58:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so7586652wro.4
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2019 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAYyX9uJkmy+PaSSr6Il6bqlp+qNEw3PUkHkNhAWLds=;
        b=wBXX9oCDMbDwDMuaTuCAPEWzYOVn4VrAj2w+YlfPfZbkcei/NtOKUITEBg61VECw6m
         +4SLsYkLE9/ojQK1bghkqXgOs8p7Zu82WFPYWel+VEkoRKHvfJfoexuy8ND3+L6cm0wI
         cI77ojQYs6UkzwS6a6U7BnFbrlFLXksxQAETiJcykdFdBQMj6aq38TpM3joNlvkCDqUw
         SG3D931RoEXrxeKA5qwBDI3wN6/qtQHBckqGT3o71n7g1//2DrDVgerHIasTFwppfeL3
         pY8Ikc0dAoMgHpirhfOWqs0Al/RwMADwxs12uoowyIic3FX8dw6QHpX+DvWGYxusn2kZ
         8gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAYyX9uJkmy+PaSSr6Il6bqlp+qNEw3PUkHkNhAWLds=;
        b=JZ6JRCV1ydj4b717vimmYb8qD7dI5aBPaUQj6H/2Sz9AQvPL+lLUakNjSZx/aqorB7
         +3SxQwd+5WWx3lpo1vwDjatafjkSblMyGszz47/L7xzbkwBxCS3D4UOXja3P5na4orgh
         ZI2cRXKIbDzIun6d87ZMURktnNG+SB/uAmKfSZo3BimlIlH/BXnkljSm9+weYEmCv25W
         WjbSuAOmv4qOx+Q5z4hDs4A37JsXkcjaElBJGK7UJUz7bf++EA2zHA79w8iVBTR3pKC6
         PWezUgR0CJvfXMvjXcjIxPpmrHsoRLbNdU2QXVsVzh5/InajEPhN64qKvP4il+SDWXON
         3DHQ==
X-Gm-Message-State: APjAAAXhhclZQjp+Zlvp43wKOZpJNkZcOB5aYivXKd/egoeGpcd4Uiq9
        oUJ+wdX8zkdBjpLTcd38c4J8RqWVosw+SM0tAv3wfmgWyug=
X-Google-Smtp-Source: APXvYqzjtR7RYasIPX2oWQL73hyxN/m0FS6mtJrgC3T8vNZaFDJOt9HQNeTie1ulXGIfLlofnsfGgbNhWl2T0qhjZvQ=
X-Received: by 2002:adf:f406:: with SMTP id g6mr9627266wro.325.1569427087366;
 Wed, 25 Sep 2019 08:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190911233239.5916-1-ard.biesheuvel@linaro.org>
 <alpine.DEB.2.21.1909121533270.30174@bear.techie.net> <CAKv+Gu95wtjPXRUF=wK3-Y6+zNcvaqpr+T4Z4-wV3OJH+oNgVg@mail.gmail.com>
 <alpine.DEB.2.21.1909191400240.3069@bear.techie.net>
In-Reply-To: <alpine.DEB.2.21.1909191400240.3069@bear.techie.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 25 Sep 2019 17:57:55 +0200
Message-ID: <CAKv+Gu_evq+B1=eHQyy1-+3PhA3fMKhRULTTZW4S=nR8FHs2zg@mail.gmail.com>
Subject: Re: [PATCH] efi: don't iterate over EFI vars pointlessly if no SSDT
 override was specified
To:     Scott Talbert <swt@techie.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 Sep 2019 at 20:01, Scott Talbert <swt@techie.net> wrote:
>
> On Thu, 12 Sep 2019, Ard Biesheuvel wrote:
>
> >>> The kernel command line option efivar_ssdt= allows a EFI variable name
> >>> to be specified which contains an ACPI SSDT table that will be loaded
> >>> into memory by the OS.
> >>>
> >>> Currently, that code will always iterate over the EFI variables and
> >>> compare each name with the provided name, even if the command line
> >>> option wasn't set to begin with.
> >>>
> >>> So bail early when no variable name was provided.
> >>>
> >>> Cc: Scott Talbert <swt@techie.net>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> ---
> >>> drivers/firmware/efi/efi.c | 3 +++
> >>> 1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> >>> index ad3b1f4866b3..8f020827cdd3 100644
> >>> --- a/drivers/firmware/efi/efi.c
> >>> +++ b/drivers/firmware/efi/efi.c
> >>> @@ -282,6 +282,9 @@ static __init int efivar_ssdt_load(void)
> >>>       void *data;
> >>>       int ret;
> >>>
> >>> +     if (!efivar_ssdt[0])
> >>> +             return 0;
> >>> +
> >>>       ret = efivar_init(efivar_ssdt_iter, &entries, true, &entries);
> >>>
> >>>       list_for_each_entry_safe(entry, aux, &entries, list) {
> >>
> >> Thanks for the quick fix!
> >>
> >> I can confirm this fixes booting on my Mac Pro 2012 system when applied to
> >> 5.3-rc7.
> >>
> >> Whenever this makes it in, if it could be targeted for the stable kernels
> >> as well, that would be appreciated.
> >>
> >
> > I'll send it out as a fix with a cc to -stable.
>
> Hi - just a quick reminder on this as I don't see it in Linus' tree yet.
> Not that I need it urgently, but just want to make sure it isn't
> forgotten.
>

Hi Scott,

This should get sent out in the next couple of day. It usually takes
another week or so after that for changes to make it into Linus's
tree.
