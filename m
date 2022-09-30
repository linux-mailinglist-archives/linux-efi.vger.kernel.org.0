Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A005F1447
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 23:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiI3VAK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 17:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiI3VAI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 17:00:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3043EA5D;
        Fri, 30 Sep 2022 14:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6FBFB82A2D;
        Fri, 30 Sep 2022 21:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8043AC433D7;
        Fri, 30 Sep 2022 21:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664571602;
        bh=vkwsIzcGS2jETeiJRp/8RutxMOCJl7Zv/6Fd6qBBQLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LjxK9Gt2NBW7WLTNzEZIz0QlS1LRUB5Uz1+M45mYi0Im0Nz+dSMfiHhIy26kWWxiL
         hWqPn3QSegLK4YRVGqftKVGFKeuFYcMYHr0tvdMKE1HkYHKqsixXGjhI3HNWUWXt1K
         s7877yOhSq2eu4+vOTU80hhHSr+9dzlHrSS6TSKI14PGUg9PVgELcYQw4GEKUQ3Va+
         cCNVRzkpCMFMi4VVQMBHf7gwZSmC4JtPHYtNtukyHwadNwilBaKFSWzOmuiYXgiCjO
         GxBSDazC8jDVbgTlpLZCI1I1U2/I3KeCvGUGNhDSC68PsU6YVfcFR7R3QJZuRCuxB6
         SZhtKkmNTJfwA==
Received: by mail-lf1-f44.google.com with SMTP id a2so8644610lfb.6;
        Fri, 30 Sep 2022 14:00:02 -0700 (PDT)
X-Gm-Message-State: ACrzQf3urHNKj/LlldbypwL7Cf7KgDvUjzv31NPnjVeBKhLZ5UDcSCg3
        st7ScqJpMYX0NyMSq09OS1Q2rE9zQV9pNph3rq4=
X-Google-Smtp-Source: AMsMyM76JzlePLAxTaPu+4BrMa6gPr+Ax0OkeuNIJlRyNAL2lYOchpuPlVaNfch3zgsaxDjFCwvhwxcgW/xIMQfm6C4=
X-Received: by 2002:a05:6512:261b:b0:4a1:abd7:3129 with SMTP id
 bt27-20020a056512261b00b004a1abd73129mr4091546lfb.637.1664571600418; Fri, 30
 Sep 2022 14:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <5649176eacda434267f68676f1733d06c572d19e.1664298147.git.demi@invisiblethingslab.com>
 <CAMj1kXEs-o8jvNqRiW+Ue2i52RBgg4iktg8UONCACk8-Gx4XXA@mail.gmail.com>
 <YzczpIYop5olD4hj@itl-email> <CAMj1kXHGPzy9T1LcE8LX+woGtUGTzrDgbjDBJabJ+bwDVPbTag@mail.gmail.com>
 <YzdPv4+fYX3SG9P0@itl-email>
In-Reply-To: <YzdPv4+fYX3SG9P0@itl-email>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 30 Sep 2022 22:59:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGTZZmW=QZOL1FvrsBLsvFzN1GkvZCotuZ-C-gBVGY6CQ@mail.gmail.com>
Message-ID: <CAMj1kXGTZZmW=QZOL1FvrsBLsvFzN1GkvZCotuZ-C-gBVGY6CQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Support ESRT in Xen dom0
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Peter Jones <pjones@redhat.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 30 Sept 2022 at 22:21, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> On Fri, Sep 30, 2022 at 09:11:19PM +0200, Ard Biesheuvel wrote:
> > On Fri, 30 Sept 2022 at 20:21, Demi Marie Obenour
> > <demi@invisiblethingslab.com> wrote:
> > >
> > > On Fri, Sep 30, 2022 at 06:36:11PM +0200, Ard Biesheuvel wrote:
> > > > On Fri, 30 Sept 2022 at 01:02, Demi Marie Obenour
> > > > <demi@invisiblethingslab.com> wrote:
> > > > >
> > > > > fwupd requires access to the EFI System Resource Table (ESRT) to
> > > > > discover which firmware can be updated by the OS.  Currently, Lin=
ux does
> > > > > not expose the ESRT when running as a Xen dom0.  Therefore, it is=
 not
> > > > > possible to use fwupd in a Xen dom0, which is a serious problem f=
or e.g.
> > > > > Qubes OS.
> > > > >
> > > > > Before Xen 4.17, this was not fixable due to hypervisor limitatio=
ns.
> > > > > The UEFI specification requires the ESRT to be in EfiBootServices=
Data
> > > > > memory, which Xen will use for whatever purposes it likes.  There=
fore,
> > > > > Linux cannot safely access the ESRT, as Xen may have overwritten =
it.
> > > > >
> > > > > Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServi=
cesData
> > > > > or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServi=
cesData
> > > > > memory, Xen replaces the ESRT with a copy in memory that it has
> > > > > reserved.  Such memory is currently of type EFI_RUNTIME_SERVICES_=
DATA,
> > > > > but in the future it will be of type EFI_ACPI_RECLAIM_MEMORY.  Th=
is
> > > > > ensures that the ESRT can safely be accessed by the OS.
> > > > >
> > > > > When running as a Xen dom0, use the new
> > > > > xen_config_table_memory_region_max() function to determine if Xen=
 has
> > > > > reserved the ESRT and, if so, find the end of the memory region
> > > > > containing it.  This allows programs such as fwupd which require =
the
> > > > > ESRT to run under Xen, and so makes fwupd support in Qubes OS pos=
sible.
> > > > >
> > > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > >
> > > > Why do we need this patch? I'd expect esrt_table_exists() to return
> > > > false when patch 1/2 is applied.
> > >
> > > efi_enabled(EFI_MEMMAP) is false under Xen, so there needs to be an
> > > alternative way to get the end of the memory region containing the ES=
RT.
> > > That is what this patch provides.
> >
> > OK. I don't think we need that to be honest. When running under Xen,
> > we should be able to assume that the ESRT does not span multiple
> > memory regions arbitrarily, so we can just omit this check if
> > !efi_enabled(EFI_MEMMAP)
> >
> > IIRC (and Peter would know), we are trying to filter out descriptors
> > that are completely bogus here: zero lenght, zero address, etc etc. I
> > don't think we need that for Xen.
>
> Xen doesn=E2=80=99t uninstall bogus ESRTs, so there is no less reason to =
worry
> under Xen than on bare hardware.

That may be true. But if Xen needs dom0 to be able to cross reference
the EFI memory map, it should provide one (and set EFI_MEMMAP to
enabled).
