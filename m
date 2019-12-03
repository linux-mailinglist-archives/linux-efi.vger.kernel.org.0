Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144C410FCEC
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 12:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfLCLyx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 06:54:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24574 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbfLCLyx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 06:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575374091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aW7ZugmwoIcjuikyDZkzt+LN1JeujEo0YrxdZrd3z4A=;
        b=K2My4Zra8emhqbCnytsr1OpN5wx1NhAULAhkDg+Q257/0TOmdj4kbtRIcrcLosMMMiJzpn
        Mq7ZKT25wqd8i+7UX+mlC2Y4JderVNC37EHbPafEZfbD0uwivEAyazsyVNSCdbzga9F6QO
        O8PbbhULBYaB45faIa4172/5BH8Z+AM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-j1FCUGnRMrGppNhHKyqOxg-1; Tue, 03 Dec 2019 06:54:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6289A107ACC4;
        Tue,  3 Dec 2019 11:54:46 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-100.pek2.redhat.com [10.72.12.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8901F5C290;
        Tue,  3 Dec 2019 11:54:39 +0000 (UTC)
Date:   Tue, 3 Dec 2019 19:54:35 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Michael Weiser <michael@weiser.dinsnail.net>
Cc:     linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191203115435.GA2606@dhcp-128-65.nay.redhat.com>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
 <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
 <20191129152700.GA8286@weiser.dinsnail.net>
 <20191202085829.GA15808@dhcp-128-65.nay.redhat.com>
 <20191202090520.GA15874@dhcp-128-65.nay.redhat.com>
 <20191202234541.GA27567@weiser.dinsnail.net>
MIME-Version: 1.0
In-Reply-To: <20191202234541.GA27567@weiser.dinsnail.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: j1FCUGnRMrGppNhHKyqOxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/03/19 at 12:45am, Michael Weiser wrote:
> Hi Dave,
>=20
> On Mon, Dec 02, 2019 at 05:05:20PM +0800, Dave Young wrote:
>=20
> > > It seems a serious problem, the EFI modified memmap does not get an
> > > /proc/iomem resource update, but kexec_file relies on /proc/iomem in
> > > X86.
> > >=20
> > > There is an question from Sai about why add_efi_memmap is not enabled=
 by
> > > default:
> > > https://www.spinics.net/lists/linux-mm/msg185166.html
>=20
> Incidentally, a data point I did not think to mention: I do boot the
> kernel as EFI application directly from the firmware as a boot entry
> with compiled in initrd and command line:
>=20
> $ grep EFI nobak/kernel/linux/.config
> CONFIG_EFI=3Dy
> CONFIG_EFI_STUB=3Dy
> # CONFIG_EFI_MIXED is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> # EFI (Extensible Firmware Interface) Support
> CONFIG_EFI_VARS=3Dm
> CONFIG_EFI_ESRT=3Dy
> CONFIG_EFI_VARS_PSTORE=3Dm
> # CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
> CONFIG_EFI_RUNTIME_MAP=3Dy
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> # CONFIG_EFI_RCI2_TABLE is not set
> # end of EFI (Extensible Firmware Interface) Support
> CONFIG_UEFI_CPER=3Dy
> CONFIG_UEFI_CPER_X86=3Dy
> CONFIG_EFI_EARLYCON=3Dy
> CONFIG_EFI_PARTITION=3Dy
> CONFIG_FB_EFI=3Dy
> CONFIG_EFIVAR_FS=3Dy
> # CONFIG_EFI_PGT_DUMP is not set
>=20
> $ grep CMDLINE nobak/kernel/linux/.config
> CONFIG_CMDLINE_BOOL=3Dy
> CONFIG_CMDLINE=3D"root=3DUUID=3D97[...]e4 rd.luks.uuid=3D8a[...]c3 rd.luk=
s.allow-discards=3D8a[...]c3 mem_sleep_default=3Ddeep resume=3DUUID=3D97[..=
.]e4 resume_offset=3D96256 efi=3Ddebug memblock=3Ddebug"
> CONFIG_CMDLINE_OVERRIDE=3Dy
> # CONFIG_BLK_CMDLINE_PARSER is not set
> # CONFIG_CMDLINE_PARTITION is not set
> CONFIG_FB_CMDLINE=3Dy
>=20
> $ efibootmgr -v
> BootCurrent: 000A
> Timeout: 2 seconds
> BootOrder: 000A,0009,0008,0005,0007,0006,0004,0002,0001,0000,0003
> [...]
> Boot0005* gentoo-5.4.0-next-20191127+-clear
> HD(1,GPT,e7[...]f2,0x800,0x64000)/File(\kernel-5.4.0-next-20191127+-clear=
)
> [...]
> Boot000A* gentoo-5.4.1-gentoo
> HD(1,GPT,e7[...]f2,0x800,0x64000)/File(\kernel-5.4.1-gentoo)
>=20
> So there's no boot loader that could construct an e820 table for the
> kernel to consume. I understand it's then up to the EFI stub to come up
> with a e820 table from the EFI memory map.
>=20
> > > Long time ago the add_efi_memmap is only enabled in case we explict
> > > enable it on cmdline, I'm not sure if we can do it by default, maybe =
we
> > > should.   Need opinion from X86 maintainers..
> > > Can you try below diff see if it works for you? (not tested, and need
> > > explicitly 'add_efi_memmap' in kernel cmdline param)
>=20
> Neither adding add_efi_memmap nor adding your patch and setting that opti=
on
> does make the ESRT memory region appear in /proc/iomem. kexec_file still
> loads the kernel across the ESRT region.
>=20

Hmm, sorry, my bad, actuall add_efi_memmap does not consider the
EFI_MEMORY_RUNTIME attribute, it only reads the memory descriptor types.

Will read your replied information later, did not get time today, but
probably below chunk can help?

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.=
c
index 3b9fd679cea9..516307617621 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -293,6 +293,8 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 =
size)
 =09early_memunmap(new, new_size);
=20
 =09efi_memmap_install(new_phys, num_entries);
+=09e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+=09e820__update_table(e820_table);
 }
=20
 /*

Thanks
Dave

