Return-Path: <linux-efi+bounces-1281-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA49913BD3
	for <lists+linux-efi@lfdr.de>; Sun, 23 Jun 2024 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75ED8281DCE
	for <lists+linux-efi@lfdr.de>; Sun, 23 Jun 2024 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122BC1802D2;
	Sun, 23 Jun 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGHoL8UC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE518383B0;
	Sun, 23 Jun 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719153948; cv=none; b=Fn/s6F9MCmtaIo7QT5tl4JnkAgAtfbI7uV2by/CCFafUUwechytFMaHCTghGUK8S8qxR3nvIS8ykqLVF/6D6pYgO9uDo4WK//F2QjE4GaiqtdhHoE1bshzUKqIE37fo91fxA0ThjxSsP6PNCwl7CKEwiyyAJUZlFWnsQ0z0+DeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719153948; c=relaxed/simple;
	bh=2So9gXPeE07Sny7uqP3rv6mC9HKltfQ1doqelhU58K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WefMfq/Wuws5lV+TNHX9DpB0xqF+wsq2j8Hw28kUmA2fF3uU6xVwtfAV8sYelDh2gBOa3QTYct1sIeR6VfT/tjm9Hhk1ms9b+p3LzBFG8icWMXzsqH9oCNdNqxaBsnwM/7YgcF1wU7WVpxALYy4NkN7ZzeEvIG8hn81i2AA8FeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGHoL8UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980BDC2BD10;
	Sun, 23 Jun 2024 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719153947;
	bh=2So9gXPeE07Sny7uqP3rv6mC9HKltfQ1doqelhU58K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGHoL8UC+6PmK023eAP5uTNw20h5+uankrWAFEf6PUnQGxZQ7M0gLXJpVGDZsrXr5
	 Rw5NWhO1O+WUGmL03Tjh0tS9BD8lysTnf6P/zFmZQkO2uMhH84g53yTSHfLh9RDXL9
	 vmjJHv6Tocra8dphUBrvWDYYruB7XeUqeN4ULldg1/sX5yGv43lu95XiTvJXIMdiIL
	 e5+EmcKpmw7QSPMaZjnMcITQihyNstN14WQbhWroD/+mkAJymz2Tivk/XC0x6BQc0N
	 d9n3abWMpYLZIqmmR7vnuir2cUPLuvHazNxgnprp2uUAV2kUMNjSaqM7AI0IFFfTVK
	 QUFv8Lb+EGJyQ==
Date: Sun, 23 Jun 2024 22:31:42 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Ard Biesheuvel <ardb@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH] riscv: enable HAVE_ARCH_STACKLEAK
Message-ID: <Zngxzg3BsdI31psu@xhacker>
References: <20240617123029.723-1-jszhang@kernel.org>
 <ZnX6YtFGfXd0ixwR@ghost>
 <ZnYenFigMU4Lxa0K@xhacker>
 <ZnZIRafvq7J1B2t6@ghost>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnZIRafvq7J1B2t6@ghost>

