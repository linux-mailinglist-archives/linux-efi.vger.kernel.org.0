Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48BB33CEC4
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 08:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCPHnF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 03:43:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:42847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhCPHmz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Mar 2021 03:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615880564;
        bh=8yDr8Mi2eVooRRFxco1MT4YMNjK8v9cGV/UYrJ4vWBc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fHCdGjHAPcioohfdruk0ChAE4+IbB97JNjD96jPUMFiNzpg2WdcNJAcdksas9fq6I
         9SgPE86Ge5+L2sLjFj1fd6zqIb8iLJ5KGD0rplqJb/G+CQrDcChsOE8tqIou9VNkyU
         tWyF7nqXKnnGCANUSBUfE/KUamcc3pf7RhzRyvZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([62.143.246.89]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1lPeif1PFF-003beb; Tue, 16
 Mar 2021 08:42:44 +0100
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Ard Biesheuvel <ardb@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Steve McIntyre <steve@einval.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20210306113519.294287-1-ardb@kernel.org>
 <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon>
 <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <81899e5a-ab6d-69a2-c172-535300b3ce02@gmx.de>
Date:   Tue, 16 Mar 2021 08:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E+/W7fDRaQJFtvR+70EuR7xDHtZB39Skz59uxuY8WgHXxHKaLxj
 ZazplTGb6LpfTcHiJKcnT4IIbu0/1xZNFEkKRv5HWx3dyZG+gKZMc57WSGqWTmMvAdD0f6G
 2S0r5aN52hFbnhCVQO+UolNsBP+CiV1875CWmcMZYTiii9RMGcZfuFhYJt4CBILrOOnWEZJ
 8yM67Y9ZZ/WSQpD45tnrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WPLdMnD/lWc=:ECaWxVYGU5ZUvfI6zOkX1s
 LsGPSt3Vdg+rtKGke21XgjjSkB900uqNi95WFyD5jK56vGTZ9u+VFBifNlrsRugwODOwRV+IP
 A1jht0i1miLNMYRX1fZMOb+Hy9FWyJjLozA9MeIR0qqVW4/wOJYUd/uSfQLyv7q6d7wVT38Ip
 6eZvhALpk8+rn26XXicYi2ITcCHk9fg7xzWdquagDyNca4YolR0kO7HcTU0Y9zZuTyFqGrQTN
 B9sPsHWBr+sO5Z7smMzA2iBJ+Vo2wc2oCJayJn57Sf06nwrgIg6KL1znsAToptrMHwLiK6gZO
 1H+hERuQ/xchI5RBw8VNo/0fsGOO6n59C2Ga6tXuIH8f6kVauBrHwKGv21uUBM4mPzSEHFL1X
 as7m6MHJjjCpxHLP6TLf023pLRrty88p40EJt5Xasdp3Z30HBxAp+e85xHTRf9GQuOGkm/cPv
 OuZKMJk/CUObLYZJoh+qgqrDkcbMfNhSS3wrI39yhlUwy43mWuqMwLoYXvxAwYjcrcEIh9i3N
 ZBUSaZVk3DXbNRSZfCbSC7mWxrFd410cixptjD4Wdxg/hSWDR8vUHT7ulSRSVA7KU5URdL3Qt
 22MCSi0BlkarFsDzW+xRwyelYQE1vxm80hr3sZ2S18RZZ9iG5GEg1PiK6uwAGw3OapdRxsz3/
 8oQUpvk/rXL07AyIXPyNpFy4cMbrFkF8cTA+H6VlIJLRniabrRn8nyuWmiwJF2076Jp3gf5Zd
 X8ctMuzSNFow5LrFXpfxh7l0Lmf5wL0k29ZUOw/631ir5nZSDBdMj9wRioXIInb3zPsX/1rGb
 vpwKYTCeoIqctb07hU+5nBy0iVgp0qNzxjCK64PcVYwEEFO1nA5RflcTxsACLZ5KuMt8qEj2B
 taITxqmI7XBol259Q6Fg==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 3/15/21 2:07 PM, Ard Biesheuvel wrote:
> On Mon, 15 Mar 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
>>
>> On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
>>> On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
>>>>
> ...
>>>> fwiw, the valid use-case for ACPI boot on these things is for distro
>>>> installer.. it might not be the shiny accelerated experience, but you
>>>> want to be able to get thru the installer and then install updates to
>>>> get latest kernel/dtb/etc
>>>>
>>>> it is a small use-case, but kinda an important step ;-)
>>>>
>>>
>>> That is a fair point. However, as I understand it, we need this to wor=
k around
>>> - the need to pass efi=3Dnovamap
>>> - broken poweroff on Flex5g
>>
>> One more: broken EFI variable runtime services on all Snapdragon laptop=
s
>>
>> It's been another pain of running debian-installer (d-i) on these
>> laptops, where EFI NV variables are just stored on UFS disk.  So after
>> Linux takes over the control of UFS, EFI NV variable runtime services
>> then become out of service.  Currently, we have to apply a hack [1] on
>> d-i grub-installer to get around the issue,  and it's been the only
>> remaining out-of-tree patch we have to carry for d-i.  With this nice
>> `OverrideSupported` support, we will be able to drop that hack
>> completely.
>>
>>>
>>> So an installer either needs to set the EFI variable, or pass
>>> efi=3Dnovamap on the first boot. Note that there are no arm64 EFI
>>> systems known where efi=3Dnovamap causes problems. In fact, I would
>>> prefer to stop using SetVirtualAddressMap() altogether, as it does not
>>> provide any benefit whatsoever. So perhaps we should make efi=3Dnovama=
p
>>> the default and be done with it.
>>>
>>> Broken poweroff is hardly a showstopper for an installer, given that
>>> we cannot even install GRUB correctly.
>>>
>>> In summary, I am more than happy to collaborate constructively on this
>>> (which is why I wrote the patch), but I don't think we're at a point
>>> yet where this is the only thing standing in our way when it comes to
>>> a smooth out-of-the-box Linux installation experience.
>>
>> There might be more to be done for getting a smooth Linux installation
>> experience.  But IMHO, this `OverrideSupported` thing is definitely
>> a big step to that.
>>
>
> So the problem here seems to be that grub-install (or efibootmgr)
> tolerates efivarfs being absent entirely, but bails out if it exists
> but gives an error when trying to access it, right?
>
> This is not only a problem on Snapdragon systems afaik - most Uboot
> based arm64 systems booting via EFI are affected by this as well.
>
> So it would be good if we could align with those folks, and maybe the
> ones working on RISC-V as well, to see if we can get some consensus
> around taking this approach.
>
> For the folks newly cc'ed on this thread: full version here
> https://lore.kernel.org/linux-arm-msm/20210306113519.294287-1-ardb@kerne=
l.org/
>
> Note that I am both the author of the patch, and the maintainer
> pushing back on it. Please chime in if you think there are reasons why
> we want this, something like this or nothing like this.
>
Hello Ard,

looking at this thread it is hard to understand why this patch should be
needed.

If an UEFI application does not want to consume a service, it can do so
without having to manipulate the RT properties table.

Which UEFI applications are broken? Why can't they be fixed instead of
patching the kernel?

Can we have complete descriptions of the deficiencies of the involved
applications. I saw GRUB and the Debian installer mentioned in the
thread. Are there others?

Best regards

Heinrich
