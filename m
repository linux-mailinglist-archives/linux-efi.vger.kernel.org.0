Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765CB33CEDC
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 08:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhCPHwl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 03:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhCPHwX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Mar 2021 03:52:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF205C06174A
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 00:52:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so1008391pjb.0
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hOZ9Rg7lcXXkQQAolqlRhzXrZO7Pm9+F+419RRBDPiM=;
        b=Qs59s5q9s2tgd0hQ7Q3t0uym5pFq1OCiWUr1AaaJjTsMr3SA2UEVQGlbJ7N0uyIRKM
         HFhS3FH5A1sjwse4f/CcsuAHdctYXjbd/zMpdtvK5LnkNxvFyqFQGhNziNqjA99bopVB
         ZT2VsyRTsKw8av1Oy7bI0y6mI0B3ClvfUMDK2pjG44fvVliXwLTy7UmtSfY5PEg8ROeg
         JKqNCx4vYHbr1qOXTH+PJCmPvIrALRI0KlZBZ7laW4n8jYtJSKbZlcPk1obiIvf23sHe
         QbNNcfvubaa7rzXzYJoV97EEey0tWyxQ248FyKtYjzhsdl7eUzMMHM401pXZ47c5VhE3
         DRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOZ9Rg7lcXXkQQAolqlRhzXrZO7Pm9+F+419RRBDPiM=;
        b=iJO5cNPOQ/u6aqNo+fYhwLTRbbU6CXuVCfOEHslf9x1M8nc6EDs0lD5TOujpWAsBru
         dJlunm2riLFyOwm9o7rS3rwpBbETiiPKZQFMufoi63blEUmtDOeMpREcDnDixBLyajG0
         msVRkH9Uf9ApYbS7NB38ywRKyUWtQbyjfcL2cTu6WS2uVxuy3YNyAVl3cICgRIrD2nAu
         2bqat2R4ArzGPmK3rJ84AR9Xz//jFCyTVccG+xmPkOTUMJ5uHdrXpYC+FQrzE8UHVJZu
         /J8HAjkJ3/2HQHzwVbl7nAG38O4EA8G0HF5ypyzZXv6E63TBMeBxH1/yjz3CLAAFixKB
         JMOw==
X-Gm-Message-State: AOAM5316vm+ItWq2ViiSesfQbUkUrtlmCioizRdz5ODRkqYeUk8ZhPmg
        jGS5QUp9MF7unmS5dxZrsgMZbQ==
X-Google-Smtp-Source: ABdhPJwYQyzof0mrKMDKPOpJ1ILnqUY4bPmeePn+KWgJ8vl+iGeqb3GIj8qVA28Cuc4nE8UkvF6oDA==
X-Received: by 2002:a17:902:7c14:b029:e6:5d7e:62a2 with SMTP id x20-20020a1709027c14b02900e65d7e62a2mr15589753pll.42.1615881143252;
        Tue, 16 Mar 2021 00:52:23 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id v14sm2016407pju.19.2021.03.16.00.52.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Mar 2021 00:52:22 -0700 (PDT)
Date:   Tue, 16 Mar 2021 15:52:15 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Steve McIntyre <steve@einval.com>,
        Rob Clark <robdclark@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based
 on EFI variable
Message-ID: <20210316075214.GA32651@dragon>
References: <20210306113519.294287-1-ardb@kernel.org>
 <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon>
 <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 15, 2021 at 02:07:01PM +0100, Ard Biesheuvel wrote:
> On Mon, 15 Mar 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
> > > >
> ...
> > > > fwiw, the valid use-case for ACPI boot on these things is for distro
> > > > installer.. it might not be the shiny accelerated experience, but you
> > > > want to be able to get thru the installer and then install updates to
> > > > get latest kernel/dtb/etc
> > > >
> > > > it is a small use-case, but kinda an important step ;-)
> > > >
> > >
> > > That is a fair point. However, as I understand it, we need this to work around
> > > - the need to pass efi=novamap
> > > - broken poweroff on Flex5g
> >
> > One more: broken EFI variable runtime services on all Snapdragon laptops
> >
> > It's been another pain of running debian-installer (d-i) on these
> > laptops, where EFI NV variables are just stored on UFS disk.  So after
> > Linux takes over the control of UFS, EFI NV variable runtime services
> > then become out of service.  Currently, we have to apply a hack [1] on
> > d-i grub-installer to get around the issue,  and it's been the only
> > remaining out-of-tree patch we have to carry for d-i.  With this nice
> > `OverrideSupported` support, we will be able to drop that hack
> > completely.
> >
> > >
> > > So an installer either needs to set the EFI variable, or pass
> > > efi=novamap on the first boot. Note that there are no arm64 EFI
> > > systems known where efi=novamap causes problems. In fact, I would
> > > prefer to stop using SetVirtualAddressMap() altogether, as it does not
> > > provide any benefit whatsoever. So perhaps we should make efi=novamap
> > > the default and be done with it.
> > >
> > > Broken poweroff is hardly a showstopper for an installer, given that
> > > we cannot even install GRUB correctly.
> > >
> > > In summary, I am more than happy to collaborate constructively on this
> > > (which is why I wrote the patch), but I don't think we're at a point
> > > yet where this is the only thing standing in our way when it comes to
> > > a smooth out-of-the-box Linux installation experience.
> >
> > There might be more to be done for getting a smooth Linux installation
> > experience.  But IMHO, this `OverrideSupported` thing is definitely
> > a big step to that.
> >
> 
> So the problem here seems to be that grub-install (or efibootmgr)
> tolerates efivarfs being absent entirely, but bails out if it exists
> but gives an error when trying to access it, right?

Yes, with EFI variables runtime service marked as unsupported,
efibootmgr will just exit on efi_variables_supported() check [1] in
a way that its parent process, i.e. grub-install, doesn't take as an
error.  But otherwise, efibootmgr will go much further and exit with
a real error when trying to access efivars.

Shawn

[1] https://github.com/rhboot/efibootmgr/blob/master/src/efibootmgr.c#L1764