On Fri, Jun 21, 2024 at 08:43:01PM -0700, Charlie Jenkins wrote:
> On Sat, Jun 22, 2024 at 08:45:16AM +0800, Jisheng Zhang wrote:
> > On Fri, Jun 21, 2024 at 03:10:42PM -0700, Charlie Jenkins wrote:
> > > On Mon, Jun 17, 2024 at 08:30:29PM +0800, Jisheng Zhang wrote:
> > > > Add support for the stackleak feature. Whenever the kernel returns to user
> > > > space the kernel stack is filled with a poison value.
> > > > 
> > > > At the same time, disables the plugin in EFI stub code because EFI stub
> > > > is out of scope for the protection.
> > > > 
> > > > Tested on qemu and milkv duo:
> > > > / # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
> > > > [   38.675575] lkdtm: Performing direct entry STACKLEAK_ERASING
> > > > [   38.678448] lkdtm: stackleak stack usage:
> > > > [   38.678448]   high offset: 288 bytes
> > > > [   38.678448]   current:     496 bytes
> > > > [   38.678448]   lowest:      1328 bytes
> > > > [   38.678448]   tracked:     1328 bytes
> > > > [   38.678448]   untracked:   448 bytes
> > > > [   38.678448]   poisoned:    14312 bytes
> > > > [   38.678448]   low offset:  8 bytes
> > > > [   38.689887] lkdtm: OK: the rest of the thread stack is properly erased
> > > > 
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >  arch/riscv/Kconfig                    | 1 +
> > > >  arch/riscv/kernel/entry.S             | 4 ++++
> > > >  drivers/firmware/efi/libstub/Makefile | 3 ++-
> > > >  3 files changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 0525ee2d63c7..9cbfdffec96c 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -118,6 +118,7 @@ config RISCV
> > > >  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> > > >  	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> > > >  	select HAVE_ARCH_SECCOMP_FILTER
> > > > +	select HAVE_ARCH_STACKLEAK
> > > 
> > > When this is selected, stackleak.h include
> > > arch/riscv/include/asm/thread_info.h without sizes.h and I hit:
> > > 
> > > ./arch/riscv/include/asm/thread_info.h:30:33: error: ‘SZ_4K’ undeclared here (not in a function)
> > >    30 | #define OVERFLOW_STACK_SIZE     SZ_4K
> > >       |                                 ^~~~~
> > > 
> > > Adding "#include <linux/sizes.h>" to thread_info.h resolves the issue.
> > > I am testing this based on 6.10-rc4. Did you encounter this?
> > 
> > I didn't meet this kind of compiler error when testing. Mind
> > to share your .config file? It looks strange.
> 
> The .config exceeds the mailing list character limit, but here is the
> defconfig created with savedefconfig. It is just defconfig +
> CONFIG_GCC_PLUGIN_STACKLEAK with modules removed. 

I can reproduce the compile error. If disabling VMAP_STACK, the error
would disappear. I believe the case can be reproduced under other
config combinations but we didn't find it so far ;)

I will send a v2.

