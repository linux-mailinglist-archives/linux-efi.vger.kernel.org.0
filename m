Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E6780E13
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjHROfS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377785AbjHROfJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 10:35:09 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A30A2D4A
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 07:35:06 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 82936240105
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 16:35:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1692369304; bh=CeAJsCi5TQpaqRWbANCcaVHCuN4QX/EmDaFtsa8EaoE=;
        h=Content-Transfer-Encoding:Mime-Version:Subject:From:Cc:Date:
         Message-Id:To:From;
        b=ZPKoQcLxiwbOsEvxjVeNLSHnrdfCK1KGm5r+6JE1cnjFUPL2/2m+MKINMCexRCiPD
         lpigAMJuw5+sD3ZuQ5utnsvO2tt7rDDFRy6+r9p/+HB7+ogG/7Hvs8e+GE7Eym9RFt
         k6n0hJESw1uIj5ZTa7b33NTpQ4oQynqORRpQyHHpHPuPc13x1Tsjfb0dm27JSvtPbS
         vZv9wiyJ+6UDKwqxKKDT6eZE9/zFJjM0yyjqO8WY/xByF1KDW40iHtwd20E5deREo3
         A38bNZyBYBfUpgvQKJv6HrateDONEzDUP4e9Pp7bqte67e9p8K7atnDEQkpdhjKzVw
         jNiHhLZmRiy8Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RS4CT3zyHz6tvt;
        Fri, 18 Aug 2023 16:35:01 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 15/17] x86/boot: Split off PE/COFF .data section
From:   =?utf-8?Q?Marvin_H=C3=A4user?= <mhaeuser@posteo.de>
In-Reply-To: <20230818134422.380032-16-ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Date:   Fri, 18 Aug 2023 14:35:01 +0000
Message-Id: <98D635CA-43D4-4A0B-8791-2FDC1DC695B3@posteo.de>
References: <20230818134422.380032-16-ardb@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Thanks for your effort! Not sure what the documentation policies are, but mi=
ght it be worth mentioning that we cannot have .rdata at this time, because c=
urrent-gen EFI will map it as RW?

Best regards,
Marvin

> On Aug 18, 2023, at 15:45, Ard Biesheuvel <ardb@kernel.org> wrote:
> =EF=BB=BFDescribe the code and data of the decompressor binary using separ=
ate
> .text and .data PE/COFF sections, so that we will be able to map them
> using restricted permissions once we increase the section and file
> alignment sufficiently. This avoids the need for memory mappings that
> are writable and executable at the same time, which is something that
> is best avoided for security reasons.
>=20
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> arch/x86/boot/Makefile |  2 +-
> arch/x86/boot/header.S | 19 +++++++++++++++----
> 2 files changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index b26e30a2d865f72d..50c50fce646e2417 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -90,7 +90,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>=20
> SETUP_OBJS =3D $(addprefix $(obj)/,$(setup-y))
>=20
> -sed-zoffset :=3D -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stu=
b_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\=
|_edata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
> +sed-zoffset :=3D -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stu=
b_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\=
|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
>=20
> quiet_cmd_zoffset =3D ZOFFSET $@
>       cmd_zoffset =3D $(NM) $< | sed -n $(sed-zoffset) > $@
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index ccfb7a7d8c29275e..25dda40dacb52292 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -79,9 +79,9 @@ optional_header:
>    .byte    0x02                # MajorLinkerVersion
>    .byte    0x14                # MinorLinkerVersion
>=20
> -    .long    setup_size + ZO__end - 0x200    # SizeOfCode
> +    .long    ZO__data            # SizeOfCode
>=20
> -    .long    0                # SizeOfInitializedData
> +    .long    ZO__end - ZO__data        # SizeOfInitializedData
>    .long    0                # SizeOfUninitializedData
>=20
>    .long    setup_size + ZO_efi_pe_entry    # AddressOfEntryPoint
> @@ -182,9 +182,9 @@ section_table:
>    .byte    0
>    .byte    0
>    .byte    0
> -    .long    ZO__end
> +    .long    ZO__data
>    .long    setup_size
> -    .long    ZO__edata            # Size of initialized data
> +    .long    ZO__data            # Size of initialized data
>                        # on disk
>    .long    setup_size
>    .long    0                # PointerToRelocations
> @@ -195,6 +195,17 @@ section_table:
>        IMAGE_SCN_MEM_READ        | \
>        IMAGE_SCN_MEM_EXECUTE        # Characteristics
>=20
> +    .ascii    ".data\0\0\0"
> +    .long    ZO__end - ZO__data        # VirtualSize
> +    .long    setup_size + ZO__data        # VirtualAddress
> +    .long    ZO__edata - ZO__data        # SizeOfRawData
> +    .long    setup_size + ZO__data        # PointerToRawData
> +
> +    .long    0, 0, 0
> +    .long    IMAGE_SCN_CNT_INITIALIZED_DATA    | \
> +        IMAGE_SCN_MEM_READ        | \
> +        IMAGE_SCN_MEM_WRITE        # Characteristics
> +
>    .set    section_count, (. - section_table) / 40
> #endif /* CONFIG_EFI_STUB */
>=20
> --=20
> 2.39.2

