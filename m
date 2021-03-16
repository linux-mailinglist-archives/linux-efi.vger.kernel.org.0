Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D4333D602
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 15:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhCPOpx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 10:45:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:43317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235649AbhCPOpV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Mar 2021 10:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615905906;
        bh=+hj371ZvbslSEXbF2GK+d5/3/Dm7TR/yGFlFX9d6bgg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LX8woALPmxBU2bDL+NpV6leiMUCmyQzX7YyycUpd4fokU3tBXFQyvxuoDrK6+e/EN
         5NCgj3BDaoWfT9EWUNoKXFoK1Tt9yGXjct0evfdJm7FYNACQi1lEkRbyhk+pmLC6Ox
         6zL+JA/PIeDQfOzpqliA2SgRpRBdLoS/Grj9mjgA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([62.143.246.89]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiDd-1l4G0z19Tz-00QFLJ; Tue, 16
 Mar 2021 15:45:06 +0100
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Steve McIntyre <steve@einval.com>,
        Rob Clark <robdclark@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon>
 <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <20210316075214.GA32651@dragon>
 <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
 <20210316090609.GB32651@dragon> <YFB7Y0FSSXmPEByF@enceladus>
 <d3d25724-6777-3c9e-5dbe-0e1570544376@gmx.de>
 <CAMj1kXGGdVYVxaz6+P=Ao_ZnzAOQ15eq3USzq3td-hYpbGe+vQ@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <a0383983-9845-24ea-4f78-dec390206c6c@gmx.de>
Date:   Tue, 16 Mar 2021 15:45:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGGdVYVxaz6+P=Ao_ZnzAOQ15eq3USzq3td-hYpbGe+vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sr0Do53DvpSqg+yABKR6+u+nsJ/iYRhgZ2fcpvMJ7ldwo/o4uRT
 fKvfCfFSJX8RVbFvNkyLcH7viIhgLNrszb2+J7+9IuRNTqQ746/iwo8IbyUanNoPoAGXMiM
 5tLI4M5181UrNEkrWeHovgVIOWUvDt3jc6MZnbvm3n2k/8iBJDBeKV6Me8Zq1SyQwkrcSFq
 vPNhfyZbUmeu6TAeW1xyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OCrM649mjCc=:56O7Ka3+N2IbvvB3M6j2yh
 PsvUCXNpycvQcb/Me3NRDCK8Ho4iNUGiE5EZAWiSEQuEuVhFYmxpki81GMUK6Nd1fPXjU8ppg
 GZ1TConuyHT+8NuobFYrZeF6w3GT1xrh2ICc4N6DA8NC5RdKQJ+UOgTI9k3BaaXDw6xp6IqWW
 6xwnFeRGOsMF4rk//0bF3X6bUkDGqylfN/w+xv3v2v76mw//6Rwc+kqBAQ6j9jH3eUmtY+qDl
 f0rrQDJ10kkenjtMFRRtMnMxstHD3uDsM32gsNX1C1dY1Q71ChYML1ME79K3zi+/GSAXlRlIL
 x3D4lK0p0lO17sNMF8bolHTSBz8dCUD9F9MrOITo8FHzTLlYI5PH35U/tAiq0GxW8Uc6RmOWO
 6wjxG8poXtF+llGkf+hwty7vACq+dnbpLNU2iLLRZiAtvjVW9TAql4xFRw9PEb7hrsBLr/9On
 3iqpzMRBRxUt4oEpqafRXbHkiCbrFrWKf33kRGxnPUZqP4gIdCoxV6zs+Z3zPEkgVVmz3xSTG
 Kh5krIUf3SEjQluKS0GigR9X1Q57/mHB2sOU6qUx6y2JdOzTZO9Uiv24izgHV0d5/EMYWrp2k
 zlwKZm/NW4sVsoNmH5xWmGE19xgfjB5cPWQORpnhVn6S9UoFWj3q5pJkL/EBsTppAjg4Jn3Nf
 Zch0gINR2SqkR2TCQPAOZvVsvGMNW/iM8dDmReCpWpiXfKMtIKKA4LNpsS0SBk4W1Tsxvv+lr
 fSIwJQjRVkI8KujfyOa1REm6aZQBcN3k9Efe9QtxI+dkdqbv1jVOd/bbeXv8i+/DQY4F7NMTD
 Qa7O3N1ANnXWDI5P4T41r582YOvdM+OPsVCkNtBHFjiiQKNWdQIfRIcW4yNLSYIQql7ksFG7q
 00pcJj/+kdBIrG++K7Jw==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 16.03.21 15:06, Ard Biesheuvel wrote:
> On Tue, 16 Mar 2021 at 14:25, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 16.03.21 10:33, Ilias Apalodimas wrote:
>>> Hi Shawn,
>>>
>>>>>>>>> So an installer either needs to set the EFI variable, or pass
>>>>>>>>> efi=3Dnovamap on the first boot. Note that there are no arm64 EF=
I
>>>>>>>>> systems known where efi=3Dnovamap causes problems. In fact, I wo=
uld
>>>>>>>>> prefer to stop using SetVirtualAddressMap() altogether, as it do=
es not
>>>>>>>>> provide any benefit whatsoever. So perhaps we should make efi=3D=
novamap
>>>>>>>>> the default and be done with it.
>>>>>>>>>
>>>>>>>>> Broken poweroff is hardly a showstopper for an installer, given =
that
>>>>>>>>> we cannot even install GRUB correctly.
>>>>>>>>>
>>>>>>>>> In summary, I am more than happy to collaborate constructively o=
n this
>>>>>>>>> (which is why I wrote the patch), but I don't think we're at a p=
oint
>>>>>>>>> yet where this is the only thing standing in our way when it com=
es to
>>>>>>>>> a smooth out-of-the-box Linux installation experience.
>>>>>>>>
>>>>>>>> There might be more to be done for getting a smooth Linux install=
ation
>>>>>>>> experience.  But IMHO, this `OverrideSupported` thing is definite=
ly
>>>>>>>> a big step to that.
>>>>>>>>
>>>>>>>
>>>>>>> So the problem here seems to be that grub-install (or efibootmgr)
>>>>>>> tolerates efivarfs being absent entirely, but bails out if it exis=
ts
>>>>>>> but gives an error when trying to access it, right?
>>>>>>
>>>>>> Yes, with EFI variables runtime service marked as unsupported,
>>>>>> efibootmgr will just exit on efi_variables_supported() check [1] in
>>>>>> a way that its parent process, i.e. grub-install, doesn't take as a=
n
>>>>>> error.  But otherwise, efibootmgr will go much further and exit wit=
h
>>>>>> a real error when trying to access efivars.
>>>>>>
>>>>>
>>>>> OK, so I suggest we fix efibootmgr, by extending the
>>>>> efi_variables_supported() check to perform a GetVariable() call on a=
n
>>>>> arbitrary variable (e.g., BootOrder),
>>>>
>>>> Hmm, I'm not sure we should ask more from user space, as it's already
>>>> been doing the right thing, and efi_variables_supported() is proved t=
o
>>>> work properly with any sane low-level software (kernel + firmware),
>>>> either EFI variables service is supported or not.  That said, IMHO,
>>
>> No, there is not one but there are three EFI variable services.
>>
>> GetVariable() available after ExitBootServices() and SetVariable() not
>> available() is completely legal according to the current UEFI specifica=
tion.
>>
>
> This is a valid point. efibootmgr may be able to read the Boot####
> variables, but may be unable to change them.
>
>>>> right now the low-level software on Snapdragon laptops is insane, i.e=
.
>>>> the unsupported/broken EFI runtime services are not communicated to
>>>> user space properly in established way.
>>
>> Please, describe:
>>
>> * Which UEFI version is reported by your Snapdragon laptop?
>> * What is the observed behavior?
>>
>
> These laptops have the EFI varstore in a eMMC partition. This is
> basically the same problem that many uboot based platforms have as
> well, i.e., that it is not possible for the OS and the firmware to
> share the MMC because the ownership of the MMC controller cannot be
> shared.
>
>>>
>>> But the EFI_UNSUPPORTED is an error that's allowed from the spec.
>>> Yes the sane thing to do is not expose it at all, but it's not violati=
ng
>>> any spec by doing so.
>>> So why shouldn't a userspace application be able to handle all return =
codes
>>> explicitly and instead treat them as a single error? And when that hap=
pens why
>>> shouldut  the kernel mask that error out for it?
>>
>> The runtime services must always be callable even they can only report
>> EFI_UNSUPPORTED.
>>
>> Only since UEFI specification 2.8 errata B do we have the
>> EFI_RT_PROPERTIES_TABLE which tells us which runtime services are
>> implemented.
>>
>> UEFI 2.8 B makes it clear that any runtime service may be reported as
>> unsupported. EFI applications are expected to cope with a service being
>> unavailable.
>>
>
> Indeed. The firmware on these machines predates the UEFI 2.8B
> specification, but given the fact that EFI_UNSUPPORTED is a valid
> return code now for these services, we should deal with them
> gracefully anyway. And apparently, doing so would also remove the need
> for special hacks to support installing GRUB on these platforms.
>

Hello Ard,

it is still unclear to why you would need the patch. Why should a user
provide a UEFI variable telling which service is not working correctly?

Is the firmware correctly returning EFI_UNSUPPORTED for unsupported
services?
For which services?

In which software is the bug that cannot gracefully deal with
unsupported services?

GRUB never gave me a problem on boards with U-Boot which only provides
GetVariable() and not SetVariable(). GRUB spits out warnings but works
as expected.

Best regards

Heinrich
