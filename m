Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A634333F537
	for <lists+linux-efi@lfdr.de>; Wed, 17 Mar 2021 17:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhCQQNz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Mar 2021 12:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231954AbhCQQNm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Mar 2021 12:13:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACA7C64F50
        for <linux-efi@vger.kernel.org>; Wed, 17 Mar 2021 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615993683;
        bh=jo6CsNR2DZSYHrexaNdjPDvZpRLlRqBSQ5FwzJCv52s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lG8J2InMoK7Po6qkiYS+dI05qqHZxSzmBvwE7v2psQbE1ghWOv8mxd/xtmep9Oba1
         jz7fpSxFiCknbOOqnON1AgBqVI/U0O9GEEQBtAbqVEkNx/UfM9frW4BPLuHmS71eRV
         qpfVAwwKmv9h0E5URzVjFCSue3ZeJLjMxB032TtZ5y2vdtE5jkd8KwV6/lJjUtnPlX
         oSNXmoWpDZscwDmrJ8B6UkrvF9Kpn3Fi56yrK9OTTW5fi9++hSb+pTot8u/+cDXx4C
         GmaNtqq3Fjuj45fKgdvpeGIoK+sWSxNl2Is/tYlJV1tvHEHV7xqWspF6E9CbSnYnlj
         SFUmaXHE5GXrg==
Received: by mail-oi1-f176.google.com with SMTP id w125so13519090oib.13
        for <linux-efi@vger.kernel.org>; Wed, 17 Mar 2021 08:08:03 -0700 (PDT)
X-Gm-Message-State: AOAM5308vv+UjF/Q14snBMVXLoHMs1XG2lI/kn+zJ3BUotTu8/Lr5gNH
        +R6itfR04D4OKRw4XkchZaLhM3fhK4NG+cmxC0c=
X-Google-Smtp-Source: ABdhPJyRSXhRAJA/WK6OfycGhxvvKIYsNpNP4D35CMg66Gqotozhp1UWTBWtW32Cv5hiQUJq4zQ2Th0cLsAUFco91q4=
X-Received: by 2002:aca:538c:: with SMTP id h134mr3048398oib.174.1615993682864;
 Wed, 17 Mar 2021 08:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <75d99346-73c1-993c-8bba-08cb3b3271a2@gmx.de> <CAMj1kXHue99LeDYHP4Cg6+-0iJrjkgti2H8=V4NChw5mScDLCA@mail.gmail.com>
In-Reply-To: <CAMj1kXHue99LeDYHP4Cg6+-0iJrjkgti2H8=V4NChw5mScDLCA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Mar 2021 16:07:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHEACdfON72AKimMDvNN8-Yhd-ff+S3egC_9vO7zYzrag@mail.gmail.com>
Message-ID: <CAMj1kXHEACdfON72AKimMDvNN8-Yhd-ff+S3egC_9vO7zYzrag@mail.gmail.com>
Subject: Re: [RFC] efi: variable name size limit in efivar_init()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 17 Mar 2021 at 14:32, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Matthew and Peter)
>

Now for real... (thanks Heinrich)

> On Wed, 17 Mar 2021 at 08:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> >
> > Hello Ard,
> >
> > in efivar_init() I read:
> >
> >          /*
> >           * Per EFI spec, the maximum storage allocated for both
> >           * the variable name and variable data is 1024 bytes.
> >           */
> >
> >          do {
> >                  variable_name_size = 1024;
> >
> > This dates back at least to Linux 2.5.0 of 23-Nov-2001 where in
> > arch/ia64/kernel/efivars.c we have:
> >
> > /*
> >   * The maximum size of VariableName + Data = 1024
> >   * Therefore, it's reasonable to save that much
> >   * space in each part of the structure,
> >   * and we use a page for reading/writing.
> >   */
> >
> > I cannot find this 1024 byte size limit neither in UEFI spec 2.8B nor in
> > EFI spec 1.1.
> >
> > Variable d719b2cb-3d3a-4596-a3bc-dad00e67656f-db has 5080 bytes of data
> > on my laptop.
> >
> > It may not reasonable to use a variable name exceeding 512 UTF-16
> > characters. But shouldn't we handle this case gracefully in efivar_init()?
> >
>
> This predates my involvement in EFI by a long time, so I've cc'ed
> Peter and Matthew, who may be able to shed some light on this.
