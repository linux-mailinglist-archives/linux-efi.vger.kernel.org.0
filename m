Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347B2178148
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 20:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbgCCSBh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 13:01:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388022AbgCCSBg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 13:01:36 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4BEC2072D
        for <linux-efi@vger.kernel.org>; Tue,  3 Mar 2020 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258496;
        bh=1hbl3m4Hxf0gY967O41p8JrE6SOgP2qeMfhUCwBDxGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yH9UMtTYzf+YGUlfGBAUo5wq7uE6GJCjlvfTxWyDPp3tAcN2Ikn7rmk8pFe5F9bdh
         yIeCyfwJMaY+/7iJmeismCsrCX7EzSH9E+9glKGcAO13JIYROQEdIOaYFvCIK5Aj8h
         uqXHEnVwU5mGHFZ+40/FekIfMsKwLCLghI6xQbv0=
Received: by mail-wr1-f43.google.com with SMTP id z15so5604442wrl.1
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 10:01:35 -0800 (PST)
X-Gm-Message-State: ANhLgQ3AbC5QB0FM/biIsRq1ujYRL7kyALKpbN8gK0jmlOBvKMtJB4tr
        MQYsvMsKPZFLCoN3+8N2PYdkUDWH24QybIKgZRUC/A==
X-Google-Smtp-Source: ADFU+vtCh+tBWrTvRcAc/NH0JeRqkB01tuIpt1Bnu3LmZDWpVgJ/bX7HfAGeJP895OCyGjQV8HtajjRojSX0FCuXtVE=
X-Received: by 2002:adf:e742:: with SMTP id c2mr6489330wrn.262.1583258494072;
 Tue, 03 Mar 2020 10:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20200216182334.8121-1-ardb@kernel.org> <20200216182334.8121-17-ardb@kernel.org>
 <20200303160353.GA20372@roeck-us.net> <CAKv+Gu_dG2dsrNBWG3fV5S40y6iRGSj7MO2gbtZhqEUg5mXgyQ@mail.gmail.com>
 <20200303175355.GA14065@roeck-us.net>
In-Reply-To: <20200303175355.GA14065@roeck-us.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 19:01:23 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_4tbdR8zF0eerZBbiFhCh_hg20rTovxqcaByW8J4b-UA@mail.gmail.com>
Message-ID: <CAKv+Gu_4tbdR8zF0eerZBbiFhCh_hg20rTovxqcaByW8J4b-UA@mail.gmail.com>
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