Thanks a lot.
> 
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_NO_HZ_IDLE=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_BPF_SYSCALL=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_CGROUPS=y
> CONFIG_MEMCG=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> CONFIG_RT_GROUP_SCHED=y
> CONFIG_CGROUP_PIDS=y
> CONFIG_CGROUP_FREEZER=y
> CONFIG_CGROUP_HUGETLB=y
> CONFIG_CPUSETS=y
> CONFIG_CGROUP_DEVICE=y
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> CONFIG_CGROUP_BPF=y
> CONFIG_NAMESPACES=y
> CONFIG_USER_NS=y
> CONFIG_CHECKPOINT_RESTORE=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_EXPERT=y
> # CONFIG_SYSFS_SYSCALL is not set
> CONFIG_PROFILING=y
> CONFIG_ARCH_MICROCHIP=y
> CONFIG_ARCH_RENESAS=y
> CONFIG_ARCH_SIFIVE=y
> CONFIG_ARCH_SOPHGO=y
> CONFIG_SOC_STARFIVE=y
> CONFIG_ARCH_SUNXI=y
> CONFIG_ARCH_THEAD=y
> CONFIG_ARCH_VIRT=y
> CONFIG_ARCH_CANAAN=y
> CONFIG_SMP=y
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPUFREQ_DT=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_ACPI=y
> CONFIG_JUMP_LABEL=y
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_NET=y
> CONFIG_PACKET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> CONFIG_IP_PNP_BOOTP=y
> CONFIG_IP_PNP_RARP=y
> CONFIG_NETFILTER=y
> CONFIG_NET_SCHED=y
> CONFIG_NETLINK_DIAG=y
> CONFIG_NET_L3_MASTER_DEV=y
> CONFIG_CGROUP_NET_PRIO=y
> CONFIG_CGROUP_NET_CLASSID=y
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=y
> CONFIG_PCI=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_PCI_HOST_GENERIC=y
> CONFIG_PCIE_XILINX=y
> CONFIG_PCIE_FU740=y
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_MTD=y
> CONFIG_MTD_BLOCK=y
> CONFIG_MTD_CFI=y
> CONFIG_MTD_CFI_ADV_OPTIONS=y
> CONFIG_MTD_SPI_NOR=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_VIRTIO_BLK=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_BLK_DEV_SR=y
> CONFIG_SCSI_VIRTIO=y
> CONFIG_ATA=y
> CONFIG_SATA_AHCI=y
> CONFIG_SATA_AHCI_PLATFORM=y
> CONFIG_MD=y
> CONFIG_NETDEVICES=y
> CONFIG_VIRTIO_NET=y
> CONFIG_MACB=y
> CONFIG_E1000E=y
> CONFIG_R8169=y
> CONFIG_RAVB=y
> CONFIG_MICREL_PHY=y
> CONFIG_MICROSEMI_PHY=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DW=y
> CONFIG_SERIAL_OF_PLATFORM=y
> CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> CONFIG_SERIAL_SH_SCI=y
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_VIRTIO=y
> CONFIG_SPI=y
> CONFIG_SPI_SIFIVE=y
> CONFIG_SPI_SUN6I=y
> # CONFIG_PTP_1588_CLOCK is not set
> CONFIG_GPIO_SIFIVE=y
> CONFIG_CPU_THERMAL=y
> CONFIG_RZG2L_THERMAL=y
> CONFIG_WATCHDOG=y
> CONFIG_SUNXI_WATCHDOG=y
> CONFIG_RENESAS_RZG2LWDT=y
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_GPIO=y
> CONFIG_FB=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> CONFIG_SOUND=y
> CONFIG_SND=y
> CONFIG_SND_SOC=y
> CONFIG_USB=y
> CONFIG_USB_OTG=y
> CONFIG_USB_XHCI_HCD=y
> CONFIG_USB_XHCI_PLATFORM=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_HCD_PLATFORM=y
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> CONFIG_USB_STORAGE=y
> CONFIG_USB_UAS=y
> CONFIG_USB_GADGET=y
> CONFIG_MMC=y
> CONFIG_MMC_SDHCI=y
> CONFIG_MMC_SDHCI_PLTFM=y
> CONFIG_MMC_SDHCI_OF_DWCMSHC=y
> CONFIG_MMC_SDHCI_CADENCE=y
> CONFIG_MMC_SPI=y
> CONFIG_MMC_SDHI=y
> CONFIG_MMC_DW=y
> CONFIG_MMC_DW_STARFIVE=y
> CONFIG_MMC_SUNXI=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_DRV_SUN6I=y
> CONFIG_DMADEVICES=y
> CONFIG_DW_AXI_DMAC=y
> CONFIG_SYNC_FILE=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_INPUT=y
> CONFIG_VIRTIO_MMIO=y
> CONFIG_CLK_SOPHGO_CV1800=y
> # CONFIG_CLK_STARFIVE_JH7100_AUDIO is not set
> # CONFIG_CLK_STARFIVE_JH7110_AON is not set
> # CONFIG_CLK_STARFIVE_JH7110_STG is not set
> # CONFIG_CLK_STARFIVE_JH7110_ISP is not set
> # CONFIG_CLK_STARFIVE_JH7110_VOUT is not set
> # CONFIG_SUN8I_DE2_CCU is not set
> CONFIG_RENESAS_OSTM=y
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> CONFIG_SUN50I_IOMMU=y
> CONFIG_RPMSG_CHAR=y
> CONFIG_RPMSG_CTRL=y
> CONFIG_RPMSG_VIRTIO=y
> CONFIG_EXTCON=y
> CONFIG_IIO=y
> CONFIG_PHY_RCAR_GEN3_USB2=y
> CONFIG_LIBNVDIMM=y
> CONFIG_NVMEM_SUNXI_SID=y
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> CONFIG_AUTOFS_FS=y
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_HUGETLBFS=y
> # CONFIG_EFIVAR_FS is not set
> CONFIG_NFS_FS=y
> CONFIG_NFS_V4=y
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
> CONFIG_ROOT_NFS=y
> CONFIG_9P_FS=y
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_SECURITY=y
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_APPARMOR=y
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_GCC_PLUGIN_STACKLEAK=y
> CONFIG_CRYPTO_USER_API_HASH=y
> CONFIG_CRYPTO_DEV_VIRTIO=y
> CONFIG_PRINTK_TIME=y
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_PAGEALLOC=y
> CONFIG_SCHED_STACK_END_CHECK=y
> CONFIG_DEBUG_VM=y
> CONFIG_DEBUG_VM_PGFLAGS=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_DEBUG_PER_CPU_MAPS=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_WQ_WATCHDOG=y
> CONFIG_DEBUG_TIMEKEEPING=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LIST=y
> CONFIG_DEBUG_PLIST=y
> CONFIG_DEBUG_SG=y
> # CONFIG_RCU_TRACE is not set
> CONFIG_RCU_EQS_DEBUG=y
> # CONFIG_FTRACE is not set
> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_MEMTEST=y
> 

