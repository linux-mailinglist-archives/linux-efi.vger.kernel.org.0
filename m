Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF80329FE2B
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgJ3HBP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 03:01:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58336 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgJ3HBO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Oct 2020 03:01:14 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kYO6A-0006BV-Vl
        for linux-efi@vger.kernel.org; Fri, 30 Oct 2020 06:41:19 +0000
Received: by mail-pg1-f198.google.com with SMTP id j5so3937265pgt.4
        for <linux-efi@vger.kernel.org>; Thu, 29 Oct 2020 23:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lQGB6Z+DlttLvK1t0RSiU2hFBumfJx5H0k9qVrtCUso=;
        b=Urt1EsgEfkPIhaTYppUk0ySS6DkZzOEWJo1ZOd6duj6/HpO/uSdtOSYHmvMpq33HXI
         tChOzPm7fu0E6uj+zkxO0dZGYAE1DNc8J4cvovt+KCj2VCte68CuAVP97d4gePku9zet
         fSqsDL3OsUWlX4L7FLyKotsKi/KXIQSoBBVL1+nuKrECC4FlesFmoEW/IpKNnquDuPHn
         fQHxGWf48a8q9UIsN2n4E6sJsU26x+oKc4vaaOIpcNbBG5qqNt9avtVkXIoTGNy5y6AN
         fuVC4gqGNJA4IPU2RCp/p9kWYYgnCHAkiVkq772tU7QVWwRHBOfQjOAc3s+YAqLZ1cmx
         79cA==
X-Gm-Message-State: AOAM533CMxvqcMBuTLYlbPlS9UOpw/CldQCCfqNOa5jrnuuksaaVj76M
        ZF9zlsaZ18JpNRPiBVfSXMG+pAKdfO6EsKbjLvcjgQ6eqjiWsqTQHrTmslgwJ2p0wBK1w1YYszd
        18d8Sa6blRjxyerknbR+zMttUD/vhGUoJKH7eIw==
X-Received: by 2002:a17:90a:5211:: with SMTP id v17mr827814pjh.200.1604040076390;
        Thu, 29 Oct 2020 23:41:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCzbHn9wLOOexv95zPAg5kwhts8E1/uXx4uHA9axsvOk5EpS2rcJueoWvZRbvkzYcXaKELAg==
X-Received: by 2002:a17:90a:5211:: with SMTP id v17mr827781pjh.200.1604040076040;
        Thu, 29 Oct 2020 23:41:16 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id mm19sm1949998pjb.45.2020.10.29.23.41.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 23:41:14 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Message-Id: <F0AAA39C-4FD0-4FA5-9DEE-BC645289EA8F@canonical.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_C2636F85-FEF7-440B-ABCD-E83992764EA9"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] tpm: efi: Don't create binary_bios_measurements file for
 an empty log
Date:   Fri, 30 Oct 2020 14:41:10 +0800
In-Reply-To: <20201028173958.GA4624@sequoia>
Cc:     "Kenneth R . Crudup" <kenny@panix.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        =?utf-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20201028154102.9595-1-tyhicks@linux.microsoft.com>
 <20201028163002.GA5150@sequoia> <20201028173958.GA4624@sequoia>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--Apple-Mail=_C2636F85-FEF7-440B-ABCD-E83992764EA9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Oct 29, 2020, at 01:39, Tyler Hicks <tyhicks@linux.microsoft.com> =
wrote:
>=20
> On 2020-10-28 11:30:11, Tyler Hicks wrote:
>> So, we need help from Kai, Kenneth, or Mimi to verify my assumption =
that
>> their firmware is providing an empty main event log and a populated
>> final event log.
>=20
> Hi Kai, Kenneth, and Mimi - could one or two of you please follow =
these
> steps:
>=20
> 1) Apply the proposed patch in the grandparent of this email so that
>   your kernel doesn't crash
> 2) Revert commit 7f3d176f5f7e ("tpm: Require that all digests are
>   present in TCG_PCR_EVENT2 structures") so that
>   __calc_tpm2_event_size() goes back to being less picky and may treat
>   a final log event as a valid event log header
> 3) Add some debugging warnings in efi_tpm_eventlog_init() to check for
>   an empty main event log and a populated final event log, as shown
>   below
> 4) Boot the resulting kernel build, look for the warnings, and report
>   back
>=20
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index c1955d320fec..c4d2dbd5ed42 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -78,6 +78,9 @@ int __init efi_tpm_eventlog_init(void)
> 		goto out;
> 	}
>=20
> +	WARN(!log_tbl->size && final_tbl->nr_events,
> +	     "nr_events =3D %llu\n", final_tbl->nr_events);
> +
> 	tbl_size =3D 0;
> 	if (final_tbl->nr_events !=3D 0) {
> 		void *events =3D (void *)efi.tpm_final_log
> @@ -95,6 +98,8 @@ int __init efi_tpm_eventlog_init(void)
> 		goto out_calc;
> 	}
>=20
> +	WARN(!log_tbl->size && tbl_size, "tbl_size =3D %d\n", tbl_size);
> +
> 	memblock_reserve((unsigned long)final_tbl,
> 			 tbl_size + sizeof(*final_tbl));
> 	efi_tpm_final_log_size =3D tbl_size;
>=20
> For your convenience, I've created a branch with these changes on top =
of
> v5.9:
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/linux.git/log/?h=3D=
tpm/bin-bios-measurements-debug

Dmesg attached.

Kai-Heng

--Apple-Mail=_C2636F85-FEF7-440B-ABCD-E83992764EA9
Content-Disposition: attachment;
	filename=dmesg
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="dmesg"
Content-Transfer-Encoding: 7bit

