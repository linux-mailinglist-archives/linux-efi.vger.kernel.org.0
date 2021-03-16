Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3B33D8AF
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 17:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhCPQGo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 12:06:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:60075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238443AbhCPQGX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Mar 2021 12:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615910765;
        bh=t+8pwaavcKvrzVIH+mFMhHIBW3TfmtFEhi1ZQ5fEQSE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=b/QQaKWJ1cNYQpiFa+9pkQ4kCDzOYQq04xnq7Eqp9n5EFPrQSBU1J+R7WS/ERq4j1
         FwSEj7D4xQ7TVZbUZS1cw0PWruIk/UEZRHpYkHZQj9uvpstP3rjXgVig6zDI8pMrhh
         kPXYq0foGcaD+AJEiRzJVzcjzaHPajyyMhqQ0sw8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([62.143.246.89]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD2O-1lrO632Ad8-00eIUp; Tue, 16
 Mar 2021 17:06:05 +0100
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
 <a0383983-9845-24ea-4f78-dec390206c6c@gmx.de>
 <CAMj1kXE7xQ3D2-VG5hUuwaautQt5VT2d9OtAO4QFQQStpOMEJg@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <bbbc4017-739b-1c40-c061-a1b0ec7429ed@gmx.de>
Date:   Tue, 16 Mar 2021 17:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXE7xQ3D2-VG5hUuwaautQt5VT2d9OtAO4QFQQStpOMEJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YPv2fDhfeYw2iVWlqMYnRKyrblX8RIlSMc7MGZMYrfwZWjFpzig
 VC2JXpiE7rjNLytiOryGd84gMK0tCVHsVU8JNEKYxPKAhld6/SBwOs07moJSJ8YwFUMRE9z
 PoUj5VyOJpqX2OyXR+1T9hVXXU+9P0T2K0ddJK8wzrPWTWeu+4WGdEVqyDlAS9vI15cJWon
 P8t9fiGnbPfIbxQ4Is2aQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FUerWa48DZA=:uwhInlLaQ+/q9nbFQksoBC
 /7IsrpevVO7NIeSlwJ1cKVWyoxerxGGCb+1v3MNf19fbVT2E0CJEUsHLxkUkaIgZKQEnP1av1
 e0unUGkYvbkpyIG4dIRBAoDDFCOl0hrmsC1XhdN6LjO+Ak2Vig4YI34JQyS/CLJ+qFGYJxMmV
 iWLxp3ebTZe/4HrXn4vTbd01cnBZTEf3dBCUqm+EbI+95w/v84j46aNLfxNtjMLygWIrP7Lhd
 bGuMQCV5a1lhBMi6CIlCHCrIqnVAQTd0auHzq9Q3VjdlBpkXU7q+udfwMZ7jmt6ysPOQClVFv
 NGKh6khov3qG6WwDT1/B08vWnGHVxZ2G5g7R1O4GaVfQS8AEq/dPwiWgzA9hiW6NpBofnFHe0
 CVgC6sTkk7y2meyIxWTmDqLQlNtXxzOMuxZHM96fdHK3nbd+ij/IMw8rh57/S5kK7Wx4mxwpL
 +7EdkqeGRKao+Yk/Kx/9QKQ4AJ8BBrx+lSgGwp5vCrgNoBX7ALDMUrWb7bLDvBz4JM53hlRL2
 xE1D/RcXWX9sfmVeLUMHNTCLbtTUdBvV6oOeExzFHO54J364ibK4nqHv5fNRhm5pR5n6FyoOn
 90I+UZiK9Bsz/xRHqMROB1FGeW8bp52v00Je/sfgQg7doaNvURs6NAAdBV2KmmhT2cahK2tQw
 2bhOUt1aH3ewKK63scViNOQJGbWNxiZE0So4Yowf1GjqHr83QAWZHDXRtF2TxLzMuMQLATomZ
 CRzUfb11cBTDs7uY0r7fkGymdEeTRMknJCw4tYibkuQ/t3RiQrRpkKSOHIvfjFgg2qCFlSjMF
 J/1dDgY0E5ezGNrjat9NVFC7ZUkCDH8X10l4MDnTnq5j49BzJIQ3ua75UueHAc7YjmbKzKeJR
 Z+8rZDNobfTLyjSRtqYg==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 16.03.21 15:55, Ard Biesheuvel wrote:
> On Tue, 16 Mar 2021 at 15:45, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 16.03.21 15:06, Ard Biesheuvel wrote:
>>> On Tue, 16 Mar 2021 at 14:25, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
>>>>
>>>> On 16.03.21 10:33, Ilias Apalodimas wrote:
>>>>> Hi Shawn,
>>>>>
>>>>>>>>>>> So an installer either needs to set the EFI variable, or pass
>>>>>>>>>>> efi=3Dnovamap on the first boot. Note that there are no arm64 =
EFI
>>>>>>>>>>> systems known where efi=3Dnovamap causes problems. In fact, I =
would
>>>>>>>>>>> prefer to stop using SetVirtualAddressMap() altogether, as it =
does not
>>>>>>>>>>> provide any benefit whatsoever. So perhaps we should make efi=
=3Dnovamap
>>>>>>>>>>> the default and be done with it.
>>>>>>>>>>>
>>>>>>>>>>> Broken poweroff is hardly a showstopper for an installer, give=
n that
>>>>>>>>>>> we cannot even install GRUB correctly.
>>>>>>>>>>>
>>>>>>>>>>> In summary, I am more than happy to collaborate constructively=
 on this
>>>>>>>>>>> (which is why I wrote the patch), but I don't think we're at a=
 point
>>>>>>>>>>> yet where this is the only thing standing in our way when it c=
omes to
>>>>>>>>>>> a smooth out-of-the-box Linux installation experience.
>>>>>>>>>>
>>>>>>>>>> There might be more to be done for getting a smooth Linux insta=
llation
>>>>>>>>>> experience.  But IMHO, this `OverrideSupported` thing is defini=
tely
>>>>>>>>>> a big step to that.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> So the problem here seems to be that grub-install (or efibootmgr=
)
>>>>>>>>> tolerates efivarfs being absent entirely, but bails out if it ex=
ists
>>>>>>>>> but gives an error when trying to access it, right?
>>>>>>>>
>>>>>>>> Yes, with EFI variables runtime service marked as unsupported,
>>>>>>>> efibootmgr will just exit on efi_variables_supported() check [1] =
in
>>>>>>>> a way that its parent process, i.e. grub-install, doesn't take as=
 an
>>>>>>>> error.  But otherwise, efibootmgr will go much further and exit w=
ith
>>>>>>>> a real error when trying to access efivars.
>>>>>>>>
>>>>>>>
>>>>>>> OK, so I suggest we fix efibootmgr, by extending the
>>>>>>> efi_variables_supported() check to perform a GetVariable() call on=
 an
>>>>>>> arbitrary variable (e.g., BootOrder),
>>>>>>
>>>>>> Hmm, I'm not sure we should ask more from user space, as it's alrea=
dy
>>>>>> been doing the right thing, and efi_variables_supported() is proved=
 to
>>>>>> work properly with any sane low-level software (kernel + firmware),
>>>>>> either EFI variables service is supported or not.  That said, IMHO,
>>>>
>>>> No, there is not one but there are three EFI variable services.
>>>>
>>>> GetVariable() available after ExitBootServices() and SetVariable() no=
t
>>>> available() is completely legal according to the current UEFI specifi=
cation.
>>>>
>>>
>>> This is a valid point. efibootmgr may be able to read the Boot####
>>> variables, but may be unable to change them.
>>>
>>>>>> right now the low-level software on Snapdragon laptops is insane, i=
.e.
>>>>>> the unsupported/broken EFI runtime services are not communicated to
>>>>>> user space properly in established way.
>>>>
>>>> Please, describe:
>>>>
>>>> * Which UEFI version is reported by your Snapdragon laptop?
>>>> * What is the observed behavior?
>>>>
>>>
>>> These laptops have the EFI varstore in a eMMC partition. This is
>>> basically the same problem that many uboot based platforms have as
>>> well, i.e., that it is not possible for the OS and the firmware to
>>> share the MMC because the ownership of the MMC controller cannot be
>>> shared.
>>>
>>>>>
>>>>> But the EFI_UNSUPPORTED is an error that's allowed from the spec.
>>>>> Yes the sane thing to do is not expose it at all, but it's not viola=
ting
>>>>> any spec by doing so.
>>>>> So why shouldn't a userspace application be able to handle all retur=
n codes
>>>>> explicitly and instead treat them as a single error? And when that h=
appens why
>>>>> shouldut  the kernel mask that error out for it?
>>>>
>>>> The runtime services must always be callable even they can only repor=
t
>>>> EFI_UNSUPPORTED.
>>>>
>>>> Only since UEFI specification 2.8 errata B do we have the
>>>> EFI_RT_PROPERTIES_TABLE which tells us which runtime services are
>>>> implemented.
>>>>
>>>> UEFI 2.8 B makes it clear that any runtime service may be reported as
>>>> unsupported. EFI applications are expected to cope with a service bei=
ng
>>>> unavailable.
>>>>
>>>
>>> Indeed. The firmware on these machines predates the UEFI 2.8B
>>> specification, but given the fact that EFI_UNSUPPORTED is a valid
>>> return code now for these services, we should deal with them
>>> gracefully anyway. And apparently, doing so would also remove the need
>>> for special hacks to support installing GRUB on these platforms.
>>>
>>
>> Hello Ard,
>>
>> it is still unclear to why you would need the patch. Why should a user
>> provide a UEFI variable telling which service is not working correctly?
>>
>
> Why would it be the user setting this variable?
>
>> Is the firmware correctly returning EFI_UNSUPPORTED for unsupported
>> services?
>
> Yes
>
>> For which services?
>>
>
> All runtime services except SetVirtualAddressMap() and ResetSystem()
>
>> In which software is the bug that cannot gracefully deal with
>> unsupported services?
>>
>
> The debian installer gives up if it cannot set the boot path for GRUB.

The installer should simply open a message box asking the user to set up
a boot option for shimaa64.efi (or grubaa64.efi).

This is nothing that can be fixed in the Linux kernel.

Best regards

Heinrich

>
>> GRUB never gave me a problem on boards with U-Boot which only provides
>> GetVariable() and not SetVariable(). GRUB spits out warnings but works
>> as expected.
>>
>> Best regards
>>
>> Heinrich

