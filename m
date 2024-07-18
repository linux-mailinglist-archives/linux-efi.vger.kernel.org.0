Return-Path: <linux-efi+bounces-1460-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4060934A8F
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 10:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116CF28687A
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 08:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B37F460;
	Thu, 18 Jul 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEM9FS0e"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8E7A715
	for <linux-efi@vger.kernel.org>; Thu, 18 Jul 2024 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293136; cv=none; b=UjytPSZwdjvBOIuooZYPZjVrhOvnTfQfMfniP0Ec/uwJQGLWyh9zlkX7uc7e+ZWnJoZc3VYtwRxd46UKFqdfv6k6IWXVq50N/Vnhag971JctBZCfcZjABg2lZIeIwtwzMDxel3JzTYKI+jRRz6oxiUwa1tdQkZRpYO3xCPxNH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293136; c=relaxed/simple;
	bh=4lDsaA2aKHlJ61vz50kJ3jYASP3OQf7A0s2Kva+RhHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mun1Two0+EtNt0DE9cwyvQiTVENOKbmPlvZ+Bi/IxDORmrvWl841JGPhnRrizI1hQvGXBGw+R0IH6vmPm0Q0O8vEMcQjB6lCX1oMrquJXMZd7P0oGtHxVYEbnjtztAgTdnL4IY/z8qi5L4gZhFFt5J7qXaSacLS0WmMEN8h5+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEM9FS0e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwOnHPkmxLOYtjt6MO8OWx7h5LkIIkcp51BsdFCiSNk=;
	b=XEM9FS0eErruaQIW4sfrurjPtzvMcNXFAwQzdokvEe5w2kouZPL1lhlQu+CNggP15dRcXN
	jb35M7XEmg1vk/s8+TeXZhyWSOrr8rpZHg7J8/yvMKn0DnlZhLGNptleHfc1MPG3xc5Vht
	O3YVKIR1V24Pecx6OXxD56PVAtodc54=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-FbkKMEPzOCym2v-wDC6Xhg-1; Thu,
 18 Jul 2024 04:58:48 -0400
X-MC-Unique: FbkKMEPzOCym2v-wDC6Xhg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB55D1955D56;
	Thu, 18 Jul 2024 08:58:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EEC83000187;
	Thu, 18 Jul 2024 08:58:36 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC 3/7] efi/emulator: Initial rountines to emulate EFI boot time service
Date: Thu, 18 Jul 2024 16:57:53 +0800
Message-ID: <20240718085759.13247-4-piliu@redhat.com>
In-Reply-To: <20240718085759.13247-1-piliu@redhat.com>
References: <20240718085759.13247-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Pingfan Liu <kernelfans@gmail.com>

efi emulator aims to serve the kexec if the kernel wrapped by efistub.
It is paired with efistub, so only implements the minimus set of EFI boot
service which merely enough boots up efistub.

To simplify the code, the task such as the building of page table etc is
shift to the first kernel as more as possible. (This part is implement
in the later patch in this series)

To do:
-1. a simple memory allocator
-2. a few extra efi boot service.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
To: kexec@lists.infradead.org
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/Makefile                 |   1 +
 drivers/firmware/efi/efi_emulator/Makefile    |  98 +++++
 .../firmware/efi/efi_emulator/amba-pl011.c    |  80 ++++
 .../efi_emulator/arm64_emulator_service.lds   |  45 ++
 .../firmware/efi/efi_emulator/config_table.c  |  23 ++
 drivers/firmware/efi/efi_emulator/core.c      | 211 ++++++++++
 drivers/firmware/efi/efi_emulator/earlycon.h  |  19 +
 .../firmware/efi/efi_emulator/efi_emulator.S  |  12 +
 drivers/firmware/efi/efi_emulator/emulator.h  |  66 +++
 drivers/firmware/efi/efi_emulator/entry.c     |  57 +++
 drivers/firmware/efi/efi_emulator/head.S      |  10 +
 drivers/firmware/efi/efi_emulator/initrd.c    |  15 +
 drivers/firmware/efi/efi_emulator/lib.c       |  73 ++++
 drivers/firmware/efi/efi_emulator/memory.c    |  27 ++
 .../firmware/efi/efi_emulator/memory_api.c    |  73 ++++
 drivers/firmware/efi/efi_emulator/misc.c      |  76 ++++
 drivers/firmware/efi/efi_emulator/pe_loader.c | 124 ++++++
 drivers/firmware/efi/efi_emulator/printf.c    | 389 ++++++++++++++++++
 .../efi/efi_emulator/runtime_service.c        |  28 ++
 include/linux/efi_emulator.h                  |  45 ++
 include/linux/kexec.h                         |   2 +
 21 files changed, 1474 insertions(+)
 create mode 100644 drivers/firmware/efi/efi_emulator/Makefile
 create mode 100644 drivers/firmware/efi/efi_emulator/amba-pl011.c
 create mode 100644 drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds
 create mode 100644 drivers/firmware/efi/efi_emulator/config_table.c
 create mode 100644 drivers/firmware/efi/efi_emulator/core.c
 create mode 100644 drivers/firmware/efi/efi_emulator/earlycon.h
 create mode 100644 drivers/firmware/efi/efi_emulator/efi_emulator.S
 create mode 100644 drivers/firmware/efi/efi_emulator/emulator.h
 create mode 100644 drivers/firmware/efi/efi_emulator/entry.c
 create mode 100644 drivers/firmware/efi/efi_emulator/head.S
 create mode 100644 drivers/firmware/efi/efi_emulator/initrd.c
 create mode 100644 drivers/firmware/efi/efi_emulator/lib.c
 create mode 100644 drivers/firmware/efi/efi_emulator/memory.c
 create mode 100644 drivers/firmware/efi/efi_emulator/memory_api.c
 create mode 100644 drivers/firmware/efi/efi_emulator/misc.c
 create mode 100644 drivers/firmware/efi/efi_emulator/pe_loader.c
 create mode 100644 drivers/firmware/efi/efi_emulator/printf.c
 create mode 100644 drivers/firmware/efi/efi_emulator/runtime_service.c
 create mode 100644 include/linux/efi_emulator.h

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index a2d0009560d0f..eb2a5d864f416 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
 obj-$(CONFIG_UEFI_CPER)			+= cper.o cper_cxl.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
 subdir-$(CONFIG_EFI_STUB)		+= libstub
+obj-y					+= efi_emulator/
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
 obj-$(CONFIG_EFI_TEST)			+= test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