[    0.000000] microcode: microcode updated early to revision 0xd6, date = 2020-04-27
[    0.000000] Linux version 5.9.0+ (khfeng@ThinkPad-T580) (gcc (Ubuntu 10.2.0-15ubuntu1) 10.2.0, GNU ld (GNU Binutils for Ubuntu) 2.35.1) #28 SMP Fri Oct 30 14:05:37 CST 2020
[    0.000000] Command line: BOOT_IMAGE=/@/boot/vmlinuz-5.9.0+ root=UUID=523fd023-8a9d-45cc-90fc-7823d5a8636f ro rootflags=subvol=@ quiet splash vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000403fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040400000-0x000000004f248fff] usable
[    0.000000] BIOS-e820: [mem 0x000000004f249000-0x000000004f24afff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004f24b000-0x000000004fee4fff] usable
[    0.000000] BIOS-e820: [mem 0x000000004fee5000-0x000000004fee5fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000004fee6000-0x000000005eaabfff] usable
[    0.000000] BIOS-e820: [mem 0x000000005eaac000-0x000000005eaacfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000005eaad000-0x000000005eaadfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005eaae000-0x0000000068419fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006841a000-0x00000000694f4fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000694f5000-0x0000000069599fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006959a000-0x00000000695fefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000695ff000-0x00000000695fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000069600000-0x000000006f7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000028f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi: TPMFinalLog=0x69592000 SMBIOS=0x686a5000 SMBIOS 3.0=0x686a2000 ACPI=0x695fe000 ACPI 2.0=0x695fe014 ESRT=0x6852f000 MEMATTR=0x62e3b018 RNG=0x686a6198 TPMEventLog=0x5ec19d18 
[    0.000000] efi: seeding entropy pool
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20LAZ3TXCN/20LAZ3TXCN, BIOS N27ET38W (1.24 ) 11/28/2019
[    0.000000] tsc: Detected 1800.000 MHz processor
[    0.000973] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000977] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000990] last_pfn = 0x28f800 max_arch_pfn = 0x400000000
[    0.000997] MTRR default type: write-back
[    0.000999] MTRR fixed ranges enabled:
[    0.001001]   00000-9FFFF write-back
[    0.001002]   A0000-BFFFF uncachable
[    0.001004]   C0000-FFFFF write-protect
[    0.001005] MTRR variable ranges enabled:
[    0.001008]   0 base 0080000000 mask 7F80000000 uncachable
[    0.001010]   1 base 0070000000 mask 7FF0000000 uncachable
[    0.001011]   2 base 006C000000 mask 7FFC000000 uncachable
[    0.001013]   3 base 006B000000 mask 7FFF000000 uncachable
[    0.001014]   4 disabled
[    0.001015]   5 disabled
[    0.001016]   6 disabled
[    0.001017]   7 disabled
[    0.001017]   8 disabled
[    0.001018]   9 disabled
[    0.001953] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002299] last_pfn = 0x69600 max_arch_pfn = 0x400000000
[    0.023491] esrt: Reserving ESRT space from 0x000000006852f000 to 0x000000006852f0b0.
[    0.023506] check: Scanning 1 areas for low memory corruption
[    0.023514] Using GB pages for direct mapping
[    0.024568] Secure boot disabled
[    0.024570] RAMDISK: [mem 0x26887000-0x275b0fff]
[    0.024583] ACPI: Early table checksum verification disabled
[    0.024588] ACPI: RSDP 0x00000000695FE014 000024 (v02 LENOVO)
[    0.024593] ACPI: XSDT 0x00000000695B3188 00012C (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024602] ACPI: FACP 0x00000000695EC000 0000F4 (v05 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024610] ACPI: DSDT 0x00000000695C1000 026B21 (v02 LENOVO SKL      00000000 INTL 20160527)
[    0.024615] ACPI: FACS 0x000000006953E000 000040
[    0.024619] ACPI: SSDT 0x00000000695F4000 008063 (v02 LENOVO DptfTabl 00001000 INTL 20160527)
[    0.024623] ACPI: SSDT 0x00000000695F3000 0003DB (v02 LENOVO Tpm2Tabl 00001000 INTL 20160527)
[    0.024627] ACPI: TPM2 0x00000000695F2000 000034 (v03 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024631] ACPI: UEFI 0x0000000069553000 000042 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024636] ACPI: SSDT 0x00000000695EE000 0030DA (v02 LENOVO SaSsdt   00003000 INTL 20160527)
[    0.024640] ACPI: SSDT 0x00000000695ED000 0005C6 (v02 LENOVO PerfTune 00001000 INTL 20160527)
[    0.024644] ACPI: HPET 0x00000000695EB000 000038 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024648] ACPI: APIC 0x00000000695EA000 00012C (v03 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024652] ACPI: MCFG 0x00000000695E9000 00003C (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024656] ACPI: ECDT 0x00000000695E8000 000053 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024660] ACPI: SSDT 0x00000000695BF000 001C12 (v02 LENOVO RVP7Rtd3 00001000 INTL 20160527)
[    0.024665] ACPI: SSDT 0x00000000695BD000 00163C (v02 LENOVO ProjSsdt 00000010 INTL 20160527)
[    0.024669] ACPI: BOOT 0x00000000695BC000 000028 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024673] ACPI: BATB 0x00000000695BB000 00004A (v02 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024677] ACPI: SSDT 0x00000000695B9000 0017AE (v02 LENOVO CpuSsdt  00003000 INTL 20160527)
[    0.024681] ACPI: SSDT 0x00000000695B8000 00056D (v02 LENOVO CtdpB    00001000 INTL 20160527)
[    0.024686] ACPI: SSDT 0x00000000695B7000 000678 (v02 LENOVO UsbCTabl 00001000 INTL 20160527)
[    0.024690] ACPI: LPIT 0x00000000695B6000 000094 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024694] ACPI: WSMT 0x00000000695B5000 000028 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024698] ACPI: SSDT 0x00000000695B4000 000141 (v02 LENOVO HdaDsp   00000000 INTL 20160527)
[    0.024702] ACPI: SSDT 0x00000000695FD000 0004D5 (v02 LENOVO TbtTypeC 00000000 INTL 20160527)
[    0.024706] ACPI: SSDT 0x00000000695B2000 0002D1 (v02 LENOVO Wwan     00000001 INTL 20160527)
[    0.024711] ACPI: DBGP 0x00000000695B1000 000034 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024715] ACPI: DBG2 0x00000000695B0000 000054 (v00 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024720] ACPI: POAT 0x00000000695AF000 000055 (v03 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024728] ACPI: SSDT 0x00000000695AE000 00006C (v01 LENOVO NvOptTbl 00001000 INTL 20160527)
[    0.024737] ACPI: SSDT 0x00000000695AC000 00147E (v02 LENOVO SgPch    00001000 INTL 20160527)
[    0.024741] ACPI: DMAR 0x00000000695AB000 0000A8 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024745] ACPI: ASF! 0x00000000695AA000 0000A0 (v32 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024750] ACPI: FPDT 0x00000000695A9000 000044 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024754] ACPI: BGRT 0x00000000695A8000 000038 (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024758] ACPI: UEFI 0x000000006950A000 00013E (v01 LENOVO TP-N27   00001240 PTEC 00000002)
[    0.024770] ACPI: Local APIC address 0xfee00000
[    0.024887] No NUMA configuration found
[    0.024889] Faking a node at [mem 0x0000000000000000-0x000000028f7fffff]
[    0.024905] NODE_DATA(0) allocated [mem 0x28f7d5000-0x28f7fffff]
[    0.025471] Zone ranges:
[    0.025472]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.025474]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.025476]   Normal   [mem 0x0000000100000000-0x000000028f7fffff]
[    0.025478]   Device   empty
[    0.025479] Movable zone start for each node
[    0.025484] Early memory node ranges
[    0.025486]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.025487]   node   0: [mem 0x0000000000059000-0x000000000009cfff]
[    0.025488]   node   0: [mem 0x0000000000100000-0x000000003fffffff]
[    0.025489]   node   0: [mem 0x0000000040400000-0x000000004f248fff]
[    0.025491]   node   0: [mem 0x000000004f24b000-0x000000004fee4fff]
[    0.025491]   node   0: [mem 0x000000004fee6000-0x000000005eaabfff]
[    0.025493]   node   0: [mem 0x000000005eaae000-0x0000000068419fff]
[    0.025493]   node   0: [mem 0x00000000695ff000-0x00000000695fffff]
[    0.025494]   node   0: [mem 0x0000000100000000-0x000000028f7fffff]
[    0.025959] Zeroed struct page in unavailable ranges: 34895 pages
[    0.025961] Initmem setup node 0 [mem 0x0000000000001000-0x000000028f7fffff]
[    0.025964] On node 0 totalpages: 2062257
[    0.025965]   DMA zone: 64 pages used for memmap
[    0.025966]   DMA zone: 21 pages reserved
[    0.025967]   DMA zone: 3995 pages, LIFO batch:0
[    0.026005]   DMA32 zone: 6593 pages used for memmap
[    0.026006]   DMA32 zone: 421910 pages, LIFO batch:63
[    0.032131]   Normal zone: 25568 pages used for memmap
[    0.032133]   Normal zone: 1636352 pages, LIFO batch:63
[    0.056923] Reserving Intel graphics memory at [mem 0x6b800000-0x6f7fffff]
[    0.057321] ACPI: PM-Timer IO Port: 0x1808
[    0.057323] ACPI: Local APIC address 0xfee00000
[    0.057334] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.057335] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.057336] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.057337] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.057338] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.057338] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.057339] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.057340] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.057341] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.057342] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.057343] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.057343] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.057344] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.057345] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.057346] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.057347] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.057375] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.057379] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.057381] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.057383] ACPI: IRQ0 used by override.
[    0.057384] ACPI: IRQ9 used by override.
[    0.057387] Using ACPI (MADT) for SMP configuration information
[    0.057390] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.057399] e820: update [mem 0x62211000-0x622a1fff] usable ==> reserved
[    0.057412] TSC deadline timer available
[    0.057413] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.057445] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.057447] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.057449] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x000fffff]
[    0.057452] PM: hibernation: Registered nosave memory: [mem 0x40000000-0x403fffff]
[    0.057454] PM: hibernation: Registered nosave memory: [mem 0x4f249000-0x4f24afff]
[    0.057456] PM: hibernation: Registered nosave memory: [mem 0x4fee5000-0x4fee5fff]
[    0.057459] PM: hibernation: Registered nosave memory: [mem 0x5eaac000-0x5eaacfff]
[    0.057459] PM: hibernation: Registered nosave memory: [mem 0x5eaad000-0x5eaadfff]
[    0.057462] PM: hibernation: Registered nosave memory: [mem 0x62211000-0x622a1fff]
[    0.057464] PM: hibernation: Registered nosave memory: [mem 0x6841a000-0x694f4fff]
[    0.057465] PM: hibernation: Registered nosave memory: [mem 0x694f5000-0x69599fff]
[    0.057466] PM: hibernation: Registered nosave memory: [mem 0x6959a000-0x695fefff]
[    0.057468] PM: hibernation: Registered nosave memory: [mem 0x69600000-0x6f7fffff]
[    0.057469] PM: hibernation: Registered nosave memory: [mem 0x6f800000-0xefffffff]
[    0.057470] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
[    0.057471] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfe00ffff]
[    0.057472] PM: hibernation: Registered nosave memory: [mem 0xfe010000-0xfe010fff]
[    0.057472] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.057475] [mem 0x6f800000-0xefffffff] available for PCI devices
[    0.057476] Booting paravirtualized kernel on bare hardware
[    0.057480] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.057487] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.057866] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
[    0.057877] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
[    0.057878] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.057921] Built 1 zonelists, mobility grouping on.  Total pages: 2030011
[    0.057922] Policy zone: Normal
[    0.057923] Kernel command line: BOOT_IMAGE=/@/boot/vmlinuz-5.9.0+ root=UUID=523fd023-8a9d-45cc-90fc-7823d5a8636f ro rootflags=subvol=@ quiet splash vt.handoff=7
[    0.058865] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.059315] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.059435] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.107312] Memory: 7938248K/8249028K available (14339K kernel code, 2420K rwdata, 4784K rodata, 2568K init, 5112K bss, 310520K reserved, 0K cma-reserved)
[    0.107325] random: get_random_u64 called from __kmem_cache_create+0x2d/0x540 with crng_init=1
[    0.107622] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.107651] Kernel/User page tables isolation: enabled
[    0.107687] ftrace: allocating 43402 entries in 170 pages
[    0.140023] ftrace: allocated 170 pages with 4 groups
[    0.140229] rcu: Hierarchical RCU implementation.
[    0.140231] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.140233] 	Rude variant of Tasks RCU enabled.
[    0.140234] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.140235] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.146440] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.147215] random: crng done (trusting CPU's manufacturer)
[    0.147263] Console: colour dummy device 80x25
[    0.147270] printk: console [tty0] enabled
[    0.147306] ACPI: Core revision 20200717
[    0.147931] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.148028] APIC: Switch to symmetric I/O mode setup
[    0.148032] DMAR: Host address width 39
[    0.148034] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.148045] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.148047] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.148054] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.148055] DMAR: RMRR base: 0x00000068a3f000 end: 0x00000068a5efff
[    0.148058] DMAR: RMRR base: 0x0000006b000000 end: 0x0000006f7fffff
[    0.148061] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.148062] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.148063] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.149932] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.149934] x2apic enabled
[    0.149949] Switched APIC routing to cluster x2apic.
[    0.154183] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.171978] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x19f2297dd97, max_idle_ns: 440795236593 ns
[    0.171985] Calibrating delay loop (skipped), value calculated using timer frequency.. 3600.00 BogoMIPS (lpj=7200000)
[    0.171989] pid_max: default: 32768 minimum: 301
[    0.176032] LSM: Security Framework initializing
[    0.176050] Yama: becoming mindful.
[    0.176094] AppArmor: AppArmor initialized
[    0.176175] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.176200] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.176714] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.176756] process: using mwait in idle threads
[    0.176760] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.176761] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.176765] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.176767] Spectre V2 : Mitigation: Full generic retpoline
[    0.176768] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.176768] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.176772] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.176773] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.176775] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.176792] SRBDS: Mitigation: Microcode
[    0.176792] MDS: Mitigation: Clear CPU buffers
[    0.177120] Freeing SMP alternatives memory: 40K
[    0.182435] smpboot: CPU0: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz (family: 0x6, model: 0x8e, stepping: 0xa)
[    0.182712] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.182732] ... version:                4
[    0.182733] ... bit width:              48
[    0.182734] ... generic registers:      4
[    0.182735] ... value mask:             0000ffffffffffff
[    0.182736] ... max period:             00007fffffffffff
[    0.182737] ... fixed-purpose events:   3
[    0.182738] ... event mask:             000000070000000f
[    0.182805] rcu: Hierarchical SRCU implementation.
[    0.183928] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.183981] smp: Bringing up secondary CPUs ...
[    0.183981] x86: Booting SMP configuration:
[    0.183981] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.197098] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.197098]  #5 #6 #7
[    0.200708] smp: Brought up 1 node, 8 CPUs
[    0.200708] smpboot: Max logical packages: 1
[    0.200708] smpboot: Total of 8 processors activated (28800.00 BogoMIPS)
[    0.204541] devtmpfs: initialized
[    0.204541] x86/mm: Memory block size: 128MB
[    0.205397] PM: Registering ACPI NVS region [mem 0x5eaac000-0x5eaacfff] (4096 bytes)
[    0.205397] PM: Registering ACPI NVS region [mem 0x694f5000-0x69599fff] (675840 bytes)
[    0.205397] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.205397] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.205397] pinctrl core: initialized pinctrl subsystem
[    0.205397] PM: RTC time: 06:30:55, date: 2020-10-30
[    0.205397] NET: Registered protocol family 16
[    0.205397] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.205397] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.205418] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.205445] audit: initializing netlink subsys (disabled)
[    0.208000] audit: type=2000 audit(1604039455.060:1): state=initialized audit_enabled=0 res=1
[    0.208167] thermal_sys: Registered thermal governor 'fair_share'
[    0.208169] thermal_sys: Registered thermal governor 'bang_bang'
[    0.208170] thermal_sys: Registered thermal governor 'step_wise'
[    0.208171] thermal_sys: Registered thermal governor 'user_space'
[    0.208181] EISA bus registered
[    0.208199] cpuidle: using governor ladder
[    0.208199] cpuidle: using governor menu
[    0.208199] Simple Boot Flag at 0x47 set to 0x1
[    0.208199] ACPI: bus type PCI registered
[    0.208199] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.208537] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    0.208543] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    0.208561] PCI: Using configuration type 1 for base access
[    0.208561] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.212064] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.212064] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.212141] ACPI: Added _OSI(Module Device)
[    0.212141] ACPI: Added _OSI(Processor Device)
[    0.212141] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.212141] ACPI: Added _OSI(Processor Aggregator Device)
[    0.212141] ACPI: Added _OSI(Linux-Dell-Video)
[    0.212141] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.212141] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.319555] ACPI: 15 ACPI AML tables successfully acquired and loaded
[    0.322617] ACPI: EC: EC started
[    0.322618] ACPI: EC: interrupt blocked
[    0.326849] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.326850] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.330044] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.414168] ACPI: Dynamic OEM Table Load:
[    0.414194] ACPI: SSDT 0xFFFF89E1C58E3800 00058B (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
[    0.418195] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.418195] ACPI: Dynamic OEM Table Load:
[    0.418195] ACPI: SSDT 0xFFFF89E1C56A4000 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
[    0.424797] ACPI: Dynamic OEM Table Load:
[    0.424811] ACPI: SSDT 0xFFFF89E1C570F540 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
[    0.424811] ACPI: Dynamic OEM Table Load:
[    0.424811] ACPI: SSDT 0xFFFF89E1C58E2000 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
[    0.428493] ACPI: Dynamic OEM Table Load:
[    0.428513] ACPI: SSDT 0xFFFF89E1C5933000 000D14 (v02 PmRef  ApIst    00003000 INTL 20160527)
[    0.437866] ACPI: Dynamic OEM Table Load:
[    0.437880] ACPI: SSDT 0xFFFF89E1C56A5000 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
[    0.441533] ACPI: Dynamic OEM Table Load:
[    0.441546] ACPI: SSDT 0xFFFF89E1C56A4800 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
[    0.451514] ACPI: Interpreter enabled
[    0.451614] ACPI: (supports S0 S3 S4 S5)
[    0.451615] ACPI: Using IOAPIC for interrupt routing
[    0.451697] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.453243] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.461664] ACPI: Power Resource [PUBS] (on)
[    0.462176] acpi PNP0C0A:01: ACPI dock station (docks/bays count: 1)
[    0.492201] ACPI: Power Resource [PC01] (on)
[    0.526759] ACPI: Power Resource [WRST] (on)
[    0.526759] ACPI: Power Resource [PXP] (on)
[    0.564576] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    0.564586] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.568972] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.571399] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
[    0.575736] PCI host bridge to bus 0000:00
[    0.575740] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.575742] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.575744] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.575745] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    0.575747] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.575749] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    0.575750] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    0.575752] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.575753] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.575755] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.575756] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.575758] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    0.575759] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    0.575761] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[    0.575762] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[    0.575764] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[    0.575765] pci_bus 0000:00: root bus resource [mem 0x6f800000-0xefffffff window]
[    0.575767] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    0.575769] pci_bus 0000:00: root bus resource [bus 00-7e]
[    0.575791] pci 0000:00:00.0: [8086:5914] type 00 class 0x060000
[    0.577545] pci 0000:00:02.0: [8086:5917] type 00 class 0x030000
[    0.577561] pci 0000:00:02.0: reg 0x10: [mem 0xe7000000-0xe7ffffff 64bit]
[    0.577571] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.577578] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.577607] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.579381] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.579396] pci 0000:00:04.0: reg 0x10: [mem 0xe9240000-0xe9247fff 64bit]
[    0.581325] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.581342] pci 0000:00:08.0: reg 0x10: [mem 0xe9250000-0xe9250fff 64bit]
[    0.583106] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.583129] pci 0000:00:14.0: reg 0x10: [mem 0xe9220000-0xe922ffff 64bit]
[    0.583214] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.585177] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.585200] pci 0000:00:14.2: reg 0x10: [mem 0xe9251000-0xe9251fff 64bit]
[    0.587109] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.587317] pci 0000:00:15.0: reg 0x10: [mem 0xe9252000-0xe9252fff 64bit]
[    0.590026] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.590065] pci 0000:00:16.0: reg 0x10: [mem 0xe9253000-0xe9253fff 64bit]
[    0.590206] pci 0000:00:16.0: PME# supported from D3hot
[    0.592095] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.592202] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.594135] pci 0000:00:1c.6: [8086:9d16] type 01 class 0x060400
[    0.594252] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.594252] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.594252] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.595774] pci 0000:00:1d.2: [8086:9d1a] type 01 class 0x060400
[    0.595878] pci 0000:00:1d.2: PME# supported from D0 D3hot D3cold
[    0.601799] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.603765] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.603782] pci 0000:00:1f.2: reg 0x10: [mem 0xe924c000-0xe924ffff]
[    0.605679] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.605709] pci 0000:00:1f.3: reg 0x10: [mem 0xe9248000-0xe924bfff 64bit]
[    0.605750] pci 0000:00:1f.3: reg 0x20: [mem 0xe9230000-0xe923ffff 64bit]
[    0.605816] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.607692] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.607744] pci 0000:00:1f.4: reg 0x10: [mem 0xe9254000-0xe92540ff 64bit]
[    0.607796] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.607796] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
[    0.607796] pci 0000:00:1f.6: reg 0x10: [mem 0xe9200000-0xe921ffff]
[    0.607796] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.607796] pci 0000:02:00.0: [10de:1d10] type 00 class 0x030200
[    0.607796] pci 0000:02:00.0: reg 0x10: [mem 0xe8000000-0xe8ffffff]
[    0.607811] pci 0000:02:00.0: reg 0x14: [mem 0x70000000-0x7fffffff 64bit pref]
[    0.607827] pci 0000:02:00.0: reg 0x1c: [mem 0x80000000-0x81ffffff 64bit pref]
[    0.607837] pci 0000:02:00.0: reg 0x24: [io  0xd000-0xd07f]
[    0.607848] pci 0000:02:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    0.607879] pci 0000:02:00.0: Enabling HDA controller
[    0.612301] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.612305] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.612309] pci 0000:00:1c.0:   bridge window [mem 0xe8000000-0xe8ffffff]
[    0.612315] pci 0000:00:1c.0:   bridge window [mem 0x70000000-0x81ffffff 64bit pref]
[    0.612791] pci 0000:04:00.0: [8086:24fd] type 00 class 0x028000
[    0.612884] pci 0000:04:00.0: reg 0x10: [mem 0xe9100000-0xe9101fff 64bit]
[    0.613468] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.614679] pci 0000:00:1c.6: PCI bridge to [bus 04]
[    0.614685] pci 0000:00:1c.6:   bridge window [mem 0xe9100000-0xe91fffff]
[    0.614786] pci 0000:07:00.0: [8086:15c0] type 01 class 0x060400
[    0.614850] pci 0000:07:00.0: enabling Extended Tags
[    0.614955] pci 0000:07:00.0: supports D1 D2
[    0.614957] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.615159] pci 0000:00:1d.0: PCI bridge to [bus 07-3f]
[    0.615165] pci 0000:00:1d.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.615171] pci 0000:00:1d.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.615273] pci 0000:08:00.0: [8086:15c0] type 01 class 0x060400
[    0.615341] pci 0000:08:00.0: enabling Extended Tags
[    0.615448] pci 0000:08:00.0: supports D1 D2
[    0.615449] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.615607] pci 0000:08:01.0: [8086:15c0] type 01 class 0x060400
[    0.615675] pci 0000:08:01.0: enabling Extended Tags
[    0.615785] pci 0000:08:01.0: supports D1 D2
[    0.615787] pci 0000:08:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.615941] pci 0000:08:02.0: [8086:15c0] type 01 class 0x060400
[    0.616010] pci 0000:08:02.0: enabling Extended Tags
[    0.616116] pci 0000:08:02.0: supports D1 D2
[    0.616118] pci 0000:08:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.616307] pci 0000:07:00.0: PCI bridge to [bus 08-3f]
[    0.616318] pci 0000:07:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.616325] pci 0000:07:00.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.616410] pci 0000:09:00.0: [8086:15bf] type 00 class 0x088000
[    0.616435] pci 0000:09:00.0: reg 0x10: [mem 0xe6000000-0xe603ffff]
[    0.616450] pci 0000:09:00.0: reg 0x14: [mem 0xe6040000-0xe6040fff]
[    0.616523] pci 0000:09:00.0: enabling Extended Tags
[    0.616646] pci 0000:09:00.0: supports D1 D2
[    0.616648] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.616843] pci 0000:08:00.0: PCI bridge to [bus 09]
[    0.616854] pci 0000:08:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.616915] pci 0000:08:01.0: PCI bridge to [bus 0a-3e]
[    0.616926] pci 0000:08:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.616933] pci 0000:08:01.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.617041] pci 0000:3f:00.0: [8086:15c1] type 00 class 0x0c0330
[    0.617067] pci 0000:3f:00.0: reg 0x10: [mem 0xe5f00000-0xe5f0ffff]
[    0.617159] pci 0000:3f:00.0: enabling Extended Tags
[    0.617286] pci 0000:3f:00.0: supports D1 D2
[    0.617287] pci 0000:3f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.617386] pci 0000:3f:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:08:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.617533] pci 0000:08:02.0: PCI bridge to [bus 3f]
[    0.617544] pci 0000:08:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.617866] pci 0000:40:00.0: [17aa:0003] type 00 class 0x010802
[    0.617891] pci 0000:40:00.0: reg 0x10: [mem 0xe9000000-0xe9003fff 64bit]
[    0.618094] pci 0000:40:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1d.2 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.618326] pci 0000:00:1d.2: PCI bridge to [bus 40]
[    0.618332] pci 0000:00:1d.2:   bridge window [mem 0xe9000000-0xe90fffff]
[    0.620664] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.620784] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.620899] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.621013] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.621127] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.621241] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.621361] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.621474] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.623989] ACPI: EC: interrupt unblocked
[    0.623989] ACPI: EC: event unblocked
[    0.623989] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.623989] ACPI: EC: GPE=0x16
[    0.623989] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.623989] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.624007] iommu: Default domain type: Translated 
[    0.624014] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=mem,locks=none
[    0.624014] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.624014] pci 0000:00:02.0: vgaarb: setting as boot device
[    0.624014] vgaarb: loaded
[    0.624280] SCSI subsystem initialized
[    0.624309] libata version 3.00 loaded.
[    0.624309] ACPI: bus type USB registered
[    0.624309] usbcore: registered new interface driver usbfs
[    0.624309] usbcore: registered new interface driver hub
[    0.624309] usbcore: registered new device driver usb
[    0.624309] pps_core: LinuxPPS API ver. 1 registered
[    0.624309] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.624309] PTP clock support registered
[    0.624309] EDAC MC: Ver: 3.0.0
[    0.628511] Registered efivars operations
[    0.628511] NetLabel: Initializing
[    0.628511] NetLabel:  domain hash size = 128
[    0.628511] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.628511] NetLabel:  unlabeled traffic allowed by default
[    0.628511] PCI: Using ACPI for IRQ routing
[    0.635982] PCI: pci_cache_line_size set to 64 bytes
[    0.639984] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.639984] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    0.639984] e820: reserve RAM buffer [mem 0x4f249000-0x4fffffff]
[    0.639984] e820: reserve RAM buffer [mem 0x4fee5000-0x4fffffff]
[    0.639984] e820: reserve RAM buffer [mem 0x5eaac000-0x5fffffff]
[    0.639984] e820: reserve RAM buffer [mem 0x62211000-0x63ffffff]
[    0.639984] e820: reserve RAM buffer [mem 0x6841a000-0x6bffffff]
[    0.639984] e820: reserve RAM buffer [mem 0x69600000-0x6bffffff]
[    0.639984] e820: reserve RAM buffer [mem 0x28f800000-0x28fffffff]
[    0.641399] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.641405] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.643471] clocksource: Switched to clocksource tsc-early
[    0.662179] VFS: Disk quotas dquot_6.6.0
[    0.662204] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.662388] AppArmor: AppArmor Filesystem Enabled
[    0.662443] pnp: PnP ACPI init
[    0.662639] system 00:00: [mem 0x40000000-0x403fffff] has been reserved
[    0.662648] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.662978] system 00:01: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.662980] system 00:01: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.662982] system 00:01: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.662985] system 00:01: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.662987] system 00:01: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.662989] system 00:01: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.662991] system 00:01: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.662997] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.663713] system 00:02: [io  0xff00-0xfffe] has been reserved
[    0.663719] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.664860] system 00:03: [io  0x0680-0x069f] has been reserved
[    0.664862] system 00:03: [io  0xffff] has been reserved
[    0.664864] system 00:03: [io  0xffff] has been reserved
[    0.664866] system 00:03: [io  0xffff] has been reserved
[    0.664869] system 00:03: [io  0x1800-0x18fe] has been reserved
[    0.664870] system 00:03: [io  0x164e-0x164f] has been reserved
[    0.664877] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.665106] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.665193] system 00:05: [io  0x1854-0x1857] has been reserved
[    0.665199] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.665234] pnp 00:06: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
[    0.665264] pnp 00:07: Plug and Play ACPI device, IDs LEN009b PNP0f13 (active)
[    0.665499] system 00:08: [io  0x1800-0x189f] could not be reserved
[    0.665501] system 00:08: [io  0x0800-0x087f] has been reserved
[    0.665504] system 00:08: [io  0x0880-0x08ff] has been reserved
[    0.665506] system 00:08: [io  0x0900-0x097f] has been reserved
[    0.665508] system 00:08: [io  0x0980-0x09ff] has been reserved
[    0.665510] system 00:08: [io  0x0a00-0x0a7f] has been reserved
[    0.665512] system 00:08: [io  0x0a80-0x0aff] has been reserved
[    0.665514] system 00:08: [io  0x0b00-0x0b7f] has been reserved
[    0.665516] system 00:08: [io  0x0b80-0x0bff] has been reserved
[    0.665518] system 00:08: [io  0x15e0-0x15ef] has been reserved
[    0.665520] system 00:08: [io  0x1600-0x167f] could not be reserved
[    0.665522] system 00:08: [io  0x1640-0x165f] could not be reserved
[    0.665525] system 00:08: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.665529] system 00:08: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.665531] system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.665533] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.665535] system 00:08: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.665537] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.665540] system 00:08: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.665542] system 00:08: [mem 0xeffe0000-0xefffffff] has been reserved
[    0.665549] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.668413] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.670496] system 00:0a: [mem 0xfed10000-0xfed17fff] could not be reserved
[    0.670499] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.670501] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.670503] system 00:0a: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.670505] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.670507] system 00:0a: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.670509] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.670511] system 00:0a: [mem 0xff000000-0xffffffff] has been reserved
[    0.670513] system 00:0a: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.670516] system 00:0a: [mem 0xeffe0000-0xefffffff] has been reserved
[    0.670522] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.671214] system 00:0b: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.671217] system 00:0b: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.671219] system 00:0b: [mem 0x00100000-0x6f7fffff] could not be reserved
[    0.671222] system 00:0b: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.671224] system 00:0b: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.671230] system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.671542] pnp: PnP ACPI: found 12 devices
[    0.678213] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.678316] NET: Registered protocol family 2
[    0.678514] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.678604] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.678832] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.678992] TCP: Hash tables configured (established 65536 bind 65536)
[    0.679058] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.679100] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.679184] NET: Registered protocol family 1
[    0.679190] NET: Registered protocol family 44
[    0.679198] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[    0.679209] pci 0000:08:01.0: bridge window [io  0x1000-0x0fff] to [bus 0a-3e] add_size 1000
[    0.679214] pci 0000:07:00.0: bridge window [io  0x1000-0x0fff] to [bus 08-3f] add_size 1000
[    0.679216] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 07-3f] add_size 2000
[    0.679226] pci 0000:00:1d.0: BAR 13: assigned [io  0x2000-0x3fff]
[    0.679232] pci 0000:02:00.0: BAR 6: no space for [mem size 0x00080000 pref]
[    0.679234] pci 0000:02:00.0: BAR 6: failed to assign [mem size 0x00080000 pref]
[    0.679237] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.679240] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.679246] pci 0000:00:1c.0:   bridge window [mem 0xe8000000-0xe8ffffff]
[    0.679250] pci 0000:00:1c.0:   bridge window [mem 0x70000000-0x81ffffff 64bit pref]
[    0.679256] pci 0000:00:1c.6: PCI bridge to [bus 04]
[    0.679263] pci 0000:00:1c.6:   bridge window [mem 0xe9100000-0xe91fffff]
[    0.679273] pci 0000:07:00.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.679276] pci 0000:08:01.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.679278] pci 0000:08:00.0: PCI bridge to [bus 09]
[    0.679285] pci 0000:08:00.0:   bridge window [mem 0xe6000000-0xe60fffff]
[    0.679296] pci 0000:08:01.0: PCI bridge to [bus 0a-3e]
[    0.679299] pci 0000:08:01.0:   bridge window [io  0x2000-0x2fff]
[    0.679306] pci 0000:08:01.0:   bridge window [mem 0xd0000000-0xe5efffff]
[    0.679310] pci 0000:08:01.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.679318] pci 0000:08:02.0: PCI bridge to [bus 3f]
[    0.679325] pci 0000:08:02.0:   bridge window [mem 0xe5f00000-0xe5ffffff]
[    0.679336] pci 0000:07:00.0: PCI bridge to [bus 08-3f]
[    0.679339] pci 0000:07:00.0:   bridge window [io  0x2000-0x2fff]
[    0.679345] pci 0000:07:00.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.679350] pci 0000:07:00.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.679357] pci 0000:00:1d.0: PCI bridge to [bus 07-3f]
[    0.679360] pci 0000:00:1d.0:   bridge window [io  0x2000-0x3fff]
[    0.679364] pci 0000:00:1d.0:   bridge window [mem 0xd0000000-0xe60fffff]
[    0.679368] pci 0000:00:1d.0:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.679374] pci 0000:00:1d.2: PCI bridge to [bus 40]
[    0.679379] pci 0000:00:1d.2:   bridge window [mem 0xe9000000-0xe90fffff]
[    0.679388] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.679390] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.679392] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.679394] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.679396] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.679398] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.679399] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.679401] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.679403] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.679404] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.679406] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.679408] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    0.679409] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    0.679411] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    0.679413] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    0.679414] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
[    0.679416] pci_bus 0000:00: resource 20 [mem 0x6f800000-0xefffffff window]
[    0.679418] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff window]
[    0.679420] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.679422] pci_bus 0000:02: resource 1 [mem 0xe8000000-0xe8ffffff]
[    0.679423] pci_bus 0000:02: resource 2 [mem 0x70000000-0x81ffffff 64bit pref]
[    0.679425] pci_bus 0000:04: resource 1 [mem 0xe9100000-0xe91fffff]
[    0.679427] pci_bus 0000:07: resource 0 [io  0x2000-0x3fff]
[    0.679429] pci_bus 0000:07: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.679430] pci_bus 0000:07: resource 2 [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.679432] pci_bus 0000:08: resource 0 [io  0x2000-0x2fff]
[    0.679434] pci_bus 0000:08: resource 1 [mem 0xd0000000-0xe60fffff]
[    0.679435] pci_bus 0000:08: resource 2 [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.679437] pci_bus 0000:09: resource 1 [mem 0xe6000000-0xe60fffff]
[    0.679440] pci_bus 0000:0a: resource 0 [io  0x2000-0x2fff]
[    0.679442] pci_bus 0000:0a: resource 1 [mem 0xd0000000-0xe5efffff]
[    0.679443] pci_bus 0000:0a: resource 2 [mem 0x90000000-0xb1ffffff 64bit pref]
[    0.679445] pci_bus 0000:3f: resource 1 [mem 0xe5f00000-0xe5ffffff]
[    0.679447] pci_bus 0000:40: resource 1 [mem 0xe9000000-0xe90fffff]
[    0.679772] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.681476] PCI: CLS 128 bytes, default 64
[    0.681538] Unpacking initramfs...
[    0.723769] Initramfs unpacking failed: Decoding failed
[    0.723785] fbcon: Taking over console
[    0.726544] Freeing initrd memory: 13480K
[    0.726619] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.726621] software IO TLB: mapped [mem 0x63ac5000-0x67ac5000] (64MB)
[    0.726812] resource sanity check: requesting [mem 0xfed10000-0xfed15fff], which spans more than pnp 00:08 [mem 0xfed10000-0xfed13fff]
[    0.726820] caller snb_uncore_imc_init_box+0x78/0xc0 mapping multiple BARs
[    0.727266] check: Scanning for low memory corruption every 60 seconds
[    0.728178] Initialise system trusted keyrings
[    0.728210] Key type blacklist registered
[    0.728279] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    0.730455] zbud: loaded
[    0.730951] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.731187] fuse: init (API version 7.31)
[    0.731473] integrity: Platform Keyring initialized
[    0.748948] Key type asymmetric registered
[    0.748950] Asymmetric key parser 'x509' registered
[    0.748964] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.749033] io scheduler mq-deadline registered
[    0.749685] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.750071] pcieport 0000:00:1c.6: PME: Signaling with IRQ 123
[    0.750230] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.750264] pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.750707] pcieport 0000:00:1d.2: PME: Signaling with IRQ 125
[    0.751333] pcieport 0000:08:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.751763] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.751869] efifb: probing for efifb
[    0.751915] efifb: showing boot graphics
[    0.753709] efifb: framebuffer at 0xc0000000, using 8100k, total 8100k
[    0.753711] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    0.753712] efifb: scrolling: redraw
[    0.753714] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.753849] Console: switching to colour frame buffer device 240x67
[    0.763827] fb0: EFI VGA frame buffer device
[    0.763842] intel_idle: MWAIT substates: 0x11142120
[    0.763843] intel_idle: v0.5.1 model 0x8E
[    0.764632] intel_idle: Local APIC timer is reliable in all C-states
[    0.765269] ACPI: AC Adapter [AC] (off-line)
[    0.765439] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.765495] ACPI: Sleep Button [SLPB]
[    0.765548] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    0.765585] ACPI: Lid Switch [LID]
[    0.765635] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.765671] ACPI: Power Button [PWRF]
[    0.773085] thermal LNXTHERM:00: registered as thermal_zone0
[    0.773087] ACPI: Thermal Zone [THM0] (41 C)
[    0.773506] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.777417] Linux agpgart interface v0.103
[    0.780257] tpm_tis STM7304:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    0.804811] battery: ACPI: Battery Slot [BAT0] (battery present)
[    0.810760] loop: module loaded
[    0.811273] libphy: Fixed MDIO Bus: probed
[    0.811274] tun: Universal TUN/TAP device driver, 1.6
[    0.811403] PPP generic driver version 2.4.2
[    0.811601] VFIO - User Level meta-driver version: 0.3
[    0.811759] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.811764] ehci-pci: EHCI PCI platform driver
[    0.811785] ehci-platform: EHCI generic platform driver
[    0.811808] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.811817] ohci-pci: OHCI PCI platform driver
[    0.811833] ohci-platform: OHCI generic platform driver
[    0.811851] uhci_hcd: USB Universal Host Controller Interface driver
[    0.812256] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.812266] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.813437] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    0.813808] xhci_hcd 0000:00:14.0: cache line size of 128 is not supported
[    0.814165] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.09
[    0.814168] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.814170] usb usb1: Product: xHCI Host Controller
[    0.814172] usb usb1: Manufacturer: Linux 5.9.0+ xhci-hcd
[    0.814174] usb usb1: SerialNumber: 0000:00:14.0
[    0.814406] hub 1-0:1.0: USB hub found
[    0.814439] hub 1-0:1.0: 12 ports detected
[    0.816950] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.816955] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.816960] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    0.817023] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.09
[    0.817025] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.817027] usb usb2: Product: xHCI Host Controller
[    0.817028] usb usb2: Manufacturer: Linux 5.9.0+ xhci-hcd
[    0.817030] usb usb2: SerialNumber: 0000:00:14.0
[    0.817245] hub 2-0:1.0: USB hub found
[    0.817272] hub 2-0:1.0: 6 ports detected
[    0.818442] usb: port power management may be unreliable
[    0.819040] xhci_hcd 0000:3f:00.0: xHCI Host Controller
[    0.819047] xhci_hcd 0000:3f:00.0: new USB bus registered, assigned bus number 3
[    0.820273] xhci_hcd 0000:3f:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000000009810
[    0.820664] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.09
[    0.820666] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.820668] usb usb3: Product: xHCI Host Controller
[    0.820670] usb usb3: Manufacturer: Linux 5.9.0+ xhci-hcd
[    0.820672] usb usb3: SerialNumber: 0000:3f:00.0
[    0.820954] hub 3-0:1.0: USB hub found
[    0.820969] hub 3-0:1.0: 2 ports detected
[    0.822046] xhci_hcd 0000:3f:00.0: xHCI Host Controller
[    0.822052] xhci_hcd 0000:3f:00.0: new USB bus registered, assigned bus number 4
[    0.822056] xhci_hcd 0000:3f:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    0.822114] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.09
[    0.822116] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.822117] usb usb4: Product: xHCI Host Controller
[    0.822119] usb usb4: Manufacturer: Linux 5.9.0+ xhci-hcd
[    0.822121] usb usb4: SerialNumber: 0000:3f:00.0
[    0.822335] hub 4-0:1.0: USB hub found
[    0.822347] hub 4-0:1.0: 2 ports detected
[    0.823251] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.825942] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.825949] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.826265] mousedev: PS/2 mouse device common for all mice
[    0.826767] rtc_cmos 00:04: RTC can wake from S4
[    0.827550] rtc_cmos 00:04: registered as rtc0
[    0.827800] rtc_cmos 00:04: setting system clock to 2020-10-30T06:30:56 UTC (1604039456)
[    0.827857] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.827870] i2c /dev entries driver
[    0.827944] device-mapper: uevent: version 1.0.3
[    0.828174] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[    0.828220] platform eisa.0: Probing EISA bus 0
[    0.828242] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.828244] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.828246] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.828248] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.828249] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.828251] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.828253] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.828255] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.828256] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.828258] platform eisa.0: EISA: Detected 0 cards
[    0.828262] intel_pstate: Intel P-state driver initializing
[    0.828623] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.829362] intel_pstate: HWP enabled
[    0.829898] ledtrig-cpu: registered to indicate activity on CPUs
[    0.829901] EFI Variables Facility v0.08 2004-May-17
[    0.838286] battery: ACPI: Battery Slot [BAT1] (battery present)
[    0.880139] intel_pmc_core INT33A1:00:  initialized
[    0.880205] drop_monitor: Initializing network drop monitor service
[    0.880322] NET: Registered protocol family 10
[    0.887116] Segment Routing with IPv6
[    0.887133] NET: Registered protocol family 17
[    0.887250] Key type dns_resolver registered
[    0.887626] microcode: sig=0x806ea, pf=0x80, revision=0xd6
[    0.887666] microcode: Microcode Update Driver: v2.2.
[    0.887669] IPI shorthand broadcast: enabled
[    0.887676] sched_clock: Marking stable (886500827, 1162293)->(897701991, -10038871)
[    0.887728] registered taskstats version 1
[    0.887737] Loading compiled-in X.509 certificates
[    0.888237] Loaded X.509 cert 'Build time autogenerated kernel key: 54aec3f9a7a83dc4da728839484e01ad5628cca8'
[    0.888265] zswap: loaded using pool lzo/zbud
[    0.888403] Key type ._fscrypt registered
[    0.888404] Key type .fscrypt registered
[    0.888404] Key type fscrypt-provisioning registered
[    0.888452] Key type trusted registered
[    0.891406] Key type encrypted registered
[    0.891408] AppArmor: AppArmor sha1 policy hashing enabled
[    0.892835] integrity: Loading X.509 certificate: UEFI:MokListRT
[    0.892856] integrity: Loaded X.509 cert 'SomeOrg: shim: a01ee84e9b37ace407961cc468c5909447878469'
[    0.892856] integrity: Loading X.509 certificate: UEFI:MokListRT
[    0.893428] integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    0.893820] ima: Allocated hash algorithm: sha1
[    0.928545] ima: No architecture policies found
[    0.928564] evm: Initialising EVM extended attributes:
[    0.928564] evm: security.selinux
[    0.928565] evm: security.SMACK64
[    0.928565] evm: security.SMACK64EXEC
[    0.928565] evm: security.SMACK64TRANSMUTE
[    0.928566] evm: security.SMACK64MMAP
[    0.928566] evm: security.apparmor
[    0.928566] evm: security.ima
[    0.928566] evm: security.capability
[    0.928567] evm: HMAC attrs: 0x1
[    0.929795] PM:   Magic number: 8:392:520
[    0.930035] RAS: Correctable Errors collector initialized.
[    0.930933] Freeing unused decrypted memory: 2040K
[    0.931293] Freeing unused kernel image (initmem) memory: 2568K
[    1.016406] Write protecting the kernel read-only data: 22528k
[    1.016983] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.017354] Freeing unused kernel image (rodata/data gap) memory: 1360K
[    1.062780] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.062781] x86/mm: Checking user space page tables
[    1.106749] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.106753] Run /init as init process
[    1.106754]   with arguments:
[    1.106754]     /init
[    1.106755]     splash
[    1.106755]   with environment:
[    1.106755]     HOME=/
[    1.106756]     TERM=linux
[    1.106756]     BOOT_IMAGE=/@/boot/vmlinuz-5.9.0+
[    1.152050] usb 1-7: new full-speed USB device number 2 using xhci_hcd
[    1.195080] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    1.195320] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.198994] nvme nvme0: pci function 0000:40:00.0
[    1.199626] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    1.200389] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    1.200420] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    1.203929] e1000e: Intel(R) PRO/1000 Network Driver
[    1.203930] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.204463] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    1.211311] i2c i2c-0: 1/2 memory slots populated (from DMI)
[    1.211672] i2c i2c-0: Successfully instantiated SPD at 0x50
[    1.213566] nvme nvme0: 8/0/0 default/read/poll queues
[    1.221101]  nvme0n1: p1 p2
[    1.301266] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2b, bcdDevice= 0.10
[    1.301267] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.428277] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    1.451435] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    1.460566] usb 2-3: New USB device found, idVendor=0bda, idProduct=0316, bcdDevice= 2.04
[    1.460567] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.460568] usb 2-3: Product: USB3.0-CRW
[    1.460569] usb 2-3: Manufacturer: Generic
[    1.460569] usb 2-3: SerialNumber: 20120501030900000
[    1.471780] usb-storage 2-3:1.0: USB Mass Storage device detected
[    1.471904] scsi host0: usb-storage 2-3:1.0
[    1.471995] usbcore: registered new interface driver usb-storage
[    1.472879] usbcore: registered new interface driver uas
[    1.522240] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 54:ee:75:e8:57:0d
[    1.522241] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    1.522312] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: 1000FF-0FF
[    1.523080] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    1.576302] usb 1-8: new high-speed USB device number 3 using xhci_hcd
[    1.748222] tsc: Refined TSC clocksource calibration: 1799.990 MHz
[    1.748226] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x19f22049b0a, max_idle_ns: 440795294996 ns
[    1.748408] clocksource: Switched to clocksource tsc
[    1.761978] usb 1-8: New USB device found, idVendor=13d3, idProduct=56a6, bcdDevice=17.11
[    1.761980] usb 1-8: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    1.761980] usb 1-8: Product: Integrated Camera
[    1.761981] usb 1-8: Manufacturer: Azurewave
[    1.761982] usb 1-8: SerialNumber: 0001
[    1.892082] usb 1-9: new full-speed USB device number 4 using xhci_hcd
[    2.025038] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4690]
[    2.042550] usb 1-9: New USB device found, idVendor=06cb, idProduct=009a, bcdDevice= 1.64
[    2.042551] usb 1-9: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    2.042552] usb 1-9: SerialNumber: 8d97a807073f
[    2.060131] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
[    2.060137] psmouse serio1: synaptics: Trying to set up SMBus access
[    2.140034] raid6: avx2x4   gen() 30510 MB/s
[    2.208035] raid6: avx2x4   xor()  7715 MB/s
[    2.276034] raid6: avx2x2   gen() 34747 MB/s
[    2.344036] raid6: avx2x2   xor() 22058 MB/s
[    2.412036] raid6: avx2x1   gen() 29969 MB/s
[    2.480035] raid6: avx2x1   xor() 19041 MB/s
[    2.490022] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
[    2.490240] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.548034] raid6: sse2x4   gen() 14482 MB/s
[    2.616037] raid6: sse2x4   xor()  7716 MB/s
[    2.684037] raid6: sse2x2   gen() 14790 MB/s
[    2.752037] raid6: sse2x2   xor()  9425 MB/s
[    2.820034] raid6: sse2x1   gen() 11102 MB/s
[    2.888036] raid6: sse2x1   xor()  6436 MB/s
[    2.888037] raid6: using algorithm avx2x2 gen() 34747 MB/s
[    2.888037] raid6: .... xor() 22058 MB/s, rmw enabled
[    2.888038] raid6: using avx2x2 recovery algorithm
[    2.890242] xor: automatically using best checksumming function   avx       
[    2.906471] Btrfs loaded, crc32c=crc32c-intel
[    2.917413] BTRFS: device fsid 523fd023-8a9d-45cc-90fc-7823d5a8636f devid 1 transid 28763 /dev/nvme0n1p2 scanned by btrfs (237)
[    2.933410] BTRFS info (device nvme0n1p2): disk space caching is enabled
[    2.933411] BTRFS info (device nvme0n1p2): has skinny extents
[    2.937368] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    2.946483] BTRFS info (device nvme0n1p2): enabling ssd optimizations
[    3.041197] systemd[1]: Inserted module 'autofs4'
[    3.146707] systemd[1]: systemd 246.6-1ubuntu1 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.164469] systemd[1]: Detected architecture x86-64.
[    3.180951] systemd[1]: Set hostname to <ThinkPad-T580>.
[    3.260977] systemd[1]: /lib/systemd/system/dbus.service:12: Unit configured to use KillMode=none. This is unsafe, as it disables systemd's process lifecycle management for the service. Please update your service to use a safer KillMode=, such as 'mixed' or 'control-group'. Support for KillMode=none is deprecated and will eventually be removed.
[    3.278390] systemd[1]: /lib/systemd/system/plymouth-start.service:17: Unit configured to use KillMode=none. This is unsafe, as it disables systemd's process lifecycle management for the service. Please update your service to use a safer KillMode=, such as 'mixed' or 'control-group'. Support for KillMode=none is deprecated and will eventually be removed.
[    3.292693] systemd[1]: Queued start job for default target Graphical Interface.
[    3.293724] systemd[1]: Created slice system-modprobe.slice.
[    3.293899] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    3.294045] systemd[1]: Created slice User and Session Slice.
[    3.294099] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.294137] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
[    3.294185] systemd[1]: Reached target Remote File Systems.
[    3.294197] systemd[1]: Reached target Slices.
[    3.294762] systemd[1]: Listening on Syslog Socket.
[    3.294839] systemd[1]: Listening on fsck to fsckd communication Socket.
[    3.294896] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    3.295036] systemd[1]: Listening on Journal Audit Socket.
[    3.295105] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.295187] systemd[1]: Listening on Journal Socket.
[    3.295303] systemd[1]: Listening on udev Control Socket.
[    3.295381] systemd[1]: Listening on udev Kernel Socket.
[    3.296107] systemd[1]: Mounting Huge Pages File System...
[    3.296776] systemd[1]: Mounting POSIX Message Queue File System...
[    3.297610] systemd[1]: Mounting Kernel Debug File System...
[    3.298408] systemd[1]: Mounting Kernel Trace File System...
[    3.299803] systemd[1]: Starting Journal Service...
[    3.300843] systemd[1]: Starting Set the console keyboard layout...
[    3.301792] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    3.302541] systemd[1]: Starting Load Kernel Module drm...
[    3.303039] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    3.303081] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    3.304396] systemd[1]: Starting Load Kernel Modules...
[    3.305213] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.306249] systemd[1]: Starting Coldplug All udev Devices...
[    3.307511] systemd[1]: Starting Uncomplicated firewall...
[    3.309752] systemd[1]: Mounted Huge Pages File System.
[    3.309858] systemd[1]: Mounted POSIX Message Queue File System.
[    3.309937] systemd[1]: Mounted Kernel Debug File System.
[    3.310011] systemd[1]: Mounted Kernel Trace File System.
[    3.310439] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    3.311140] systemd[1]: Finished Uncomplicated firewall.
[    3.312923] BTRFS info (device nvme0n1p2): disk space caching is enabled
[    3.314515] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.315380] systemd[1]: Activating swap /swapfile...
[    3.315899] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    3.315979] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[    3.316912] systemd[1]: Starting Load/Save Random Seed...
[    3.317802] systemd[1]: Starting Create System Users...
[    3.318170] systemd[1]: modprobe@drm.service: Succeeded.
[    3.318628] systemd[1]: Finished Load Kernel Module drm.
[    3.320216] BTRFS warning (device nvme0n1p2): swapfile must not be copy-on-write
[    3.320878] lp: driver loaded but no devices found
[    3.320983] systemd[1]: swapfile.swap: Swap process exited, code=exited, status=255/EXCEPTION
[    3.320989] systemd[1]: swapfile.swap: Failed with result 'exit-code'.
[    3.321419] systemd[1]: Failed to activate swap /swapfile.
[    3.321517] systemd[1]: Dependency failed for Swap.
[    3.321593] systemd[1]: swap.target: Job swap.target/start failed with result 'dependency'.
[    3.324889] ppdev: user-space parallel port driver
[    3.328096] systemd[1]: Finished Load/Save Random Seed.
[    3.329004] systemd[1]: Finished Load Kernel Modules.
[    3.330026] systemd[1]: Mounting FUSE Control File System...
[    3.330880] systemd[1]: Mounting Kernel Configuration File System...
[    3.331640] systemd[1]: Starting Apply Kernel Variables...
[    3.333007] systemd[1]: Mounted FUSE Control File System.
[    3.333787] systemd[1]: Mounted Kernel Configuration File System.
[    3.335010] systemd[1]: Finished Create System Users.
[    3.335803] systemd[1]: Starting Create Static Device Nodes in /dev...
[    3.344593] systemd[1]: Finished Apply Kernel Variables.
[    3.345007] systemd[1]: Finished Create Static Device Nodes in /dev.
[    3.346253] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    3.394888] systemd[1]: Finished Coldplug All udev Devices.
[    3.396209] systemd[1]: Finished Set the console keyboard layout.
[    3.396359] systemd[1]: Reached target Local File Systems (Pre).
[    3.397649] systemd[1]: Mounting Mount unit for core, revision 10126...
[    3.398643] systemd[1]: Mounting Mount unit for core, revision 10185...
[    3.400008] systemd[1]: Mounting Mount unit for core18, revision 1885...
[    3.401021] systemd[1]: Mounting Mount unit for core18, revision 1932...
[    3.404532] systemd[1]: Started Journal Service.
[    3.590460] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[    3.590599] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[    3.597083] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    3.603800] nfc: nfc_init: NFC Core ver 0.1
[    3.603819] NET: Registered protocol family 39
[    3.631176] intel_rapl_common: Found RAPL domain package
[    3.631178] intel_rapl_common: Found RAPL domain dram
[    3.646155] proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THERMAL_PCI
[    3.652330] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[    3.654520] mc: Linux media interface: v0.10
[    3.656158] Non-volatile memory driver v1.3
[    3.663984] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.664575] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.666969] Bluetooth: Core ver 2.22
[    3.667022] NET: Registered protocol family 31
[    3.667022] Bluetooth: HCI device and connection manager initialized
[    3.667032] Bluetooth: HCI socket layer initialized
[    3.667037] Bluetooth: L2CAP socket layer initialized
[    3.667041] Bluetooth: SCO socket layer initialized
[    3.672387] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    3.672388] thinkpad_acpi: http://ibm-acpi.sf.net/
[    3.672389] thinkpad_acpi: ThinkPad BIOS N27ET38W (1.24 ), EC N27HT16W
[    3.672390] thinkpad_acpi: Lenovo ThinkPad T580, model 20LAZ3TXCN
[    3.680601] thinkpad_acpi: radio switch found; radios are enabled
[    3.681057] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    3.681058] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    3.681505] BTRFS warning (device nvme0n1p2): swapfile must not be copy-on-write
[    3.683114] videodev: Linux video capture interface: v2.00
[    3.684907] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    3.697564] BTRFS warning (device nvme0n1p2): swapfile must not be copy-on-write
[    3.700879] i915 0000:00:02.0: enabling device (0006 -> 0007)
[    3.701544] checking generic (c0000000 7e9000) vs hw (e7000000 1000000)
[    3.701545] checking generic (c0000000 7e9000) vs hw (c0000000 10000000)
[    3.701546] fb0: switching to inteldrmfb from EFI VGA
[    3.703398] thinkpad_acpi: battery 2 registered (start 0, stop 100)
[    3.704785] Console: switching to colour dummy device 80x25
[    3.704828] i915 0000:00:02.0: vgaarb: deactivate vga console
[    3.707504] thinkpad_acpi: battery 1 registered (start 0, stop 100)
[    3.707509] battery: new extension: ThinkPad Battery Extension
[    3.708235] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input6
[    3.710915] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=mem
[    3.712147] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    3.713364] Intel(R) Wireless WiFi driver for Linux
[    3.716862] rmi4_smbus 0-002c: registering SMbus-connected sensor
[    3.725357] usbcore: registered new interface driver btusb
[    3.727745] Bluetooth: hci0: Firmware revision 0.1 build 50 week 12 2019
[    3.728143] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    3.728144] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.728145] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.728146] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.728146] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    3.728147] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    3.730576] cryptd: max_cpu_qlen set to 1000
[    3.734877] iwlwifi 0000:04:00.0: loaded firmware version 36.ad812ee0.0 8265-36.ucode op_mode iwlmvm
[    3.736637] uvcvideo: Found UVC 1.00 device Integrated Camera (13d3:56a6)
[    3.742431] AVX2 version of gcm_enc/dec engaged.
[    3.742433] AES CTR mode by8 optimization enabled
[    3.746467] uvcvideo 1-8:1.0: Entity type for entity Realtek Extended Controls Unit was not initialized!
[    3.746469] uvcvideo 1-8:1.0: Entity type for entity Extension 4 was not initialized!
[    3.746470] uvcvideo 1-8:1.0: Entity type for entity Processing 2 was not initialized!
[    3.746471] uvcvideo 1-8:1.0: Entity type for entity Camera 1 was not initialized!
[    3.746554] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/input/input7
[    3.746608] usbcore: registered new interface driver uvcvideo
[    3.746609] USB Video Class driver (1.1.1)
[    3.771273] iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wireless AC 8265, REV=0x230
[    3.832881] iwlwifi 0000:04:00.0: base HW address: e4:70:b8:68:56:9b
[    3.834123] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3276-030, fw id: 2620110
[    3.866971] intel_rapl_common: Found RAPL domain package
[    3.866972] intel_rapl_common: Found RAPL domain core
[    3.866973] intel_rapl_common: Found RAPL domain uncore
[    3.866974] intel_rapl_common: Found RAPL domain dram
[    3.890388] audit: type=1400 audit(1604039459.556:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ippusbxd" pid=534 comm="apparmor_parser"
[    3.898611] audit: type=1400 audit(1604039459.564:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=542 comm="apparmor_parser"
[    3.902689] audit: type=1400 audit(1604039459.568:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=537 comm="apparmor_parser"
[    3.902692] audit: type=1400 audit(1604039459.568:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=537 comm="apparmor_parser"
[    3.902694] audit: type=1400 audit(1604039459.568:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=537 comm="apparmor_parser"
[    3.904795] audit: type=1400 audit(1604039459.572:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=546 comm="apparmor_parser"
[    3.904798] audit: type=1400 audit(1604039459.572:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=546 comm="apparmor_parser"
[    3.908268] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    3.908656] thermal thermal_zone12: failed to read out thermal zone (-61)
[    3.928706] audit: type=1400 audit(1604039459.596:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=532 comm="apparmor_parser"
[    3.929151] audit: type=1400 audit(1604039459.596:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="tcpdump" pid=536 comm="apparmor_parser"
[    3.937777] BTRFS warning (device nvme0n1p2): swapfile must not be copy-on-write
[    3.940686] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[    3.946615] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
[    3.951179] input: Synaptics TM3276-030 as /devices/rmi4-00/input/input8
[    3.964200] serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
[    4.224562] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.224563] Bluetooth: BNEP filters: protocol multicast
[    4.224566] Bluetooth: BNEP socket layer initialized
[    4.229347] NET: Registered protocol family 38
[    4.314119] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
[    4.358742] input: TPPS/2 IBM TrackPoint as /devices/rmi4-00/rmi4-00.fn03/serio2/input/input9
[    5.022712] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 on minor 0
[    5.025367] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    5.025542] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input10
[    5.025728] ACPI: Video Device [PXSX] (multi-head: no  rom: yes  post: no)
[    5.025758] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:35/LNXVIDEO:01/input/input11
[    5.026066] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    5.140894] fbcon: i915drmfb (fb0) is primary device
[    5.152982] Console: switching to colour frame buffer device 240x67
[    5.173585] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    5.215004] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC257: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    5.215006] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.215006] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    5.215007] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    5.215007] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    5.215008] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19
[    5.215009] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[    5.268751] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    5.268806] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    5.268845] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    5.268879] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    5.268913] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    5.268950] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    5.268986] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[    5.344702] kauditd_printk_skb: 35 callbacks suppressed
[    5.344703] audit: type=1400 audit(1604039461.012:46): apparmor="ALLOWED" operation="open" profile="/usr/sbin/sssd" name="/etc/sssd/conf.d/" pid=790 comm="sssd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[    5.344726] audit: type=1400 audit(1604039461.012:47): apparmor="ALLOWED" operation="open" profile="/usr/sbin/sssd" name="/usr/share/sssd/cfg_rules.ini" pid=790 comm="sssd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[    5.760308] audit: type=1400 audit(1604039461.428:48): apparmor="DENIED" operation="capable" profile="/usr/sbin/cups-browsed" pid=812 comm="cups-browsed" capability=23  capname="sys_nice"
[    8.684534] rfkill: input handler disabled
[    8.958232] wlp4s0: authenticate with d8:8f:76:7c:52:a9
[    8.969947] wlp4s0: send auth to d8:8f:76:7c:52:a9 (try 1/3)
[    8.975550] wlp4s0: authenticated
[    8.976079] wlp4s0: associate with d8:8f:76:7c:52:a9 (try 1/3)
[    8.977272] wlp4s0: RX AssocResp from d8:8f:76:7c:52:a9 (capab=0x1011 status=0 aid=5)
[    8.978489] wlp4s0: associated
[    9.002997] IPv6: ADDRCONF(NETDEV_CHANGE): wlp4s0: link becomes ready
[    9.020020] wlp4s0: Limiting TX power to 27 (27 - 0) dBm as advertised by d8:8f:76:7c:52:a9
[   77.397273] Bluetooth: RFCOMM TTY layer initialized
[   77.397283] Bluetooth: RFCOMM socket layer initialized
[   77.397293] Bluetooth: RFCOMM ver 1.11
[   77.572171] rfkill: input handler enabled
[   79.550460] rfkill: input handler disabled

--Apple-Mail=_C2636F85-FEF7-440B-ABCD-E83992764EA9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> 
> Thank you!
> 
> Tyler


--Apple-Mail=_C2636F85-FEF7-440B-ABCD-E83992764EA9--
