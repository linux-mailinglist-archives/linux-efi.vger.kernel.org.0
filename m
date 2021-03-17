Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7675B33E9D3
	for <lists+linux-efi@lfdr.de>; Wed, 17 Mar 2021 07:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCQGgU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Mar 2021 02:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCQGgO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Mar 2021 02:36:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0DBC06175F
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 23:36:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g15so425263pfq.3
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QXYdbDJ4l9UNeReM6+5M4v8sC1XzyynPlfUXjxx74BE=;
        b=wUUDx9ChQDFa9rZqBGj5/jTDZgMx6Qi7sEV/CZQPoxGKBBYUhd1bIaHBQvs+q4uVeV
         DFu89qjAtiW7CaNZp1dhpD8/EudU6rj+SI7YKqy+um0/OYcZn6D3RMoYZGL3ELZcd8Qj
         STBg3THkx13rYk8Zr3Z6GcK2+0KPcMysGBen4I+wVieEYHBdXf/gLbDCZxjYmspfSAab
         UwbnYhiduqyJiL0qiRkabtXkE8uadLz/qOHhpGaEenKCpK/3VlRQ+JhNz8d4L9im0x/l
         VKL5mTYF/gw7Y+isrOZAO0TdRJdhcZeqZs1LMv10T0FtehVZWrAHV27dDz86DR/MD1h0
         N2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QXYdbDJ4l9UNeReM6+5M4v8sC1XzyynPlfUXjxx74BE=;
        b=tce1+/0PZZCBVDAOA3NnSH/E547BwaQ4GgkjhXIFSnhqHE/FrKQDt6kZnGPuiZQRxD
         JnVBc5aNNcuMETgRdd8rbVdRk5vBq2uTn7cIhPtbTzUi2spNJoc75eFFgN9zquSRRAfN
         4N8VVFc0zHL+706uk7hpCIJl6Pv4G9yAxJBbYYL8mYrMJMZb7tzXjS7rJT54DWFG7DpW
         I3olvrNyCjB/BKPGzBSYhUQ7M9MMZmHLZf48JkAQIEBGl6asHd4qqzK3gI/i549uzOHn
         tjJT+sBNsZbxx93bP5NpmV6zc77VSdkngrhds3HuFykoVPsCDmjGzR8ctvxaLtaMzPNw
         fHkw==
X-Gm-Message-State: AOAM5327pQmDVexFN0keMZsdYGTJUT9dl9kFDke4K0H75oQHXoy28p93
        0x0dkKALU9rNd6fv8iM9mD8BUQ==
X-Google-Smtp-Source: ABdhPJxhw0hFukIhDnZV8zhSt1KC5d+fO0+Z/Md9y74n8QKPapNN8W7mIj9y3EABl/qPYOi5iZ47jA==
X-Received: by 2002:a63:410:: with SMTP id 16mr1378817pge.220.1615962973480;
        Tue, 16 Mar 2021 23:36:13 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id i20sm17351435pgg.65.2021.03.16.23.36.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Mar 2021 23:36:13 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:36:06 +0800
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
Message-ID: <20210317063602.GC32651@dragon>
References: <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon>
 <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <20210316075214.GA32651@dragon>
 <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
 <20210316090609.GB32651@dragon>
 <CAMj1kXEqbjy1x=sN=X6bwnO4Y47MsKxL9dX6VPfpE0-KGovA6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEqbjy1x=sN=X6bwnO4Y47MsKxL9dX6VPfpE0-KGovA6Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 16, 2021 at 10:33:17AM +0100, Ard Biesheuvel wrote:
