Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371AE332DDF
	for <lists+linux-efi@lfdr.de>; Tue,  9 Mar 2021 19:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhCISKe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Mar 2021 13:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhCISKQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Mar 2021 13:10:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B1C06174A;
        Tue,  9 Mar 2021 10:10:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u16so17516321wrt.1;
        Tue, 09 Mar 2021 10:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzNzOMmL3LWxNFZWZ4MjuPE4IoBxhndH+OpOnMvFnFM=;
        b=XJpqnTCcD3rJKzTtEjCLK3L/1Eav0uY8rGGdlCYiKKUB+gNQB08xzfQR4hGT+d894n
         dPC0fitBR86mE0VK1AsNBpc6cwi1NKicxU6hH2yRqklx3E7CyqlYYCQ8jeMU97ED/uo9
         RTVGVpo7EsR8yF7kwy3MYXbQgon85qmaOZlo/uiuOn9JEpY4QF4mQkigKpHaBEcB09n7
         6Gi58gNkL8QpNNXgDgxGvnvI+rEkTYs/ZF3Hsgxc1MRfP9BHwHWlaq0xgFRwT1BPncCe
         qjnJWEzELT1xBGsgeKXAKor/MGQpfC/xdeJMl/lR+49PO/+/kNwlluRIJWygHidLXR2w
         TM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzNzOMmL3LWxNFZWZ4MjuPE4IoBxhndH+OpOnMvFnFM=;
        b=hGCpkTRCUgA5Uwcc5BC8KK5K/mp6n2eXBSGyxxwowN3PJpATf1IAHz/GCxsjtrnk41
         1a1Ab3Q+XqY++LgP580UDteYi+XuYzZ+J0roThz+Ba8rexEmcR3jY7W11Zt/zg+c1BkV
         P4eI9ygMpGEPSOuZc0DQKRjP3fZVpFubvWoSle0E74szQv6fXbjzpXhmo/9RHI8Niykk
         zpCRUQuCt45FlTk/e1S7LmIvK8lKnracNLehC42r1eTHYi8gudaZ2GjDw6h9A06LsK7N
         E8M69wbyjulp0lKJTx1vmVmNfLwvzRPBfRFDOQ0UpHSg6QvoxlvtUAkHOdNjbPqTBr0m
         ADaQ==
X-Gm-Message-State: AOAM533ZoHzDyx5PJbOLWHpp3/tLrp5aofqML5wqBA+AQXqb4KTWE3I4
        GAV1pj0+XMEiL215EKBP/50YMrY5iiM6gSKFtErgezLShWY=
X-Google-Smtp-Source: ABdhPJwE3ScQ1bpw69IoW/E49g+COZlQQ8p/WEAkLFTH9EauMwzuIfQQWf7WzBfc6ok6k0hJsW637cSOvBIdtVRlvdo=
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr31318206wrt.28.1615313415017;
 Tue, 09 Mar 2021 10:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20210306113519.294287-1-ardb@kernel.org> <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com> <20210309032248.GR17424@dragon>
In-Reply-To: <20210309032248.GR17424@dragon>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 9 Mar 2021 10:13:22 -0800
Message-ID: <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 8, 2021 at 7:22 PM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Mon, Mar 08, 2021 at 02:34:48PM +0100, Ard Biesheuvel wrote:
> > On Sun, 7 Mar 2021 at 12:02, Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > On Sat, Mar 06, 2021 at 12:35:19PM +0100, Ard Biesheuvel wrote:
> > > > Allow EFI systems to override the set of supported runtime services
> > > > declared via the RT_PROP table, by checking for the existence of a
> > > > 'OverrideSupported' EFI variable of the appropriate size under the
> > > > RT_PROP table GUID, and if it does, combine the supported mask using
> > > > logical AND. (This means the override can only remove support, not
> > > > add it back).
> > > >
> > > > Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > Cc: Rob Clark <robdclark@gmail.com>
> > > > Cc: Leif Lindholm <leif@nuviainc.com>
> > > > Cc: linux-arm-msm@vger.kernel.org
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Awesome, Ard!  On both Lenovo Yoga C630 and Flex 5G latops:
> > >
> > > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> > >
> > > With 'OverrideSupported' EFI variable added from UEFI Shell, we can drop
> > > 'efi=novamap' kernel cmdline and get around the broken poweroff runtime
> > > services nicely.  Thanks!
> > >
> >
> > Thanks for confirming.
> >
> > However, I am not going to merge this without some justification, and
> > hopefully some input from other folks (Leif?)
> >
> > RTPROP already provides what we need on all platforms that use
> > DtbLoader, and the patch for that is queued up for v5.12-rcX, with a
> > cc:stable to v5.10. This allows any RT service to be marked as
> > disabled, including SetVirtualAddressMap().
> >
> > So afaict, that means that this patch would be a special case for
> > Flex5G, right?
>
> It's for all Snapdragon based laptops, as we need to disable
> SetVirtualAddressMap runtime services on all of them.
>
> > So how are platforms such as this one going to load the
> > DTB? If some loader will be involved (or even just GRUB),
>
> Yes, GRUB.
>
> > shouldn't it
> > be that component that sets RTPROP like DtbLoader will, not the kernel
> > itself.
> >
> > Btw I don't think ACPI boot is a use case here. I don't see a software
> > framebuffer with no wifi support as a usage mode that justifies
> > carrying EFI stub hacks for everyone.
>
> Okay.  I'm fine to carry it as an out-of-tree patch until someday you
> consider ACPI boot is useful for everyone.  But I do boot these laptops
> with ACPI at daily basis right now as arm64 native build machine, with
> USB Ethernet adapter.

fwiw, the valid use-case for ACPI boot on these things is for distro
installer.. it might not be the shiny accelerated experience, but you
want to be able to get thru the installer and then install updates to
get latest kernel/dtb/etc

it is a small use-case, but kinda an important step ;-)

BR,
-R
