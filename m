Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFA358D04
	for <lists+linux-efi@lfdr.de>; Thu,  8 Apr 2021 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhDHS5P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Apr 2021 14:57:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:37015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhDHS5O (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 8 Apr 2021 14:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617908211;
        bh=go5L+dyOzXYvB1n7vP7B5XZdndXUP0wMC8Zi/yo/B/M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QYEnr0m3lf8RYPOA8NPtbzV1AnS11qBRkBIe1mHbznrf1EzelUXpbHsrMLFci5e97
         rLY7YTX32U/5mztnM8WoII5FiRA6ESl9srkNymQPKW/5sKtAf4xBVTGixpDjWcJ31A
         kva6DdCRBrjo96y1F9VdEteoieSgqI3ryP1eOhtY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.35] ([62.143.247.63]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1m66RP2vqi-00g14b; Thu, 08
 Apr 2021 20:56:51 +0200
Subject: Re: [PATCH v2 5/8] linux/arm: account for COFF headers appearing at
 unexpected offsets
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>, linux-efi@vger.kernel.org
Cc:     grub-devel@gnu.org, daniel.kiper@oracle.com, leif@nuviainc.com
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
 <20201025134941.4805-6-ard.biesheuvel@arm.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <70b3f147-b6d6-013e-fc65-e7228486d911@gmx.de>
Date:   Thu, 8 Apr 2021 20:56:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20201025134941.4805-6-ard.biesheuvel@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QbYgtSCmoB0ciRMXaIysLClLn1DGBIXuLYZe7NFK19ZE/StoY5p
 ygV/rk6qdSa+AbAP/LxLVdu5nEc3++nt3JL96MXbVueIM7cZCgLbm5dO1ObwSD0fxggHY9j
 aWr66e9ezfMEpziRznESnw0cONNdOTZnTjZBQfTSRk6LpaevAEzDS+A1UZz0aj6TbSKDDRS
 Me9Sv7A2UPXxtBTkr+83Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G61KIiny5Cc=:di8FXEvytg4UbfMjwZ8vHr
 qfBeHSjYSVxfHtL025xQ37T6+EHLumYj/ynO4y4NphTQwN5xCdU+X4+1HT/pYr8GZMUybWWkc
 HxDbKXKkEmiDPFcgE7wCsa3COwFIAi3BKh+yKg93ifZpNYiL8krXpQTfohVF8HqvGlJM24EOF
 ncnPJ+wNbuZRzPAGu1IMj6Hxwo7ipEnsfF73rN3Y7YzoNvjTeO6aKJgfIfX2rwK4494UhD0fj
 jQ/ruybil7yQch5wDdjzTDIQscR8C3AJxZ6iy6sMr6zKShTK+9EfOuN/7KiLOSnO4NBHsh8wR
 CWcHOvXcvAbiSSANN3sgoG9cJIdag40Rriv4ZL/hxPOpnrcfXwCHjxg6eK1J76FwZup3nDuCM
 hREfb52V6R7fX1ZQni9uj6dv9Wmk7zbNmTj3X+RFCusH3OtuyHa1PbV756JR8nhm796BM3+Jx
 PM/Fk8LxPs3Gi5Ac9hLO0aOfOKRPRBf+wEEv7R2ec1HaA6hX6TYzVmpFuSPzLHkA1mmiBzpfN
 TAVpnlZk81CUeXQW61VGaMlsh1qVsuDqqnB/bfVRKFIFeDtvjlGw6AlYkCyjsr9raFB8YQ0QK
 +XozXiMbZAxShivvAktzvUy+NbpSjoyJ9Guysv8se1ni2ag4diV1LGA9264FHxXfuezbLc/Qf
 HxsiGZCZ9hpPnQNZPMpySpAqnhDVtVzXZlOmktBPRND/OYvBN3uNPhGHBhb4yTQ+SvyoiceIw
 aMqv8dUiMG7FPlUaGadHie1m4zohpjdTWUSFF7U6VtJBbbcpWvqzTrAmpqsySkk0BCbfRXqp9
 X3ZJ+KIbvK4JI3DPG8KPxgvGz+mhf0DCHiZYoaatLhqcB3BRr46erZZo2qZTpVQVLuzAi0kEt
 Cp6SVwI52nFD8MfsXQtsaiV7x2gyNF1K++EGbvS3wdlX+VAsiUxnKia414w4hFA9Cseq7UO+X
 EtzOZsCwjY3iw9zHyGK/gSCCCtnkXWZySHf6d45bLxR5ExdL9UT5ox7EWBDgxSh8ZVX8BVOoF
 HrPbQPXFhjeUj6lJ9w9J8R5Z/GGnW9K7PTO2TzwDQa3s/nwcoIpzVziLfjGoLrmtBmpSe9BwB
 YhBgPp5vOoufZQA1N+wg+9ID0+hqy5a0vRBiSHPFtnZOZY/rlCt9r54PK566EJ/+muPoi6kmJ
 A/rGRMYe1eJuZ3DfPtvN4/5ZEqQms2wuZQIrW7PZy1UtQUPFCrvg0OlVNrBWbpF1Z4egc=
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/25/20 2:49 PM, Ard Biesheuvel wrote:
> The way we load the Linux and PE/COFF image headers depends on a fixed
> placement of the COFF header at offset 0x40 into the file. This is a
> reasonable default, given that this is where Linux emits it today.
> However, in order to comply with the PE/COFF spec, which permits this
> header to appear anywhere in the file, let's ensure that we read the
> header from where it actually appears in the file if it is not located
> at offset 0x40.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
>   grub-core/loader/arm64/linux.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/lin=
ux.c
> index 915b6ad7292d..28ff8584a3b5 100644
> --- a/grub-core/loader/arm64/linux.c
> +++ b/grub-core/loader/arm64/linux.c
> @@ -66,6 +66,21 @@ grub_arch_efi_linux_load_image_header (grub_file_t fi=
le,
>     grub_dprintf ("linux", "UEFI stub kernel:\n");
>     grub_dprintf ("linux", "PE/COFF header @ %08x\n", lh->hdr_offset);
>
> +  /*
> +   * The PE/COFF spec permits the COFF header to appear anywhere in the=
 file, so
> +   * we need to double check whether it was where we expected it, and i=
f not, we
> +   * must load it from the correct offset into the coff_image_header fi=
eld of
> +   * struct linux_arch_kernel_header.
> +   */
> +  if ((grub_uint8_t *) lh + lh->hdr_offset !=3D (grub_uint8_t *) &lh->c=
off_image_header)
> +    {
> +      grub_file_seek (file, lh->hdr_offset);

Isn't this overly complicated? Why don't we first read the whole file
into memory and then analyze it instead of using multiple accesses which
only slows down the process?

Best regards

Heinrich

> +
> +      if (grub_file_read (file, &lh->coff_image_header, sizeof(struct g=
rub_coff_image_header))
> +	  !=3D sizeof(struct grub_coff_image_header))
> +	return grub_error(GRUB_ERR_FILE_READ_ERROR, "failed to read COFF image=
 header");
> +    }
> +
>     return GRUB_ERR_NONE;
>   }
>
>

