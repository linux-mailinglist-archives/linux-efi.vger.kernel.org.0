Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABC15F2C8E
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 10:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJCI51 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJCI45 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 04:56:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFF84BD18
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 01:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBC66B80ED6
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 08:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C400C433B5
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664786497;
        bh=v2U6BZJDvr14oOCX6NYP8Ep8ieHeh6yTLas8+pjXhtc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qr8NU3RbqCczA4aiTujFWiQu5lNkBBvbs53V+ANGqQC5ShzahsUeezBUB+zRCXa6X
         6F2XDh6e//s+0S/DMOgPhH1HFHuFscLhKUYTubP9tsGlh4gRmhezTCzYxioqZyPOl/
         AgBxRN4EPBC652os36dxhfjXj2OdLwuktvurCJyojrrR90AZEUQgH5UstIEs1BnkSg
         DMCgBgTpAfFthYsdU7zfamjlJZvNr1jw+rbI/62kd/bUcJynrXA4L4xnG3CihEcsEe
         7WKnarjYOSnTOxqx//rskan9L284cwy8X5+yRGnfT9wu+bU2u/eqHIwGyJ9CY/pQE/
         Wr1ofM9FNa8jg==
Received: by mail-lj1-f171.google.com with SMTP id d26so2715030ljl.2
        for <linux-efi@vger.kernel.org>; Mon, 03 Oct 2022 01:41:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf01yy51iPgbwidSl7GpVFBaPnIHlg6OyZYHFU2FqSsWsnN/DS+9
        weRHtMf5ur2m88TOVo46X+cxlB0hcZo/9xUzp7Q=
X-Google-Smtp-Source: AMsMyM54GabGSBFDJa25jVqciI4CR+sj6LpueHp3yBJdL7CAze93ucqNTSKMeYSQpVfVNklAVT53FzRQ6bUCGnHtOJ8=
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id
 h16-20020a05651c159000b0026c43119b84mr4371997ljq.152.1664786495531; Mon, 03
 Oct 2022 01:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221002095626.484279-1-ardb@kernel.org> <20221002095626.484279-6-ardb@kernel.org>
 <Yzm8HIccvuxyicYx@itl-email> <CAMj1kXG-0Bpc5B08EAJTGsNKan4S4628Wwz7wPh-EAY9p4zg1Q@mail.gmail.com>
In-Reply-To: <CAMj1kXG-0Bpc5B08EAJTGsNKan4S4628Wwz7wPh-EAY9p4zg1Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 3 Oct 2022 10:41:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE+64akXeGPopDO+Qg37fhndRbuBCGg2gr7ZSJb0WP2eg@mail.gmail.com>
Message-ID: <CAMj1kXE+64akXeGPopDO+Qg37fhndRbuBCGg2gr7ZSJb0WP2eg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] efi: esrt: Omit region sanity check when no
 memory map is available
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2 Oct 2022 at 23:43, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 2 Oct 2022 at 18:28, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Sun, Oct 02, 2022 at 11:56:26AM +0200, Ard Biesheuvel wrote:
> > > In order to permit the ESRT to be used when doing pseudo-EFI boot
> > > without a EFI memory map, e.g., when booting inside a Xen dom0 on x86=
,
> > > make the sanity checks optional based on whether the memory map is
> > > available.
> > >
> > > If additional validation is needed, it is up to the Xen EFI glue code=
 to
> > > implement this in its xen_efi_config_table_is_valid() helper, or prov=
ide
> > > a EFI memory map like it does on other architectures.
> >
> > I don=E2=80=99t like this.  It is easy to use a hypercall to get the en=
d of the
> > memory region containing the config table, which is what my one of my
> > previous patches actually does.  Skipping all of the validation could
> > easily lead to a regression.
>
> I don't like putting Xen specific hacks left and right because Xen on
> x86 cannot be bothered to provide an EFI memory map. And as for
> regressions, ESRT does not work at all under Xen (given the lack of a
> memory map) and so I fail to see how this could break a currently
> working case.
>
> >  I understand wanting to get Xen-specific
> > code out of esrt.c, but this isn=E2=80=99t the answer.  Some sort of ab=
straction
> > over both cases would be a much better solution.
> >
>
> We have such an abstraction already, it is called the EFI memory map.
>
> So there are two options here:
> - expose a EFI memory map
> - add a ESRT specific check to xen_efi_config_table_is_valid() so that
> the ESRT is withheld from dom0 if there is something wrong with it.
>

Actually, the obvious answer here is to implement
efi_mem_desc_lookup() for the EFI_PARAVIRT / !EFI_MEMMAP case. I'll
have a go at that and send a v2 shortly.
