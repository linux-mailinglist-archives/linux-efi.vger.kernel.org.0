Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363A85A88BD
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 00:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiHaWFI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 Aug 2022 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiHaWFH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 31 Aug 2022 18:05:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10F3813F52
        for <linux-efi@vger.kernel.org>; Wed, 31 Aug 2022 15:05:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46E6BED1;
        Wed, 31 Aug 2022 15:05:10 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 974773F71A;
        Wed, 31 Aug 2022 15:05:03 -0700 (PDT)
Message-ID: <d58f870f-c41c-9d4b-4dc8-83ef4efe5ce9@arm.com>
Date:   Wed, 31 Aug 2022 17:05:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 6/9] arm64: efi: enable generic EFI compressed boot
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>
References: <20220827083850.2702465-1-ardb@kernel.org>
 <20220827083850.2702465-7-ardb@kernel.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20220827083850.2702465-7-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,


On 8/27/22 03:38, Ard Biesheuvel wrote:
> Wire up the generic EFI zboot support for arm64.

Thanks for this series, its very helpful when using a boot manager that 
isn't grub (ex: systemd-boot, ipxe, etc) since those boot managers have 
the expectation that they are simply executing efi images. Given how 
large some of the uncompressed images get, and having a half dozen of 
them on a machine isn't ideal. So this series solves that problem, as 
well as cleans up some of the less than ideal grubisms that aren't 
needed on !x86 platforms.

So, I've been testing this series with a clean (as in grub/grubby/etc 
was never near the system) systemd-boot, which now works given the fixes 
to the initrd= option. It seems that the resulting boot path is 
noticeably faster as well. Given I've been testing both gziped and 
Lz4'ed images it could just be the latter option is faster, or it could 
be grubs decompressor/load sequence is just slow.

That said, I think there are a couple build tweaks in order. First, I 
would expect that just a normal 'make' (rather than 'make vmlinuz.efi') 
would make the resulting image when ZBOOT is enabled . Then I would 
expect 'make install' (or maybe a new 'make ezinstall?') to pass the new 
compressed efi to the installkernel utility. The install option would 
work without changes if the make pass just renames/creates the resulting 
vmlinuz.efi as Image. So.. there are a bunch of choices here, but my 
assumption is that the ZBOOT changes the resulting image, and the normal 
make/make install sequence just does the right thing.


So, now the fun bit. At the moment my shim->grub->efi-stubbed kernel 
path (which is the default fedora/rhel sequence) appears to be broken if 
I swap the compressed image (not the .gz version) in for a normal 
decompressed kernel. That appears to be a grub bug in fedora at the 
moment, but I've not fully tracked it down.

I was going to test secure boot, but the above problem has temporary 
stalled that, and I'm still cleaning up a few things on the sd-boot side 
(there isn't a shim in the path) before that is a workable testing path 
for anything other than a test signed kernel.


Thanks again for this, its extremely helpful.


> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/arm64/Makefile      | 4 ++--
>   arch/arm64/boot/Makefile | 6 ++++++
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6d9d4a58b898..92676ccc6363 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -153,10 +153,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>   boot		:= arch/arm64/boot
>   KBUILD_IMAGE	:= $(boot)/Image.gz
>   
> -all:	Image.gz
> +all:	$(notdir $(KBUILD_IMAGE))
>   
>   
> -Image: vmlinux
> +Image vmlinuz.efi: vmlinux
>   	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>   
>   Image.%: Image
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index a0e3dedd2883..c65aee088410 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -38,3 +38,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>   
>   $(obj)/Image.zst: $(obj)/Image FORCE
>   	$(call if_changed,zstd)
> +
> +EFI_ZBOOT_PAYLOAD	:= Image
> +EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
> +EFI_ZBOOT_MACH_TYPE	:= ARM64
> +
> +include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot

