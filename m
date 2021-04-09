Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C435957C
	for <lists+linux-efi@lfdr.de>; Fri,  9 Apr 2021 08:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhDIGaR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Apr 2021 02:30:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:35287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhDIGaQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 9 Apr 2021 02:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617949792;
        bh=vUHSgi0SRqKTSANTFAgEMV3UjMLJbnHuxVxBl5TYp0o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=guN+0Dp1ErBLWCZzs6quO+LMwr/1EoJf/FxACMgMhHL9hJReKV19+1Yw77paSAgMF
         cCahYirEyjnE6krKcvNIyKIukQKXgsnDcKRwdiQeUFb9pQpZazIJcfpO/8DuXRWfT/
         xgz0uJfr+IhfIShdnPPP5bugZmj8mpmPaOLRv5HQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.35] ([62.143.247.63]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1liqh20yaa-00uGUt; Fri, 09
 Apr 2021 08:29:52 +0200
Subject: Re: [PATCH v2 3/8] efi: move MS-DOS stub out of generic PE header
 definition
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Daniel Kiper <dkiper@net-space.pl>,
        GRUB development mailing list <grub-devel@gnu.org>,
        "Leif Lindholm <Leif Lindholm" <leif@nuviainc.com>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
 <20201025134941.4805-4-ard.biesheuvel@arm.com>
 <19e3bf0e-8bec-2485-1f79-4859ab0d7de5@gmx.de>
 <CAMj1kXHjZ15gGkR7vazVuMViLE5wgzgjxH+RkGbYVfkx30MWXA@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <a9a2ebbb-f35b-7355-fe36-0e5317e92d39@gmx.de>
Date:   Fri, 9 Apr 2021 08:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHjZ15gGkR7vazVuMViLE5wgzgjxH+RkGbYVfkx30MWXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hH6OQ7iJKjpFjBO+rw4Ku5XVAoU7PN3GisgdgW4LaP9O0sdPz9I
 kMjMxCKq9EEL2fNpjDd/Qe9yQ+c+F1XtiR8SMlxeACfW88GlBdiSrljrETu5bUMRxmTQcPD
 WO8Pm4AEaCmGyDrvFEF4tU4nojyWVj4VACPPO8jioOlfsuIkn5kXGiXauaNRAALEdGdCHz3
 dx4OorROEg87Uxdwt81Tg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qLJUUs/PSfE=:/qF+LPTF5yojQgXR6v9UMs
 a+4l+uUSSdrxIv9uC6kgSlXlwoWgDOdAdUSuA81R9wx8vyXszZI1djrGIFrS/aZCEmakvTQJ9
 Mh+NXmie7Y2EmiYJixegC64kcENxwxsF2B9zbIqgoabuXAzrE+hNu4byUkcbq4e7/v21Kp9xH
 EDQFJW4yDdv2qN3cxqngH9t8+UwMXdVv0ka+lv1lLesWiLFj+DaGOVpXkSvz5tnOtg0uxRcUT
 LcvpT/qkc7W9qE/oaZvAO2VCuHhz5cK64wIETrncEO4qEJ0OOp4+BvxmTwQ7EiEC7hto5CNvs
 1Ai2I8cq+xBTKQ3CpiyiDURgiy4yfkA2YFG0fbcICWWgenvA3HNSFV2ZfF7lUfJqODFvcWUgA
 7TztZ0sNlDkM5PVO0iKrqLCdEZpz8CaqCeD+bEHQx0ocwIRd3ssUvayxe3/sFfiZyDqNrbDff
 NIViT0SR3uyzvKdXF88XuRSOv/X7O75d7uRza5qy4M6a0+eXSk2ugZmBsn+oRXPhS+SNZN2dY
 LIwm2jxPTPSQ5g6paJbHK9Mx9W7nxZlGjgHO+5XDUeHvQroXH8PUtrBh3YlflUReYf4pPIIcT
 fKnHPBYQ8bUThOdr3BY3QRXa0YfVbwEYzqwg2K6Cnlw1FRP4Yqt6aEQCdSs9GOGBWl6zg4MVu
 tmp/UG5puWJK+S3YbXk+R99ca4Ry4GoyI9PGnL7laQbMyK0ZGd08xB1/jipUCo7tuv3jLOwxE
 2dVabtrkpHU3V8TZ3nGVPfbsCHUyIdxFHza98FZCx3sX0TmeACa0F0CPTM7BUJQQ92/L0K6OQ
 CPyp0vL8DLN6uIwSu7qPBriaT5T9fxFPbGurHcrRzayP9j+AIgMUHnFrToxnIyBWx4K28gYAX
 al2S2YvE/uj4lltHZvynsU0P5JZJJNfOsnPQb72vxW5teZJEpaMWiOaD+yD795fVi3mWhyPCL
 oQNby6L1K6g1KYa4EWBc4JNQPS4VsqethZQyKZw/1xZ1spLp2pOmo0/Yfcuonnd+HkvLCb5bZ
 O4A2g8+4lO+j9S+c1/QjU6FsVrYutsiNb33v7sODXQnckP6zJuFP/1ySseOZUSInnViK9lkp8
 T52VvXzXpcBFMMb6vT5s5QA6nZLCrdsCs5ZXeJigrmf79ONWOWmod9Dt08A2MsbeBQWHdsfKJ
 6zGhH5U2a2Qjk1YYWEruMSU3LPMrV9CI0UltmvUTfsYpumPWs9+Ezjb23OIk4m4cTenao=
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/9/21 8:10 AM, Ard Biesheuvel wrote:
> On Thu, 8 Apr 2021 at 20:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 10/25/20 2:49 PM, Ard Biesheuvel wrote:
>>> The PE/COFF spec permits the COFF signature and file header to appear
>>> anywhere in the file, and the actual offset is recorded in 4 byte
>>> little endian field at offset 0x3c of the image.
>>>
>>> When GRUB is emitted as a PE/COFF binary, we reuse the 128 byte MS-DOS
>>> stub (even for non-x86 architectures), putting the COFF signature and
>>> file header at offset 0x80. However, other PE/COFF images may use
>>> different values, and non-x86 Linux kernels use an offset of 0x40
>>> instead.
>>>
>>> So let's get rid of the grub_pe32_header struct from pe32.h, given tha=
t
>>> it does not represent anything defined by the PE/COFF spec. Instead,
>>> use the GRUB_PE32_MSDOS_STUB_SIZE macro explicitly to reference the
>>> COFF header in the only place in the code where we rely on this.
>>>
>>> The remaining fields are moved into a struct grub_coff_image_header,
>>> which we will use later to access COFF header fields of arbitrary
>>> images (and which may therefore appear at different offsets)
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
>>> ---
>>>    grub-core/kern/efi/efi.c | 5 +++--
>>>    include/grub/efi/pe32.h  | 5 +----
>>>    2 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/grub-core/kern/efi/efi.c b/grub-core/kern/efi/efi.c
>>> index e0165e74c587..9e5a72be538d 100644
>>> --- a/grub-core/kern/efi/efi.c
>>> +++ b/grub-core/kern/efi/efi.c
>>> @@ -282,7 +282,7 @@ grub_addr_t
>>>    grub_efi_modules_addr (void)
>>>    {
>>>      grub_efi_loaded_image_t *image;
>>> -  struct grub_pe32_header *header;
>>> +  struct grub_coff_image_header *header;
>>>      struct grub_pe32_coff_header *coff_header;
>>>      struct grub_pe32_section_table *sections;
>>>      struct grub_pe32_section_table *section;
>>> @@ -293,7 +293,8 @@ grub_efi_modules_addr (void)
>>>      if (! image)
>>>        return 0;
>>>
>>> -  header =3D image->image_base;
>>> +  header =3D (struct grub_coff_image_header *) ((char *) image->image=
_base
>>> +                                           + GRUB_PE32_MSDOS_STUB_SIZ=
E);
>>
>> After checking that the file starts with the letters 'MZ' we can find a=
t
>> file offset 0x3c the position of the 'PE\0\0' indicating the start of
>> the COFF header. This avoids relying upon any fixed offset and conforms
>> to the PE Format specification.
>>
>
> I think you might be missing the point here. This is not about
> arbitrary PE/COFF images that GRUB loads, this is about the PE/COFF
> image that is constructed by the GRUB build system to carry GRUB
> itself: what would be the point of extracting the offset from the
> image if we always put the PE header at the same offset?

We should not assume that a file /boot/grub/x86_64-efi/core.efi contains
a GRUB EFI binary. We should check the header. If we can't find 'MZ' at
offset 0 and 'PE\0\0' at the position indicated by the offset at 0x3c,
it is definitively not a valid EFI binary.

I would prefer one common function for checking EFI headers instead of
grub_arch_efi_linux_check_image() per architecture.

Best regards

Heinrich

>
> In any case, I don't care deeply one way or the other, so feel free to
> propose an alternative to this patch.
>
>
>> See
>> https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#ms-dos-s=
tub-image-only
>>
>> Best regards
>>
>> Heinrich
>>
>>>      coff_header =3D &(header->coff_header);
>>>      sections
>>>        =3D (struct grub_pe32_section_table *) ((char *) coff_header
>>> diff --git a/include/grub/efi/pe32.h b/include/grub/efi/pe32.h
>>> index 0ed8781f0376..a2da4b318c85 100644
>>> --- a/include/grub/efi/pe32.h
>>> +++ b/include/grub/efi/pe32.h
>>> @@ -254,11 +254,8 @@ struct grub_pe32_section_table
>>>
>>>    #define GRUB_PE32_SIGNATURE_SIZE 4
>>>
>>> -struct grub_pe32_header
>>> +struct grub_coff_image_header
>>>    {
>>> -  /* This should be filled in with GRUB_PE32_MSDOS_STUB.  */
>>> -  grub_uint8_t msdos_stub[GRUB_PE32_MSDOS_STUB_SIZE];
>>> -
>>>      /* This is always PE\0\0.  */
>>>      char signature[GRUB_PE32_SIGNATURE_SIZE];
>>>
>>>
>>

