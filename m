Return-Path: <linux-efi+bounces-5213-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA0C1A047
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED9518912FE
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 11:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE44330310;
	Wed, 29 Oct 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G6c7LF4e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCA32F761
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737228; cv=none; b=K7ySLRTrS8fIWOlqhsJJ+Q4MFo81zgZDEV10KwukVs4xU6LG9/L0tMgqjmRDJNBKRf87d5EghN69SKYyAqJ+M7oI6laplawiFfirr/kO8HWxD83oGoe+rGpSlHQ1K4vzATWKLSnsRiym6qHPbJZZXXA7bNcvTMft4gTUertjR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737228; c=relaxed/simple;
	bh=Hjkf53zqmGuffTDA/lEf7CNxn/oGC5EWuEOnSQGpNUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gax7HDnRn71HFZ4rz1ZCCPa5iCuSAmkXdWvyxHHVxTNsp6aR1gk/cUmHUUQwa0u3P9UvpgqXClvx7yczZisPvgOBuJ565XhZxOaNJe56DrfYUDqB2VCaMcuNEMnHKZwnJSYkk++H5VSVlteX/P+Fa9KT/q6OP3Nf/9VPUg+Hqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=G6c7LF4e; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso7658255a91.1
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737224; x=1762342024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/A6oM3VT03v+OO6JYlGjLYI0SFwHFSmDU7wY8ZWBxg=;
        b=G6c7LF4e+f4s2AYPLQKTLRnc9nPT3davp1/XTjgz645UVttXKTA2x4v9WbO+BsWI0O
         h3ogonXDJQtdomshXokrrcrZpAv/mM2PRpHchjAJFvQ3YqOjWVmI23dqJyvXeg/EVghf
         GmP7iBDNxYJGwbPjNbUzplnd9w0Kp1mm96ugwmeQxdVxyU39iRSTcv5veq0/qLjU7UxF
         nFYJ2waVwj7tVnKG3u5YmWpAPmFhPOxiyBvtjEyoS1baWJJZxGOOvAHCdqL7Iox1dCkt
         kZhJSzFsLy9M0mlFhE6G8jCUABby4+QRoK1t4ts2xpc9Mpytwx/PeXsS5qtZjJ71se8t
         b7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737224; x=1762342024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/A6oM3VT03v+OO6JYlGjLYI0SFwHFSmDU7wY8ZWBxg=;
        b=kghlvtqJCJyzPtMXF7AVHJJ0Wncb8mnd8gihNS0zC5Jak21uFCPjtUccWn7Ca9Fwno
         xc6Co8IH4w5oZ4Vq0o52vYZx+j5B4uJ/6Cs0pknt/gXBCcmgX4i7PJ+ICX8Ba/mzNHx/
         XNr3dJuOZl23ygjNfvju3XFgCHGVLct7+BINrWjBwhhZB61XCEAim6mOBOPibR2zCTtz
         vGa5YhZ+thpbm6tmgTjR9BDqFZ9NosXDV9z0gr6cw+L6iMisBl1rybggmfjS2Mp3cK76
         V/8eXlhiMRLq0rSDqGW6boJJynHfzZWwGxLXooFBuzXHz1uuzE64k7l70GW5m/dkHQHY
         TwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxWxUeb1oO+ZNYbq4OEUGnO97HyNG8ekt+QIJw8wZe2VCaUV9pIwoCH8sjHaT/lXXYxduEXeaKh7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5lNcfOhKF7fW4oyk/R5s9taTy1PbZMU/xGyad7nd+NMkbJWV
	lCBH3YhQNQDRcA6ywVcT15GiK3NSzXAJ363FFHVgIvJqJxenZvnHCbY7/9G5v7FSeYk=
X-Gm-Gg: ASbGnctUWOa0xAHTPvvSCglE5Eun6WxPPNbaoQg/0D2IsQqaKhLudlGCSvVdLB0nPRA
	1nKLcSFaqPOJPzz7fkXXsTNpz+15GW6d47a3/D8jly1LFPVKcfBpGZKbsbgFj9TU7DokiCEC9UE
	6YFOBw0RsbOl96KHf+SmDix4lIco68s/Wt42g1QPEaKG70RWGqZ9fk1sPv75Hyy7DN5VVNNTOmH
	f5cjrrxAdf2oTo5jiv/AITGAWWP6DtzLBsWshu2BsCKhaR4vl88otms+66VJXtZGu6e8tqz4RkU
	PkIdcyszhg5psIvcEsNzZdF5EmM1FnpsiC0i47YpYEs98CS0QHG/SwEaHQUHZFisOP/kUKBMtim
	si1tgdAZmB78CKN0tCKgGwLLQeRj8AWNM47WE5cvHUKEa4qo6n6NcL3A27Mmz24a9Vo43sog2Y/
	+12UHO3zaMsspqr4ynKMzNT+PusIJo
X-Google-Smtp-Source: AGHT+IHpjKO2jUEb6+cQytmuQWp7mpQLNMuWE1ztXt3I54KFHlYNvHVC4AHhBNanzFdemT5w+k0ovA==
X-Received: by 2002:a17:90b:134b:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-3403a28efb0mr2855484a91.27.1761737223563;
        Wed, 29 Oct 2025 04:27:03 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:03 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 00/10] Add RAS support for RISC-V architecture
