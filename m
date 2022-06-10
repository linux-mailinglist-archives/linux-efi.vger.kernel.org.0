Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F354657C
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbiFJLZS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 07:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiFJLZR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 07:25:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3909EED7A2;
        Fri, 10 Jun 2022 04:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B879EB832C7;
        Fri, 10 Jun 2022 11:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C876C34114;
        Fri, 10 Jun 2022 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654860312;
        bh=R7E/rhnNrACRko2rS5mkC65LV2AS1sbDF48bNArKqCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OdW49OZ2G0DH43aev+ICAtbsWWbHFStsHOeouI2lqbtIyLGMJGpYKEBSBYc6C2gDU
         4FOes5PXQLmq3w9wvl5ThMGVeixrpPPc0D/MbI8GlyBCn8W9UPhyyaLbIPLt39Uixj
         W83f7yjjDrQ2QbLxD64P00x5W+9bMoOHgzskdAnsDhGUTR9z3KD/lSA++1X2Hv7U/l
         Hlm5rn2MmmpUMTCSAiZVuN9fu/g6Q9ZxVl7lAWVoSkPtRqGXxxnCivuuk8cRSIQNTf
         0XsKWPW+A8tLwC2X71bA2wXl7vUzqj6GkeStCkQxrcchfH/UkeiM9zD3v4ghjPTZwG
         8TfdoW95quHUg==
Received: by mail-oi1-f174.google.com with SMTP id bl34so3672142oib.1;
        Fri, 10 Jun 2022 04:25:12 -0700 (PDT)
X-Gm-Message-State: AOAM5327BK6Ug5tAY21OYaI/V+vtEeuTq60Dh/SsT4ffz7vzo+qx7E5i
        ltyrrtWFFNnef92J+Rl5vBWkTIHX7mGka3yDenk=
X-Google-Smtp-Source: ABdhPJxchFb1YBSq+ODryfDT61Kd03pOAps2R21snltVHICUuIHqUgkA3se7XxGAoa7fI3/uaYqtBouurO7FziMDMm8=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr4439313oan.126.1654860300884; Fri, 10
 Jun 2022 04:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093805.1354256-1-mawupeng1@huawei.com> <CAMj1kXH5r=CUoLCndBUsZ04_0UCJ2VqgJDdp2wbdNCtEx0Yxag@mail.gmail.com>
In-Reply-To: <CAMj1kXH5r=CUoLCndBUsZ04_0UCJ2VqgJDdp2wbdNCtEx0Yxag@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Jun 2022 13:24:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHNK+t1yWMP4+syi-_01qxZ=o-5HoaTTzRhFM7EqLaBPQ@mail.gmail.com>
Message-ID: <CAMj1kXHNK+t1yWMP4+syi-_01qxZ=o-5HoaTTzRhFM7EqLaBPQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] introduce mirrored memory support for arm64
To:     Wupeng Ma <mawupeng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>, songmuchun@bytedance.com,
        Randy Dunlap <rdunlap@infradead.org>,
        damien.lemoal@opensource.wdc.com,
        Stephen Boyd <swboyd@chromium.org>,
        Wei Liu <wei.liu@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, gpiccoli@igalia.com,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        chenzhou10@huawei.com, vijayb@linux.microsoft.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 10 Jun 2022 at 13:23, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 7 Jun 2022 at 11:16, Wupeng Ma <mawupeng1@huawei.com> wrote:
