Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5C677A30
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 12:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjAWLcU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 06:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjAWLcS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 06:32:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77A81117B;
        Mon, 23 Jan 2023 03:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F529B80D3C;
        Mon, 23 Jan 2023 11:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15312C4339E;
        Mon, 23 Jan 2023 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674473535;
        bh=A/UyFADav4a2/VogKdjeDJqleagup09QvBbH3Ovi6zg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EuLibXdYI6vvoPtSd6SCGvsenAjT4SGb32/miFGZ0+apsX96HupHtXTvGYIEQnuZs
         6TaZbfHCbHKPncnl+qSYXKIuT/tSd1q2xh0XTElsNeke+E7w10MBNh5KdTsm2BFew5
         Ik64w4ONbBKz6KIkJ4U15+dDLzVwpOseN9hMBDN6lZ/nEFBLOwlHXLg3mQO3O+8ND0
         fBIb3BFWKIln8HUlx5RGd18TyTPU7+WmpTgR8xZ05GhBzE0zQf3uSutWnDnWqi4xaO
         GnvqoC2Z5BVyllD9EDKWLUh6dlBl1NzGpG/83tjPUebPsNalEL3kQ3iRuPTu79Rxxh
         fKWHQpHaKLOKw==
Received: by mail-lf1-f48.google.com with SMTP id x40so17657971lfu.12;
        Mon, 23 Jan 2023 03:32:14 -0800 (PST)
X-Gm-Message-State: AFqh2kp8h9/PPgs+wZ2ukQbBufrGGKXsRE4KEiB0AWV6xho6EcsNK0Y6
        yJj3da6tssZvR7zlOLl2u8e45DAD2azjbJpUSd8=
X-Google-Smtp-Source: AMrXdXsi1IGGW9PSJJNYUVEjRMZ41+dSuiIUe/mOtFY/tKzXm2MPg/Uw+INMIUISejdpNoNRbKrqdInfH3TRto92uOw=
X-Received: by 2002:ac2:4bd5:0:b0:4d5:76af:f890 with SMTP id
 o21-20020ac24bd5000000b004d576aff890mr1243569lfq.228.1674473533013; Mon, 23
 Jan 2023 03:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20230119164255.28091-1-johan+linaro@kernel.org>
 <20230119164255.28091-3-johan+linaro@kernel.org> <CAMj1kXEOOh8MrAt=L7aBt9wX5Pcmh4irnDuKqsDF7pB5-xnmog@mail.gmail.com>
 <Y8q7qz29QMfeNdMV@hovoldconsulting.com>
In-Reply-To: <Y8q7qz29QMfeNdMV@hovoldconsulting.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 23 Jan 2023 12:32:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFimwezNAW8VzGboJcBkBWBi8GquvGmfm4h_j7Sz5HyOA@mail.gmail.com>
Message-ID: <CAMj1kXFimwezNAW8VzGboJcBkBWBi8GquvGmfm4h_j7Sz5HyOA@mail.gmail.com>
Subject: Re: [PATCH 2/4] efivarfs: always register filesystem
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Jan 2023 at 17:04, Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Jan 20, 2023 at 10:23:18AM +0100, Ard Biesheuvel wrote:
> > (cc Peter, Heinrich)
> >
> > On Thu, 19 Jan 2023 at 17:45, Johan Hovold <johan+linaro@kernel.org> wrote:
> > >
> > > The efivar ops are typically registered at subsys init time so that
> > > they are available when efivarfs is registered at module init time.
> > >
> > > Other efivars implementations, such as Google SMI, exists and can
> > > currently be build as modules which means that efivar may not be
> > > available when efivarfs is initialised.
> > >
> > > Move the efivar availability check from module init to when the
> > > filesystem is mounted to allow late registration of efivars.
> > >
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >
> > I think this change is fine in principle, but I 'm not sure if there
> > is user space code that the distros are carrying that might get
> > confused by this: beforehand, efivarfs would not exist in
> > /proc/filesystems and now, it will but trying to mount it might fail.
>
> User space must already handle mount failing since commit 483028edacab
> ("efivars: respect EFI_UNSUPPORTED return from firmware") so that should
> not be an issue.
>

Fair enough
