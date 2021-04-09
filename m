Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC0C3595AC
	for <lists+linux-efi@lfdr.de>; Fri,  9 Apr 2021 08:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhDIGlF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Apr 2021 02:41:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:59567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhDIGlF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 9 Apr 2021 02:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617950438;
        bh=y9hz3hp246sSvQDd38FFxwWhL1d598awtwnKvrccnmw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AK4MI0qnoTiNwtt8msGefMgGFsXQ1oNREX+N9ft7niJYKZTvB1eznfbFc6QndFoZV
         1JffjhiTYeiQnft1wkFdHcibWsf/cwBHwSM0raCvrgixE35GbeiwY+Ie6qOaH1c7Pk
         MXc+OiymFHRwJJkz3GtyC0u+w8g6JuJsvF28zEoU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.35] ([62.143.247.63]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1l0xNx3QXU-00TlI3; Fri, 09
 Apr 2021 08:40:37 +0200
Subject: Re: [PATCH v2 5/8] linux/arm: account for COFF headers appearing at
 unexpected offsets
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <leif@nuviainc.com>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
 <20201025134941.4805-6-ard.biesheuvel@arm.com>
 <70b3f147-b6d6-013e-fc65-e7228486d911@gmx.de>
 <CAMj1kXFC6OvBD2tDeKWbSWugurvheZdr9vw_F-r6WRwnpLsG2w@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <371cd2a9-1302-8e8c-9c2e-3fffb1be6a1e@gmx.de>
Date:   Fri, 9 Apr 2021 08:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFC6OvBD2tDeKWbSWugurvheZdr9vw_F-r6WRwnpLsG2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YVdTdzXt+odTb8sbDsehRrFabKie2T8hKCXCrOfVMw5p/gxYThf
 LuyDBsyLstcKUMNpxeau2u5xVmUAAD62sylLemKsb4/85+BWe4lPmHJ8wyBrAakyKoa+3Lh
 s7ct+KKeTSn227mM6iySwe3LM+3xnFutd/JMypuY784YMlAevaPE5EXacdJJpQdxJbPD6If
 9+sy89R/OL4gdehy9fkBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AEAjXVs7i80=:6kkest2D45RR8roSTz6N+7
 MwMJ9UpnI840lrJsGkiCX5PpugxoA28zDX50mCpG07WZ4KEOIsxiVZ+DbO4oEuN5bTsgt1HSh
 q3KR8VhkjP36czz1qRInK6DyDjL18y0Cnbh7su9AiCMNcsL/w6PCC7QRHHFj8DdU/OQPoNApC
 WbTXa1TJi/kHvx35RM+z3yTRIbAYtOXYywFmxdwjAQHaoqWWA8x2mytXAeVLIN8V5udUnZ1H7
 Sgzbj+p3lsfLZb8co4NMxNNdV71bPSY+JOKGDhH3UpEpK1IoXSCaSlklklJWcM8CdXI/fRONL
 YUmLRA5HOXBmrVSIN8hTH+GvOJYWmdsVOgChJ3v71XBcOp/78TMj96vwoGSyhAKTwagBlZ1pG
 +1OBXQWadl78tZpoCM8sJDjIEogx5mszgm8vOsOjRbwdC8GQOR4yCkBO5Nu6rKNIj4CQQKBes
 TwkjaPjcgciLTG1cbi7kUnZpliLGgyXfAKKE1V96FlvtgO7arYKduoklHxSCPH0nSdNRFSzUj
 WHzMhTJjKKG5NfyuDXXIi+bgoiOoSt2mOco6WjGok66FVibufPwo7S9jAbkoz5657ThMRUXfp
 zSy70c6LUQphXxLO4EGPgGG0NbNoIfIUit6neBq+Lz7NGl+D9UIHohVBoHiusQdSlYfzC0xV9
 DuHxKt4MepciTMRmb7PRfTR3pwHmzos0djtsnpiXP+TqXPbsSyo6Hj91IZEZQ8vDIik3UfAmR
 IUU4OXS8i4Bw9gS4/sDe7JUMLDIF2woiMMfqHfmUHyC4toxE4iMb4DsZcFXCcl/vT4OXcjmSL
 6cZZPlMVLbkeorWZTzU4jNvSLgfX4IuBhmsW0kLwbbViVIqjcT15Jxrdf0DZdvep3BY6d4gfd
 jWyeKLt4x/I50WxPU3GxIBLAOIKwMMo7lSYQ1LtwlXs273XwFxPVTzU9gXn9+TyMrtSyYSLC2
 7pdOZbAJyIwW10RK7t0GBFUEy4XQSqJcLFxv5dpcYQ31xMYpePzfjE4iq4hPqOzfHTXlNzapY
 wNTCb4SP8inOlqE/ZUBH0y2Yn872Z8j7GgJ7OhfAdiP2Mey3zpCXhveWLHGrrK95esragvkpw
 H65zWbGgzkC7RlYx7zZX/iTFHLnZTSeSHrNsIY3g/DR4beox0Txon2DGhCJlAfW3OkgeDq+qs
 M5OpSTPcc4lCnyV6EHWQHrvEqtfwQkle+gVDbS9gRnRwg3g37yj81/jXAo+a7daoYz5Wc=
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/9/21 8:12 AM, Ard Biesheuvel wrote:
> On Thu, 8 Apr 2021 at 20:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 10/25/20 2:49 PM, Ard Biesheuvel wrote:
>>> The way we load the Linux and PE/COFF image headers depends on a fixed
>>> placement of the COFF header at offset 0x40 into the file. This is a
>>> reasonable default, given that this is where Linux emits it today.
>>> However, in order to comply with the PE/COFF spec, which permits this
>>> header to appear anywhere in the file, let's ensure that we read the
>>> header from where it actually appears in the file if it is not located
>>> at offset 0x40.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
>>> ---
>>>    grub-core/loader/arm64/linux.c | 15 +++++++++++++++
>>>    1 file changed, 15 insertions(+)
>>>
>>> diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/l=
inux.c
>>> index 915b6ad7292d..28ff8584a3b5 100644
>>> --- a/grub-core/loader/arm64/linux.c
>>> +++ b/grub-core/loader/arm64/linux.c
>>> @@ -66,6 +66,21 @@ grub_arch_efi_linux_load_image_header (grub_file_t =
file,
>>>      grub_dprintf ("linux", "UEFI stub kernel:\n");
>>>      grub_dprintf ("linux", "PE/COFF header @ %08x\n", lh->hdr_offset)=
;
>>>
>>> +  /*
>>> +   * The PE/COFF spec permits the COFF header to appear anywhere in t=
he file, so
>>> +   * we need to double check whether it was where we expected it, and=
 if not, we
>>> +   * must load it from the correct offset into the coff_image_header =
field of
>>> +   * struct linux_arch_kernel_header.
>>> +   */
>>> +  if ((grub_uint8_t *) lh + lh->hdr_offset !=3D (grub_uint8_t *) &lh-=
>coff_image_header)
>>> +    {
>>> +      grub_file_seek (file, lh->hdr_offset);
>>
>> Isn't this overly complicated? Why don't we first read the whole file
>> into memory and then analyze it instead of using multiple accesses whic=
h
>> only slows down the process?
>>
>
> Given that the condition will never hold in practice, as the offset is
> always going to be 0x40, this change is not expected to affect
> performance at all.

The PE COFF specification let's you specify any value. The linux command
can be used to launch arbitrary EFI binaries if they have the Linux
magic 'ARM\x64' in the right place.

What I never understood is why the linux command is checking this Linux
magic field at all instead of running any EFI binary thrown at it.

Best regards

Heinrich

>
> Doing a complete overhaul of the PE image loading logic for this seems
> unwise to me.
>

