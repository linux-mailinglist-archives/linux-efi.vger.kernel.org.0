Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E801933D0DF
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 10:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhCPJdi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 05:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhCPJd2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Mar 2021 05:33:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91766C06174A
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 02:33:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u16so10081386wrt.1
        for <linux-efi@vger.kernel.org>; Tue, 16 Mar 2021 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=et+1ZvQ1+gasZwQhD3sG15pwfg1DAlDgsMAObHI9SQI=;
        b=k99Do/ibQk6c/NeYMaFi2pLZspwXBRoXXnd+ayQ866j02kvxP0Dy61E3vKnhUHIpja
         H2Cxt1DZF4Isz1Wd5Ks+0N4EbahzVdyAV4nL3LOuxdDzRw/jmeEpKzIUqFllHM4Fwp1q
         HGbSvdv+hO1csv2Yb8v1m2z/4ipV07iilUv7aCouBpnwqODHCRNXmssR8RkHBDMtnGiG
         1ksg2nSfKlp40tyklN/Dca+BIwmLb3TBnxvT9h10Q+/FTYSyoUT3sI2U/oXtAfLSsnPW
         DSNjfejurNhf/X/1V9avo4d5mYsqPBPOqKyP6fGKjpHgx6S+pXfUTrWWXcgQ2BfcLdn4
         EDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=et+1ZvQ1+gasZwQhD3sG15pwfg1DAlDgsMAObHI9SQI=;
        b=uViHwnTGXDeHWh48zcF02FM9cnxvnbgKn+IvIdp2vtWl8A05IWXdvF05UzdpUgcJck
         pBmzYHYrNwLhdbVNkR513zhGtrPmcb8AObbBRrpGDnWXArIcumyYKGYM0o/sjyUJ/tlw
         jTOk9BZ0dc/jMLdgVDuZg+SJp6ObWTuVT6hN7apjAbR/li5VLO1mpnRLTTMEMAC0WzJp
         phcWaQiJ2y/XHOPYcHupgvwP22IVUfKCMatZ4GzDkR743brV7wkjFgjCUwbn7stJmp2/
         ymFmwu8LmtT1LLsdDwkaZMVI2HsdO5yPn5x7V40cthZnYB5Jdq3VaubXUksY3Me1nRVU
         zXkA==
X-Gm-Message-State: AOAM530TF9f78LUCfiEYW8UmWsacYTUR7usKycWH5trtQMIXHKPc/RPn
        lghsFnbfqSwgh/H7f9SUmirGUQ==
X-Google-Smtp-Source: ABdhPJwC7HGrtfYKqXfX6qEl85FnHRO39oFh9Nz9/qnNUfk813kz4MXo5GBFHdlgOiZGGGeuQvqgrA==
X-Received: by 2002:adf:84e6:: with SMTP id 93mr3678452wrg.376.1615887206246;
        Tue, 16 Mar 2021 02:33:26 -0700 (PDT)
Received: from enceladus (ppp-94-64-113-158.home.otenet.gr. [94.64.113.158])
        by smtp.gmail.com with ESMTPSA id w11sm22899048wrv.88.2021.03.16.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 02:33:25 -0700 (PDT)
Date:   Tue, 16 Mar 2021 11:33:23 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Steve McIntyre <steve@einval.com>,
        Rob Clark <robdclark@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based
 on EFI variable
Message-ID: <YFB7Y0FSSXmPEByF@enceladus>
References: <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon>
 <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <20210316075214.GA32651@dragon>
 <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
 <20210316090609.GB32651@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316090609.GB32651@dragon>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Shawn,

> > > > > > So an installer either needs to set the EFI variable, or pass
> > > > > > efi=novamap on the first boot. Note that there are no arm64 EFI
> > > > > > systems known where efi=novamap causes problems. In fact, I would
> > > > > > prefer to stop using SetVirtualAddressMap() altogether, as it does not
> > > > > > provide any benefit whatsoever. So perhaps we should make efi=novamap
> > > > > > the default and be done with it.
> > > > > >
> > > > > > Broken poweroff is hardly a showstopper for an installer, given that
> > > > > > we cannot even install GRUB correctly.
> > > > > >
> > > > > > In summary, I am more than happy to collaborate constructively on this
> > > > > > (which is why I wrote the patch), but I don't think we're at a point
> > > > > > yet where this is the only thing standing in our way when it comes to
> > > > > > a smooth out-of-the-box Linux installation experience.
> > > > >
> > > > > There might be more to be done for getting a smooth Linux installation
> > > > > experience.  But IMHO, this `OverrideSupported` thing is definitely
> > > > > a big step to that.
> > > > >
> > > >
> > > > So the problem here seems to be that grub-install (or efibootmgr)
> > > > tolerates efivarfs being absent entirely, but bails out if it exists
> > > > but gives an error when trying to access it, right?
> > >
> > > Yes, with EFI variables runtime service marked as unsupported,
> > > efibootmgr will just exit on efi_variables_supported() check [1] in
> > > a way that its parent process, i.e. grub-install, doesn't take as an
> > > error.  But otherwise, efibootmgr will go much further and exit with
> > > a real error when trying to access efivars.
> > >
> > 
> > OK, so I suggest we fix efibootmgr, by extending the
> > efi_variables_supported() check to perform a GetVariable() call on an
> > arbitrary variable (e.g., BootOrder),
> 
> Hmm, I'm not sure we should ask more from user space, as it's already
> been doing the right thing, and efi_variables_supported() is proved to
> work properly with any sane low-level software (kernel + firmware),
> either EFI variables service is supported or not.  That said, IMHO,
> right now the low-level software on Snapdragon laptops is insane, i.e.
> the unsupported/broken EFI runtime services are not communicated to
> user space properly in established way.

But the EFI_UNSUPPORTED is an error that's allowed from the spec. 
Yes the sane thing to do is not expose it at all, but it's not violating
any spec by doing so.
So why shouldn't a userspace application be able to handle all return codes
explicitly and instead treat them as a single error? And when that happens why
should the kernel mask that error out for it?

Thanks
/Ilias
> 
> Shawn
> 
> > and treat EFI_UNSUPPORTED as a
> > special case that means that carrying on is pointless.
> > 
> > (but someone please confirm that the snapdragon efi firmware does
> > return EFI_UNSUPPORTED and not some other return value when calling
> > GetVariable() from under the OS)
