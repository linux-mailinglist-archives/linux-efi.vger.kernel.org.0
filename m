Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7633D04C
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 10:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCPJG2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 05:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCPJGV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Mar 2021 05:06:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C40C061756
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 02:06:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso1005048pjb.4
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 02:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0yEEgmRevfgCYpgPJc7GGKptlmU0ANQIaf96uEVK5qM=;
        b=OSoKMpUFFxvOoMYFPyikPDpPQ8IL9GcsbEPJw4SNyredW/UhHpvlbYqLVDj7fN7NlQ
         LD6abCe55LW0A4h39kAsKQv78W/k5ybxqioWfdhWQvDeyUfsSbQlVlkO99h76U0sTf5r
         /D0AKd6zfK5Cp/JweXYi6bSrLWvqknstm/zjeXNKc+OAlVqjXy7a2SSo1FUDXcVrU8d1
         qxA0Bj6Miq44ViZLYmiF1c+DN4H8R6ZnsoMfguAXGpG6TJ0ucDhYQh9rSMyUhcuGbbk3
         YXvNcAEt8AH5xYdDz0K5Kcs4V66FXTLlt8dUY0/WkAdjfrK3TVycdFDGJvHoys8ofArX
         uzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0yEEgmRevfgCYpgPJc7GGKptlmU0ANQIaf96uEVK5qM=;
        b=Uz035t5OsR8SXzXExV75wPLzAWJIuLns/UBGUJ3QBvAinjcRuGwsIflv+EcdJezNKj
         pQtil5Vq0mBRsTpTOLRHsSqyS8eUoIZHZi8dEcIcnbUMdy4Rz+eKps/PAqW4VSZfv6d0
         rzHIIg2VwKfR9K34+WbSjOz9yWZ+pJTW8YACjMzfCBKEvEvrPzyAvbdMjLyOGjBHX3HM
         2bAi+4rt0yUCujo//t44LQI/rMmEI7ZhO0q00YQFFFFq4g/x1LOjOAD8jxphVgi7hpTA
         yECrk5IPrrcFOM1cLCNGDh0lkwVtiYPDYdOsMpSZquamW+8DhtpFA4RPEfaPZ9VLp0rE
         YEzA==
X-Gm-Message-State: AOAM5317BAymX2lX3TTBdD8842c7PKc+E3eG2X70zDX6wKAKNsY8mkIy
        2UR8EElYEjzZe6WrJ+Y0uddSjQ==
X-Google-Smtp-Source: ABdhPJzVx+rFrBXK4uWtnB+iQFThvQ2smZF5aMcI1iMIux+9nyFuAR4nkpzlmrtQ9h7ujeokGBrN0A==
X-Received: by 2002:a17:902:bb8e:b029:e6:3b2:5834 with SMTP id m14-20020a170902bb8eb02900e603b25834mr16322317pls.38.1615885580268;
        Tue, 16 Mar 2021 02:06:20 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id l22sm2516265pjl.14.2021.03.16.02.06.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Mar 2021 02:06:19 -0700 (PDT)
Date:   Tue, 16 Mar 2021 17:06:13 +0800
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
Message-ID: <20210316090609.GB32651@dragon>
References: <20210306113519.294287-1-ardb@kernel.org>
 <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon>
 <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <20210316075214.GA32651@dragon>
 <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 16, 2021 at 08:57:19AM +0100, Ard Biesheuvel wrote:
> On Tue, 16 Mar 2021 at 08:52, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > On Mon, Mar 15, 2021 at 02:07:01PM +0100, Ard Biesheuvel wrote:
> > > On Mon, 15 Mar 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > >
> > > > On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
> > > > > On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
> > > > > >
> > > ...
> > > > > > fwiw, the valid use-case for ACPI boot on these things is for distro
> > > > > > installer.. it might not be the shiny accelerated experience, but you
> > > > > > want to be able to get thru the installer and then install updates to
> > > > > > get latest kernel/dtb/etc
> > > > > >
> > > > > > it is a small use-case, but kinda an important step ;-)
> > > > > >
> > > > >
> > > > > That is a fair point. However, as I understand it, we need this to work around
> > > > > - the need to pass efi=novamap
> > > > > - broken poweroff on Flex5g
> > > >
> > > > One more: broken EFI variable runtime services on all Snapdragon laptops
> > > >
> > > > It's been another pain of running debian-installer (d-i) on these
> > > > laptops, where EFI NV variables are just stored on UFS disk.  So after
> > > > Linux takes over the control of UFS, EFI NV variable runtime services
> > > > then become out of service.  Currently, we have to apply a hack [1] on
> > > > d-i grub-installer to get around the issue,  and it's been the only
> > > > remaining out-of-tree patch we have to carry for d-i.  With this nice
> > > > `OverrideSupported` support, we will be able to drop that hack
> > > > completely.
> > > >
> > > > >
> > > > > So an installer either needs to set the EFI variable, or pass
> > > > > efi=novamap on the first boot. Note that there are no arm64 EFI
> > > > > systems known where efi=novamap causes problems. In fact, I would
> > > > > prefer to stop using SetVirtualAddressMap() altogether, as it does not
> > > > > provide any benefit whatsoever. So perhaps we should make efi=novamap
> > > > > the default and be done with it.
> > > > >
> > > > > Broken poweroff is hardly a showstopper for an installer, given that
> > > > > we cannot even install GRUB correctly.
> > > > >
> > > > > In summary, I am more than happy to collaborate constructively on this
> > > > > (which is why I wrote the patch), but I don't think we're at a point
> > > > > yet where this is the only thing standing in our way when it comes to
> > > > > a smooth out-of-the-box Linux installation experience.
> > > >
> > > > There might be more to be done for getting a smooth Linux installation
> > > > experience.  But IMHO, this `OverrideSupported` thing is definitely
> > > > a big step to that.
> > > >
> > >
> > > So the problem here seems to be that grub-install (or efibootmgr)
> > > tolerates efivarfs being absent entirely, but bails out if it exists
> > > but gives an error when trying to access it, right?
> >
> > Yes, with EFI variables runtime service marked as unsupported,
> > efibootmgr will just exit on efi_variables_supported() check [1] in
> > a way that its parent process, i.e. grub-install, doesn't take as an
> > error.  But otherwise, efibootmgr will go much further and exit with
> > a real error when trying to access efivars.
> >
> 
> OK, so I suggest we fix efibootmgr, by extending the
> efi_variables_supported() check to perform a GetVariable() call on an
> arbitrary variable (e.g., BootOrder),

Hmm, I'm not sure we should ask more from user space, as it's already
been doing the right thing, and efi_variables_supported() is proved to
work properly with any sane low-level software (kernel + firmware),
either EFI variables service is supported or not.  That said, IMHO,
right now the low-level software on Snapdragon laptops is insane, i.e.
the unsupported/broken EFI runtime services are not communicated to
user space properly in established way.

Shawn

> and treat EFI_UNSUPPORTED as a
> special case that means that carrying on is pointless.
> 
> (but someone please confirm that the snapdragon efi firmware does
> return EFI_UNSUPPORTED and not some other return value when calling
> GetVariable() from under the OS)
