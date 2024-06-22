Return-Path: <linux-efi+bounces-1280-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA19131CC
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jun 2024 05:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE701C219DB
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jun 2024 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0792D8C11;
	Sat, 22 Jun 2024 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="limB+3Vs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E332748E
	for <linux-efi@vger.kernel.org>; Sat, 22 Jun 2024 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719027786; cv=none; b=rRjW/AP6aA3GJiE+liwcpfJw84jwyfVQSnVWRuIfcl89wkpmn41Rfabn+40AqR/zgfFER+TNph5ZTHXEnHvsbudN7Nj3XBONH8Xa1e+fG5xs4ZhW39LdnWo8H4z3UhAfon2swBu5LjflGDRlFp0pn5QBpyKhl3IZzh2NK195SGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719027786; c=relaxed/simple;
	bh=md+d5eOFEp72HoBlscvVP6VpQ3p1DCTxYW852JpK+2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSqHAGU38ko5IMVpW1KVAzxRzSvZ3Wjf8y9sQRjOanmei1uBhhAk03OU9qG0MuRyF7hIrIrMB+QoICLNOSKdJxPrltClFgecUXqXaQjVgELrIkaoBayLgSdg+pOoDZLU/WFCzWLKhes7VJoBfv3Q7Ntiy7RTRjMkxjLM1VC8fSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=limB+3Vs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9aa039327so22657595ad.2
        for <linux-efi@vger.kernel.org>; Fri, 21 Jun 2024 20:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719027784; x=1719632584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/9AP8f9oWnlydulW7IOn40tz3CggsdR+C3pRKzSoM0=;
        b=limB+3VsiXtN1+7DMjer8ZZ+Jz8ioSaqv717hz3g9cXSag7iE41voJPkILKgFpPUgF
         ADDoizPlFprMf2kgtUs+Sq6iQZ+viDJKa5HEshbTxLRtvBVP1P4PxM3jl+3CYNVE0JGJ
         6aF1UWnZWMoXKMeEF8VUsEbspN+26gECBFOSUfbP8IKUPudaG4ewxSBysThv0Sy06q8a
         ZEi2Yfdx2b+53gcEqi64cTnK8tzPOn8NLutbefhTbx9SkDuscZdlgNSCRyxmPxtSAfmv
         nYmZKPBekR46csdaCqLXLXZGIo+URJLv7y6PwxCkdPG4lEQNZul/FtX9NqaOBW27odrq
         paMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719027784; x=1719632584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/9AP8f9oWnlydulW7IOn40tz3CggsdR+C3pRKzSoM0=;
        b=A21N0KZPniHG1XgeLqXARwEUKqc5k8DamLUlbV0jWvgdNxvMAWXNNBov6dcvunWAUs
         zcAzvkFQ3P/tfbTepGglncpQRvr4+hgTJjKGd1WZHSYmBfgEFbxfyF/kLg2kcmGnAPa/
         CCj8hmVoi/i3abceN2oLrrFiDElDXFWjlU27I+0/pEt1wa4VHYyYnCLntMc9AYZCnmPv
         8Tywc6kFO0Xu8DLFgMXe2qBUrPWycBOifA1ARM6BMgmlCO8YnFrZ8sFdlC4qZ4kS/edF
         pd5XdjnjzUUTrsHq9MkaqZDl1yM1pYYaDk4WTgWVDjovcSorEl7KStVof2lMdiaMQYyD
         3kTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxSkSGw5jo32LxIbfgWTH4cP5x2w1tAHCT7/5nDMrMhjOuc2TSS/ESLSw14ZI9atT8hGIFoUeVNNhFB/uuZ5ABFLAI4rNk3Njc
X-Gm-Message-State: AOJu0Yw3j+AD+KU3ufxVdME+vP6pLonzuR861+ll8r+m5vVoQMB7MlQi
	dcqtR8kdV4n6uBZoYJxdva2zV15sh8+OI6mAtOBk5qK6/tZqqzes8TQHRmZafxA=
X-Google-Smtp-Source: AGHT+IFnH3cx78e2DnhyAAhYdYmgHcrINAoIi2vO4P6W4liQvBS+Wi4yLniRtuSQUuVrAUzG0K7r+g==
X-Received: by 2002:a17:903:32c9:b0:1f9:bece:4a3c with SMTP id d9443c01a7336-1f9bece54bfmr100442475ad.2.1719027784380;
        Fri, 21 Jun 2024 20:43:04 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:42ed:862d:aca2:ce0a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5bf2sm21643515ad.189.2024.06.21.20.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:43:03 -0700 (PDT)
Date: Fri, 21 Jun 2024 20:43:01 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Ard Biesheuvel <ardb@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH] riscv: enable HAVE_ARCH_STACKLEAK
Message-ID: <ZnZIRafvq7J1B2t6@ghost>
References: <20240617123029.723-1-jszhang@kernel.org>
 <ZnX6YtFGfXd0ixwR@ghost>
 <ZnYenFigMU4Lxa0K@xhacker>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnYenFigMU4Lxa0K@xhacker>