diff --git a/drivers/firmware/efi/efi_emulator/Makefile b/drivers/firmware/efi/efi_emulator/Makefile
new file mode 100644
index 0000000000000..e37472004a2b5
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/Makefile
@@ -0,0 +1,98 @@
+# non-x86 reuses KBUILD_CFLAGS, x86 does not
+cflags-y			:= $(KBUILD_CFLAGS)
+
+cflags-$(CONFIG_X86_32)		:= -march=i386
+cflags-$(CONFIG_X86_64)		:= -mcmodel=small
+cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
+				   -fno-strict-aliasing -mno-red-zone \
+				   -mno-mmx -mno-sse -fshort-wchar \
+				   -Wno-pointer-sign \
+				   $(call cc-disable-warning, address-of-packed-member) \
+				   $(call cc-disable-warning, gnu) \
+				   -fno-asynchronous-unwind-tables \
+				   $(CLANG_FLAGS)
+
+# arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
+# disable the stackleak plugin
+cflags-$(CONFIG_ARM64)		+= $(DISABLE_STACKLEAK_PLUGIN) \
+				   -fno-unwind-tables -fno-asynchronous-unwind-tables
+cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
+				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
+				   -DEFI_HAVE_STRCMP -fno-builtin  \
+				   $(call cc-option,-mno-single-pic-base)
+cflags-$(CONFIG_RISCV)		+= -DNO_ALTERNATIVE -mno-relax
+cflags-$(CONFIG_LOONGARCH)	+=
+
+cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
+
+cflags-y	+= -I drivers/firmware/efi/libstub
+
+KBUILD_CFLAGS			:= $(subst $(CC_FLAGS_FTRACE),,$(cflags-y)) \
+				   -Os -DDISABLE_BRANCH_PROFILING \
+				   -D__NO_FORTIFY \
+				   -ffreestanding \
+				   -fno-stack-protector \
+				   $(call cc-option,-fno-addrsig) \
+				   -D__DISABLE_EXPORTS
+
+#
+# struct randomization only makes sense for Linux internal types, which the EFI
+# stub code never touches, so let's turn off struct randomization for the stub
+# altogether
+#
+KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS), $(KBUILD_CFLAGS))
+
+# remove SCS flags from all objects in this directory
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable CFI
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
+
+GCOV_PROFILE			:= n
+# Sanitizer runtimes are unavailable and cannot be linked here.
+KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
+KMSAN_SANITIZE			:= n
+UBSAN_SANITIZE			:= n
+OBJECT_FILES_NON_STANDARD	:= y
+
+# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
+KCOV_INSTRUMENT			:= n
+
+OBJECT_FILES_NON_STANDARD	:= y
+emulator-y			:= head.o entry.o \
+				   core.o pe_loader.o misc.o memory.o memory_api.o runtime_service.o config_table.o \
+				   lib.o printf.o \
+				   amba-pl011.o
+obj-y				:= efi_emulator.o
+
+
+EMULATOR_OBJS = $(addprefix $(obj)/,$(emulator-y))
+
+quiet_cmd_ar_emulator = PAD     $@
+      cmd_ar_emulator = $(AR) rcSTP $@ $^
+
+$(obj)/emulator.a: $(EMULATOR_OBJS)
+	$(call if_changed,ar_emulator)
+
+
+quiet_cmd_link_emulator = PAD     $@
+      cmd_link_emulator = ld -z norelro -z noexecstack -shared --no-undefined -X -Bsymbolic -z notext --emit-relocs --no-apply-dynamic-relocs  \
+				-T $(srctree)/drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds \
+                                --whole-archive $< --no-whole-archive -o $@
+
+
+$(obj)/emulator.ro: $(obj)/emulator.a FORCE
+	$(call if_changed,link_emulator)
+
+
+$(obj)/emulator.raw: $(obj)/emulator.ro FORCE
+	objcopy  -O binary -R .note -R .note.gnu.build-id -R .comment -g $< $@
+
+$(obj)/efi_emulator.o: $(obj)/emulator.raw
+
+
+targets				+= $(emulator-y)
+
+
diff --git a/drivers/firmware/efi/efi_emulator/amba-pl011.c b/drivers/firmware/efi/efi_emulator/amba-pl011.c
new file mode 100644
index 0000000000000..334b25e177081
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/amba-pl011.c
@@ -0,0 +1,80 @@
+
+#include <linux/stdarg.h>
+#include <linux/amba/serial.h>
+#include "earlycon.h"
+
+#define SERIAL_IO_MEM32 3
+#define UPIO_MEM32 SERIAL_IO_MEM32
+
+struct uart_port {
+	unsigned long		iobase;			/* in/out[bwl] */
+	unsigned char __iomem	*membase;		/* read/write[bwl] */
+	unsigned char		iotype;			/* io access style */
+};
+
+static struct uart_port pl011_port;
+
+static void pl011_putc(struct uart_port *port, unsigned char c)
+{
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+		cpu_relax();
+	if (port->iotype == UPIO_MEM32)
+		writel(c, port->membase + UART01x_DR);
+	else
+		writeb(c, port->membase + UART01x_DR);
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+		cpu_relax();
+}
+
+static int pl011_put_str(const char *str, void *data)
+{
+	char *p = (char *)str;
+	struct uart_port *port = (struct uart_port *)data;
+
+	for (; *p != '\0'; p++)
+		pl011_putc(port, *p);
+
+	return (p - str);
+}
+
+static void pl011_write(struct uart_port *port, unsigned int reg, unsigned int val)
+{
+	void __iomem *addr = port->membase + reg;
+
+	if (port->iotype == UPIO_MEM32)
+		writel_relaxed(val, addr);
+	else
+		writew_relaxed(val, addr);
+}
+
+static bool pl011_match(struct efi_emulator_param *param, const char *name)
+{
+	struct uart_port *port = &pl011_port;
+
+	if (strcmp(param->earlycon_name, name))
+		return false;
+
+	port->iotype = UPIO_MEM32;
+	port->membase = (unsigned char *)param->earlycon_reg_base;
+	return true;
+}
+
+static void pl011_reset(void *data)
+{
+	struct uart_port *port = data;
+
+	/* disable DMA */
+	pl011_write(port, UART011_DMACR, 0);
+	/* disable interrupt */
+	pl011_write(port, UART011_IMSC, 0);
+	/* Skip: set clk rate */
+	/* Now, pl011 can be used in poll mode */
+}
+
+struct earlycon pl011 = {
+	.match = pl011_match,
+	.reset = pl011_reset,
+	.put_str = pl011_put_str,
+	.data = &pl011_port,
+	.name = "amba-pl011",
+};
diff --git a/drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds b/drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds
new file mode 100644
index 0000000000000..82d7659346af5
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+ENTRY(emulator_entry)
+EMULATOR_BASE_ADDR = 0x0;
+
+SECTIONS
+{
+	. = EMULATOR_BASE_ADDR;
+	.head : ALIGN(4096) {
+		*(.head.text)
+	}
+
+	.text : {
+		*(.text* .init.text*)
+	}
+
+	.rodata : ALIGN(8) {
+		*(.rodata* .init.rodata* .srodata*)
+
+		_etext = ALIGN(4096);
+		. = _etext;
+	}
+
+	.rela.dyn : ALIGN(4096) {
+		_rela_start = .;
+		*(.rela .rela*)
+		_rela_end = .;
+	}
+
+	.data : ALIGN(4096) {
+		*(.data* .init.data*)
+		_edata = ALIGN(512);
+		. = _edata;
+	}
+
+	.bss : {
+		*(.bss* .init.bss*)
+		_end = ALIGN(512);
+		. = _end;
+	}
+
+	/DISCARD/ : {
+		*(.modinfo .init.modinfo)
+	}
+}
diff --git a/drivers/firmware/efi/efi_emulator/config_table.c b/drivers/firmware/efi/efi_emulator/config_table.c
new file mode 100644
index 0000000000000..3efe76cbd86fd
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/config_table.c
@@ -0,0 +1,23 @@
+
+#include "emulator.h"
+
+
+static efi_status_t conjoin_memreserve_table(void *table, efi_config_table_t *t)
+{
+	struct linux_efi_memreserve *prev, *next;
+
+	prev = (struct linux_efi_memreserve *)t->table;
+	next = (struct linux_efi_memreserve *)table;
+
+	prev->next = (phys_addr_t)next;
+	next->next = 0;
+	return EFI_SUCCESS;
+}
+
+efi_status_t conjoin_table(efi_guid_t *uuid, void *table, efi_config_table_t *t)
+{
+	if (!efi_guidcmp(t->guid, LINUX_EFI_MEMRESERVE_TABLE_GUID))
+		return conjoin_memreserve_table(table, t);
+
+	return EFI_OUT_OF_RESOURCES;
+}
diff --git a/drivers/firmware/efi/efi_emulator/core.c b/drivers/firmware/efi/efi_emulator/core.c
new file mode 100644
index 0000000000000..29f3671a2db26
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/core.c
@@ -0,0 +1,211 @@
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "emulator.h"
+
+int emulator_initialize(void);
+
+struct efi_emulator_param *emulator_param;
+
+static efi_loaded_image_t loaded_image;
+static bool print_enabled;
+
+/* The 1st kernel convert cmdline to utf16 and pass to emulator */
+static efi_status_t handle_protocol_loaded_image(efi_handle_t h, void **data)
+{
+	loaded_image.load_options = emulator_param->cmdline;
+	loaded_image.load_options_size = emulator_param->sz_in_byte;
+	/* loaded address */
+	loaded_image.image_base = 0x0;
+
+	*data = &loaded_image;
+	return EFI_SUCCESS;
+
+}
+
+
+static efi_status_t __efiapi emulator_handle_protocol(efi_handle_t h,
+				efi_guid_t *uuid, void **data)
+{
+	if (!efi_guidcmp(*uuid, LOADED_IMAGE_PROTOCOL_GUID))
+		return handle_protocol_loaded_image(h, data);
+
+	return EFI_UNSUPPORTED;
+}
+
+//The LocateProtocol() function finds the first device handle that support Protocol, and returns a
+// pointer to the protocol interface from that handle in Interface. If no protocol instances are found, then Interface is set to NULL.
+static efi_status_t __efiapi emulator_locate_protocol(efi_guid_t *uuid,
+				void *registration, void **interface)
+{
+	if (!efi_guidcmp(*uuid, EFI_TCG2_PROTOCOL_GUID)) {
+		*interface = &emulator_tcg2;
+		return EFI_SUCCESS;
+	} else if (!efi_guidcmp(*uuid, EFI_CC_MEASUREMENT_PROTOCOL_GUID)) {
+		*interface = &emulator_cc;
+		return EFI_SUCCESS;
+	} else if (!efi_guidcmp(*uuid, EFI_RNG_PROTOCOL_GUID)) {
+		*interface = &emulator_rng;
+		return EFI_SUCCESS;
+	}
+
+	return EFI_UNSUPPORTED;
+}
+
+// 2do
+static efi_status_t __efiapi emulator_allocate_pages(int alloc_type, int mem_type,
+			unsigned long nr_pages, efi_physical_addr_t *addr)
+{
+	return __emulator_allocate_pages(alloc_type, mem_type, nr_pages, addr);
+}
+
+// 2do
+static efi_status_t __efiapi emulator_free_pages(efi_physical_addr_t addr,
+			unsigned long nr_4KB)
+{
+	return EFI_SUCCESS;
+
+}
+
+static efi_status_t __efiapi emulator_allocate_pool(int mem_type, unsigned long sz,
+				       void **pool)
+{
+	return __emulator_allocate_pool(mem_type, sz, pool);
+
+}
+
+static efi_status_t __efiapi emulator_free_pool(void *pool)
+{
+	return EFI_SUCCESS;
+
+}
+
+/* memmove() alias as memcpy() */
+static void __efiapi emulator_copy_mem(void *dest, const void *src, unsigned long count)
+{
+	char *tmp;
+	const char *s;
+
+	if (dest <= src) {
+		tmp = dest;
+		s = src;
+		while (count--)
+			*tmp++ = *s++;
+	} else {
+		tmp = dest;
+		tmp += count;
+		s = src;
+		s += count;
+		while (count--)
+			*--tmp = *--s;
+	}
+
+}
+
+static void __efiapi emulator_set_mem(void *dst, unsigned long cnt, unsigned char val)
+{
+	unsigned char *dst_ptr = (char *)dst;
+	unsigned long i;
+
+	for (i = 0; i < cnt; i++)
+		dst_ptr[i] = val;
+}
+
+static efi_status_t __efiapi emulator_install_configuration_table(efi_guid_t *uuid,
+								     void *table)
+{
+	efi_config_table_t *t = (efi_config_table_t *)systabs.tables;
+	int i;
+
+	for (i = 0; i < systabs.nr_tables; i++, t++) {
+		if (!efi_guidcmp(t->guid, *uuid))
+			return conjoin_table(uuid, table, t);
+	}
+	t->guid = *uuid;
+	t->table = table;
+	systabs.nr_tables++;
+
+	return EFI_SUCCESS;
+}
+
+/*
+ * As the final stage, destroy the boottime context, e.g. release the memory
+ * occupied by some data struct.
+ */
+static efi_status_t __efiapi emulator_exit_boot_services(efi_handle_t handle,
+							    unsigned long map_key)
+{
+	return EFI_SUCCESS;
+}
+
+static efi_boot_services_t bt_services = {
+	.handle_protocol = emulator_handle_protocol,
+	.locate_protocol = emulator_locate_protocol,
+	.allocate_pool = emulator_allocate_pool,
+	.free_pool = emulator_free_pool,
+	.allocate_pages = emulator_allocate_pages,
+	.free_pages = emulator_free_pages,
+	.copy_mem = emulator_copy_mem,
+	.set_mem = emulator_set_mem,
+	.get_memory_map = emulator_get_memory_map,
+	.install_configuration_table = emulator_install_configuration_table,
+	.exit_boot_services = emulator_exit_boot_services,
+};
+
+/* UCS-2 (Universal Coded Character Set) */
+static efi_status_t __efiapi output_string(efi_simple_text_output_protocol_t * simple,
+						       efi_char16_t *str)
+{
+	if (print_enabled)
+		print_ucs2_string(str);
+	return EFI_SUCCESS;
+}
+
+static efi_simple_text_output_protocol_t text_out = {
+	.output_string = output_string,
+};
+
+efi_system_table_t systabs = {
+	.hdr = {
+		.signature = EFI_SYSTEM_TABLE_SIGNATURE,
+	},
+
+	.con_out = &text_out,
+	.runtime = NULL,
+	.boottime = &bt_services,
+	.nr_tables = 0,
+	.tables = 0,
+
+};
+
+static efi_rt_properties_table_t rt_support = {
+	.runtime_services_supported = 0,
+};
+
+int initialize_emulator_service(struct efi_emulator_param *param)
+{
+
+	efi_config_table_t *tables;
+	unsigned int i;
+
+	printf("initialize_emulator_service, dtb=0x%lx, mempool_start=0x%lx, end:0x%lx\n",
+			param->dtb, param->mempool_start, param->mempool_start + param->mempool_sz);
+	emulator_param = param;
+	print_enabled = param->print_enabled;
+	i = param->rt_info.systab_nr_tables;
+	systabs.tables = (unsigned long)&param->rt_info.systab_tables;
+	tables = param->rt_info.systab_tables;
+	tables[i].guid = DEVICE_TREE_GUID;
+	tables[i].table = (void *)param->dtb;
+	i++;
+	if (!param->noefi_boot) {
+		rt_support.runtime_services_supported = param->rt_info.runtime_supported_mask;
+	}
+	tables[i].guid = EFI_RT_PROPERTIES_TABLE_GUID;
+	tables[i].table = (void *)&rt_support;
+	i++;
+	systabs.nr_tables = i;
+
+	systabs.runtime = (efi_runtime_services_t *)param->rt_info.runtime;
+	return 0;
+}
diff --git a/drivers/firmware/efi/efi_emulator/earlycon.h b/drivers/firmware/efi/efi_emulator/earlycon.h
new file mode 100644
index 0000000000000..189af549d5af2
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/earlycon.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/efi_emulator.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm-generic/io.h>
+
+struct earlycon {
+	bool (*match)(struct efi_emulator_param *param, const char *name);
+	int (*put_str)(const char *str, void *data);
+	void (*reset)(void *data);
+	void *data;
+	const char *name;
+};
+
+extern struct earlycon pl011;
+
+extern int pl011_puts(const char *str);
+void setup_earlycon(struct efi_emulator_param *param);
diff --git a/drivers/firmware/efi/efi_emulator/efi_emulator.S b/drivers/firmware/efi/efi_emulator/efi_emulator.S
new file mode 100644
index 0000000000000..fb52593ba3b2e
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/efi_emulator.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+	.section .rodata, "a"
+
+	.align	8
+_efi_emulator_start:
+	.globl	_efi_emulator_start
+	.incbin	"drivers/firmware/efi/efi_emulator/emulator.raw"
+
+	.align	8
+_efi_emulator_end:
+	.globl	_efi_emulator_end
diff --git a/drivers/firmware/efi/efi_emulator/emulator.h b/drivers/firmware/efi/efi_emulator/emulator.h
new file mode 100644
index 0000000000000..e524cbd92180c
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/emulator.h
@@ -0,0 +1,66 @@
+#include <linux/nls.h>
+#include <linux/efi_emulator.h>
+
+/* Included from drivers/firmware/efi/libstub */
+#include <efistub.h>
+
+#define EMULATOR_BASE_ADDR 0
+
+typedef union efi_rng_protocol efi_rng_protocol_t;
+
+union efi_rng_protocol {
+	struct {
+		efi_status_t (__efiapi *get_info)(efi_rng_protocol_t *,
+						  unsigned long *,
+						  efi_guid_t *);
+		efi_status_t (__efiapi *get_rng)(efi_rng_protocol_t *,
+						 efi_guid_t *, unsigned long,
+						 u8 *out);
+	};
+	struct {
+		u32 get_info;
+		u32 get_rng;
+	} mixed_mode;
+};
+
+struct uki_info {
+	unsigned long initrd_base;
+	unsigned long initrd_sz;
+	unsigned long cmdline_base;
+	unsigned long cmdline_sz;
+};
+
+extern struct efi_emulator_param *emulator_param;
+extern efi_tcg2_protocol_t emulator_tcg2;
+extern efi_cc_protocol_t emulator_cc;
+extern efi_rng_protocol_t emulator_rng;
+extern efi_system_table_t systabs;
+extern efi_runtime_services_t rt_services;
+extern char *heap_start, *heap_end, *heap_cur;
+
+void *aligned_alloc(size_t alignment, size_t size);
+void *memcpy(void *dest, const void *src, size_t n);
+void *memset(void *s, int c, size_t n);
+int strcmp(const char *cs, const char *ct);
+size_t wcslen(const wchar_t *str);
+int wcscmp(const wchar_t *s1, const wchar_t *s2);
+int printf(const char *format, ...);
+void print_ucs2_string(efi_char16_t* ucs2_str);
+
+efi_status_t __emulator_allocate_pages(int alloc_type, int mem_type,
+			unsigned long nr_pages, efi_physical_addr_t *addr);
+efi_status_t __emulator_allocate_pool(int mem_type, unsigned long sz,
+				       void **pool);
+efi_status_t emulator_get_memory_map(unsigned long *map_sz,
+	void *memmap, unsigned long *map_key, unsigned long *desc_sz,
+	unsigned int *desc_version);
+
+efi_status_t conjoin_table(efi_guid_t *uuid, void *table, efi_config_table_t *t);
+
+int initialize_emulator_service(struct efi_emulator_param *param);
+void initialize_heap(struct efi_emulator_param *param);
+void load_kernel_pe(char *kern_buf, unsigned long sz, efi_system_table_t *systabs);
+void load_kernel_from_mem(efi_system_table_t *systabs);
+void emulator_main(struct efi_emulator_param *param);
+void emulator_entry(struct efi_emulator_param *param);
+
diff --git a/drivers/firmware/efi/efi_emulator/entry.c b/drivers/firmware/efi/efi_emulator/entry.c
new file mode 100644
index 0000000000000..c851a9acafa77
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/entry.c
@@ -0,0 +1,57 @@
+//SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/efi_emulator.h>
+#include <asm/barrier.h>
+#include <asm/sysreg.h>
+#include <asm/elf.h>
+#include <uapi/linux/elf.h>
+
+#include "emulator.h"
+#include "earlycon.h"
+
+extern void enable_sctlr_el1(unsigned long scratch_reg);
+static void arch_handle_mmu(struct efi_emulator_param *param)
+{
+	if (!param->mmu_on && param->pgd_root) {
+	}
+}
+
+extern const Elf64_Rela _rela_start[], _rela_end[];
+
+static void noinline arch_reloc_fixup(long delta)
+{
+	unsigned long *apply_addr, res;
+	Elf64_Rela *rela;
+
+	/* fix rela */
+	for (rela = (Elf64_Rela *)_rela_start; rela < _rela_end; rela++) {
+		//todo counterpart of R_AARCH64_RELATIVE on riscv
+		if (ELF64_R_TYPE(rela->r_info) != R_AARCH64_RELATIVE)
+			continue;
+		apply_addr = (unsigned long *)(rela->r_offset + delta);
+		res = rela->r_addend + delta;
+		*apply_addr = res;
+	}
+	// todo flush cache
+
+}
+
+/* 
+ * Ensure this entry and @param is in the mapping before jump to it.
+ * It should be PIC and at the beginning of emulator.
+ * It should be memory aligned
+ */
+void emulator_main(struct efi_emulator_param *param)
+{
+	long delta = param->load_address - EMULATOR_BASE_ADDR;
+
+	arch_handle_mmu(param);
+	arch_reloc_fixup(delta);
+	setup_earlycon(param);
+	printf("param:0x%lx, delta=0x%lx\n", (unsigned long)param, delta);
+	printf("kernel_img_start:0x%lx, sz:0x%lx\n", (unsigned long)param->kernel_img_start, (unsigned long)param->kernel_img_sz);
+	initialize_emulator_service(param);
+	initialize_heap(param);
+	load_kernel_pe((char *)param->kernel_img_start, param->kernel_img_sz,
+		&systabs);
+}
diff --git a/drivers/firmware/efi/efi_emulator/head.S b/drivers/firmware/efi/efi_emulator/head.S
new file mode 100644
index 0000000000000..8efa10f483a7c
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/head.S
@@ -0,0 +1,10 @@
+
+.section        ".head.text","ax"
+
+/* x0 holds the physical address of emulator_param */
+emulator_entry:
+	ldr	x1, [x0]
+	mov	sp, x1
+	adrp	x2, emulator_main
+	add	x2, x2, #:lo12:emulator_main
+	br	x2
diff --git a/drivers/firmware/efi/efi_emulator/initrd.c b/drivers/firmware/efi/efi_emulator/initrd.c
new file mode 100644
index 0000000000000..771b6f8954e33
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/initrd.c
@@ -0,0 +1,15 @@
+// this file is a place holder to implment EFI_LOAD_FILE2_PROTOCOL.LoadFile(), not linked in yet
+
+static efi_status_t load_file(efi_load_file2_protocol_t *this,
+		efi_device_path_protocol_t *dp, bool boot_policy,
+		unsigned long buffer_sz, void *buffer)
+{
+
+	struct efi_vendor_dev_path p = dp;
+
+	if (!efiguid_cmp(p->vendorguid , LINUX_EFI_INITRD_MEDIA_GUID))
+		if (uki_info.initrd_sz) {
+			memcpy(buffer, uki_info.initrd_base, uki_info.initrd_sz);
+			return;
+		}
+}
diff --git a/drivers/firmware/efi/efi_emulator/lib.c b/drivers/firmware/efi/efi_emulator/lib.c
new file mode 100644
index 0000000000000..f12aa40405650
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/lib.c
@@ -0,0 +1,73 @@
+//SPDX-License-Identifier: GPL-2.0
+#include "emulator.h"
+
+void *memcpy(void *dest, const void *src, size_t count)
+{
+	char *tmp = dest;
+	const char *s = src;
+
+	while (count--)
+		*tmp++ = *s++;
+	return dest;
+}
+
+void *memset(void *s, int c, size_t count)
+{
+	char *xs = s;
+
+	while (count--)
+		*xs++ = c;
+	return s;
+}
+
+int memcmp(const void *cs, const void *ct, size_t count)
+{
+	const unsigned char *su1, *su2;
+	int res = 0;
+
+	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
+		if ((res = *su1 - *su2) != 0)
+			break;
+	return res;
+}
+
+size_t strlen(const char *s)
+{
+	const char *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+
+int strcmp(const char *cs, const char *ct)
+{
+	unsigned char c1, c2;
+
+	while (1) {
+		c1 = *cs++;
+		c2 = *ct++;
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+		if (!c1)
+			break;
+	}
+	return 0;
+}
+
+int wcscmp(const wchar_t *s1, const wchar_t *s2)
+{
+    while (*s1 && (*s1 == *s2)) {
+        s1++;
+        s2++;
+    }
+    return (int)(*s1 - *s2);
+}
+
+size_t wcslen(const wchar_t *str)
+{
+    const wchar_t *s;
+
+    for (s = str; *s; ++s);
+    return (s - str);
+}
diff --git a/drivers/firmware/efi/efi_emulator/memory.c b/drivers/firmware/efi/efi_emulator/memory.c
new file mode 100644
index 0000000000000..518ab7f30020e
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/memory.c
@@ -0,0 +1,27 @@
+//SPDX-License-Identifier: GPL-2.0
+#include "emulator.h"
+
+char *heap_start, *heap_end, *heap_cur;
+
+void initialize_heap(struct efi_emulator_param *param)
+{
+	heap_start = (char *)param->mempool_start;
+	heap_end = heap_start + param->mempool_sz;
+	heap_cur = heap_start;
+}
+
+//2do, the memory management is more complicated since we need to distinguish EFI_BOOT_SERVICE, RUNTIME, LOADER memory descr
+
+void *aligned_alloc(size_t alignment, size_t size)
+{
+	char *p;
+
+	p = (char *)ALIGN((unsigned long)heap_cur, alignment);
+	heap_cur = p + size;
+
+	//todo, update the efi_memory_desc to include this page, if it crosses the PAGE boundary
+	//as EFI_BOOT_SERVICE,
+	return p;
+}
+
+
diff --git a/drivers/firmware/efi/efi_emulator/memory_api.c b/drivers/firmware/efi/efi_emulator/memory_api.c
new file mode 100644
index 0000000000000..709bbddaa4679
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/memory_api.c
@@ -0,0 +1,73 @@
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "emulator.h"
+
+/*
+ * mem_type affects the allocated chunk in efi_memory_desc_t's type. Later,
+ * kernel can know whether to reclaim them.
+ */
+efi_status_t __emulator_allocate_pages(int alloc_type, int mem_type,
+			unsigned long nr_pages, efi_physical_addr_t *addr)
+{
+	efi_physical_addr_t res;
+	efi_status_t status;
+
+	if (alloc_type == EFI_ALLOCATE_ANY_PAGES) {
+		res = (efi_physical_addr_t)aligned_alloc(PAGE_SIZE, nr_pages << PAGE_SHIFT);
+		*addr = res;
+		status = EFI_SUCCESS;
+	} else if (alloc_type == EFI_ALLOCATE_MAX_ADDRESS) {
+		//tmp
+		res = (efi_physical_addr_t)aligned_alloc(PAGE_SIZE, nr_pages << PAGE_SHIFT);
+		*addr = res;
+		status = EFI_SUCCESS;
+	/* e.g. aarch64 kimage loaded alignment */
+	} else if (alloc_type == EFI_ALLOCATE_ADDRESS) {
+		//tmp, just aligned on 2MB as aarch64 boot protocol
+		res = (efi_physical_addr_t)aligned_alloc(1<<21, nr_pages << PAGE_SHIFT);
+		*addr = res;
+		status = EFI_SUCCESS;
+	}
+
+	return status;
+}
+
+//todo
+efi_status_t __emulator_allocate_pool(int mem_type, unsigned long sz,
+				       void **pool)
+{
+	void *res;
+
+	res = aligned_alloc(sizeof(unsigned long), sz);
+	*pool = res;
+	return EFI_SUCCESS;
+}
+
+/* @memmap: only holds efi_memory_desc */
+efi_status_t emulator_get_memory_map(unsigned long *map_sz,
+	void *memmap, unsigned long *map_key, unsigned long *desc_sz,
+	unsigned int *desc_version)
+{
+	//todo rt_info.memmap will be accessed by kernel, so it should be marked as reserved
+	struct efi_boot_memmap *p = &emulator_param->rt_info.memmap;
+	//efi_memory_desc_t *desc = p->map;
+
+	if (!map_sz || !desc_sz)
+		return EFI_INVALID_PARAMETER;
+	if (*map_sz < p->map_size || !memmap) {
+		*map_sz = p->map_size;
+		*desc_sz = p->desc_size;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	/* desc range size*/
+	*map_sz = p->map_size;
+	memcpy(memmap, p->map, p->map_size);
+	if (!!desc_sz)
+		*desc_sz = p->desc_size;
+	if (!!desc_version)
+		*desc_version = p->desc_ver;
+
+	return EFI_SUCCESS;
+}
diff --git a/drivers/firmware/efi/efi_emulator/misc.c b/drivers/firmware/efi/efi_emulator/misc.c
new file mode 100644
index 0000000000000..5a82adb6b193c
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/misc.c
@@ -0,0 +1,76 @@
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "emulator.h"
+
+static efi_status_t __efiapi emulator_tcg2_hash_log_extend_event(
+		efi_tcg2_protocol_t *this, u64 flags,
+		efi_physical_addr_t data_to_hash, u64 data_to_hash_len,
+		const efi_tcg2_event_t *efi_td_event)
+{
+
+	return EFI_SUCCESS;
+
+}
+
+efi_tcg2_protocol_t emulator_tcg2 = {
+	.hash_log_extend_event = emulator_tcg2_hash_log_extend_event,	
+};
+
+static efi_status_t __efiapi emulator_cc_map_pcr_to_mr_index(efi_cc_protocol_t *this,
+		u32 pcr_index, efi_cc_mr_index_t *mr_index)
+{
+	return EFI_SUCCESS;
+}
+
+static efi_status_t __efiapi emulator_cc_hash_log_extend_event(
+		efi_cc_protocol_t *this, u64 flags, 
+		efi_physical_addr_t data_to_hash, u64 data_to_hash_len,
+		const efi_cc_event_t *efi_td_event)
+{
+
+	return EFI_SUCCESS;
+}
+
+efi_cc_protocol_t emulator_cc = {
+	.hash_log_extend_event = emulator_cc_hash_log_extend_event,	
+	.map_pcr_to_mr_index = emulator_cc_map_pcr_to_mr_index,
+};
+
+static efi_status_t __efiapi emulator_get_rng(efi_rng_protocol_t * this,
+						 efi_guid_t *uuid, unsigned long size,
+						 u8 *out)
+{
+	//in fact, disable aslr
+	*out = 0;
+	return EFI_SUCCESS;
+}
+
+efi_rng_protocol_t emulator_rng = {
+	.get_rng = emulator_get_rng,
+};
+
+static efi_status_t __efiapi emulator_get_memory_attributes(
+	efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64 *)
+{
+	return EFI_SUCCESS;
+}
+
+static efi_status_t __efiapi emulator_set_memory_attributes(
+	efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64)
+{
+	return EFI_SUCCESS;
+}
+
+static efi_status_t __efiapi emulator_clear_memory_attributes(
+	efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64)
+{
+	return EFI_SUCCESS;
+}
+
+efi_memory_attribute_protocol_t emulator_memory_attribute = {
+	.get_memory_attributes = emulator_get_memory_attributes,
+	.set_memory_attributes = emulator_set_memory_attributes,
+	.clear_memory_attributes = emulator_clear_memory_attributes,
+};
diff --git a/drivers/firmware/efi/efi_emulator/pe_loader.c b/drivers/firmware/efi/efi_emulator/pe_loader.c
new file mode 100644
index 0000000000000..ff921d611a287
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/pe_loader.c
@@ -0,0 +1,124 @@
+
+#include <linux/pe.h>
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "emulator.h"
+
+#define VALID_PAYLOAD (IMAGE_SCN_CNT_CODE |IMAGE_SCN_CNT_INITIALIZED_DATA |IMAGE_SCN_CNT_UNINITIALIZED_DATA)
+
+typedef efi_status_t (*uefi_pe_entry)(efi_handle_t handle, efi_system_table_t *systab);
+
+struct pe_instance {
+	uefi_pe_entry entry;
+	efi_handle_t handle;
+};
+
+#if 0
+static struct uki_info uki_info;
+#endif
+
+static int load_pe(char *buf, unsigned long buf_sz, unsigned long pe_hdr_offset,
+			struct pe_instance *inst, efi_system_table_t *systab)
+{
+	unsigned long exec_sz, load_addr, delta;
+	struct pe_hdr *pe_hdr;
+	struct pe32plus_opt_hdr *opt_hdr;
+	struct section_header *sect_hdr;
+	int section_nr, i;
+	char *src, *dst;
+	
+	pe_hdr = (struct pe_hdr *)buf;
+	section_nr = pe_hdr->sections;
+	opt_hdr = (struct pe32plus_opt_hdr *)(buf + sizeof(struct pe_hdr));
+	sect_hdr = (struct section_header *)((char *)opt_hdr + pe_hdr->opt_hdr_size);
+	exec_sz = opt_hdr->image_size - opt_hdr->header_size;
+
+	/*
+	 * The allocated memory should meet the section aligment requirement.
+	 * The first section is loaded at load_addr.
+	 */
+	load_addr = (unsigned long)aligned_alloc(opt_hdr->section_align, exec_sz);
+
+	delta = load_addr - sect_hdr->virtual_address;
+ 	/*copy section to segment */
+	//opt_hdr->section_align;
+	for (i = 0; i < section_nr; i++) {
+		if (!(sect_hdr->flags & VALID_PAYLOAD)) {
+			sect_hdr++;
+			continue;
+		}
+		/* data_addr is relative to the whole file */
+		src = buf + sect_hdr->data_addr - pe_hdr_offset;
+		dst = (char *)(sect_hdr->virtual_address + delta);
+		memcpy(dst, src, sect_hdr->raw_data_size);
+		memset(dst + sect_hdr->raw_data_size, 0, sect_hdr->virtual_size - sect_hdr->raw_data_size);
+#if 0
+		//2do, for UKI
+		if (strcmp(sect_hdr->name, ".initrd")) {
+			uki_info.initrd_base = dst;
+			uki_info.initrd_sz = sect_hdr->raw_data_size;
+		}
+		if (strcmp(sect_hdr->name, ".cmdline")) {
+			uki_info.cmdline_base = dst;
+			uki_info.cmdline_sz = sect_hdr->raw_data_size;
+		}
+#endif
+		sect_hdr++;
+	}
+
+	/* no need to resolve relocation */
+
+	/* As for SP, using the current value */
+
+	inst->entry = (uefi_pe_entry)(opt_hdr->entry_point + delta);
+	inst->handle = (efi_handle_t)load_addr;
+
+	printf("entry_point:0x%lx, delta:0x%lx, final inst's entry at:0x%lx\n",
+		opt_hdr->entry_point, delta, inst->entry);
+	return 0;
+}
+
+static int launch_pe(char *pe_buf, u64 buf_sz, unsigned long pe_hdr_offset, efi_system_table_t *systab)
+{
+	struct pe_instance inst;
+
+	load_pe(pe_buf, buf_sz, pe_hdr_offset, &inst, systab);
+	inst.entry(inst.handle, systab);
+	return 0;
+}
+
+struct input_param_passed_by {
+	u64 kernel_pa_start;
+	u64 kernel_sz;
+	u64 pgtable;
+	u64 memory_descs;
+};
+
+
+/* see drivers/firmware/efi/libstub/zboot-header.S */
+struct linux_pe_zboot_header {
+	uint32_t mz_magic;
+	uint32_t image_type;
+	uint32_t payload_offset;
+	uint32_t payload_size;
+	uint32_t reserved[2];
+	uint32_t compress_type;
+};
+
+void load_kernel_pe(char *kern_buf, unsigned long sz, efi_system_table_t *systabs)
+{
+	struct linux_pe_zboot_header *hdr;
+	u32 pe_hdr_offset;
+	char *buf = kern_buf;
+
+	hdr = (struct linux_pe_zboot_header *)buf;
+	/* Check mz signature */
+	if (memcmp(&hdr->image_type, "zimg", sizeof(hdr->image_type)))
+		return;
+	pe_hdr_offset = *((u32 *)(buf + 0x3c));
+	/* */
+	buf += pe_hdr_offset;
+	sz -= pe_hdr_offset;
+	launch_pe(buf, sz, pe_hdr_offset, systabs);
+}
+
diff --git a/drivers/firmware/efi/efi_emulator/printf.c b/drivers/firmware/efi/efi_emulator/printf.c
new file mode 100644
index 0000000000000..367d1ede98422
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/printf.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* The most of this file is copied from arch/x86/boot/printf.c */
+
+#include <linux/ctype.h>
+#include <linux/efi.h>
+
+#include "earlycon.h"
+#include "emulator.h"
+
+static int skip_atoi(const char **s)
+{
+	int i = 0;
+
+	while (isdigit(**s))
+		i = i * 10 + *((*s)++) - '0';
+	return i;
+}
+
+#define ZEROPAD	1		/* pad with zero */
+#define SIGN	2		/* unsigned/signed long */
+#define PLUS	4		/* show plus */
+#define SPACE	8		/* space if plus */
+#define LEFT	16		/* left justified */
+#define SMALL	32		/* Must be 32 == 0x20 */
+#define SPECIAL	64		/* 0x */
+
+#define __do_div(n, base) ({ \
+int __res; \
+__res = ((unsigned long) n) % (unsigned) base; \
+n = ((unsigned long) n) / (unsigned) base; \
+__res; })
+
+static char *number(char *str, long num, int base, int size, int precision,
+		    int type)
+{
+	/* we are called with base 8, 10 or 16, only, thus don't need "G..."  */
+	static const char digits[16] = "0123456789ABCDEF"; /* "GHIJKLMNOPQRSTUVWXYZ"; */
+
+	char tmp[66];
+	char c, sign, locase;
+	int i;
+
+	/* locase = 0 or 0x20. ORing digits or letters with 'locase'
+	 * produces same digits or (maybe lowercased) letters */
+	locase = (type & SMALL);
+	if (type & LEFT)
+		type &= ~ZEROPAD;
+	if (base < 2 || base > 16)
+		return NULL;
+	c = (type & ZEROPAD) ? '0' : ' ';
+	sign = 0;
+	if (type & SIGN) {
+		if (num < 0) {
+			sign = '-';
+			num = -num;
+			size--;
+		} else if (type & PLUS) {
+			sign = '+';
+			size--;
+		} else if (type & SPACE) {
+			sign = ' ';
+			size--;
+		}
+	}
+	if (type & SPECIAL) {
+		if (base == 16)
+			size -= 2;
+		else if (base == 8)
+			size--;
+	}
+	i = 0;
+	if (num == 0)
+		tmp[i++] = '0';
+	else
+		while (num != 0)
+			tmp[i++] = (digits[__do_div(num, base)] | locase);
+	if (i > precision)
+		precision = i;
+	size -= precision;
+	if (!(type & (ZEROPAD + LEFT)))
+		while (size-- > 0)
+			*str++ = ' ';
+	if (sign)
+		*str++ = sign;
+	if (type & SPECIAL) {
+		if (base == 8)
+			*str++ = '0';
+		else if (base == 16) {
+			*str++ = '0';
+			*str++ = ('X' | locase);
+		}
+	}
+	if (!(type & LEFT))
+		while (size-- > 0)
+			*str++ = c;
+	while (i < precision--)
+		*str++ = '0';
+	while (i-- > 0)
+		*str++ = tmp[i];
+	while (size-- > 0)
+		*str++ = ' ';
+	return str;
+}
+
+size_t strnlen(const char *s, size_t count)
+{
+	const char *sc;
+
+	for (sc = s; count-- && *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+
+int vsprintf(char *buf, const char *fmt, va_list args)
+{
+	int len;
+	unsigned long num;
+	int i, base;
+	char *str;
+	const char *s;
+
+	int flags;		/* flags to number() */
+
+	int field_width;	/* width of output field */
+	int precision;		/* min. # of digits for integers; max
+				   number of chars for from string */
+	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
+
+	for (str = buf; *fmt; ++fmt) {
+		if (*fmt != '%') {
+			*str++ = *fmt;
+			continue;
+		}
+
+		/* process flags */
+		flags = 0;
+	      repeat:
+		++fmt;		/* this also skips first '%' */
+		switch (*fmt) {
+		case '-':
+			flags |= LEFT;
+			goto repeat;
+		case '+':
+			flags |= PLUS;
+			goto repeat;
+		case ' ':
+			flags |= SPACE;
+			goto repeat;
+		case '#':
+			flags |= SPECIAL;
+			goto repeat;
+		case '0':
+			flags |= ZEROPAD;
+			goto repeat;
+		}
+
+		/* get field width */
+		field_width = -1;
+		if (isdigit(*fmt))
+			field_width = skip_atoi(&fmt);
+		else if (*fmt == '*') {
+			++fmt;
+			/* it's the next argument */
+			field_width = va_arg(args, int);
+			if (field_width < 0) {
+				field_width = -field_width;
+				flags |= LEFT;
+			}
+		}
+
+		/* get the precision */
+		precision = -1;
+		if (*fmt == '.') {
+			++fmt;
+			if (isdigit(*fmt))
+				precision = skip_atoi(&fmt);
+			else if (*fmt == '*') {
+				++fmt;
+				/* it's the next argument */
+				precision = va_arg(args, int);
+			}
+			if (precision < 0)
+				precision = 0;
+		}
+
+		/* get the conversion qualifier */
+		qualifier = -1;
+		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L') {
+			qualifier = *fmt;
+			++fmt;
+		}
+
+		/* default base */
+		base = 10;
+
+		switch (*fmt) {
+		case 'c':
+			if (!(flags & LEFT))
+				while (--field_width > 0)
+					*str++ = ' ';
+			*str++ = (unsigned char)va_arg(args, int);
+			while (--field_width > 0)
+				*str++ = ' ';
+			continue;
+
+		case 's':
+			s = va_arg(args, char *);
+			len = strnlen(s, precision);
+
+			if (!(flags & LEFT))
+				while (len < field_width--)
+					*str++ = ' ';
+			for (i = 0; i < len; ++i)
+				*str++ = *s++;
+			while (len < field_width--)
+				*str++ = ' ';
+			continue;
+
+		case 'p':
+			if (field_width == -1) {
+				field_width = 2 * sizeof(void *);
+				flags |= ZEROPAD;
+			}
+			str = number(str,
+				     (unsigned long)va_arg(args, void *), 16,
+				     field_width, precision, flags);
+			continue;
+
+		case 'n':
+			if (qualifier == 'l') {
+				long *ip = va_arg(args, long *);
+				*ip = (str - buf);
+			} else {
+				int *ip = va_arg(args, int *);
+				*ip = (str - buf);
+			}
+			continue;
+
+		case '%':
+			*str++ = '%';
+			continue;
+
+			/* integer number formats - set up the flags and "break" */
+		case 'o':
+			base = 8;
+			break;
+
+		case 'x':
+			flags |= SMALL;
+			fallthrough;
+		case 'X':
+			base = 16;
+			break;
+
+		case 'd':
+		case 'i':
+			flags |= SIGN;
+		case 'u':
+			break;
+
+		default:
+			*str++ = '%';
+			if (*fmt)
+				*str++ = *fmt;
+			else
+				--fmt;
+			continue;
+		}
+		if (qualifier == 'l')
+			num = va_arg(args, unsigned long);
+		else if (qualifier == 'h') {
+			num = (unsigned short)va_arg(args, int);
+			if (flags & SIGN)
+				num = (short)num;
+		} else if (flags & SIGN)
+			num = va_arg(args, int);
+		else
+			num = va_arg(args, unsigned int);
+		str = number(str, num, base, field_width, precision, flags);
+	}
+	*str = '\0';
+	return str - buf;
+}
+
+int sprintf(char *buf, const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i = vsprintf(buf, fmt, args);
+	va_end(args);
+	return i;
+}
+
+static struct earlycon *con;
+
+static int puts(const char *s)
+{
+	if (con)
+		return con->put_str(s, con->data);
+	else
+		return 0;
+}
+
+int printf(const char *fmt, ...)
+{
+	char printf_buf[1024];
+	va_list args;
+	int printed;
+
+	va_start(args, fmt);
+	printed = vsprintf(printf_buf, fmt, args);
+	va_end(args);
+
+	puts(printf_buf);
+
+	return printed;
+}
+
+
+static size_t utf16_to_ascii(char *s, efi_char16_t c16)
+{
+	unsigned char lead;
+	size_t len;
+
+	if (c16 < 0x80) {
+		/* 1-byte sequence */
+		if (s) *s = c16;
+		len = 1;
+	} else if (c16 < 0x800) {
+		/* 2-byte sequence */
+		lead = 0xC0;
+		len = 2;
+	} else {
+		/* 3-byte sequence */
+		lead = 0xE0;
+		len = 3;
+	}
+
+	if (s) {
+		switch (len) {
+				case 3:
+					s[2] = 0x80 | (c16 & 0x3F);
+					c16 >>= 6;
+					fallthrough;
+				case 2:
+					s[1] = 0x80 | (c16 & 0x3F);
+					c16 >>= 6;
+					fallthrough;
+				case 1:
+					s[0] = lead | c16;
+		}
+	}
+	return len;
+}
+
+/* Convert the UCS-2 string to a UTF-8 string */
+void print_ucs2_string(efi_char16_t* ucs2_str)
+{
+	char utf8_str[1024];
+	char* p = utf8_str;
+
+	while (*ucs2_str)
+	    p += utf16_to_ascii(p, *ucs2_str++);
+
+	/* Null-terminate the UTF-8 string */
+	*p = '\0';
+	/* Print the UTF-8 string */
+	printf("%s\n", utf8_str);
+}
+
+static struct earlycon *all_con_types[] = { &pl011, };
+
+void setup_earlycon(struct efi_emulator_param *param)
+{
+	struct earlycon *p;
+	int i;
+
+	for (i = 0; i < sizeof(all_con_types) / sizeof(struct earlycon *); i++) {
+
+		p = all_con_types[i];
+		if (p->match(param, p->name)) {
+			con = p;
+			p->reset(p->data);
+			break;
+		}
+	}
+}
diff --git a/drivers/firmware/efi/efi_emulator/runtime_service.c b/drivers/firmware/efi/efi_emulator/runtime_service.c
new file mode 100644
index 0000000000000..87e49a8d4e2db
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/runtime_service.c
@@ -0,0 +1,28 @@
+//SPDX-License-Identifier: GPL-2.0
+
+#include "emulator.h"
+
+static efi_status_t emulator_get_variable(efi_char16_t *name, efi_guid_t *vendor,
+		u32 *attr, unsigned long *data_size, void *data)
+{
+	if (!efi_guidcmp(*vendor, EFI_GLOBAL_VARIABLE_GUID)) {
+		if (wcscmp(name, L"SecureBoot"))
+			return EFI_NOT_FOUND;
+	}
+	return EFI_NOT_FOUND;
+}
+
+static efi_status_t emulator_set_virtual_address_map(unsigned long memory_map_size,
+						unsigned long descriptor_size,
+						u32 descriptor_version,
+						efi_memory_desc_t *virtual_map)
+{
+	/* The first kernel has called this one-shot service */
+	return EFI_NOT_FOUND;
+}
+
+efi_runtime_services_t rt_services = {
+	.set_virtual_address_map = emulator_set_virtual_address_map,
+	.get_variable = emulator_get_variable,
+
+};
diff --git a/include/linux/efi_emulator.h b/include/linux/efi_emulator.h
new file mode 100644
index 0000000000000..cb977539cf05f
--- /dev/null
+++ b/include/linux/efi_emulator.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_EFI_EMULATOR_H
+#define _LINUX_EFI_EMULATOR_H
+
+#include <linux/types.h>
+#include <linux/nls.h>
+#include <linux/efi.h>
+
+//todo, arch abstraction, for x86, it is efi_info
+struct efi_rt_info {
+	const efi_runtime_services_t	*runtime;	/* EFI runtime services table */
+	unsigned int runtime_version;	/* Runtime services version */
+	u32 runtime_supported_mask;
+	/* Build systab tables from the following */
+	unsigned int systab_nr_tables;
+	efi_config_table_t systab_tables[20];
+	struct efi_boot_memmap	memmap;
+};
+
+/* 1st kernel passes information through this struct */
+struct efi_emulator_param {
+	unsigned long sp;
+	/* Should be page-aligned */
+	unsigned long load_address;
+	unsigned int sz_in_byte;
+	wchar_t cmdline[512];
+	bool noefi_boot;
+	bool print_enabled;
+	char earlycon_name[16];
+	phys_addr_t earlycon_reg_base;
+	unsigned long earlycon_reg_sz;
+
+	bool mmu_on;
+	/* root of pgtable */
+	phys_addr_t pgd_root;
+	phys_addr_t kernel_img_start;
+	unsigned long kernel_img_sz;
+	phys_addr_t dtb;
+	phys_addr_t mempool_start;
+	unsigned long mempool_sz;
+	struct efi_rt_info rt_info;
+};
+
+extern unsigned char _efi_emulator_start[], _efi_emulator_end[];
+#endif
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3c..cff6b6869498b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -325,6 +325,7 @@ struct kimage {
 	unsigned int hotplug_support:1;
 #endif
 
+	bool is_pe;
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
 #endif
@@ -462,6 +463,7 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+extern phys_addr_t arch_emulator_prepare_pgtable(struct kimage *kimage);
 extern bool kexec_file_dbg_print;
 
 #define kexec_dprintk(fmt, arg...) \
-- 
2.41.0


