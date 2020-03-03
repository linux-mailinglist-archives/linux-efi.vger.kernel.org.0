Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D67178500
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 22:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgCCVkh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 16:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgCCVkh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 16:40:37 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B9420CC7
        for <linux-efi@vger.kernel.org>; Tue,  3 Mar 2020 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583271636;
        bh=0jpsm3BBvnD478P2r5zTpeDAbp5w828MO+Ug3OmTz1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vV83R1WQOEwrilldQhJXU9KGgWVNk6TsLU0nQ/rrZJh8ai/KCnQBnqYKVmUYYf6jW
         ekhuKN3kiGxYF6aAFkl0dcHpEIdwgLXWMjURm9/wowTO5Zo89POSTgZrNZ8NzPcm/f
         oQAOPicbfhz/MDGF2wkFpkL63OCZziQKS7kMrZz8=
Received: by mail-wm1-f42.google.com with SMTP id g134so3661107wme.3
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 13:40:35 -0800 (PST)
X-Gm-Message-State: ANhLgQ1LaLsh1T7W/MZOjCRJ1ygtivjDqRxWMxv2erpiG5vhjZska3IP
        gqpCXEOTKmdUzXlo3zyCQxaSA04Cg+I8S6D1kulBLA==
X-Google-Smtp-Source: ADFU+vv8K/yzcQfqLLdVnpOiBFhF4pvd3KmGe7fU1o40H8tR6B6No3Mj2vvp3wcRAAYE3cJq3QBoueGxcMNpfBbbYrE=
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr560545wmt.68.1583271634105;
 Tue, 03 Mar 2020 13:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20200216182334.8121-1-ardb@kernel.org> <20200216182334.8121-17-ardb@kernel.org>
 <20200303160353.GA20372@roeck-us.net> <CAKv+Gu_dG2dsrNBWG3fV5S40y6iRGSj7MO2gbtZhqEUg5mXgyQ@mail.gmail.com>
 <20200303175355.GA14065@roeck-us.net> <CAKv+Gu_4tbdR8zF0eerZBbiFhCh_hg20rTovxqcaByW8J4b-UA@mail.gmail.com>
 <CAKv+Gu8+JV0WLqNzX_cMGRwDH4vMS_v8a_uJ8ciDtgzGUVsmhA@mail.gmail.com> <20200303203043.GA4078@roeck-us.net>
