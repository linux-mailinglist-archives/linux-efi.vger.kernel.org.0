Return-Path: <linux-efi+bounces-4743-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DAB543E5
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 09:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA42188CC84
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77785281530;
	Fri, 12 Sep 2025 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q1IyLvD+"
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1542820D1;
	Fri, 12 Sep 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662246; cv=none; b=i/+RAWOjc/UUoj8ZSKVGc5KtFwrEY3MUVsXTHIp1G/el/M/QKrdirpFXwMLi5ZKJdzrtCmKpxmW373wAktm6OMhvaZbnTmg6iwVwhVMbuJytztvnO5V6e8GFnuyw5MMDnp9PjbnnW7Da9XEP/un1vfq9JygFxeDmWxBXf5aMpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662246; c=relaxed/simple;
	bh=P7cUOL2g+F6gp0/6ezwtEHsJfG+nztCCunpKN92MqQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lW79dB80BiXQVY4AzBeIDzgh7DZmCWdTdh7ixqrFwD0TitzULcJyTelEk+bEHg5rLJI+2yWbKOrMcNqKMuqwI18ro13BVv+gu2e4U0bI++y/UnxsIPtP4vX3tL3KxKmiDQwStCsPzpZ0a5ONB2Mhl80K+ncuyEx12OzN+0h5Ue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q1IyLvD+; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757662240; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GKqEXm4uUJ/zbwCaM3425+aQc2qcRW4Q7cTIqt152L8=;
	b=q1IyLvD+xOdaxn0ygPVsg7Y91Wm5QECfVh0mhHXNr9d4ywX1wWWPLAuEED/a8qPqvRpKgv0pTpda18MqnJjloiYGlrVWL4yliIHXK4fMHRTdFAnVgT8lN0of2NiL4qgBnSYqQFyuWvIPCSHArCq3rxPMLYwZIRJMndU2f9+xbmU=
Received: from 30.222.50.8(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WnqAeI._1757662238 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 15:30:38 +0800
Message-ID: <72563756-a53a-4f50-9bf4-87f6b26af036@linux.alibaba.com>
Date: Fri, 12 Sep 2025 15:30:41 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/10] Add RAS support for RISC-V architecture
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 cleger@rivosinc.com, robert.moore@intel.com, sunilvl@ventanamicro.com,
 apatel@ventanamicro.com, xueshuai@linux.alibaba.com
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/2/27 20:36, Himanshu Chauhan 写道:
> This series implements the RAS (Reliability, Availability and Serviceability)
> support for RISC-V architecture using RISC-V RERI specification. It is conformant
> to ACPI platform error interfaces (APEI). It uses the highest priority
> Supervisor Software Events (SSE)[2] to deliver the hardware error events to the kernel.
> The SSE implemetation has already been merged in OpenSBI. Clement has sent a patch series for
> its implemenation in Linux kernel.[5]
>
> The GHES driver framework is used as is with the following changes for RISC-V:
> 	1. Register each ghes entry with SSE layer. Ghes notification vector is SSE event.
> 	2. Add RISC-V specific entries for processor type and ISA string
> 	3. Add fixmap indices GHES SSE Low and High Priority to help map and read from
> 	   physical addresses present in GHES entry.
> 	4. Other changes to build/configure the RAS support
>
> How to Use:
> ----------
> This RAS stack consists of Qemu[3], OpenSBI, EDK2[4], Linux kernel and devmem utility to inject and trigger
> errors. Qemu [Ref.] has support to emulate RISC-V RERI. The RAS agent is implemented in OpenSBI which
> creates CPER records. EDK2 generates HEST table and populates it with GHES entries with the help of
> OpenSBI.
>
> Qemu Command:
> ------------
> <qemu-dir>/build/qemu-system-riscv64 \
>      -s -accel tcg -m 4096 -smp 2 \
>      -cpu rv64,smepmp=false \
>      -serial mon:stdio \
>      -d guest_errors -D ./qemu.log \
>      -bios <opensbi-dir>/build/platform/generic/firmware/fw_dynamic.bin \
>      -monitor telnet:127.0.0.1:55555,server,nowait \
>      -device virtio-gpu-pci -full-screen \
>      -device qemu-xhci \
>      -device usb-kbd \
>      -blockdev node-name=pflash0,driver=file,read-only=on,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_CODE.fd \
>      -blockdev node-name=pflash1,driver=file,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_VARS.fd \
>      -M virt,pflash0=pflash0,pflash1=pflash1,rpmi=true,reri=true,aia=aplic-imsic \
>      -kernel <kernel image> \
>      -initrd <rootfs image> \
>      -append "root=/dev/ram rw console=ttyS0 earlycon=uart8250,mmio,0x10000000"
>
> Error Injection & Triggering:
> ----------------------------
> devmem 0x4010040 32 0x2a1
> devmem 0x4010048 32 0x9001404
> devmem 0x4010044 8 1
>
> The above commands injects a TLB error on CPU 0.
>
> Sample Output (CPU 0):
> ---------------------
> [   34.370282] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> [   34.371375] {1}[Hardware Error]: event severity: recoverable
> [   34.372149] {1}[Hardware Error]:  Error 0, type: recoverable
> [   34.372756] {1}[Hardware Error]:   section_type: general processor error
> [   34.373357] {1}[Hardware Error]:   processor_type: 3, RISCV
> [   34.373806] {1}[Hardware Error]:   processor_isa: 6, RISCV64
> [   34.374294] {1}[Hardware Error]:   error_type: 0x02
> [   34.374845] {1}[Hardware Error]:   TLB error
> [   34.375448] {1}[Hardware Error]:   operation: 1, data read
> [   34.376100] {1}[Hardware Error]:   target_address: 0x0000000000000000
>
> References:
> ----------
> [1] RERI Specification: https://github.com/riscv-non-isa/riscv-ras-eri/releases/download/v1.0/riscv-reri.pdf
> [2] SSE Section in OpenSBI v3.0: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc3/riscv-sbi.pdf
> [3] Qemu source (with RERI emulation support): https://github.com/ventanamicro/qemu.git (branch: dev-upstream)
> [4] EDK2: https://github.com/ventanamicro/edk2.git (branch: dev-upstream)
> [5] SSE Kernel Patches: https://lore.kernel.org/linux-riscv/649fdead-09b0-4f94-a6ff-099fc970d890@rivosinc.com/T/

