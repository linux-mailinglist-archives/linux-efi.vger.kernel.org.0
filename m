Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DCA4E6F48
	for <lists+linux-efi@lfdr.de>; Fri, 25 Mar 2022 09:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347178AbiCYIIW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Mar 2022 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353468AbiCYIIU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Mar 2022 04:08:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2571CC518;
        Fri, 25 Mar 2022 01:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66D54B82705;
        Fri, 25 Mar 2022 08:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DA0C340F6;
        Fri, 25 Mar 2022 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648195604;
        bh=+IuwM8J1LTQxPvWn0rnPm1DRUsb3A005zWWx/PosR9s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vQFXiry0Y6zGbDoP5rfQvkhnVBb5og/SKAnr4t0pk9g0LJeXur4xdOkA7UXjkp9Ua
         HdoFVf8gsESFMXpURBloZ6DPyfm5NA59Qkeo/79u6tnBv1bnv2u+bcFBIU27pxEGXK
         0jiiKRKC4+v9xXA2zR96dSU0AhYChlP8GmFrZfgOT8A4GwAAvuIdLGQhcwO8BwvZoM
         JNn7ShN9lK5UQ4e3+nZJmfE/I50hOr/wupDHgGuqrrqCYaMYhHhObWMwogHCj4YcTa
         ZXJ0W+OkXZ157Kx1tDakrSVmiV5DsYLKRnuKffzWYXmBwu/HDuE76UNHbMV0zUZ8Mh
         4qaUqx3ro8dLw==
Received: by mail-ot1-f43.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso5007832otj.0;
        Fri, 25 Mar 2022 01:06:44 -0700 (PDT)
X-Gm-Message-State: AOAM532RRDd+202C6okeuisTctUYJdnRW/H/G4j7Sb9qjffJJYUGAYqp
        jlPnu2tk4/7P7riagOAqxgXHZrZmPpDSLXeWVB0=
X-Google-Smtp-Source: ABdhPJzTiMtlkysj9cRZHyAUygoCJV3uzQgMIJ8ylt8KauQ3Sr8JU6P4Vheb3YMSFQwQCMeTjBvPiT59ZnF3JxNFMYQ=
X-Received: by 2002:a05:6830:2e7:b0:5b2:68c1:182a with SMTP id
 r7-20020a05683002e700b005b268c1182amr3726604ote.71.1648195603145; Fri, 25 Mar
 2022 01:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220224154330.26564-1-baskov@ispras.ru> <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
 <20220228183044.GA18400@srcf.ucam.org> <9787f1c1948cc640e70a50e4b929f44f@ispras.ru>
 <20220303204759.GA20294@srcf.ucam.org> <20220318163739.5doimyda5e3kdcef@redhat.com>
 <20e2f5b9ab008b12f14e763127f5ca1b@ispras.ru>
In-Reply-To: <20e2f5b9ab008b12f14e763127f5ca1b@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Mar 2022 09:06:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFgy=e6FEtcWMUU4_aGqy7DA_22S=JaqQRCGinD+9OUrA@mail.gmail.com>
Message-ID: <CAMj1kXFgy=e6FEtcWMUU4_aGqy7DA_22S=JaqQRCGinD+9OUrA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
To:     Baskov Evgeniy <baskov@ispras.ru>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 24 Mar 2022 at 17:39, <baskov@ispras.ru> wrote:
>
> On 2022-03-18 19:37, Peter Jones wrote:
> > On Thu, Mar 03, 2022 at 08:47:59PM +0000, Matthew Garrett wrote:
> >> On Thu, Mar 03, 2022 at 04:42:07PM +0300, baskov@ispras.ru wrote:
> >> > On 2022-02-28 21:30, Matthew Garrett wrote:
> >> > > On Mon, Feb 28, 2022 at 05:45:53PM +0100, Ard Biesheuvel wrote:
> >> > >
> >> > > > Given that this is a workaround for a very specific issue arising on
> >> > > > PI based implementations of UEFI, I consider this a quirk, and so I
> >> > > > think this approach is reasonable. I'd still like to gate it on some
> >> > > > kind of identification, though - perhaps something related to DMI like
> >> > > > the x86 core kernel does as well.
> >> > >
> >> > > When the V1 patches were reviewed, you suggested allocating
> >> > > EFI_LOADER_CODE rather than EFI_LOADER_DATA. The example given for a
> >> > > failure case is when NxMemoryProtectionPolicy is set to 0x7fd4, in which
> >> > > case EFI_LOADER_CODE, EFI_BOOT_SERVICES_CODE and
> >> > > EFI_RUNTIEM_SERVICES_CODE should not have the nx policy applied. So it
> >> > > seems like your initial suggestion (s/LOADER_DATA/LOADER_CODE/) should
> >> > > have worked, even if there was disagreement about whether the spec
> >> > > required it to. Is this firmware applying a stricter policy?
> >> >
> >> > Yes, this firmware is being modified to enforce stricter policy.
> >>
> >> Ok. I think this should really go through the UEFI spec process - I
> >> agree that from a strict interpretation of the spec, what this
> >> firmware
> >> is doing is legitimate, but I don't like having a situation where we
> >> have to depend on the DXE spec.
> >
> > It's in the process of getting into the UEFI spec now as
> > https://bugzilla.tianocore.org/show_bug.cgi?id=3519 .
> >
> >> How does Windows handle this? Just update the page tables itself for
> >> any
> >> regions it needs during boot?
> >
> > Microsoft's bootloader sets up its own pagetables, though I believe
> > they're switching it to use the (soon to be) standardized API.
>
> The third version of the patch is the most close in structure
> to the proposed protocol. And until the protocol is standardized and
> implemented on problematic firmware, I think, it remains the better
> solution in terms of simplicity and further porting to the new
> protocol.
>
> It is desirable to get the issue resolved, and make the kernel stricter
> comply to the spec, without waiting for the new API implementation.
> And later, switch the kernel to be using the protocol with
> subsequent patches as soon as it gets usable.
>
> So, is there a chance for these patches to be accepted in current
> form, or with some modifications?
>

I am fine with taking the v3, as it is the most likely to only affect
the systems that actually need this change in behavior.

So unless there are any objections, I will queue these up after the
merge window.