> >
> > From: Ma Wupeng <mawupeng1@huawei.com>
> >
> > Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
> > introduced mirrored memory support for x86. This support rely on UEFI to
> > report mirrored memory address ranges.  See UEFI 2.5 spec pages 157-158:
> >
> >   http://www.uefi.org/sites/default/files/resources/UEFI%202_5.pdf
> >
> > Memory mirroring is a technique used to separate memory into two separate
> > channels, usually on a memory device, like a server. In memory mirroring,
> > one channel is copied to another to create redundancy. This method makes
> > input/output (I/O) registers and memory appear with more than one address
> > range because the same physical byte is accessible at more than one
> > address. Using memory mirroring, higher memory reliability and a higher
> > level of memory consolidation are possible.
> >
> > These EFI memory regions have various attributes, and the "mirrored"
> > attribute is one of them. The physical memory region whose descriptors
> > in EFI memory map has EFI_MEMORY_MORE_RELIABLE attribute (bit: 16) are
> > mirrored. The address range mirroring feature of the kernel arranges such
> > mirrored regions into normal zones and other regions into movable zones.
> >
> > Arm64 can support this too. So mirrored memory support is added to support
> > arm64.
> >
> > The main purpose of this patch set is to introduce mirrored support for
> > arm64 and we have already fixed the problems we had which is shown in
> > patch #5 to patch #8 and try to bring total isolation in patch #9 which
> > will disable mirror feature if kernelcore is not specified.
> >
> > In order to test this support in arm64:
> > - patch this patch set
> > - add kernelcore=mirror in kernel parameter
> > - start you kernel
> >
> > Patch #1-#2 introduce mirrored memory support form arm64.
> > Patch #3-#5 fix some bugs for arm64 if memory reliable is enabled.
> > Patch #6 disable mirror feature if kernelcore is not specified.
> >
> > Thanks to Ard Biesheuvel's hard work [1], now kernel will perfer mirrored
> > memory if kaslr is enabled.
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com/T/
> >
> > Changelog since v2:
> > - remove efi_fake_mem support
> > - remove Commit ("remove some redundant code in ia64 efi_init") since
> >   efi_print_memmap() is not public
> > - add mirror flag back on initrd memory
> >
> > Changelog since v1:
> > - update changelog in cover letter
> > - use PHYS_PFN in patch #7
> >
> > Ma Wupeng (6):
> >   efi: Make efi_find_mirror() public
> >   arm64/mirror: arm64 enabling - find mirrored memory ranges
> >   mm: Ratelimited mirrored memory related warning messages
> >   mm: Demote warning message in vmemmap_verify() to debug level
> >   mm: Add mirror flag back on initrd memory
> >   efi: Disable mirror feature if kernelcore is not specified
> >
>
> I have tested these changes on QEMU/arm64 with the patch below, and
> things seem to work as expected. We have some minor issues to work out
> but the general shape of this code is good.
>
> As for the mm/ changes: does anyone mind if I take those through the
> EFI tree as well? I don't think the EFI and -mm changes depend on each
> other, so they can go into -mm separately as well.

diff --git a/drivers/firmware/efi/libstub/efi-stub.c
b/drivers/firmware/efi/libstub/efi-stub.c
index f515394cce6e..1d4dd8aca3e6 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -136,6 +136,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
        enum efi_secureboot_mode secure_boot;
        struct screen_info *si;
        efi_properties_table_t *prop_tbl;
+       const efi_dxe_services_table_t *efi_dxe_table;

        efi_system_table = sys_table_arg;

@@ -161,6 +162,20 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
                goto fail;
        }

+       efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
+       if (efi_dxe_table) {
+               efi_physical_addr_t pa = 0x60000000;
+               efi_gcd_memory_space_desc_t desc;
+
+               status = efi_dxe_call(get_memory_space_descriptor, pa, &desc);
+               if (status != EFI_SUCCESS)
+                       efi_err("Failed to get memory space
descriptor: %lx\n", status);
+               status = efi_dxe_call(set_memory_space_capabilities, pa, SZ_1G,
+                                     desc.capabilities |
EFI_MEMORY_MORE_RELIABLE);
+               if (status != EFI_SUCCESS)
+                       efi_err("Failed to set memory space
capabilities: %lx\n", status);
+       }
+
        /*
         * Get the command line from EFI, using the LOADED_IMAGE
         * protocol. We are going to copy the command line into the
diff --git a/drivers/firmware/efi/libstub/efistub.h
b/drivers/firmware/efi/libstub/efistub.h
index b0ae0a454404..bf11d85bf9b4 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -378,7 +378,8 @@ union efi_dxe_services_table {
                void *schedule;
                void *trust;
                void *process_firmware_volume;
-               void *set_memory_space_capabilities;
+               efi_status_t (__efiapi
*set_memory_space_capabilities)(efi_physical_addr_t,
+
u64, u64);
        };
        struct {
                efi_table_hdr_t hdr;
