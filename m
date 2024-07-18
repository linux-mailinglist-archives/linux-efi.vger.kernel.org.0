Return-Path: <linux-efi+bounces-1456-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD79347E9
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 08:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A02B221EE
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ECC3D0AD;
	Thu, 18 Jul 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RxkJ27Un"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9F44366;
	Thu, 18 Jul 2024 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283379; cv=none; b=KZk6v8/MEBfut25r8vPHWkSp84blyAtMFv4XS0m+pXtL3DCAnhbk9iueaq7DoTXYo6V51VUrjvNVy8E0ByBi3AOnpqo6/59Hxw4Ucftemt7YGzKjg7UIbo5ZR5T0x7EEduMsfhSIHQUWZpN2uG4DW+qaAjPwhP2GLQV1BfX3pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283379; c=relaxed/simple;
	bh=BM2mNVmuJcY/LmUfiTpu7UXdpx1WXiN11WNPacxILig=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=B1R06E5NzU6MKfgFWeOlyVIuloXIm37GEm3/fbCz0Hnx2oouhkz75SNPfqlQ9p/yLMtKUOudS+qkMJAM2VAcG7zf6HwIXzF+SN53d4OqZ3hu+O1tYIbvdA0ZU2BzH/3nR+J8nHsL9UDO0g7Lyh5OS4S2cqG2OXXLYY1QIUs7nkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=RxkJ27Un; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 46I6FOBJ3092595
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Jul 2024 23:15:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 46I6FOBJ3092595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1721283326;
	bh=4GPEBFCkI4GpI3gztc1bt8+74vJKF4Faqu6RZUuzNXE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=RxkJ27UnaTzPZav0pWlggnAVZnJW7QeOPiI988iBXUIJMSjqIwnucAp9bOClzIHaY
	 BAWuH28xPI7cPO0dJ1j5A21c4X4t4OsP6ZlD9se29CDROcgrBdiRsTe2gaGN4RXp2g
	 Rcx0JKdZHaP0C0bhqbBXK9Na9W+Pgr3klPJQjjgrxXXcHFJ1qLEOPCKmJKjsC9T62A
	 hmZs9rNSkms0dVOXN8hmWqoMP4rFvZ4ve3wJ5xUvtRzC5PqQ2ps0D2DCoUNLNDrGW6
	 TuYMaqUHlMFCRStCKV3i5ehMQ9kn2EtNNagZGs8meU7+G10zOLI3UE+bxGGgQEdub2
	 aTjk3GmBGcrBg==
Date: Wed, 17 Jul 2024 23:15:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Shao, Marshall" <Marshall.Shao@Dell.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC: "Mishra, Ashish" <Ashish.Mishra4@dell.com>,
        "Dion, Christopher" <Christopher.Dion@dell.com>,
        "Caisse, Joe" <Joe.Caisse@dell.com>,
        "Chia, Jia Yuan" <JiaYuan.Chia@dell.com>,
        "Mukundan, Govind" <Govind.Mukundan@dell.com>
Subject: Re: [Patch] Do not clear BSS region in x86 stub
User-Agent: K-9 Mail for Android
In-Reply-To: <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
References: <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
Message-ID: <A2AEC38D-56FB-4687-BDC2-54F1600F14A1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 17, 2024 12:33:08 AM PDT, "Shao, Marshall" <Marshall=2EShao@Dell=2E=
com> wrote:
>From: Marshall Shao <marshall=2Eshao@dell=2Ecom>
>
>Clearing the BSS region may cause the UEFI firmware to malfunction
>during boot=2E
>
>When booting the kernel from an older firmware version that has TPM
>enabled and the MemoryOverwriteRequestControl bit set to 1, the
>firmware's boot service might encounter an exception if it attempts
>to initialize the BSS region within the x86 stub=2E
>
>To circumvent the firmware exception, it is advisable to enlarge the
>BOOT_STACK_SIZE and to perform the initialization of static variables
>prior to the decompression of the bzImage=2E
>
>Signed-off-by: Marshall Shao <marshall=2Eshao@dell=2Ecom>
>---
> arch/x86/boot/compressed/misc=2Ec         | 8 +++-----
> arch/x86/include/asm/boot=2Eh             | 2 +-
> drivers/firmware/efi/libstub/x86-stub=2Ec | 5 -----
> 3 files changed, 4 insertions(+), 11 deletions(-)
>
>diff --git a/arch/x86/boot/compressed/misc=2Ec b/arch/x86/boot/compressed=
/misc=2Ec
>index b70e4a21c15f=2E=2Ebac5a3c55c2c 100644
>--- a/arch/x86/boot/compressed/misc=2Ec
>+++ b/arch/x86/boot/compressed/misc=2Ec
>@@ -356,11 +356,9 @@ unsigned long decompress_kernel(unsigned char *outbu=
f, unsigned long virt_addr,
>                                void (*error)(char *x))
> {
>        unsigned long entry;
>-
>-       if (!free_mem_ptr) {
>-               free_mem_ptr     =3D (unsigned long)boot_heap;
>-               free_mem_end_ptr =3D (unsigned long)boot_heap + sizeof(bo=
ot_heap);
>-       }
>+       free_mem_ptr     =3D (unsigned long)boot_heap;
>+       free_mem_end_ptr =3D (unsigned long)boot_heap + sizeof(boot_heap)=
;
>+       malloc_ptr =3D free_mem_ptr;
>
>        if (__decompress(input_data, input_len, NULL, NULL, outbuf, outpu=
t_len,
>                         NULL, error) < 0)
>diff --git a/arch/x86/include/asm/boot=2Eh b/arch/x86/include/asm/boot=2E=
h
>index 3e5b111e619d=2E=2E312bc87ab027 100644
>--- a/arch/x86/include/asm/boot=2Eh
>+++ b/arch/x86/include/asm/boot=2Eh
>@@ -33,7 +33,7 @@
> #endif
>
> #ifdef CONFIG_X86_64
>-# define BOOT_STACK_SIZE       0x4000
>+# define BOOT_STACK_SIZE       0x10000
>
> /*
>  * Used by decompressor's startup_32() to allocate page tables for ident=
ity
>diff --git a/drivers/firmware/efi/libstub/x86-stub=2Ec b/drivers/firmware=
/efi/libstub/x86-stub=2Ec
>index 1983fd3bf392=2E=2Ed92d2ccc709b 100644
>--- a/drivers/firmware/efi/libstub/x86-stub=2Ec
>+++ b/drivers/firmware/efi/libstub/x86-stub=2Ec
>@@ -21,7 +21,6 @@
> #include "efistub=2Eh"
> #include "x86-stub=2Eh"
>
>-extern char _bss[], _ebss[];
>
> const efi_system_table_t *efi_system_table;
> const efi_dxe_services_table_t *efi_dxe_table;
>@@ -476,9 +475,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handl=
e,
>        efi_status_t status;
>        char *cmdline_ptr;
>
>-       if (efi_is_native())
>-               memset(_bss, 0, _ebss - _bss);
>-
>        efi_system_table =3D sys_table_arg;
>
>        /* Check if we were booted by the EFI firmware */
>@@ -1000,7 +996,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_tab=
le_arg,
>                        struct boot_params *boot_params)
> {
>-       memset(_bss, 0, _ebss - _bss);
>        efi_stub_entry(handle, sys_table_arg, boot_params);
> }
>
>--
>2=2E34=2E1
>
>
>Internal Use - Confidential
>

This is strange=2E Is the problem that the BSS is not properly reflected i=
n the UEFI PECOFF header?