> On Tue, 16 Mar 2021 at 10:06, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > On Tue, Mar 16, 2021 at 08:57:19AM +0100, Ard Biesheuvel wrote:
> > > On Tue, 16 Mar 2021 at 08:52, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > >
> > > > On Mon, Mar 15, 2021 at 02:07:01PM +0100, Ard Biesheuvel wrote:
> > > > > On Mon, 15 Mar 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
> > > > > > > On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
> > > > > > > >
> > > > > ...
> > > > > > > > fwiw, the valid use-case for ACPI boot on these things is for distro
> > > > > > > > installer.. it might not be the shiny accelerated experience, but you
> > > > > > > > want to be able to get thru the installer and then install updates to
> > > > > > > > get latest kernel/dtb/etc
> > > > > > > >
> > > > > > > > it is a small use-case, but kinda an important step ;-)
> > > > > > > >
> > > > > > >
> > > > > > > That is a fair point. However, as I understand it, we need this to work around
> > > > > > > - the need to pass efi=novamap
> > > > > > > - broken poweroff on Flex5g
> > > > > >
> > > > > > One more: broken EFI variable runtime services on all Snapdragon laptops
> > > > > >
> > > > > > It's been another pain of running debian-installer (d-i) on these
> > > > > > laptops, where EFI NV variables are just stored on UFS disk.  So after
> > > > > > Linux takes over the control of UFS, EFI NV variable runtime services
> > > > > > then become out of service.  Currently, we have to apply a hack [1] on
> > > > > > d-i grub-installer to get around the issue,  and it's been the only
> > > > > > remaining out-of-tree patch we have to carry for d-i.  With this nice
> > > > > > `OverrideSupported` support, we will be able to drop that hack
> > > > > > completely.
> > > > > >
> > > > > > >
> > > > > > > So an installer either needs to set the EFI variable, or pass
> > > > > > > efi=novamap on the first boot. Note that there are no arm64 EFI
> > > > > > > systems known where efi=novamap causes problems. In fact, I would
> > > > > > > prefer to stop using SetVirtualAddressMap() altogether, as it does not
> > > > > > > provide any benefit whatsoever. So perhaps we should make efi=novamap
> > > > > > > the default and be done with it.
> > > > > > >
> > > > > > > Broken poweroff is hardly a showstopper for an installer, given that
> > > > > > > we cannot even install GRUB correctly.
> > > > > > >
> > > > > > > In summary, I am more than happy to collaborate constructively on this
> > > > > > > (which is why I wrote the patch), but I don't think we're at a point
> > > > > > > yet where this is the only thing standing in our way when it comes to
> > > > > > > a smooth out-of-the-box Linux installation experience.
> > > > > >
> > > > > > There might be more to be done for getting a smooth Linux installation
> > > > > > experience.  But IMHO, this `OverrideSupported` thing is definitely
> > > > > > a big step to that.
> > > > > >
> > > > >
> > > > > So the problem here seems to be that grub-install (or efibootmgr)
> > > > > tolerates efivarfs being absent entirely, but bails out if it exists
> > > > > but gives an error when trying to access it, right?
> > > >
> > > > Yes, with EFI variables runtime service marked as unsupported,
> > > > efibootmgr will just exit on efi_variables_supported() check [1] in
> > > > a way that its parent process, i.e. grub-install, doesn't take as an
> > > > error.  But otherwise, efibootmgr will go much further and exit with
> > > > a real error when trying to access efivars.
> > > >
> > >
> > > OK, so I suggest we fix efibootmgr, by extending the
> > > efi_variables_supported() check to perform a GetVariable() call on an
> > > arbitrary variable (e.g., BootOrder),
> >
> > Hmm, I'm not sure we should ask more from user space, as it's already
> > been doing the right thing, and efi_variables_supported() is proved to
> > work properly with any sane low-level software (kernel + firmware),
> > either EFI variables service is supported or not.  That said, IMHO,
> > right now the low-level software on Snapdragon laptops is insane, i.e.
> > the unsupported/broken EFI runtime services are not communicated to
> > user space properly in established way.
> >
> 
> I disagree.
> 
> My Yoga returns
> 
> efivars: get_next_variable: status=8000000000000003
> 
> which is documented in the UEFI spec 2.8B section 8.2 as
> 
> """
> EFI_UNSUPPORTED
> After ExitBootServices() has been called, this return code may be
> returned if no variable storage is supported. The platform should
> describe this runtime service as unsupported at runtime via an
> EFI_RT_PROPERTIES_TABLE configuration table.
> """
> 
> No other condition is documented under which GetNextVariable() can
> return EFI_UNSUPPORTED, so it is perfectly suitable to decide whether
> the platform in question supports variable services at runtime at all.

I'm not arguing against ideal of checking EFI_UNSUPPORTED.  Instead, I
agree with that.  What I'm arguing is that this should be done by kernel
rather than efibootmgr.  The efi_variables_supported() of efibootmgr
checks EFIVARFS_MAGIC on /sys/firmware/efi/efivars.  So if we have kernel
function efivar_init() check and respect EFI_UNSUPPORTED return and stop
right there, we are all good then.  Could you take a look at the patch
attached and see if it's acceptable?

Shawn

------8<---------------

From a30a9a03ed254e0f893b831618b30eaffe7f2da7 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Wed, 17 Mar 2021 11:57:58 +0800
Subject: [PATCH] efivars: respect EFI_UNSUPPORTED return from firmware

As per UEFI spec 2.8B section 8.2, EFI_UNSUPPORTED may be returned by
EFI variable runtime services if no variable storage is supported by
firmware.  In this case, there is no point for kernel to continue
efivars initialization.  That said, efivar_init() should fail by
returning an error code, so that efivarfs will not be mounted on
/sys/firmware/efi/efivars at all.  Otherwise, user space like efibootmgr
will be confused by the EFIVARFS_MAGIC seen there, while EFI variable
calls cannot be made successfully.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/firmware/efi/vars.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 41c1d00bf933..abdc8a6a3963 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -484,6 +484,10 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 				}
 			}
 
+			break;
+		case EFI_UNSUPPORTED:
+			err = -EOPNOTSUPP;
+			status = EFI_NOT_FOUND;
 			break;
 		case EFI_NOT_FOUND:
 			break;
-- 
2.17.1