On Tue, 3 Mar 2020 at 18:54, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Mar 03, 2020 at 05:39:43PM +0100, Ard Biesheuvel wrote:
> > On Tue, 3 Mar 2020 at 17:03, Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Sun, Feb 16, 2020 at 07:23:32PM +0100, Ard Biesheuvel wrote:
> > > > Instead of going through the EFI system table each time, just copy the
> > > > runtime services table pointer into struct efi directly. This is the
> > > > last use of the system table pointer in struct efi, allowing us to
> > > > drop it in a future patch, along with a fair amount of quirky handling
> > > > of the translated address.
> > > >
> > > > Note that usually, the runtime services pointer changes value during
> > > > the call to SetVirtualAddressMap(), so grab the updated value as soon
> > > > as that call returns. (Mixed mode uses a 1:1 mapping, and kexec boot
> > > > enters with the updated address in the system table, so in those cases,
> > > > we don't need to do anything here)
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > This patch results in a crash with i386 efi boots if PAE (CONFIG_HIGHMEM64G=y)
> > > is enabled. Bisect and crash logs attached. There is also a warning which
> > > I don't recall seeing before, but it may not be caused by this patch
> > > (I didn' bisect the warning). The warning is seen with all i386:efi boots,
> > > not only when PAE is enabled. The warning log is also attached.
> > >
> > > Guenter
> > >
> > > ---
> > > Qemu command line:
> > >
> > > qemu-system-i386 -kernel arch/x86/boot/bzImage -M pc -cpu Westmere \
> > >         -no-reboot -m 256 -snapshot \
> > >         -bios OVMF-pure-efi-32.fd \
> > >         -usb -device usb-storage,drive=d0 \
> > >         -drive file=rootfs.ext2,if=none,id=d0,format=raw \
> > >         --append 'earlycon=uart8250,io,0x3f8,9600n8 panic=-1 slub_debug=FZPUA root=/dev/sda rootwait mem=256M console=ttyS0' \
> > >         -nographic
> > >
> >
> > I am failing to reproduce this. Do you have a .config and a copy of
> > OVMF-pure-efi-32.fd anywhere?
> >
>
> https://github.com/groeck/linux-build-test/blob/master/rootfs/firmware/OVMF-pure-efi-32.fd
> https://github.com/groeck/linux-build-test/blob/master/rootfs/x86/rootfs.ext2.gz
>
> Config file is below, shortened by "make savedefconfig" on the actual
> configuration used on next-20200303. Qemu version is 4.2, though that
> should not really matter. Note that it isn't necessary to boot from usb,
> that was just my test case.
>
> Here is a pointer to a complete log, showing the various conditions
> resulting in the warning and the crash:
>
> https://kerneltests.org/builders/qemu-x86-next/builds/1310/steps/qemubuildcommand_1/logs/stdio
>

Thanks.

How do I generate your exact .config from the below? I still cannot
reproduce with the different firmware.

My qemu is 3.1 btw


>
> ---
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_USELIB=y
> CONFIG_AUDIT=y
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_PREEMPT_VOLUNTARY=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> CONFIG_TASK_XACCT=y
> CONFIG_TASK_IO_ACCOUNTING=y
> CONFIG_LOG_BUF_SHIFT=18
> CONFIG_CGROUPS=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_CGROUP_FREEZER=y
> CONFIG_CPUSETS=y
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_NAMESPACES=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_EXPERT=y
> # CONFIG_COMPAT_BRK is not set
> CONFIG_PROFILING=y
> CONFIG_SMP=y
> CONFIG_NR_CPUS=8
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> CONFIG_MICROCODE_AMD=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> # CONFIG_MTRR_SANITIZER is not set
> CONFIG_EFI=y
> CONFIG_EFI_STUB=y
> CONFIG_HZ_1000=y
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y
> CONFIG_HIBERNATION=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_TRACE_RTC=y
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_BGRT=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_EFI_VARS=y
> CONFIG_EFI_CAPSULE_LOADER=y
> # CONFIG_KVM_WERROR is not set
> CONFIG_KPROBES=y
> CONFIG_JUMP_LABEL=y
> CONFIG_STATIC_KEYS_SELFTEST=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> # CONFIG_UNUSED_SYMBOLS is not set
> CONFIG_BINFMT_MISC=y
> CONFIG_NET=y
> CONFIG_PACKET=y
> CONFIG_UNIX=y
> CONFIG_XFRM_USER=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> CONFIG_IP_PNP_BOOTP=y
> CONFIG_IP_PNP_RARP=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_SYN_COOKIES=y
> # CONFIG_INET_DIAG is not set
> CONFIG_TCP_CONG_ADVANCED=y
> # CONFIG_TCP_CONG_BIC is not set
> # CONFIG_TCP_CONG_WESTWOOD is not set
> # CONFIG_TCP_CONG_HTCP is not set
> CONFIG_TCP_MD5SIG=y
> CONFIG_INET6_AH=y
> CONFIG_INET6_ESP=y
> CONFIG_NETLABEL=y
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_ADVANCED is not set
> CONFIG_NF_CONNTRACK=y
> CONFIG_NF_CONNTRACK_FTP=y
> CONFIG_NF_CONNTRACK_IRC=y
> CONFIG_NF_CONNTRACK_SIP=y
> CONFIG_NF_CT_NETLINK=y
> CONFIG_NF_NAT=y
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
> CONFIG_NETFILTER_XT_TARGET_NFLOG=y
> CONFIG_NETFILTER_XT_TARGET_SECMARK=y
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
> CONFIG_NETFILTER_XT_MATCH_POLICY=y
> CONFIG_NETFILTER_XT_MATCH_STATE=y
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_REJECT=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_MANGLE=y
> CONFIG_IP6_NF_IPTABLES=y
> CONFIG_IP6_NF_MATCH_IPV6HEADER=y
> CONFIG_IP6_NF_FILTER=y
> CONFIG_IP6_NF_TARGET_REJECT=y
> CONFIG_IP6_NF_MANGLE=y
> CONFIG_NET_SCHED=y
> CONFIG_NET_EMATCH=y
> CONFIG_NET_CLS_ACT=y
> CONFIG_HAMRADIO=y
> CONFIG_CFG80211=y
> CONFIG_MAC80211=y
> CONFIG_MAC80211_LEDS=y
> CONFIG_RFKILL=y
> CONFIG_RFKILL_INPUT=y
> CONFIG_PCI=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_PCI_MSI=y
> CONFIG_HOTPLUG_PCI=y
> CONFIG_PCCARD=y
> CONFIG_YENTA=y
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_DEBUG_DEVRES=y
> CONFIG_PM_QOS_KUNIT_TEST=y
> CONFIG_CONNECTOR=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_VIRTIO_BLK=y
> CONFIG_BLK_DEV_NVME=y
> CONFIG_PCI_ENDPOINT_TEST=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_BLK_DEV_SR=y
> CONFIG_CHR_DEV_SG=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_MEGARAID_SAS=y
> CONFIG_SCSI_SYM53C8XX_2=y
> CONFIG_SCSI_DC395x=y
> CONFIG_SCSI_AM53C974=y
> CONFIG_SCSI_VIRTIO=y
> CONFIG_ATA=y
> CONFIG_SATA_AHCI=y
> CONFIG_ATA_PIIX=y
> CONFIG_PATA_AMD=y
> CONFIG_PATA_OLDPIIX=y
> CONFIG_PATA_SCH=y
> CONFIG_PATA_MPIIX=y
> CONFIG_ATA_GENERIC=y
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_BLK_DEV_DM=y
> CONFIG_DM_MIRROR=y
> CONFIG_DM_ZERO=y
> CONFIG_FUSION=y
> CONFIG_FUSION_SAS=y
> CONFIG_MACINTOSH_DRIVERS=y
> CONFIG_MAC_EMUMOUSEBTN=y
> CONFIG_NETDEVICES=y
> CONFIG_NETCONSOLE=y
> CONFIG_BNX2=y
> CONFIG_TIGON3=y
> CONFIG_NET_TULIP=y
> CONFIG_E100=y
> CONFIG_E1000=y
> CONFIG_E1000E=y
> CONFIG_SKY2=y
> CONFIG_NE2K_PCI=y
> CONFIG_FORCEDETH=y
> CONFIG_8139TOO=y
> # CONFIG_8139TOO_PIO is not set
> CONFIG_R8169=y
> CONFIG_FDDI=y
> CONFIG_INPUT_POLLDEV=y
> CONFIG_INPUT_EVDEV=y
> CONFIG_INPUT_JOYSTICK=y
> CONFIG_INPUT_TABLET=y
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_INPUT_MISC=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_SERIAL_NONSTANDARD=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_NR_UARTS=32
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> CONFIG_SERIAL_8250_DETECT_IRQ=y
> CONFIG_SERIAL_8250_RSA=y
> CONFIG_HW_RANDOM=y
> CONFIG_NVRAM=y
> CONFIG_HPET=y
> # CONFIG_HPET_MMAP is not set
> CONFIG_I2C_I801=y
> CONFIG_WATCHDOG=y
> CONFIG_AGP=y
> CONFIG_AGP_AMD64=y
> CONFIG_AGP_INTEL=y
> CONFIG_DRM=y
> CONFIG_DRM_I915=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> CONFIG_FB_EFI=y
> CONFIG_VGACON_SOFT_SCROLLBACK=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_SOUND=y
> CONFIG_SND=y
> CONFIG_SND_HRTIMER=y
> CONFIG_SND_SEQUENCER=y
> CONFIG_SND_SEQ_DUMMY=y
> CONFIG_SND_HDA_INTEL=y
> CONFIG_SND_HDA_HWDEP=y
> CONFIG_HIDRAW=y
> CONFIG_HID_A4TECH=y
> CONFIG_HID_APPLE=y
> CONFIG_HID_BELKIN=y
> CONFIG_HID_CHERRY=y
> CONFIG_HID_CHICONY=y
> CONFIG_HID_CYPRESS=y
> CONFIG_HID_EZKEY=y
> CONFIG_HID_GYRATION=y
> CONFIG_HID_ITE=y
> CONFIG_HID_KENSINGTON=y
> CONFIG_HID_LOGITECH=y
> CONFIG_LOGITECH_FF=y
> CONFIG_HID_REDRAGON=y
> CONFIG_HID_MICROSOFT=y
> CONFIG_HID_MONTEREY=y
> CONFIG_HID_NTRIG=y
> CONFIG_HID_PANTHERLORD=y
> CONFIG_PANTHERLORD_FF=y
> CONFIG_HID_PETALYNX=y
> CONFIG_HID_SAMSUNG=y
> CONFIG_HID_SONY=y
> CONFIG_HID_SUNPLUS=y
> CONFIG_HID_TOPSEED=y
> CONFIG_HID_PID=y
> CONFIG_USB_HIDDEV=y
> CONFIG_USB=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> CONFIG_USB_MON=y
> CONFIG_USB_XHCI_HCD=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_UHCI_HCD=y
> CONFIG_USB_PRINTER=y
> CONFIG_USB_STORAGE=y
> CONFIG_USB_UAS=y
> CONFIG_USB_TEST=y
> CONFIG_USB_EHSET_TEST_FIXTURE=y
> CONFIG_USB_LINK_LAYER_TEST=y
> CONFIG_MMC=y
> CONFIG_MMC_SDHCI=y
> CONFIG_MMC_SDHCI_PCI=y
> CONFIG_EDAC=y
> CONFIG_RTC_CLASS=y
> # CONFIG_RTC_HCTOSYS is not set
> CONFIG_DMADEVICES=y
> CONFIG_DMATEST=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_MMIO=y
> CONFIG_EEEPC_LAPTOP=y
> CONFIG_EXT3_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> CONFIG_EXT4_KUNIT_TESTS=y
> CONFIG_BTRFS_FS=y
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> # CONFIG_PRINT_QUOTA_WARNING is not set
> CONFIG_QFMT_V2=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_HUGETLBFS=y
> CONFIG_SQUASHFS=y
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=y
> CONFIG_ROOT_NFS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_UTF8=y
> CONFIG_SECURITY=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_DISABLE=y
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> CONFIG_CRC32_SELFTEST=y
> CONFIG_GLOB_SELFTEST=y
> CONFIG_STRING_SELFTEST=y
> CONFIG_PRINTK_TIME=y
> CONFIG_FRAME_WARN=1024
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_DEBUG_RODATA_TEST=y
> CONFIG_DEBUG_STACK_USAGE=y
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_SCHED_DEBUG is not set
> CONFIG_SCHEDSTATS=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_DEBUG_LOCKDEP=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> CONFIG_WW_MUTEX_SELFTEST=y
> CONFIG_DEBUG_LIST=y
> CONFIG_RCU_EQS_DEBUG=y
> CONFIG_BLK_DEV_IO_TRACE=y
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_DEBUG_TLBFLUSH=y
> CONFIG_DEBUG_BOOT_PARAMS=y
> CONFIG_DEBUG_NMI_SELFTEST=y
> CONFIG_UNWINDER_FRAME_POINTER=y
> CONFIG_KUNIT=y
> CONFIG_KUNIT_TEST=y
> CONFIG_TEST_SORT=y
> CONFIG_RBTREE_TEST=y
> CONFIG_INTERVAL_TREE_TEST=y
> CONFIG_TEST_BITMAP=y
> CONFIG_TEST_UUID=y
> CONFIG_TEST_FIRMWARE=y
> CONFIG_TEST_SYSCTL=y
> CONFIG_SYSCTL_KUNIT_TEST=y
> CONFIG_LIST_KUNIT_TEST=y