In-Reply-To: <20200303203043.GA4078@roeck-us.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 22:40:23 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9bqB-nxk76ZKeaC14dTemS8ZZNtrwHd6PUWknkqnAueQ@mail.gmail.com>
Message-ID: <CAKv+Gu9bqB-nxk76ZKeaC14dTemS8ZZNtrwHd6PUWknkqnAueQ@mail.gmail.com>
Subject: Re: [PATCH 16/18] efi: add 'runtime' pointer to struct efi
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 3 Mar 2020 at 21:30, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Mar 03, 2020 at 07:14:52PM +0100, Ard Biesheuvel wrote:
> > On Tue, 3 Mar 2020 at 19:01, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Tue, 3 Mar 2020 at 18:54, Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > On Tue, Mar 03, 2020 at 05:39:43PM +0100, Ard Biesheuvel wrote:
> > > > > On Tue, 3 Mar 2020 at 17:03, Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > >
> > > > > > On Sun, Feb 16, 2020 at 07:23:32PM +0100, Ard Biesheuvel wrote:
> > > > > > > Instead of going through the EFI system table each time, just copy the
> > > > > > > runtime services table pointer into struct efi directly. This is the
> > > > > > > last use of the system table pointer in struct efi, allowing us to
> > > > > > > drop it in a future patch, along with a fair amount of quirky handling
> > > > > > > of the translated address.
> > > > > > >
> > > > > > > Note that usually, the runtime services pointer changes value during
> > > > > > > the call to SetVirtualAddressMap(), so grab the updated value as soon
> > > > > > > as that call returns. (Mixed mode uses a 1:1 mapping, and kexec boot
> > > > > > > enters with the updated address in the system table, so in those cases,
> > > > > > > we don't need to do anything here)
> > > > > > >
> > > > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > >
> > > > > > This patch results in a crash with i386 efi boots if PAE (CONFIG_HIGHMEM64G=y)
> > > > > > is enabled. Bisect and crash logs attached. There is also a warning which
> > > > > > I don't recall seeing before, but it may not be caused by this patch
> > > > > > (I didn' bisect the warning). The warning is seen with all i386:efi boots,
> > > > > > not only when PAE is enabled. The warning log is also attached.
> > > > > >
> > > > > > Guenter
> > > > > >
> > > > > > ---
> > > > > > Qemu command line:
> > > > > >
> > > > > > qemu-system-i386 -kernel arch/x86/boot/bzImage -M pc -cpu Westmere \
> > > > > >         -no-reboot -m 256 -snapshot \
> > > > > >         -bios OVMF-pure-efi-32.fd \
> > > > > >         -usb -device usb-storage,drive=d0 \
> > > > > >         -drive file=rootfs.ext2,if=none,id=d0,format=raw \
> > > > > >         --append 'earlycon=uart8250,io,0x3f8,9600n8 panic=-1 slub_debug=FZPUA root=/dev/sda rootwait mem=256M console=ttyS0' \
> > > > > >         -nographic
> > > > > >
> > > > >
> > > > > I am failing to reproduce this. Do you have a .config and a copy of
> > > > > OVMF-pure-efi-32.fd anywhere?
> > > > >
> > > >
> > > > https://github.com/groeck/linux-build-test/blob/master/rootfs/firmware/OVMF-pure-efi-32.fd
> > > > https://github.com/groeck/linux-build-test/blob/master/rootfs/x86/rootfs.ext2.gz
> > > >
> > > > Config file is below, shortened by "make savedefconfig" on the actual
> > > > configuration used on next-20200303. Qemu version is 4.2, though that
> > > > should not really matter. Note that it isn't necessary to boot from usb,
> > > > that was just my test case.
> > > >
> > > > Here is a pointer to a complete log, showing the various conditions
> > > > resulting in the warning and the crash:
> > > >
> > > > https://kerneltests.org/builders/qemu-x86-next/builds/1310/steps/qemubuildcommand_1/logs/stdio
> > > >
> > >
> > > Thanks.
> > >
> > > How do I generate your exact .config from the below? I still cannot
> > > reproduce with the different firmware.
> > >
> > > My qemu is 3.1 btw
> > >
> >
> > Also, I don't see CONFIG_HIGHMEM64G=y anywhere below??
> >
>
> Sorry, I should have used make ARCH=i386 savedefconfig. Another attempt
> below. This needs to be built with "make ARCH=i386".
>

It still doesn't enable CONFIG_HIGHMEM64G, and so it is not entirely
clear to me how I should derive your failing config from this.
Couldn't you simply share the whole thing?




> CONFIG_SYSVIPC=y
> CONFIG_PREEMPT=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_LOG_BUF_SHIFT=14
> CONFIG_EXPERT=y
> CONFIG_PROFILING=y
> CONFIG_ARCH_PXA=y
> CONFIG_PXA_SHARPSL=y
> CONFIG_MACH_AKITA=y
> CONFIG_MACH_BORZOI=y
> CONFIG_ZBOOT_ROM_TEXT=0x0
> CONFIG_ZBOOT_ROM_BSS=0x0
> CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
> CONFIG_FPE_NWFPE=y
> CONFIG_OPROFILE=m
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> # CONFIG_BLK_DEV_BSG is not set
> CONFIG_PARTITION_ADVANCED=y
> CONFIG_BINFMT_MISC=m
> CONFIG_NET=y
> CONFIG_PACKET=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_SYN_COOKIES=y
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> CONFIG_INET6_IPCOMP=m
> CONFIG_IPV6_TUNNEL=m
> CONFIG_NETFILTER=y
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_ECN=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_RAW=m
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> CONFIG_IP_NF_ARP_MANGLE=m
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_RT=m
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_RAW=m
> CONFIG_BT=m
> CONFIG_BT_RFCOMM=m
> CONFIG_BT_RFCOMM_TTY=y
> CONFIG_BT_BNEP=m
> CONFIG_BT_BNEP_MC_FILTER=y
> CONFIG_BT_BNEP_PROTO_FILTER=y
> CONFIG_BT_HIDP=m
> CONFIG_BT_HCIUART=m
> CONFIG_BT_HCIUART_H4=y
> CONFIG_BT_HCIUART_BCSP=y
> CONFIG_BT_HCIBCM203X=m
> CONFIG_BT_HCIBPA10X=m
> CONFIG_BT_HCIBFUSB=m
> CONFIG_BT_HCIDTL1=m
> CONFIG_BT_HCIBT3C=m
> CONFIG_BT_HCIBLUECARD=m
> CONFIG_BT_HCIVHCI=m
> CONFIG_PCCARD=y
> CONFIG_PCMCIA_PXA2XX=y
> CONFIG_MTD=y
> CONFIG_MTD_CMDLINE_PARTS=y
> CONFIG_MTD_BLOCK=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_COMPLEX_MAPPINGS=y
> CONFIG_MTD_RAW_NAND=y
> CONFIG_MTD_NAND_SHARPSL=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=m
> CONFIG_BLK_DEV_SR=m
> CONFIG_CHR_DEV_SG=m
> CONFIG_ATA=y
> CONFIG_PATA_PCMCIA=y
> CONFIG_NETDEVICES=y
> CONFIG_PCMCIA_PCNET=m
> CONFIG_PPP=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_PPP_ASYNC=m
> CONFIG_USB_CATC=m
> CONFIG_USB_KAWETH=m
> CONFIG_USB_PEGASUS=m
> CONFIG_USB_RTL8150=m
> CONFIG_USB_USBNET=m
> # CONFIG_USB_NET_CDC_SUBSET is not set
> CONFIG_INPUT_EVDEV=y
> # CONFIG_KEYBOARD_ATKBD is not set
> # CONFIG_INPUT_MOUSE is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_ADS7846=y
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_UINPUT=m
> # CONFIG_SERIO is not set
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_SERIAL_8250=m
> CONFIG_SERIAL_8250_CS=m
> CONFIG_SERIAL_PXA=y
> CONFIG_SERIAL_PXA_CONSOLE=y
> CONFIG_SPI_PXA2XX=y
> CONFIG_FB=y
> CONFIG_FB_PXA=y
> CONFIG_LCD_CLASS_DEVICE=y
> CONFIG_LCD_CORGI=y
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> CONFIG_HID_A4TECH=m
> CONFIG_HID_APPLE=m
> CONFIG_HID_BELKIN=m
> CONFIG_HID_CHERRY=m
> CONFIG_HID_CHICONY=m
> CONFIG_HID_CYPRESS=m
> CONFIG_HID_EZKEY=m
> CONFIG_HID_GYRATION=m
> CONFIG_HID_MICROSOFT=m
> CONFIG_HID_MONTEREY=m
> CONFIG_HID_PANTHERLORD=m
> CONFIG_HID_PETALYNX=m
> CONFIG_HID_SAMSUNG=m
> CONFIG_HID_SUNPLUS=m
> CONFIG_USB_KBD=m
> CONFIG_USB_MOUSE=m
> CONFIG_USB=m
> CONFIG_USB_MON=m
> CONFIG_USB_OHCI_HCD=m
> CONFIG_USB_SL811_HCD=m
> CONFIG_USB_SL811_CS=m
> CONFIG_USB_ACM=m
> CONFIG_USB_PRINTER=m
> CONFIG_USB_STORAGE=m
> CONFIG_USB_MDC800=m
> CONFIG_USB_MICROTEK=m
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> CONFIG_USB_SERIAL_BELKIN=m
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
> CONFIG_USB_SERIAL_CYPRESS_M8=m
> CONFIG_USB_SERIAL_EMPEG=m
> CONFIG_USB_SERIAL_FTDI_SIO=m
> CONFIG_USB_SERIAL_VISOR=m
> CONFIG_USB_SERIAL_IPAQ=m
> CONFIG_USB_SERIAL_IR=m
> CONFIG_USB_SERIAL_EDGEPORT=m
> CONFIG_USB_SERIAL_EDGEPORT_TI=m
> CONFIG_USB_SERIAL_GARMIN=m
> CONFIG_USB_SERIAL_IPW=m
> CONFIG_USB_SERIAL_KEYSPAN_PDA=m
> CONFIG_USB_SERIAL_KEYSPAN=m
> CONFIG_USB_SERIAL_KLSI=m
> CONFIG_USB_SERIAL_KOBIL_SCT=m
> CONFIG_USB_SERIAL_MCT_U232=m
> CONFIG_USB_SERIAL_PL2303=m
> CONFIG_USB_SERIAL_SAFE=m
> CONFIG_USB_SERIAL_TI=m
> CONFIG_USB_SERIAL_CYBERJACK=m
> CONFIG_USB_SERIAL_XIRCOM=m
> CONFIG_USB_SERIAL_OMNINET=m
> CONFIG_USB_EMI62=m
> CONFIG_USB_EMI26=m
> CONFIG_USB_LEGOTOWER=m
> CONFIG_USB_LCD=m
> CONFIG_USB_CYTHERM=m
> CONFIG_USB_IDMOUSE=m
> CONFIG_USB_GADGET=m
> CONFIG_USB_ZERO=m
> CONFIG_USB_ETH=m
> CONFIG_USB_GADGETFS=m
> CONFIG_USB_MASS_STORAGE=m
> CONFIG_USB_G_SERIAL=m
> CONFIG_MMC=y
> CONFIG_MMC_PXA=y
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> CONFIG_EXT3_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_TMPFS=y
> CONFIG_JFFS2_FS=y
> CONFIG_JFFS2_SUMMARY=y
> CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> CONFIG_JFFS2_RUBIN=y
> CONFIG_CRAMFS=m
> CONFIG_NFS_FS=m
> CONFIG_NFS_V4=m
> CONFIG_NLS_DEFAULT="cp437"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_UTF8=y
> CONFIG_CRYPTO_TEST=m
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_SHA512=m
> CONFIG_CRYPTO_WP512=m
> CONFIG_CRYPTO_ANUBIS=m
> CONFIG_CRYPTO_ARC4=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_CAST5=m
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_KHAZAD=m
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRC_CCITT=y
> CONFIG_LIBCRC32C=m
> CONFIG_FONTS=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_PREEMPT is not set
> # CONFIG_FTRACE is not set
> CONFIG_DEBUG_LL=y
