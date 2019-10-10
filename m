Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2598FD1D91
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 02:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbfJJAoI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 20:44:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfJJAoI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Oct 2019 20:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=50od/B3PK0CJO1ZT1qu05XYWV3Ldcc+kIxtp//OtB+E=; b=l8g4s4edagE05Kh3Sqcy98sH/
        gqt8BJzo0AvezCil0cCxfu/nx/SPgwTNbirqwkXY8R3Bytw6iwSB/OnGeJ+wqIUm/KRszl5rreync
        a1pTNC/xuTjMuDTU1PjRRP5L2zheXEFBeTJ222Rm3U4uVaTMTziHaI3cvZkeNekDOMam+0au0EcCp
        pAwJFZEqGuZlrFqxUSVPJ9eD3Zqtsh4qAsIe6tyYul6B8holW4Q+Y4xEGStBngYYpw3SsQnKYpACI
        PpHpLMRnvH530lUGesEr3FJg5n45i/MHelHXF3oTJtvD0yPbhkLZziAkkA2SVcNwRYAEi0wj29cFX
        i1TviFx+Q==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIMYG-0002Wz-Q9; Thu, 10 Oct 2019 00:43:32 +0000
Subject: Re: [PATCH v3 1/3] x86/boot: Introduce the kernel_info
To:     Daniel Kiper <daniel.kiper@oracle.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
References: <20191009105358.32256-1-daniel.kiper@oracle.com>
 <20191009105358.32256-2-daniel.kiper@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <181249b6-5833-6f29-7d38-6dacc3f8ee62@infradead.org>
Date:   Wed, 9 Oct 2019 17:43:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191009105358.32256-2-daniel.kiper@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

Questions and comments below...
Thanks.


On 10/9/19 3:53 AM, Daniel Kiper wrote:

> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
> ---

> ---
>  Documentation/x86/boot.rst             | 121 +++++++++++++++++++++++++++++++++
>  arch/x86/boot/Makefile                 |   2 +-
>  arch/x86/boot/compressed/Makefile      |   4 +-
>  arch/x86/boot/compressed/kernel_info.S |  17 +++++
>  arch/x86/boot/header.S                 |   1 +
>  arch/x86/boot/tools/build.c            |   5 ++
>  arch/x86/include/uapi/asm/bootparam.h  |   1 +
>  7 files changed, 148 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/kernel_info.S
> 
> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> index 08a2f100c0e6..d5323a39f5e3 100644
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -68,8 +68,25 @@ Protocol 2.12	(Kernel 3.8) Added the xloadflags field and extension fields
>  Protocol 2.13	(Kernel 3.14) Support 32- and 64-bit flags being set in
>  		xloadflags to support booting a 64-bit kernel from 32-bit
>  		EFI
> +
> +Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c1889
> +		(x86/boot: Add ACPI RSDP address to setup_header)
> +		DO NOT USE!!! ASSUME SAME AS 2.13.
> +
> +Protocol 2.15:	(Kernel 5.5) Added the kernel_info.
>  =============	============================================================
>  
> +.. note::
> +     The protocol version number should be changed only if the setup header
> +     is changed. There is no need to update the version number if boot_params
> +     or kernel_info are changed. Additionally, it is recommended to use
> +     xloadflags (in this case the protocol version number should not be
> +     updated either) or kernel_info to communicate supported Linux kernel
> +     features to the boot loader. Due to very limited space available in
> +     the original setup header every update to it should be considered
> +     with great care. Starting from the protocol 2.15 the primary way to
> +     communicate things to the boot loader is the kernel_info.
> +
>  
>  Memory Layout
>  =============
> @@ -207,6 +224,7 @@ Offset/Size	Proto		Name			Meaning
>  0258/8		2.10+		pref_address		Preferred loading address
>  0260/4		2.10+		init_size		Linear memory required during initialization
>  0264/4		2.11+		handover_offset		Offset of handover entry point
> +0268/4		2.15+		kernel_info_offset	Offset of the kernel_info
>  ===========	========	=====================	============================================
>  
>  .. note::
> @@ -855,6 +873,109 @@ Offset/size:	0x264/4
>  
>    See EFI HANDOVER PROTOCOL below for more details.
>  
> +============	==================
> +Field name:	kernel_info_offset
> +Type:		read
> +Offset/size:	0x268/4
> +Protocol:	2.15+
> +============	==================
> +
> +  This field is the offset from the beginning of the kernel image to the
> +  kernel_info. It is embedded in the Linux image in the uncompressed
                  ^^
   What does      It   refer to, please?