Date: Wed, 29 Oct 2025 16:56:38 +0530
Message-ID: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RAS stands for Reliability, Availability and Serviceability.

This series implements the RAS support for RISC-V architecture using
RISC-V RERI specification. It is conformant to ACPI platform error
interfaces (APEI). It uses the highest priority Supervisor Software
Events (SSE)[2] to deliver the hardware error events to the kernel.
The SSE implementation has already been merged in OpenSBI. Clement
has sent a patch series for its implemenation in Linux kernel.[5]

The GHES driver framework is used as is with the following changes for RISC-V:
	1. Register each ghes entry with SSE layer. Ghes notification vector is SSE event.
	2. Add RISC-V specific entries for processor type and ISA string
	3. Add fixmap indices GHES SSE Low and High Priority to help map and read from
	   physical addresses present in GHES entry.
	4. Other changes to build/configure the RAS support

How to Use:
----------
This RAS stack consists of Qemu[3], OpenSBI, EDK2[4], Linux kernel and devmem utility to inject and trigger
errors. Qemu [Ref.] has support to emulate RISC-V RERI. The RAS agent is implemented in OpenSBI which
creates CPER records. EDK2 generates HEST table and populates it with GHES entries with the help of
OpenSBI.

Qemu Command:
------------
<qemu-dir>/build/qemu-system-riscv64 \
    -s -accel tcg -m 4096 -smp 2 \
    -cpu rv64,smepmp=false \
    -serial mon:stdio \
    -d guest_errors -D ./qemu.log \
    -bios <opensbi-dir>/build/platform/generic/firmware/fw_dynamic.bin \
    -monitor telnet:127.0.0.1:55555,server,nowait \
    -device virtio-gpu-pci -full-screen \ 
    -device qemu-xhci \
    -device usb-kbd \
    -blockdev node-name=pflash0,driver=file,read-only=on,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_CODE.fd \
    -blockdev node-name=pflash1,driver=file,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_VARS.fd \
    -M virt,pflash0=pflash0,pflash1=pflash1,rpmi=true,reri=true,aia=aplic-imsic \
    -kernel <kernel image> \
    -initrd <rootfs image> \
    -append "root=/dev/ram rw console=ttyS0 earlycon=uart8250,mmio,0x10000000"

Error Injection & Triggering:
----------------------------
devmem 0x4010040 32 0x2a1
devmem 0x4010048 32 0x9001404
devmem 0x4010044 8 1

The above commands injects a TLB error on CPU 0.

Sample Output (CPU 0):
---------------------
[   34.370282] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[   34.371375] {1}[Hardware Error]: event severity: recoverable
[   34.372149] {1}[Hardware Error]:  Error 0, type: recoverable
[   34.372756] {1}[Hardware Error]:   section_type: general processor error
[   34.373357] {1}[Hardware Error]:   processor_type: 3, RISCV
[   34.373806] {1}[Hardware Error]:   processor_isa: 6, RISCV64
[   34.374294] {1}[Hardware Error]:   error_type: 0x02
[   34.374845] {1}[Hardware Error]:   TLB error
[   34.375448] {1}[Hardware Error]:   operation: 1, data read
[   34.376100] {1}[Hardware Error]:   target_address: 0x0000000000000000

References:
----------
[1] RERI Specification: https://github.com/riscv-non-isa/riscv-ras-eri/releases/download/v1.0/riscv-reri.pdf
[2] SSE Section in OpenSBI v3.0: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0/riscv-sbi.pdf
[3] Qemu source (with RERI emulation support): https://github.com/ventanamicro/qemu.git (branch: dev-upstream)
[4] EDK2: https://github.com/ventanamicro/edk2.git (branch: dev-upstream)
[5] SSE Kernel Patches (v7): https://lore.kernel.org/all/20250908181717.1997461-1-cleger@rivosinc.com/

Changes in v2:
 - Made changes to be conformant with SSE v7 patches
 - Fixed some bot warnings

Himanshu Chauhan (10):
  riscv: Define ioremap_cache for RISC-V
  riscv: Define arch_apei_get_mem_attribute for RISC-V
  acpi: Introduce SSE in HEST notification types
  riscv: Add fixmap indices for GHES IRQ and SSE contexts
  riscv: conditionally compile GHES NMI spool function
  riscv: Add functions to register ghes having SSE notification
  riscv: Add RISC-V entries in processor type and ISA strings
  riscv: Introduce HEST SSE notification handlers
  riscv: Select HAVE_ACPI_APEI required for RAS
  riscv: Enable APEI GHES driver in defconfig

 arch/riscv/Kconfig                     |   1 +
 arch/riscv/configs/defconfig           |   3 +
 arch/riscv/include/asm/acpi.h          |  20 ++++
 arch/riscv/include/asm/fixmap.h        |   8 ++
 arch/riscv/include/asm/io.h            |   3 +
 drivers/acpi/apei/Kconfig              |   5 +
 drivers/acpi/apei/ghes.c               | 103 +++++++++++++++--
 drivers/firmware/efi/cper.c            |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 147 +++++++++++++++++++++++++
 include/acpi/actbl1.h                  |   3 +-
 include/linux/riscv_sbi_sse.h          |  16 +++
 11 files changed, 300 insertions(+), 12 deletions(-)

-- 
2.43.0