On Sat, Jun 22, 2024 at 08:45:16AM +0800, Jisheng Zhang wrote:
> On Fri, Jun 21, 2024 at 03:10:42PM -0700, Charlie Jenkins wrote:
> > On Mon, Jun 17, 2024 at 08:30:29PM +0800, Jisheng Zhang wrote:
> > > Add support for the stackleak feature. Whenever the kernel returns to user
> > > space the kernel stack is filled with a poison value.
> > > 
> > > At the same time, disables the plugin in EFI stub code because EFI stub
> > > is out of scope for the protection.
> > > 
> > > Tested on qemu and milkv duo:
> > > / # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
> > > [   38.675575] lkdtm: Performing direct entry STACKLEAK_ERASING
> > > [   38.678448] lkdtm: stackleak stack usage:
> > > [   38.678448]   high offset: 288 bytes
> > > [   38.678448]   current:     496 bytes
> > > [   38.678448]   lowest:      1328 bytes
> > > [   38.678448]   tracked:     1328 bytes
> > > [   38.678448]   untracked:   448 bytes
> > > [   38.678448]   poisoned:    14312 bytes
> > > [   38.678448]   low offset:  8 bytes
> > > [   38.689887] lkdtm: OK: the rest of the thread stack is properly erased
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/Kconfig                    | 1 +
> > >  arch/riscv/kernel/entry.S             | 4 ++++
> > >  drivers/firmware/efi/libstub/Makefile | 3 ++-
> > >  3 files changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 0525ee2d63c7..9cbfdffec96c 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -118,6 +118,7 @@ config RISCV
> > >  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> > >  	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> > >  	select HAVE_ARCH_SECCOMP_FILTER
> > > +	select HAVE_ARCH_STACKLEAK
> > 
> > When this is selected, stackleak.h include
> > arch/riscv/include/asm/thread_info.h without sizes.h and I hit:
> > 
> > ./arch/riscv/include/asm/thread_info.h:30:33: error: ‘SZ_4K’ undeclared here (not in a function)
> >    30 | #define OVERFLOW_STACK_SIZE     SZ_4K
> >       |                                 ^~~~~
> > 
> > Adding "#include <linux/sizes.h>" to thread_info.h resolves the issue.
> > I am testing this based on 6.10-rc4. Did you encounter this?
> 
> I didn't meet this kind of compiler error when testing. Mind
> to share your .config file? It looks strange.

The .config exceeds the mailing list character limit, but here is the
defconfig created with savedefconfig. It is just defconfig +
CONFIG_GCC_PLUGIN_STACKLEAK with modules removed. 

CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_BPF_SYSCALL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CGROUPS=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_NAMESPACES=y
CONFIG_USER_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_EXPERT=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_PROFILING=y
CONFIG_ARCH_MICROCHIP=y
CONFIG_ARCH_RENESAS=y
CONFIG_ARCH_SIFIVE=y
CONFIG_ARCH_SOPHGO=y
CONFIG_SOC_STARFIVE=y
CONFIG_ARCH_SUNXI=y
CONFIG_ARCH_THEAD=y
CONFIG_ARCH_VIRT=y
CONFIG_ARCH_CANAAN=y
CONFIG_SMP=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPUFREQ_DT=y
CONFIG_VIRTUALIZATION=y
CONFIG_ACPI=y
CONFIG_JUMP_LABEL=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NETFILTER=y
CONFIG_NET_SCHED=y
CONFIG_NETLINK_DIAG=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_PCI=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCIE_XILINX=y
CONFIG_PCIE_FU740=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_MTD=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_SPI_NOR=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_SCSI_VIRTIO=y
CONFIG_ATA=y
CONFIG_SATA_AHCI=y
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_MD=y
CONFIG_NETDEVICES=y
CONFIG_VIRTIO_NET=y
CONFIG_MACB=y
CONFIG_E1000E=y
CONFIG_R8169=y
CONFIG_RAVB=y
CONFIG_MICREL_PHY=y
CONFIG_MICROSEMI_PHY=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_OF_PLATFORM=y
CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
CONFIG_SERIAL_SH_SCI=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_SPI=y
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_SUN6I=y
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_GPIO_SIFIVE=y
CONFIG_CPU_THERMAL=y
CONFIG_RZG2L_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_SUNXI_WATCHDOG=y
CONFIG_RENESAS_RZG2LWDT=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_GPIO=y
CONFIG_FB=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SOC=y
CONFIG_USB=y
CONFIG_USB_OTG=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_STORAGE=y
CONFIG_USB_UAS=y
CONFIG_USB_GADGET=y
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_DWCMSHC=y
CONFIG_MMC_SDHCI_CADENCE=y
CONFIG_MMC_SPI=y
CONFIG_MMC_SDHI=y
CONFIG_MMC_DW=y
CONFIG_MMC_DW_STARFIVE=y
CONFIG_MMC_SUNXI=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_SUN6I=y
CONFIG_DMADEVICES=y
CONFIG_DW_AXI_DMAC=y
CONFIG_SYNC_FILE=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_CLK_SOPHGO_CV1800=y
# CONFIG_CLK_STARFIVE_JH7100_AUDIO is not set
# CONFIG_CLK_STARFIVE_JH7110_AON is not set
# CONFIG_CLK_STARFIVE_JH7110_STG is not set
# CONFIG_CLK_STARFIVE_JH7110_ISP is not set
# CONFIG_CLK_STARFIVE_JH7110_VOUT is not set
# CONFIG_SUN8I_DE2_CCU is not set
CONFIG_RENESAS_OSTM=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
CONFIG_SUN50I_IOMMU=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_VIRTIO=y
CONFIG_EXTCON=y
CONFIG_IIO=y
CONFIG_PHY_RCAR_GEN3_USB2=y
CONFIG_LIBNVDIMM=y
CONFIG_NVMEM_SUNXI_SID=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_AUTOFS_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_HUGETLBFS=y
# CONFIG_EFIVAR_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V4=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_ROOT_NFS=y
CONFIG_9P_FS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_SECURITY=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_APPARMOR=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_WQ_WATCHDOG=y
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_FTRACE is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y