Hi,

Thanks for this series.

I'm doing some work related to your patch. Besides SSE, I'm working on support
for another notification type for synchronous hardware errors (e.g., on a poison
read), which called Hardware Error Exception (HEE) in Dhaval Sharma's UEFI
proposal[0] in PRS-TG.  I have a patch for HEE support which I've sent out
separately[1].

Perhaps we could merge my work into your patchset to bringing a complete RAS
solution to the RISC-V architecture? Or, I'm also happy to wait for your patches
to land and then continue my work on top.

Let me know what you think would be best.

Cheers,
Ruidong Tian

[0]: https://lists.riscv.org/g/tech-prs/topic/risc_v_ras_related_ecrs/113685653
[1]: https://lore.kernel.org/all/20250910093347.75822-6-tianruidong@linux.alibaba.com/

> Himanshu Chauhan (10):
>    riscv: Define ioremap_cache for RISC-V
>    riscv: Define arch_apei_get_mem_attribute for RISC-V
>    acpi: Introduce SSE in HEST notification types
>    riscv: Add fixmap indices for GHES IRQ and SSE contexts
>    riscv: conditionally compile GHES NMI spool function
>    riscv: Add functions to register ghes having SSE notification
>    riscv: Add RISC-V entries in processor type and ISA strings
>    riscv: Introduce HEST SSE notification handlers
>    riscv: Add config option to enable APEI SSE handler
>    riscv: Enable APEI and NMI safe cmpxchg options required for RAS
>
>   arch/riscv/Kconfig                 |   2 +
>   arch/riscv/include/asm/acpi.h      |  20 ++++
>   arch/riscv/include/asm/fixmap.h    |   8 ++
>   arch/riscv/include/asm/io.h        |   3 +
>   drivers/acpi/apei/Kconfig          |   5 +
>   drivers/acpi/apei/ghes.c           | 102 +++++++++++++++++---
>   drivers/firmware/efi/cper.c        |   3 +
>   drivers/firmware/riscv/riscv_sse.c | 147 +++++++++++++++++++++++++++++
>   include/acpi/actbl1.h              |   3 +-
>   include/linux/riscv_sse.h          |  15 +++
>   10 files changed, 296 insertions(+), 12 deletions(-)
>

