Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFEF37C0EF
	for <lists+linux-efi@lfdr.de>; Wed, 12 May 2021 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhELOzG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 10:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231721AbhELOym (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 10:54:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 324176142D;
        Wed, 12 May 2021 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620831214;
        bh=Rpg6vD2MSJ15j9qTgQykNf+yaebjFO3vsWStZyhaHDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E+C0qCd2cnfEgVvXmYg7+1faFnpz3mJwTM880+WgLIsqqzquMUSCYR6o1vY6SOtsH
         ZRCSoqu6ecN+HMurTb87TZno+tnEVp05RACtpKgIkIVC0jxkTkxFOju79CIg+aOcnQ
         P2gttiyzDm272QEXfWz6s0QBAVfbHEgpi2wSMfJDdjlG7nBtG+TOFQES4rkGadcfyU
         m6Tkp2iLWCtERW3OEngP1Dx+BM7tQg9ob0bvxQmWFmvoc5EkUrHpqeiw1RMBkX6wUa
         WVzsi8deaqBIj46h625vsKtyLWwrpxWNayM3Tl6kjwR/dzfx262DCIE4BhT+aGC+OF
         ajaJKJm9+FVYA==
Received: by mail-ot1-f52.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso20779562otn.3;
        Wed, 12 May 2021 07:53:34 -0700 (PDT)
X-Gm-Message-State: AOAM530FgcEqB2fkiiE5Lc5tRfEZx3gzcR60ObkVbD/NtuI945Uuaiok
        HWwDvoIke4Tt33pJgUggFR1322+ip0m+2Po8AIY=
X-Google-Smtp-Source: ABdhPJyF7xGf1cHqgfWCCYhDHrUitzOZo98kYKZ3dFkIgsUffK+snHGQtF/tNm4+DMafVU58hJPr/eNtCEisCvoT65g=
X-Received: by 2002:a9d:7cd8:: with SMTP id r24mr19203843otn.90.1620831213172;
 Wed, 12 May 2021 07:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619193043.git.ashish.kalra@amd.com> <f9d22080293f24bd92684915fcee71a4974593a3.1619193043.git.ashish.kalra@amd.com>
 <YJvV9yKclJWLppWU@zn.tnic>
In-Reply-To: <YJvV9yKclJWLppWU@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 May 2021 16:53:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE0U4JxCLYPhetENDpXKMOAEXs8-dpce+CvBcgifQz2Ww@mail.gmail.com>
Message-ID: <CAMj1kXE0U4JxCLYPhetENDpXKMOAEXs8-dpce+CvBcgifQz2Ww@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] EFI: Introduce the new AMD Memory Encryption GUID.
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ashish Kalra <Ashish.Kalra@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srutherford@google.com, Sean Christopherson <seanjc@google.com>,
        venu.busireddy@oracle.com, Brijesh Singh <brijesh.singh@amd.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 12 May 2021 at 15:19, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 23, 2021 at 03:59:01PM +0000, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> >
> > Introduce a new AMD Memory Encryption GUID which is currently
> > used for defining a new UEFI environment variable which indicates
> > UEFI/OVMF support for the SEV live migration feature. This variable
> > is setup when UEFI/OVMF detects host/hypervisor support for SEV
> > live migration and later this variable is read by the kernel using
> > EFI runtime services to verify if OVMF supports the live migration
> > feature.
> >
> > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > ---
> >  include/linux/efi.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 8710f5710c1d..e95c144d1d02 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -360,6 +360,7 @@ void efi_native_runtime_setup(void);
> >
> >  /* OEM GUIDs */
> >  #define DELLEMC_EFI_RCI2_TABLE_GUID          EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> > +#define MEM_ENCRYPT_GUID                     EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
> >
> >  typedef struct {
> >       efi_guid_t guid;
> > --
>
> When you apply this patch locally, you do:
>
> $ git log -p -1 | ./scripts/get_maintainer.pl
> Ard Biesheuvel <ardb@kernel.org> (maintainer:EXTENSIBLE FIRMWARE INTERFACE (EFI))
> linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))
> linux-kernel@vger.kernel.org (open list)
>
> and this tells you that you need to CC EFI folks too.
>
> I've CCed linux-efi now - please make sure you use that script to CC the
> relevant parties on patches, in the future.
>

Thanks Boris.

You are adding this GUID to the 'OEM GUIDs' section, in which case I'd
prefer the identifier to include which OEM.

Or alternatively, put it somewhere else, but in this case, putting
something like AMD_SEV in the identifier would still help to make it
more self-documenting.

Thanks,
Ard.
