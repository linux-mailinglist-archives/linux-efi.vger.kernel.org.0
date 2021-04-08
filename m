Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21A1358CDE
	for <lists+linux-efi@lfdr.de>; Thu,  8 Apr 2021 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhDHSpc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Apr 2021 14:45:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:58707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhDHSp3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 8 Apr 2021 14:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617907498;
        bh=rB4Kf7B6B3HvDuuvqp1OGtIaR1kEfQLq7RSbZc6hHvQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=U9OWnIiXsszAG5kK0nbTwBv64SAj5I2Zm5F0QvjZLjlQE5Q3/a+ilgLiyh9dD+36W
         1cvqsUSi+W0fmCLgqyOeDQnVhCVyzd+fz3Xf0+EHPAdVqEItuL/dsSCv1Zr73yvF1B
         R2eEiirxa/1TgaEMDfYsi2gbFxfoAD0WtMhlkRow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.35] ([62.143.247.63]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1lLoCn3OBk-008tLl; Thu, 08
 Apr 2021 20:44:57 +0200
Subject: Re: [PATCH v2 3/8] efi: move MS-DOS stub out of generic PE header
 definition
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
 <20201025134941.4805-4-ard.biesheuvel@arm.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>,
        GRUB development mailing list <grub-devel@gnu.org>,
        "Leif Lindholm <Leif Lindholm" <leif@nuviainc.com>
Message-ID: <19e3bf0e-8bec-2485-1f79-4859ab0d7de5@gmx.de>
Date:   Thu, 8 Apr 2021 20:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20201025134941.4805-4-ard.biesheuvel@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3MI+M9N74C7gzS1T+rIGWhJOetJI9+CKFzF6go7hWNx4lJAGG0X
 prf2hrOLJQjpMp3c/vzHJS4Xq+TJeDaSbNPYROvKUJmQISyGwGUSdcNjlZ53QpXkV0Hs0xi
 XR70DVJX5VJAbxEq9+SENgSZz797ux1EKPZ9oSAubvacNsShSyMg7v1ny0+yiZsZK0oxdwz
 XpGKVLugl22izuyAJdlUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EP8ekbww1kc=:g21ZvNYUZ3ZpwvBufc+VL/
 lrXZCpJy9vUg/itdlOY9Q5cqM6xwGF1XPYPHoY5U6ShyvV5p23aY2oPfmuzxsoVvYi3pv+C0U
 xvee4dXd2iF9bljfyG2FQD96hUZ6EjFWP3qZc14kSjVd49ttYQpHpQHD3LHQXgK8C+RxpHYSG
 1l2Tn9YyzLcGkUELu8gZhj4f/k3qu8KMge1HHCuA3Q/OZE8r1H+xHISglckBKRRXwB6YJm+AZ
 88npz5N0mc4dmsJ9y7+ieOk34R1pm4E513n+cEzrr8H+0V9R/UByXXbh3CLlY/LPoN2WmIRO2
 ssBOGi4d8j4RuN2cEgAJ10LZ20cs3oYwCn+47sLs0bCX/1OkKYLgzokkvflJX3k6FAkF4Xdt5
 0j9kJpdSMw+xzvu1L3l8T9whalCYW9VWgeTKa+5eHqzjmRe+tefR3cq2JjO8chYZMxozSTvbI
 Avpn2YPTGHMUuAdtmREp1O5+W4JwMWPpaBZdxH5FcJIFSBFKG+iI/ULeLMxZo0i85Bf01kJhs
 hD9oxi0f8PEIQU9GTBciM3uPLQ7nqz3O79HXuOoFzr4sHKo5w2nrvRcCITcG2evb8Fie4ZN2g
 DTjuGc0dm8+DsSPk0h9oKJ61ACrkTOVFZOuZFjMbcJDdKHUEDRI3iW58bzMZSYPVy7c3We02t
 ve20Op/+V3F0DZ+BY+aC/ea+B/CeSoEUkwtmSH0AesMdUL35YjPK6SAunqrdNyW0G701F7t5i
 DHBdhfaeiAN76iQpCXl2oXA8YWkrIgG2mbYt2I7rrfS0/JH6fhckzJr8LPfaUO3nA/ZGskF7L
 bE4wZa/murdlrZBwVxnGKPkgU8AuWvGzuE6YckkfdwFjHJdu5+C1dgYbn4kYdS76iBXvij039
 5IRNzjb/PHCWeqznciI/lKoP0J8jMMdObgHTLsR0zTRx8AKbBkkqn/2ANx3AeprIb9tTNj1Sd
 bsmZIKlDFxLgrqT7Bfxuqw66bSkJdlyuUW13qU+DASBUpcyQuYW65r6HPsPB2Fya5hp3EKCPM
 shxl2FSGWzdnuUHcxniPKKsnqXlDYWSj7Z5C1WLRNfSfy1KlF7i5F+eyPoBiZ19VPvLDiFH5K
 fZ6Q/6sxhrjWQzuW1WOCGUUWv7cf7uYoPQMGYEEBSr6P2SEAeMndnE2IfI7DMy419oQJEW0uD
 qwCml5ZDL3Us7LqMDKe9EhsDpC0IDC8sR6rEe5PVRAsZaC7sZs73pit9JJq5lNNp9LnKA=
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/25/20 2:49 PM, Ard Biesheuvel wrote:
> The PE/COFF spec permits the COFF signature and file header to appear
> anywhere in the file, and the actual offset is recorded in 4 byte
> little endian field at offset 0x3c of the image.
>
> When GRUB is emitted as a PE/COFF binary, we reuse the 128 byte MS-DOS
> stub (even for non-x86 architectures), putting the COFF signature and
> file header at offset 0x80. However, other PE/COFF images may use
> different values, and non-x86 Linux kernels use an offset of 0x40
> instead.
>
> So let's get rid of the grub_pe32_header struct from pe32.h, given that
> it does not represent anything defined by the PE/COFF spec. Instead,
> use the GRUB_PE32_MSDOS_STUB_SIZE macro explicitly to reference the
> COFF header in the only place in the code where we rely on this.
>
> The remaining fields are moved into a struct grub_coff_image_header,
> which we will use later to access COFF header fields of arbitrary
> images (and which may therefore appear at different offsets)
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
>   grub-core/kern/efi/efi.c | 5 +++--
>   include/grub/efi/pe32.h  | 5 +----
>   2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/grub-core/kern/efi/efi.c b/grub-core/kern/efi/efi.c
> index e0165e74c587..9e5a72be538d 100644
> --- a/grub-core/kern/efi/efi.c
> +++ b/grub-core/kern/efi/efi.c
> @@ -282,7 +282,7 @@ grub_addr_t
>   grub_efi_modules_addr (void)
>   {
>     grub_efi_loaded_image_t *image;
> -  struct grub_pe32_header *header;
> +  struct grub_coff_image_header *header;
>     struct grub_pe32_coff_header *coff_header;
>     struct grub_pe32_section_table *sections;
>     struct grub_pe32_section_table *section;
> @@ -293,7 +293,8 @@ grub_efi_modules_addr (void)
>     if (! image)
>       return 0;
>
> -  header =3D image->image_base;
> +  header =3D (struct grub_coff_image_header *) ((char *) image->image_b=
ase
> +					      + GRUB_PE32_MSDOS_STUB_SIZE);

After checking that the file starts with the letters 'MZ' we can find at
file offset 0x3c the position of the 'PE\0\0' indicating the start of
the COFF header. This avoids relying upon any fixed offset and conforms
to the PE Format specification.

See
https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#ms-dos-stub=
-image-only

Best regards

Heinrich

>     coff_header =3D &(header->coff_header);
>     sections
>       =3D (struct grub_pe32_section_table *) ((char *) coff_header
> diff --git a/include/grub/efi/pe32.h b/include/grub/efi/pe32.h
> index 0ed8781f0376..a2da4b318c85 100644
> --- a/include/grub/efi/pe32.h
> +++ b/include/grub/efi/pe32.h
> @@ -254,11 +254,8 @@ struct grub_pe32_section_table
>
>   #define GRUB_PE32_SIGNATURE_SIZE 4
>
> -struct grub_pe32_header
> +struct grub_coff_image_header
>   {
> -  /* This should be filled in with GRUB_PE32_MSDOS_STUB.  */
> -  grub_uint8_t msdos_stub[GRUB_PE32_MSDOS_STUB_SIZE];
> -
>     /* This is always PE\0\0.  */
>     char signature[GRUB_PE32_SIGNATURE_SIZE];
>
>

