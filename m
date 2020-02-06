Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC2154B36
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2020 19:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBFSdd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Feb 2020 13:33:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:33265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgBFSdd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Feb 2020 13:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581013989;
        bh=mTyLtAMJSdfsGHe9154LBFskCXqNQtaB2udlCTF5iL8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=k3feDoPt2kw6IE8H5QptrgJ7RHXa2zCSGrD165Kh8tHd0baINKmleas15HP7fxtjP
         WBVmGmF5gRFiNGgmf0OP6svHZEvWHnQVEDTPpW3rFilEfiHUNnQNYdsSPthd78x2kn
         25WFeCNaHL3KZ1Hh6dyQu2/jGI716jJTcW+BLWyU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([84.119.33.160]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1jGCsj0ntk-00Imym; Thu, 06
 Feb 2020 19:33:09 +0100
Subject: Re: [PATCH 2/2] efi/libstub: take noinitrd cmdline argument into
 account for devpath initrd
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, ilias.apalodimas@linaro.org,
        daniel.kiper@oracle.com
References: <20200206140352.6300-1-ardb@kernel.org>
 <20200206140352.6300-3-ardb@kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <ea0b44d5-c9e4-943a-da81-8b4c8f1a371d@gmx.de>
Date:   Thu, 6 Feb 2020 19:33:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206140352.6300-3-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VVyY4ovAWJdUOHYcEXyairg3Nui/XUbHkNgTN7QT8CnPdzagY1/
 Ht55/pBrtBZl+1rf/+htzOgrgtMPWHRPS4MfiKsDIFuC5QUMcL0SyaNQrylC+9iNZ94Rqrt
 upIEmUKd4fPfU9Z28vjQkax7LOccwIiSwqt3XJ3U0/UJYrBYH8SyPex/fRCuOmNqBDUVb1s
 AKr2S9GTug9a9hUBnzOsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D+UenvpC+fQ=:iIYrV3MM/3LOkKngjGyxUJ
 07+tMHo9T4AXjenGu+CDMWmzSMz0N2g7OgK+QPWxFQJfFe2KpebWFWKb6Dh0/FTOR2cwdppAW
 upexP6nQG//o1qksaaE0yQQYgXK4CoJWmWfZimnbv65GTXfP8CuLz53NOrwPETEGCXJ+jpttq
 PTPDAI2oO87FMLSYy8NhsLUbBPL7U33idjXefwr11f0DUc2KbRkT/5RZTIHRUsyOjzmfgN1xD
 RyIZKl1GsrAaHUjAIZBOgaagT6inxXMP/kFda2pufOJX2imxBewLvXaNJh9RpQHp3oEUvIO4M
 pPlDQbJWXd3mN4T+UviBk9YFGu2YMCcya08XeUUkIZVLnSMp35ElcQkVqfXMyJWcZ5McDVxSE
 /GTXQlg1mTQxMBw/RRmRJL6TWBlPQqC7I0czZovwgQl7Rt+TpcEs/wCmnaK7Q2I+W4K10Eqt2
 uojf9Bn1qIY0KiJZTH/qjMklXV0vZTh6w3XU3ETzdh1N/nVlQmgzZQENoc9kFI3Mtj3SxLMJM
 Him56kcPhh2VyiZ2DRuLkORhCbnZvlFZgIWyXe6umC3QzXaMax7M0L0JF30Lo+aw/gZTKgzL6
 M1MqzxugdwGoICY41hTlgATJ81giDLwMy1FZqM58TgSzN+tjlUpIA0FDZEcOlhIRY4r9r7fQE
 9ntGe4aEaYhMYJMQ4jpnDvj9lN+HtD5ut+KeGDe/rvsCE23ghJzSvRrMsOs0hB/QyiAsmLfuQ
 3LfppakVe21hVOnboKHyAZMKB/gC74I4RKEiphlhXbuDH+VmzARo/ehrG/duJltpwwtU8/lNq
 byD0LcEG9qZ3G+rLAaTWnRKwI+/lQgyPWx0acnqtP52DOXLZOhJlO+e6Sl2VGgAkJ+VbYxvpo
 p9R2UWdiFZk6SIjlP0RqbWZJJc0kmpx9cjIHKMHaj2W/HnBXA1Gdvo5tYa8BzMS8cqgzUcq4b
 rVglP4uoneU/LZeOL+SmbCA6+UEKKqKd06B3Qa6XSU8JUU0t3a7jrupcx6CcIIv+Jh2p4+KOC
 ulfMyi+g5LClFnIak1QdHz/WHkNBDcCcjy6ZfhTRCHO3SEIsX1G07HTLH7M/ObMwygILhaBsp
 8wqND8Pmm4Ugp/ahSsxoaQQsX28bSIfWYXki5ILCY1jOvg+p7bRbjSgCGfILkvpJmeggG2YoK
 lQ39YzRA+9kjqH/olhgjavDAhz1GVYTYIqqYz/YhaQcd+FTJF0nkP+yPgP8oPpAd4dzT4Te1Y
 I6UL/AJRkHnOyp0kt
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/6/20 3:03 PM, Ard Biesheuvel wrote:
> One of the advantages of using what basically amounts to a callback
> interface into the bootloader for loading the initrd is that it provides
> a natural place for the bootloader or firmware to measure the initrd
> contents while they are being passed to the kernel.
>
> Unfortunately, this is not a guarantee that the initrd will in fact be
> loaded and its /init invoked by the kernel, since the command line may
> contain the 'noinitrd' option, in which case the initrd is ignored, but
> this will not be reflected in the PCR that covers the initrd measurement=
.

Does PCR here refer to the TPM Platform Configuration Register?

>
> This could be addressed by measuring the command line as well, and
> including that PCR in the attestation policy, but this locks down the
> command line completely, which may be too restrictive.
>
> So let's take the noinitrd argument into account in the stub, too. This
> forces the PCR that covers the initrd to assume a different value when
> noinitrd is passed, allowing an attestation policy to disregard the
> command line if there is no need to take its measurement into account
> for other reasons.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   drivers/firmware/efi/libstub/arm-stub.c        | 23 +++++-----
>   drivers/firmware/efi/libstub/efi-stub-helper.c |  9 ++++
>   drivers/firmware/efi/libstub/efistub.h         |  1 +
>   drivers/firmware/efi/libstub/x86-stub.c        | 45 +++++++++++-------=
--
>   4 files changed, 47 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/=
efi/libstub/arm-stub.c
> index 1db943c1ba2b..5e8f16cf016e 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -256,18 +256,21 @@ unsigned long efi_entry(void *handle, efi_system_t=
able_t *sys_table_arg,
>   	if (!fdt_addr)
>   		pr_efi("Generating empty DTB\n");
>
> -	max_addr =3D efi_get_max_initrd_addr(dram_base, *image_addr);
> -	status =3D efi_load_initrd_devpath(&initrd_addr, &initrd_size, max_add=
r);
> -	if (status =3D=3D EFI_SUCCESS)
> -		pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n"=
);
> -	else if (status =3D=3D EFI_NOT_FOUND) {
> -		status =3D efi_load_initrd(image, ULONG_MAX, max_addr,
> -					 &initrd_addr, &initrd_size);
> +	if (!noinitrd()) {
> +		max_addr =3D efi_get_max_initrd_addr(dram_base, *image_addr);
> +		status =3D efi_load_initrd_devpath(&initrd_addr, &initrd_size,
> +						 max_addr);
>   		if (status =3D=3D EFI_SUCCESS)
> -			pr_efi("Loaded initrd from command line option\n");
> +			pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n=
");
> +		else if (status =3D=3D EFI_NOT_FOUND) {
> +			status =3D efi_load_initrd(image, ULONG_MAX, max_addr,
> +						 &initrd_addr, &initrd_size);
> +			if (status =3D=3D EFI_SUCCESS)
> +				pr_efi("Loaded initrd from command line option\n");
> +		}
> +		if (status !=3D EFI_SUCCESS)
> +			pr_efi_err("Failed to load initrd!\n");
>   	}
> -	if (status !=3D EFI_SUCCESS)
> -		pr_efi_err("Failed to load initrd!\n");
>
>   	efi_random_get_seed();
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/fi=
rmware/efi/libstub/efi-stub-helper.c
> index eaf45ea749b3..367575fb8424 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -11,6 +11,7 @@
>
>   static bool __efistub_global efi_nochunk;
>   static bool __efistub_global efi_nokaslr;
> +static bool __efistub_global efi_noinitrd;
>   static bool __efistub_global efi_quiet;
>   static bool __efistub_global efi_novamap;
>   static bool __efistub_global efi_nosoftreserve;
> @@ -25,6 +26,10 @@ bool __pure nokaslr(void)
>   {
>   	return efi_nokaslr;
>   }
> +bool __pure noinitrd(void)
> +{
> +	return efi_noinitrd;
> +}
>   bool __pure is_quiet(void)
>   {
>   	return efi_quiet;
> @@ -71,6 +76,10 @@ efi_status_t efi_parse_options(char const *cmdline)
>   	if (str =3D=3D cmdline || (str && str > cmdline && *(str - 1) =3D=3D =
' '))
>   		efi_nokaslr =3D true;
>
> +	str =3D strstr(cmdline, "noinitrd");
> +	if (str =3D=3D cmdline || (str && str > cmdline && *(str - 1) =3D=3D '=
 '))
> +		efi_noinitrd =3D true;
> +
>   	str =3D strstr(cmdline, "quiet");
>   	if (str =3D=3D cmdline || (str && str > cmdline && *(str - 1) =3D=3D =
' '))
>   		efi_quiet =3D true;
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/e=
fi/libstub/efistub.h
> index fbf9f9442eed..29a5d0e9554a 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -44,6 +44,7 @@
>
>   extern bool __pure nochunk(void);
>   extern bool __pure nokaslr(void);
> +extern bool __pure noinitrd(void);
>   extern bool __pure is_quiet(void);
>   extern bool __pure novamap(void);
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/=
efi/libstub/x86-stub.c
> index 7f38f95676dd..9d86c0949b3c 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -419,26 +419,28 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t ha=
ndle,
>   	if (status !=3D EFI_SUCCESS)
>   		goto fail2;
>
> -	/*
> -	 * The initrd loaded from the Linux initrd vendor device
> -	 * path should take precedence, as we don't want the
> -	 * [unverified] command line to override the initrd
> -	 * supplied by the [potentially verified] firmware.
> -	 */
> -	status =3D efi_load_initrd_devpath(&ramdisk_addr, &ramdisk_size,
> -					 above4g ? ULONG_MAX
> -						 : hdr->initrd_addr_max);
> -	if (status =3D=3D EFI_NOT_FOUND)
> -		status =3D efi_load_initrd(image, hdr->initrd_addr_max,
> -					 above4g ? ULONG_MAX
> -						 : hdr->initrd_addr_max,
> -					 &ramdisk_addr, &ramdisk_size);
> -	if (status !=3D EFI_SUCCESS)
> -		goto fail2;
> -	hdr->ramdisk_image =3D ramdisk_addr & 0xffffffff;
> -	hdr->ramdisk_size  =3D ramdisk_size & 0xffffffff;
> -	boot_params->ext_ramdisk_image =3D (u64)ramdisk_addr >> 32;
> -	boot_params->ext_ramdisk_size  =3D (u64)ramdisk_size >> 32;
> +	if (!noinitrd()) {
> +		/*
> +		 * The initrd loaded from the Linux initrd vendor device
> +		 * path should take precedence, as we don't want the
> +		 * [unverified] command line to override the initrd
> +		 * supplied by the [potentially verified] firmware.
> +		 */
> +		status =3D efi_load_initrd_devpath(&ramdisk_addr, &ramdisk_size,
> +						 above4g ? ULONG_MAX
> +							 : hdr->initrd_addr_max);
> +		if (status =3D=3D EFI_NOT_FOUND)
> +			status =3D efi_load_initrd(image, hdr->initrd_addr_max,
> +						 above4g ? ULONG_MAX
> +							 : hdr->initrd_addr_max,
> +						 &ramdisk_addr, &ramdisk_size);
> +		if (status !=3D EFI_SUCCESS)
> +			goto fail2;
> +		hdr->ramdisk_image =3D ramdisk_addr & 0xffffffff;
> +		hdr->ramdisk_size  =3D ramdisk_size & 0xffffffff;
> +		boot_params->ext_ramdisk_image =3D (u64)ramdisk_addr >> 32;
> +		boot_params->ext_ramdisk_size  =3D (u64)ramdisk_size >> 32;
> +	}
>
>   	efi_stub_entry(handle, sys_table, boot_params);
>   	/* not reached */
> @@ -743,7 +745,8 @@ struct boot_params *efi_main(efi_handle_t handle,
>   			 ((u64)boot_params->ext_cmd_line_ptr << 32));
>   	efi_parse_options((char *)cmdline_paddr);
>
> -	if (!hdr->ramdisk_size && !boot_params->ext_ramdisk_size) {
> +	if (!hdr->ramdisk_size && !boot_params->ext_ramdisk_size &&
> +	    !noinitrd()) {
>   		unsigned long max =3D hdr->initrd_addr_max;
>   		unsigned long addr, size;
>
>

