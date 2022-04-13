Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44AF4FFD19
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiDMRw7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiDMRw5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 13:52:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAEF37BEF;
        Wed, 13 Apr 2022 10:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99A6261EFF;
        Wed, 13 Apr 2022 17:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06590C385AD;
        Wed, 13 Apr 2022 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649872235;
        bh=72D0BQpOM8DgsMxYOZ4xGuBKKYvsyfG0yqN4ABcAeNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ciqNFSB3a6s+6tQacQsr3LwWwxt9yqkxO4Rep5osYLHbC/F7hQJ32xBpsylcBrOTT
         IrhxgTN10JEvYMF9KPVFBPe0IWBtj+ew8cEdj4V/AtmiUeenjbBNdAH7L5UpVSDrB2
         PNTgogotTNstEeFYFT578TG4ipBdUm2vThOWL/lyS/EM95uz5M1N3BUjfLtyJok+we
         tueNkYfafZ9SkL7MZyiXfSiIBdBG7GFEPCojZV9jKQSg0B65hvv1eiVDB4glm93axt
         CQN1QDV4msZvT2V2WRCcXEnrMyoROzIqJs2opaM1yVrEPBraJVthbUVnUTX/sIZjmP
         dLbmmrkQXGCrw==
Received: by mail-oi1-f174.google.com with SMTP id r8so2860477oib.5;
        Wed, 13 Apr 2022 10:50:34 -0700 (PDT)
X-Gm-Message-State: AOAM533c0zjAlaqH+tEXd5qa9jpugUhaCDSn/HFxUagOgWIBVBdnzk1M
        COuf9R2sW89aLJNc52HUt8x9NA7/j9WPncK09I0=
X-Google-Smtp-Source: ABdhPJwMqB9JakBeMKzBTAQG1328aJ3fK+Q/YGyjfvegtP7jyVLxEMe3r2eQNXMCXu4zy5HvILllejSX9U63sYr5T7A=
X-Received: by 2002:a05:6808:1513:b0:2fa:7a40:c720 with SMTP id
 u19-20020a056808151300b002fa7a40c720mr988027oiw.126.1649872234062; Wed, 13
 Apr 2022 10:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220224154330.26564-1-baskov@ispras.ru> <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
 <20220228183044.GA18400@srcf.ucam.org> <9787f1c1948cc640e70a50e4b929f44f@ispras.ru>
 <20220303204759.GA20294@srcf.ucam.org> <20220318163739.5doimyda5e3kdcef@redhat.com>
 <20e2f5b9ab008b12f14e763127f5ca1b@ispras.ru> <CAMj1kXFgy=e6FEtcWMUU4_aGqy7DA_22S=JaqQRCGinD+9OUrA@mail.gmail.com>
In-Reply-To: <CAMj1kXFgy=e6FEtcWMUU4_aGqy7DA_22S=JaqQRCGinD+9OUrA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 19:50:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFzO+=z3Zx3BX_1O2YDsB2Xz=Wb0O0miyi84SLOYBUwnQ@mail.gmail.com>
Message-ID: <CAMj1kXFzO+=z3Zx3BX_1O2YDsB2Xz=Wb0O0miyi84SLOYBUwnQ@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 25 Mar 2022 at 09:06, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 24 Mar 2022 at 17:39, <baskov@ispras.ru> wrote:
> >
> > On 2022-03-18 19:37, Peter Jones wrote:
> > > On Thu, Mar 03, 2022 at 08:47:59PM +0000, Matthew Garrett wrote:
> > >> On Thu, Mar 03, 2022 at 04:42:07PM +0300, baskov@ispras.ru wrote:
> > >> > On 2022-02-28 21:30, Matthew Garrett wrote:
> > >> > > On Mon, Feb 28, 2022 at 05:45:53PM +0100, Ard Biesheuvel wrote:
> > >> > >
> > >> > > > Given that this is a workaround for a very specific issue arising on
> > >> > > > PI based implementations of UEFI, I consider this a quirk, and so I
> > >> > > > think this approach is reasonable. I'd still like to gate it on some
> > >> > > > kind of identification, though - perhaps something related to DMI like
> > >> > > > the x86 core kernel does as well.
> > >> > >
> > >> > > When the V1 patches were reviewed, you suggested allocating
> > >> > > EFI_LOADER_CODE rather than EFI_LOADER_DATA. The example given for a
> > >> > > failure case is when NxMemoryProtectionPolicy is set to 0x7fd4, in which
> > >> > > case EFI_LOADER_CODE, EFI_BOOT_SERVICES_CODE and
> > >> > > EFI_RUNTIEM_SERVICES_CODE should not have the nx policy applied. So it
> > >> > > seems like your initial suggestion (s/LOADER_DATA/LOADER_CODE/) should
> > >> > > have worked, even if there was disagreement about whether the spec
> > >> > > required it to. Is this firmware applying a stricter policy?
> > >> >
> > >> > Yes, this firmware is being modified to enforce stricter policy.
> > >>
> > >> Ok. I think this should really go through the UEFI spec process - I
> > >> agree that from a strict interpretation of the spec, what this
> > >> firmware
> > >> is doing is legitimate, but I don't like having a situation where we
> > >> have to depend on the DXE spec.
> > >
> > > It's in the process of getting into the UEFI spec now as
> > > https://bugzilla.tianocore.org/show_bug.cgi?id=3519 .
> > >
> > >> How does Windows handle this? Just update the page tables itself for
> > >> any
> > >> regions it needs during boot?
> > >
> > > Microsoft's bootloader sets up its own pagetables, though I believe
> > > they're switching it to use the (soon to be) standardized API.
> >
> > The third version of the patch is the most close in structure
> > to the proposed protocol. And until the protocol is standardized and
> > implemented on problematic firmware, I think, it remains the better
> > solution in terms of simplicity and further porting to the new
> > protocol.
> >
> > It is desirable to get the issue resolved, and make the kernel stricter
> > comply to the spec, without waiting for the new API implementation.
> > And later, switch the kernel to be using the protocol with
> > subsequent patches as soon as it gets usable.
> >
> > So, is there a chance for these patches to be accepted in current
> > form, or with some modifications?
> >
>
> I am fine with taking the v3, as it is the most likely to only affect
> the systems that actually need this change in behavior.
>
> So unless there are any objections, I will queue these up after the
> merge window.

I have queued these up now.