> +  protected mode region.
> +
> +
> +The kernel_info
> +===============
> +
> +The relationships between the headers are analogous to the various data
> +sections:
> +
> +  setup_header = .data
> +  boot_params/setup_data = .bss
> +
> +What is missing from the above list? That's right:
> +
> +  kernel_info = .rodata
> +
> +We have been (ab)using .data for things that could go into .rodata or .bss for
> +a long time, for lack of alternatives and -- especially early on -- inertia.
> +Also, the BIOS stub is responsible for creating boot_params, so it isn't
> +available to a BIOS-based loader (setup_data is, though).
> +
> +setup_header is permanently limited to 144 bytes due to the reach of the
> +2-byte jump field, which doubles as a length field for the structure, combined
> +with the size of the "hole" in struct boot_params that a protected-mode loader
> +or the BIOS stub has to copy it into. It is currently 119 bytes long, which
> +leaves us with 25 very precious bytes. This isn't something that can be fixed
> +without revising the boot protocol entirely, breaking backwards compatibility.
> +
> +boot_params proper is limited to 4096 bytes, but can be arbitrarily extended
> +by adding setup_data entries. It cannot be used to communicate properties of
> +the kernel image, because it is .bss and has no image-provided content.
> +
> +kernel_info solves this by providing an extensible place for information about
> +the kernel image. It is readonly, because the kernel cannot rely on a
> +bootloader copying its contents anywhere, but that is OK; if it becomes
> +necessary it can still contain data items that an enabled bootloader would be
> +expected to copy into a setup_data chunk.
> +
> +All kernel_info data should be part of this structure. Fixed size data have to
> +be put before kernel_info_var_len_data label. Variable size data have to be put
> +behind kernel_info_var_len_data label. Each chunk of variable size data has to

   s/behind/after/

> +be prefixed with header/magic and its size, e.g.:
> +
> +  kernel_info:
> +          .ascii  "LToP"          /* Header, Linux top (structure). */
> +          .long   kernel_info_var_len_data - kernel_info
> +          .long   kernel_info_end - kernel_info
> +          .long   0x01234567      /* Some fixed size data for the bootloaders. */
> +  kernel_info_var_len_data:
> +  example_struct:                 /* Some variable size data for the bootloaders. */
> +          .ascii  "EsTT"          /* Header/Magic. */
> +          .long   example_struct_end - example_struct
> +          .ascii  "Struct"
> +          .long   0x89012345
> +  example_struct_end:
> +  example_strings:                /* Some variable size data for the bootloaders. */
> +          .ascii  "EsTs"          /* Header/Magic. */

Where do the Magic values "EsTT" and "EsTs" come from?
where are they defined?

> +          .long   example_strings_end - example_strings
> +          .asciz  "String_0"
> +          .asciz  "String_1"
> +  example_strings_end:
> +  kernel_info_end:
> +
> +This way the kernel_info is self-contained blob.
> +
> +
> +Details of the kernel_info Fields
> +=================================
> +
> +============	========
> +Field name:	header
> +Offset/size:	0x0000/4
> +============	========
> +
> +  Contains the magic number "LToP" (0x506f544c).
> +
> +============	========
> +Field name:	size
> +Offset/size:	0x0004/4
> +============	========
> +
> +  This field contains the size of the kernel_info including kernel_info.header.
> +  It does not count kernel_info.kernel_info_var_len_data size. This field should be
> +  used by the bootloaders to detect supported fixed size fields in the kernel_info
> +  and beginning of kernel_info.kernel_info_var_len_data.
> +
> +============	========
> +Field name:	size_total
> +Offset/size:	0x0008/4
> +============	========
> +
> +  This field contains the size of the kernel_info including kernel_info.header
> +  and kernel_info.kernel_info_var_len_data.
> +
>  
>  The Image Checksum
>  ==================


-- 
~Randy
