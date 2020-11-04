Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B52A7346
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbgKDXyq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:54:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgKDXyq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Nov 2020 18:54:46 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 671E020825
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 23:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604534085;
        bh=ok/fYJAV8bL/1AuLmDXnqp8O7fhDT79bjnQKIeilga8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1jBm3LxvPPUFtbaiINDeyZsCFVPiTJkRwgnj6Ofr3pS3Fdj2qTTqn9dWMS5Xz7BYe
         ttLglkMvdkodFatepjG69rCU2UMAzyYVRoUQhdnAbbQcmSwk7P7hG5obqVvnPFZmHL
         9J+1qZpq4DCdvahRg8lv+zOquzgflq8c7BGFQNdw=
Received: by mail-ot1-f42.google.com with SMTP id l36so465954ota.4
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 15:54:45 -0800 (PST)
X-Gm-Message-State: AOAM532D0SDx1IdNAh591jqQDjyFNHG8ucoIDum7GNGyjraCn9z7TQPD
        VXOhxQWA1NbcAxvjoYhgZ2fOORn5am07mFGsV7o=
X-Google-Smtp-Source: ABdhPJx0nEZeMyzbhRvrfSiHfUQMv/ufXNej/rub8C+37WnU+/ULONWKCy93retsTVNVdch1MCDAGRDndPMREdLeDz8=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr142766otk.108.1604534084707;
 Wed, 04 Nov 2020 15:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20201104221400.7005-1-ardb@kernel.org> <f3d902ca-3fa2-aa8a-fb9a-0891b9567751@oracle.com>
In-Reply-To: <f3d902ca-3fa2-aa8a-fb9a-0891b9567751@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Nov 2020 00:54:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH81-3bayCKFQ4cO+Hw4FhRtc=DJr6qTirtg75eGwdZNQ@mail.gmail.com>
Message-ID: <CAMj1kXH81-3bayCKFQ4cO+Hw4FhRtc=DJr6qTirtg75eGwdZNQ@mail.gmail.com>
Subject: Re: [PATCH] efi: x86/xen: switch to efi_get_secureboot_mode helper
To:     boris.ostrovsky@oracle.com
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Nov 2020 at 00:53, <boris.ostrovsky@oracle.com> wrote:
>
>
> On 11/4/20 5:14 PM, Ard Biesheuvel wrote:
> > Now that we have a static inline helper to discover the platform's secure
> > boot mode that can be shared between the EFI stub and the kernel proper,
> > switch to it, and drop some comments about keeping them in sync manually.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/xen/efi.c                        | 37 +++++---------------
> >  drivers/firmware/efi/libstub/secureboot.c |  3 --
> >  2 files changed, 9 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
> > index 205a9bc981b0..a27444acaf1e 100644
> > --- a/arch/x86/xen/efi.c
> > +++ b/arch/x86/xen/efi.c
> > @@ -93,37 +93,22 @@ static efi_system_table_t __init *xen_efi_probe(void)
> >
> >  /*
> >   * Determine whether we're in secure boot mode.
> > - *
> > - * Please keep the logic in sync with
> > - * drivers/firmware/efi/libstub/secureboot.c:efi_get_secureboot().
> >   */
> >  static enum efi_secureboot_mode xen_efi_get_secureboot(void)
> >  {
> > -     static efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> >       static efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
> > +     enum efi_secureboot_mode mode;
> >       efi_status_t status;
> > -     u8 moksbstate, secboot, setupmode;
> > +     u8 moksbstate;
> >       unsigned long size;
> >
> > -     size = sizeof(secboot);
> > -     status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> > -                               NULL, &size, &secboot);
> > -
> > -     if (status == EFI_NOT_FOUND)
> > -             return efi_secureboot_mode_disabled;
> > -
> > -     if (status != EFI_SUCCESS)
> > -             goto out_efi_err;
> > -
> > -     size = sizeof(setupmode);
> > -     status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> > -                               NULL, &size, &setupmode);
> > -
> > -     if (status != EFI_SUCCESS)
> > -             goto out_efi_err;
> > -
> > -     if (secboot == 0 || setupmode == 1)
> > -             return efi_secureboot_mode_disabled;
> > +     mode = efi_get_secureboot_mode(efi.get_variable);
>
>
> Which tree is this patch against? I don't see a definition of efi_get_secureboot_mode().
>
>
> > +     if (mode == efi_secureboot_mode_unknown) {
> > +             efi_err("Could not determine UEFI Secure Boot status.\n");
>
>
> We need to include drivers/firmware/efi/libstub/efistub.h for that. Which I am not sure is meant to be included anywhere outside of libstub.
>

Ah yes, my mistake - that should be pr_err, not efi_err.
