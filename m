Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECA6314F5
	for <lists+linux-efi@lfdr.de>; Sun, 20 Nov 2022 16:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKTPhy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Nov 2022 10:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKTPht (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 20 Nov 2022 10:37:49 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF765FD0;
        Sun, 20 Nov 2022 07:37:46 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id A569A419E9E4;
        Sun, 20 Nov 2022 15:37:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A569A419E9E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1668958660;
        bh=CAqPKJIi1yDbm+KHX7GSdiJRmyN/LoZvZ7O2KKu+0oU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BfhnW4Tg18Q2kjMjhrZ+it1vXEv2GKRfsvqlJszTREcnFhOecGwBbIT8E7dM5eGbo
         GTx5Ui2G91zwVXvQL70WqU7xi1mPQPVBkIE/cHTdLi4CySPCCbKrMz55LgOhf9YWgP
         wDW36Z90jya5IL/NGmdtvPPIv5eu46RbUnNVUqZw=
MIME-Version: 1.0
Date:   Sun, 20 Nov 2022 18:37:40 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     joeyli <jlee@suse.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/23] x86_64: Improvements at compressed kernel stage
In-Reply-To: <20221120014919.GV3967@linux-l9pv.suse>
References: <cover.1666705333.git.baskov@ispras.ru>
 <20221120014919.GV3967@linux-l9pv.suse>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <50aa7df3f34f55ec435c4f489d8f3df3@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-11-20 04:49, joeyli wrote:
> Hi Evgeniy,
> 
> Thanks for your effort!
> 
> On Tue, Oct 25, 2022 at 05:12:38PM +0300, Evgeniy Baskov wrote:
...
> 
> Because Peter Jones point out this patchset to me, so I tried it
> on OVMF, and I set the EfiLoaderData in DXE memory protection policy:
> 
> Index: edk2/MdeModulePkg/MdeModulePkg.dec
> ===================================================================
> --- edk2.orig/MdeModulePkg/MdeModulePkg.dec
> +++ edk2/MdeModulePkg/MdeModulePkg.dec
> @@ -1392,7 +1392,7 @@
>    # e.g. 0x7BD4 can be used for all memory except Code and
> ACPINVS/Reserved. <BR>
>    #
>    # @Prompt Set DXE memory protection policy.
> -
> gEfiMdeModulePkgTokenSpaceGuid.PcdDxeNxMemoryProtectionPolicy|0x0000000|UINT64|0x00001048^M
> +
> gEfiMdeModulePkgTokenSpaceGuid.PcdDxeNxMemoryProtectionPolicy|0x0000004|UINT64|0x00001048^M
> 
>    ## PCI Serial Device Info. It is an array of Device, Function, and
> Power Management
>    #  information that describes the path that contains zero or more
> PCI to PCI bridges
> 
> 
> I applied this v2 patch set on top of v6.1-rc5 kernel, and boot with a
> shim which
> set the PE NX-compatibility DLL Characteristic flag. I got a page
> fault exception:
> 
> Loading Linux 6.1.0-rc5-default+ ...
> Loading initial ramdisk ...
> !!!! X64 Exception Type - 0E(#PF - Page-Fault)  CPU Apic ID - 00000000 
> !!!!
> ExceptionData - 0000000000000011  I:1 R:0 U:0 W:0 P:1 PK:0 SS:0 SGX:0
> RIP  - 0000000076A3C390, CS  - 0000000000000038, RFLAGS - 
> 0000000000210202
> RAX  - 000000007D8CCDF8, RCX - 0000000076A3C390, RDX - 000000007DE86000
> RBX  - 0000000076A3C000, RSP - 000000007FF0D2C8, RBP - 000000007DE86000
> RSI  - 000000007F9EE018, RDI - 000000007DFD1C18
> R8   - 0000000076A3C000, R9  - 0000000000000190, R10 - 000000007FF1D658
> R11  - 0000000000000004, R12 - 0000000000000190, R13 - 000000007D8CCE00
> R14  - 000000007D8C76B4, R15 - 000000007BF0CBD5
> DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
> GS   - 0000000000000030, SS  - 0000000000000030
> CR0  - 0000000080010033, CR2 - 0000000076A3C390, CR3 - 000000007FC01000
> CR4  - 0000000000000668, CR8 - 0000000000000000
> DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
> DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
> GDTR - 000000007F9DE000 0000000000000047, LDTR - 0000000000000000
> IDTR - 000000007F2E9018 0000000000000FFF,   TR - 0000000000000000
> FXSAVE_STATE - 000000007FF0CF20
> !!!! Find image based on IP(0x7BF0BAB5)
> /mnt/working/source_code-git/edk2/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/VariableRuntimeDxe.dll
> (ImageBase=0000000000F40E7C, EntryPoint=0000000000F767B8) !!!!
> 
> 
> My question is: Can I just set EfiLoaderData in DXE memory protection 
> policy
> in EDK2/OVMF to test this patchset? Or which platform (virtual or 
> physical)
> can we use for testing?
> 
> Thanks a lot!
> Joey Lee

Hi,

Thank you for testing!

The EDK2 OVMF with adjusted PcdDxeNxMemoryProtectionPolicy
should work with the kernel itself.

As far as I can see from my testing with EDK2 OVMF, this
#PF occurred inside GRUB code before the first instruction
of the kernel. You can try using GRUB master branch, where
allocations are changed to use EfiLoaderCode type and with
PcdDxeNxMemoryProtectionPolicy=0x0000004 it will still be
executable.

Thanks,
Evgeniy Baskov
