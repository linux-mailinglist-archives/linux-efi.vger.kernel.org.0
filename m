Return-Path: <linux-efi+bounces-1551-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646AF956DEE
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 16:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166C728847F
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 14:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6FF173357;
	Mon, 19 Aug 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey7nq12v"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA1174EDB
	for <linux-efi@vger.kernel.org>; Mon, 19 Aug 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079330; cv=none; b=Uqq8ibVC+qYMpbtPPGQGgiiJK9lTR9BNTT1CYJZ8DLleoyT6YpAyuEb9BzrLQBC768p9GRTsFrFTEEq0E/kLM2256fNQDuLyREHxxVtMtDHU9iocC8WQZHRtXRgb1J9KR8xnh5IdwFoVPpHudbZxn1i/Lv3otvwljODBqaU7Ui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079330; c=relaxed/simple;
	bh=G0JhpL24kKkhtP2Yl5e/paTlsRaHUMdW5sMBPag46v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vs9KIzKbvUU3dPAsJpZMFyamRIPjZtePEnSIxjzy370T3J6amMtu4RNle3sJMyrby+ivnkxPeOdwvQTmgTdvlg9dUf5YdqchCMjHNnS9OswUM+y+uxzKVikKhAA87QAH6YmrBd8ElQqf8hKsYkAsWHcJEE/rODoY5qH0xJ5bAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey7nq12v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nUnlpRgfnHSQvAfyZpIAiaoZ1eeQlE7Hh8wiqCBupI=;
	b=ey7nq12vkZdFHAfIrej5DLaJd+Vb55RxQCYx/jERN2iY7bqqH9r9IGFyh94dx3zzh8QuZ3
	HX2irwQV/8O+il6q1lFhWoPJSAWlws2JUBEDc0iTKxVNHQsEBIApqYIFHg0kc674JyWBDC
	Xa4JXOq+ANhT7CQdMbsiaOVyxkEoQcw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-RgfSY5ycPmieuTSfW7NXJQ-1; Mon,
 19 Aug 2024 10:55:21 -0400
X-MC-Unique: RgfSY5ycPmieuTSfW7NXJQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DF161955BF2;
	Mon, 19 Aug 2024 14:55:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CE3119560A3;
	Mon, 19 Aug 2024 14:55:08 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pingfan Liu <kernelfans@gmail.com>
Subject: [RFCv2 3/9] efi/emulator: Initial rountines to emulate EFI boot time service
Date: Mon, 19 Aug 2024 22:53:36 +0800
Message-ID: <20240819145417.23367-4-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
Cc: kexec@lists.infradead.org
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/Makefile                 |   1 +
 drivers/firmware/efi/efi_emulator/Makefile    |  99 +++++
 .../firmware/efi/efi_emulator/amba-pl011.c    |  81 ++++
 .../efi_emulator/arm64_emulator_service.lds   |  45 +++
 .../firmware/efi/efi_emulator/config_table.c  |  25 ++
 drivers/firmware/efi/efi_emulator/core.c      | 376 ++++++++++++++++++
 .../firmware/efi/efi_emulator/device_handle.c | 138 +++++++
 drivers/firmware/efi/efi_emulator/earlycon.h  |  19 +
 .../firmware/efi/efi_emulator/efi_emulator.S  |  12 +
 drivers/firmware/efi/efi_emulator/emulator.h  | 106 +++++
 drivers/firmware/efi/efi_emulator/entry.c     |  61 +++
 drivers/firmware/efi/efi_emulator/head.S      |  10 +
 drivers/firmware/efi/efi_emulator/lib.c       |  73 ++++
 drivers/firmware/efi/efi_emulator/memory.c    |  27 ++
 .../firmware/efi/efi_emulator/memory_api.c    |  74 ++++
 drivers/firmware/efi/efi_emulator/misc.c      |  43 ++
 drivers/firmware/efi/efi_emulator/pe_loader.c | 173 ++++++++
 drivers/firmware/efi/efi_emulator/printf.c    | 373 +++++++++++++++++
 .../efi/efi_emulator/protocol_device_path.c   |  75 ++++
 .../protocol_simple_text_output.c             |  50 +++
 include/linux/efi_emulator.h                  |  46 +++
 include/linux/kexec.h                         |   2 +
 22 files changed, 1909 insertions(+)
 create mode 100644 drivers/firmware/efi/efi_emulator/Makefile
 create mode 100644 drivers/firmware/efi/efi_emulator/amba-pl011.c
 create mode 100644 drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds
 create mode 100644 drivers/firmware/efi/efi_emulator/config_table.c
 create mode 100644 drivers/firmware/efi/efi_emulator/core.c
 create mode 100644 drivers/firmware/efi/efi_emulator/device_handle.c
 create mode 100644 drivers/firmware/efi/efi_emulator/earlycon.h
 create mode 100644 drivers/firmware/efi/efi_emulator/efi_emulator.S
 create mode 100644 drivers/firmware/efi/efi_emulator/emulator.h
 create mode 100644 drivers/firmware/efi/efi_emulator/entry.c
 create mode 100644 drivers/firmware/efi/efi_emulator/head.S
 create mode 100644 drivers/firmware/efi/efi_emulator/lib.c
 create mode 100644 drivers/firmware/efi/efi_emulator/memory.c
 create mode 100644 drivers/firmware/efi/efi_emulator/memory_api.c
 create mode 100644 drivers/firmware/efi/efi_emulator/misc.c
 create mode 100644 drivers/firmware/efi/efi_emulator/pe_loader.c
 create mode 100644 drivers/firmware/efi/efi_emulator/printf.c
 create mode 100644 drivers/firmware/efi/efi_emulator/protocol_device_path.c
 create mode 100644 drivers/firmware/efi/efi_emulator/protocol_simple_text_output.c
 create mode 100644 include/linux/efi_emulator.h

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index a2d0009560d0f..41471416945eb 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
 obj-$(CONFIG_UEFI_CPER)			+= cper.o cper_cxl.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
 subdir-$(CONFIG_EFI_STUB)		+= libstub
+obj-$(CONFIG_ARCH_SELECTS_KEXEC_PEIMAGE)	+= efi_emulator/
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
 obj-$(CONFIG_EFI_TEST)			+= test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
diff --git a/drivers/firmware/efi/efi_emulator/Makefile b/drivers/firmware/efi/efi_emulator/Makefile
new file mode 100644
index 0000000000000..d696381d168ba
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/Makefile
@@ -0,0 +1,99 @@
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
+				   core.o pe_loader.o memory.o memory_api.o config_table.o misc.o \
+				   device_handle.o protocol_simple_text_output.o protocol_device_path.o \
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
+	@$(OBJCOPY)  -O binary -R .note -R .note.gnu.build-id -R .comment -g $< $@
+
+$(obj)/efi_emulator.o: $(obj)/emulator.raw
+
+
+targets				+= $(emulator-y)
+
+
diff --git a/drivers/firmware/efi/efi_emulator/amba-pl011.c b/drivers/firmware/efi/efi_emulator/amba-pl011.c
new file mode 100644
index 0000000000000..e81b12b2a7d21
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/amba-pl011.c
@@ -0,0 +1,81 @@
+//SPDX-License-Identifier: GPL-2.0
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
index 0000000000000..32b702a156ba4
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/config_table.c
@@ -0,0 +1,25 @@
+//SPDX-License-Identifier: GPL-2.0
+
+#include "emulator.h"
+
+static efi_status_t conjoin_memreserve_table(void *table, efi_config_table_t *head)
+{
+	struct linux_efi_memreserve *new, *next;
+
+	new = (struct linux_efi_memreserve *)table;
+	new->next = 0;
+	next = (struct linux_efi_memreserve *)head->table;
+	while (next->next != 0)
+		next = (struct linux_efi_memreserve *)next->next;
+	next->next = (phys_addr_t)new;
+
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
index 0000000000000..9045f6953250c
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/core.c
@@ -0,0 +1,376 @@
+//SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "emulator.h"
+
+int emulator_initialize(void);
+
+struct efi_emulator_param *emulator_param;
+bool print_enabled;
+
+static efi_loaded_image_t loaded_image;
+
+static LIST_HEAD(image_instance_list);
+
+struct efi_pe_instance *get_instance_by_handle(efi_handle_t h)
+{
+	struct efi_pe_instance *pos;
+
+	list_for_each_entry(pos, &image_instance_list, node)
+		if (pos->handle == h)
+			return pos;
+
+	return NULL;
+}
+
+/* no free path */
+struct efi_pe_instance *allocate_pe_instance(char *file_base,
+		unsigned long file_size)
+{
+	struct efi_pe_instance *inst;
+
+	inst = aligned_alloc(8, sizeof(struct efi_pe_instance));
+	/* identity */
+	inst->handle = (efi_handle_t)inst;
+	inst->image_file_buf = file_base;
+	inst->image_file_size = file_size;
+	emulator_list_add(&inst->node, &image_instance_list);
+
+	return inst;
+}
+
+/* The 1st kernel convert cmdline to utf16 and pass to emulator */
+static efi_status_t handle_protocol_loaded_image(efi_handle_t h, void **data)
+{
+	void *base;
+
+	loaded_image.load_options = emulator_param->cmdline;
+	loaded_image.load_options_size = emulator_param->sz_in_byte;
+
+	/* loaded address */
+	base = (void *)find_image_base_for_handle(h);
+	loaded_image.image_base = base;
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
+	if (!efi_guidcmp(*uuid, EFI_LOAD_FILE2_PROTOCOL_GUID))
+		return device_handle_protocol(h, uuid, data);
+
+	return EFI_UNSUPPORTED;
+}
+
+/*
+ * LocateProtocol() finds the first device handle that support Protocol, and
+ * returns a pointer to the protocol interface from that handle in Interface.
+ * If no protocol instances are found, then Interface is set to NULL
+ */
+static efi_status_t __efiapi emulator_locate_protocol(efi_guid_t *uuid,
+				void *registration, void **interface)
+{
+	if (!efi_guidcmp(*uuid, EFI_TCG2_PROTOCOL_GUID)) {
+		return EFI_UNSUPPORTED;
+	} else if (!efi_guidcmp(*uuid, EFI_CC_MEASUREMENT_PROTOCOL_GUID)) {
+		return EFI_UNSUPPORTED;
+	} else if (!efi_guidcmp(*uuid, EFI_RNG_PROTOCOL_GUID)) {
+		*interface = &emulator_rng;
+		return EFI_SUCCESS;
+	}
+
+	return EFI_UNSUPPORTED;
+}
+
+/* each pair is {efi_guid_t *, void *} */
+static efi_status_t __efiapi emulator_install_multiple_protocol_interfaces(efi_handle_t *handle, ...)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	efi_guid_t *guid;
+	void *proto;
+	va_list args;
+	int i;
+
+	if (*handle == 0)
+		ret = device_create_handle(handle);
+
+	va_start(args, handle);
+	for (i = 0; ret == EFI_SUCCESS; i++) {
+		/* If protocol is NULL, then it's the end of the list */
+		guid = va_arg(args, efi_guid_t *);
+		if (guid == NULL)
+			break;
+		proto = va_arg(args, void *);
+	
+		if (!efi_guidcmp(*guid, EFI_DEVICE_PATH_PROTOCOL_GUID)) {
+			ret = device_attach_dev_path(*handle, proto);
+			continue;
+		}
+		
+		/* install one protocol on the device */
+		ret = device_register_protocol(*handle, *guid, proto);
+	}
+	va_end(args);
+
+	return ret;
+}
+
+static efi_status_t __efiapi emulator_uninstall_multiple_protocol_interfaces(efi_handle_t, ...)
+{
+	return EFI_UNSUPPORTED;
+}
+
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
+static efi_status_t __efiapi emulator_stall(unsigned long ms)
+{
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t __efiapi emulator_locate_handle(int, efi_guid_t *,
+				       void *, unsigned long *,
+				       efi_handle_t *)
+{
+	return EFI_UNSUPPORTED;
+}
+
+/*
+ * locates all devices on DevicePath that support Protocol and returns the
+ * handle to the device that is closest to DevicePath
+ */
+static efi_status_t __efiapi emulator_locate_device_path(efi_guid_t *guid,
+		efi_device_path_protocol_t **dp, efi_handle_t *handle)
+{
+	efi_status_t ret;
+		/* Only one device implements this protocol, so dp can be ignored */
+	if (!efi_guidcmp(*guid, EFI_LOAD_FILE2_PROTOCOL_GUID)) {
+		ret = device_find_handle_by_path(dp, handle);
+		return ret;
+	}
+
+	return EFI_NOT_FOUND;
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
+ * For UKI, systemd-stub loads linux image and start image.
+ * @path: The DeviceHandle specific file path from which the image is loaded
+ */
+static efi_status_t __efiapi emulator_load_image(bool boot_policy,
+		efi_handle_t parent_image, efi_device_path_protocol_t *path,
+		void *src_buf, unsigned long src_sz,
+		efi_handle_t *handle)
+{
+	struct efi_pe_instance *inst;
+	char *dst;
+	
+	/* copy the in-memory image */
+	if (!!src_buf) {
+		dst = aligned_alloc(8, src_sz);
+		if (!dst) {
+			printf("OOM\n");
+			return EFI_OUT_OF_RESOURCES;
+		}
+		emulator_copy_mem(dst, src_buf, src_sz);
+		inst = allocate_pe_instance(dst, src_sz);
+		inst->handle = inst;
+		*handle = inst->handle;
+	/* EFI_SIMPLE_FILE_SYSTEM_PROTOCOL or EFI_LOAD_FILE_PROTOCOL */
+	} else {
+
+	}
+	return EFI_SUCCESS;
+}
+
+static	efi_status_t __efiapi emulator_start_image(efi_handle_t handle,
+		unsigned long *exit_data_sz, efi_char16_t **exit_data)
+{
+
+	struct efi_pe_instance *inst;
+
+	inst = get_instance_by_handle(handle);
+	if (unlikely(!inst)) {
+		printf("error: can not find image\n");
+		return EFI_NOT_FOUND;
+	}
+	load_kernel_pe(inst, &systabs);
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
+	.install_multiple_protocol_interfaces = emulator_install_multiple_protocol_interfaces,
+	.uninstall_multiple_protocol_interfaces = emulator_uninstall_multiple_protocol_interfaces,
+
+	.allocate_pool = emulator_allocate_pool,
+	.free_pool = emulator_free_pool,
+	.allocate_pages = emulator_allocate_pages,
+	.free_pages = emulator_free_pages,
+	.copy_mem = emulator_copy_mem,
+	.set_mem = emulator_set_mem,
+	.get_memory_map = emulator_get_memory_map,
+
+	.stall = emulator_stall,
+
+	.locate_handle = emulator_locate_handle,
+	.locate_device_path = emulator_locate_device_path,
+	.install_configuration_table = emulator_install_configuration_table,
+	.load_image = emulator_load_image,
+	.start_image = emulator_start_image,
+	.exit_boot_services = emulator_exit_boot_services,
+};
+
+static efi_char16_t vendor[] = u"Linux Kexec";
+
+static efi_status_t unsupported_func(void)
+{
+	return EFI_UNSUPPORTED;
+}
+
+efi_system_table_t systabs = {
+	.hdr = {
+		.signature = EFI_SYSTEM_TABLE_SIGNATURE,
+	},
+	.fw_vendor = (unsigned long)vendor,
+	.fw_revision = 0x10001,
+	.con_in_handle = 0x0,
+	.con_in = (efi_simple_text_input_protocol_t *)unsupported_func,
+	.con_out_handle = 0x0,
+	.con_out = &text_out,
+	.stderr_handle = 0x0,
+	/* Per specification, A pointer to the EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL */
+	.stderr = (unsigned long)unsupported_func,
+	/* Passed in by the 1st kernel */
+	.runtime = NULL,
+	.boottime = &bt_services,
+	.nr_tables = 0,
+	.tables = 0,
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
diff --git a/drivers/firmware/efi/efi_emulator/device_handle.c b/drivers/firmware/efi/efi_emulator/device_handle.c
new file mode 100644
index 0000000000000..6e15979f62e9a
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/device_handle.c
@@ -0,0 +1,138 @@
+//SPDX-License-Identifier: GPL-2.0
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "emulator.h"
+
+static LIST_HEAD(devices_list);
+
+struct protocol_entry {
+	efi_guid_t guid;
+	void *proto;
+};
+
+/*
+ * Drivers can implement their own version of efi_load_file_protocol_t. This represents one.
+ * For example, refer to systemd-stub initrd_load_file()
+ *
+ * BS->InstallMultipleProtocolInterfaces(handle, ...)
+ * BS->LocateDevicePath(guid, dp, handle)
+ * BS->HandleProtocol(handle, guid, interface)
+ * interface->func()
+ * This struct can be abstracted to serve EFI_BOOT_SERVICES.LocateDevicePath(guid, dp, handle)
+ */
+struct device_instance {
+	struct list_head node;
+	efi_handle_t handle;
+	/*
+	 * Quote UEFI specification:
+	 * 'It is illegal to have two handles in the handle database with identical device paths'
+	 */
+	efi_device_path_protocol_t *dp;
+	/* For simplity, keep the capacity at 8 for the time being */
+	struct protocol_entry entries[8];
+};
+
+static struct device_instance *find_device_by_handle(efi_handle_t h)
+{
+	struct device_instance *inst;
+
+	list_for_each_entry(inst, &devices_list, node) {
+		if (inst->handle == h)
+			return inst;
+	}
+
+	return NULL;
+}
+
+efi_status_t device_create_handle(efi_handle_t *handle)
+{
+	struct device_instance *inst;
+	int sz;
+
+	sz = sizeof(struct device_instance);
+	inst = aligned_alloc(4, sz);
+	memset(inst, 0, sz);
+	emulator_list_add(&inst->node, &devices_list);
+	inst->handle = (efi_handle_t)inst;
+	*handle = inst->handle;
+
+	return EFI_SUCCESS;
+}
+
+efi_status_t device_attach_dev_path(efi_handle_t h, efi_device_path_protocol_t *dp)
+{
+	struct device_instance *inst = (struct device_instance *)h;
+	int sz;
+
+	sz = efi_device_path_size(dp);
+	inst->dp = aligned_alloc(4, sz);
+	/* clone the device path */
+	efi_device_path_clone(inst->dp, dp);
+
+	return EFI_SUCCESS;
+}
+
+/*
+ * BS->InstallMultipleProtocolInterfaces() calls down to here.
+ *
+ * A driver implements its own efi_load_file_protocol_t.
+ *
+ * According to EFI_LOAD_FILE2_PROTOCOL.LoadFile(), only
+ * efi_device_path_protocol_t is required.
+ */
+efi_status_t device_register_protocol(efi_handle_t handle, efi_guid_t guid,
+		void *proto)
+{
+	struct device_instance *inst;
+
+	inst = find_device_by_handle(handle);
+	if (!inst)
+		return EFI_NOT_FOUND;
+
+	for (int i = 0; i < 8; i++) {
+		if (!efi_guidcmp(inst->entries[i].guid, NULL_GUID)) {
+			inst->entries[i].guid = guid;
+			inst->entries[i].proto = proto;
+			return EFI_SUCCESS;
+		}
+	}
+
+	return EFI_OUT_OF_RESOURCES;
+}
+
+efi_status_t device_find_handle_by_path(efi_device_path_protocol_t **dp,
+		efi_handle_t *h)
+{
+	struct device_instance *inst;
+	int ret = -1;
+
+	list_for_each_entry(inst, &devices_list, node) {
+		ret = efi_device_path_compare(*dp, inst->dp);
+		if (!ret) {
+			*h = inst->handle;
+			return EFI_SUCCESS;
+		}
+	}
+
+	return EFI_NOT_FOUND;
+}
+
+efi_status_t device_handle_protocol(efi_handle_t h, efi_guid_t *uuid, void **data)
+{
+	struct device_instance *inst;
+
+	list_for_each_entry(inst, &devices_list, node) {
+		if (inst->handle == h) {
+			for (int i = 0; i < 8; i++) {
+				if (!efi_guidcmp(inst->entries[i].guid, *uuid)) {
+					*data = inst->entries[i].proto;
+					return EFI_SUCCESS;
+				}
+			}
+			/* no need to try other handles */
+			return EFI_NOT_FOUND;
+		}
+	}
+
+	return EFI_NOT_FOUND;
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
index 0000000000000..9b38d1ee69cea
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/emulator.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+typedef efi_status_t (*uefi_pe_entry)(efi_handle_t handle, efi_system_table_t *systab);
+
+struct efi_pe_instance {
+	struct list_head node;
+	efi_handle_t handle;
+	char *image_file_buf;
+	unsigned long image_file_size;
+	/* load address for the instance */
+	unsigned long image_base;
+	unsigned long image_size;
+	uefi_pe_entry entry;
+};
+
+static inline void __emulator_list_add(struct list_head *new,
+			      struct list_head *prev,
+			      struct list_head *next)
+{
+	next->prev = new;
+	new->next = next;
+	new->prev = prev;
+	WRITE_ONCE(prev->next, new);
+}
+
+static inline void emulator_list_add(struct list_head *new, struct list_head *head)
+{
+	__emulator_list_add(new, head, head->next);
+}
+
+extern bool print_enabled;
+extern struct efi_emulator_param *emulator_param;
+extern efi_tcg2_protocol_t emulator_tcg2;
+extern efi_cc_protocol_t emulator_cc;
+extern efi_rng_protocol_t emulator_rng;
+extern efi_simple_text_output_protocol_t text_out;
+extern efi_system_table_t systabs;
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
+extern unsigned long find_image_base_for_handle(efi_handle_t handle);
+
+efi_status_t device_create_handle(efi_handle_t *handle);
+efi_status_t device_attach_dev_path(efi_handle_t h, efi_device_path_protocol_t *dp);
+efi_status_t device_register_protocol(efi_handle_t handle, efi_guid_t guid,
+		void *proto);
+efi_status_t device_find_handle_by_path(efi_device_path_protocol_t **dp,
+		efi_handle_t *h);
+efi_status_t device_handle_protocol(efi_handle_t h, efi_guid_t *uuid,
+		void **data);
+
+int efi_device_path_compare(efi_device_path_protocol_t *path1,
+		efi_device_path_protocol_t *path2);
+size_t efi_device_path_size(efi_device_path_protocol_t *path);
+int efi_device_path_clone(efi_device_path_protocol_t *dst,
+		efi_device_path_protocol_t *dp);
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
+struct efi_pe_instance *get_instance_by_handle(efi_handle_t h);
+struct efi_pe_instance *allocate_pe_instance(char *file_buf, unsigned long size);
+int initialize_emulator_service(struct efi_emulator_param *param);
+void initialize_heap(struct efi_emulator_param *param);
+void load_kernel_pe(struct efi_pe_instance *inst, efi_system_table_t *systabs);
+void emulator_main(struct efi_emulator_param *param);
+void emulator_entry(struct efi_emulator_param *param);
+
diff --git a/drivers/firmware/efi/efi_emulator/entry.c b/drivers/firmware/efi/efi_emulator/entry.c
new file mode 100644
index 0000000000000..e5a31bd303858
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/entry.c
@@ -0,0 +1,61 @@
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
+	struct efi_pe_instance *inst;
+
+	arch_handle_mmu(param);
+	arch_reloc_fixup(delta);
+	setup_earlycon(param);
+	printf("param:0x%lx, delta=0x%lx\n", (unsigned long)param, delta);
+	printf("kernel_img_start:0x%lx, sz:0x%lx\n", (unsigned long)param->kernel_img_start, (unsigned long)param->kernel_img_sz);
+	initialize_emulator_service(param);
+	initialize_heap(param);
+	printf(" load_kernel_pe\n");
+
+	inst = allocate_pe_instance((char *)param->kernel_img_start,
+					param->kernel_img_sz);
+	load_kernel_pe(inst, &systabs);
+}
diff --git a/drivers/firmware/efi/efi_emulator/head.S b/drivers/firmware/efi/efi_emulator/head.S
new file mode 100644
index 0000000000000..705ff131e5fab
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/head.S
@@ -0,0 +1,10 @@
+//SPDX-License-Identifier: GPL-2.0
+.section        ".head.text","ax"
+
+/* x0 holds the physical address of emulator_param */
+emulator_entry:
+	ldr	x1, [x0]
+	mov	sp, x1
+	adrp	x2, emulator_main
+	add	x2, x2, #:lo12:emulator_main
+	br	x2
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
index 0000000000000..bd57942cb0410
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/memory_api.c
@@ -0,0 +1,74 @@
+//SPDX-License-Identifier: GPL-2.0
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
index 0000000000000..0d6e92bc539cf
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/misc.c
@@ -0,0 +1,43 @@
+//SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "emulator.h"
+
+static efi_status_t __efiapi emulator_get_rng(efi_rng_protocol_t * this,
+						 efi_guid_t *uuid, unsigned long size,
+						 u8 *out)
+{
+	/* in fact, disable aslr */
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
index 0000000000000..9113827fd7c9a
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/pe_loader.c
@@ -0,0 +1,173 @@
+//SPDX-License-Identifier: GPL-2.0
+#include <linux/pe.h>
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "emulator.h"
+
+#define VALID_PAYLOAD (IMAGE_SCN_CNT_CODE |IMAGE_SCN_CNT_INITIALIZED_DATA |IMAGE_SCN_CNT_UNINITIALIZED_DATA)
+
+/* Refer to PECOFF spec, 'Base Relocation Types' */
+#define IMAGE_REL_BASED_ABSOLUTE	0
+#define IMAGE_REL_BASED_DIR64	10
+
+unsigned long find_image_base_for_handle(efi_handle_t handle)
+{
+	struct efi_pe_instance *inst;
+
+	inst = get_instance_by_handle(handle);
+	if (!inst)
+		return (unsigned long)-1;
+	return inst->image_base;
+}
+
+typedef struct __packed base_relocation_block {
+	uint32_t page_rva;
+	uint32_t block_size;
+	struct {
+	        uint16_t offset : 12;
+	        uint16_t type : 4;	/* higher 4-bits in Word */
+	} entries[];
+} base_relocation_block_t;
+
+static int pe_image_handle_base_relocation(unsigned long base_reloc_table,
+		unsigned long sz, unsigned long load_addr, unsigned long delta)
+{
+	base_relocation_block_t *blk = (base_relocation_block_t *)base_reloc_table;	
+	unsigned long page_addr, *target_addr, value;
+	uint32_t i, array_num;
+
+	for (; (unsigned long)blk < (base_reloc_table + sz);
+	     blk = (base_relocation_block_t *)((unsigned char*)blk + blk->block_size)) {
+
+		/* block_size includes the total base_relocation_block structure */
+		array_num = (blk->block_size - sizeof(base_relocation_block_t)) >> 1;
+		page_addr = blk->page_rva + load_addr;
+		for (i = 0; i < array_num; i++) {
+			switch (blk->entries[i].type) {
+				case IMAGE_REL_BASED_ABSOLUTE:
+					continue;
+				case IMAGE_REL_BASED_DIR64:
+					target_addr = (unsigned long *)(page_addr + blk->entries[i].offset);
+					value = *target_addr + delta;
+					*target_addr = value;
+					continue;
+				default:
+					printf("ERR: unhandled reloc type: %d\n");
+					return -1; 
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * @pe_hdr_offset supplies the size of Dos Header and Stub.
+ */ 
+static int load_pe(char *file_buf, unsigned long buf_sz, unsigned long pe_hdr_offset,
+			struct efi_pe_instance *inst)
+{
+	unsigned long exec_sz, load_addr, delta;
+	unsigned long base_reloc_table, sz;
+	struct pe_hdr *pe_hdr;
+	struct pe32plus_opt_hdr *opt_hdr;
+	struct data_directory *dir;
+	struct data_dirent *dirent;
+	struct section_header *sect_hdr;
+	int section_nr, i;
+	char *pe_part_buf, *src, *dst;
+	printf("load_pe\n");
+	pe_part_buf = file_buf + pe_hdr_offset;
+	pe_hdr = (struct pe_hdr *)pe_part_buf;
+	if (pe_hdr->opt_hdr_size == 0) {
+		printf("ERR: optional header is missing\n");
+		return -1;
+	}
+	section_nr = pe_hdr->sections;
+	opt_hdr = (struct pe32plus_opt_hdr *)(pe_part_buf + sizeof(struct pe_hdr));
+	sect_hdr = (struct section_header *)((char *)opt_hdr + pe_hdr->opt_hdr_size);
+	exec_sz = opt_hdr->image_size;
+
+	/*
+	 * PE header must be loaded since some efi stubs parse them e.g. systemd-stub
+	 */
+	load_addr = (unsigned long)aligned_alloc(opt_hdr->section_align, exec_sz);
+
+	/*
+	 * Each section has the same delta. Got the delta based on the first
+	 * section's RVA.
+	 */
+	delta = load_addr - opt_hdr->image_base;
+	/* copy PE headers */
+	memcpy((void *)load_addr, file_buf, opt_hdr->header_size);
+
+ 	/* copy section to segment */
+	for (i = 0; i < section_nr; i++) {
+		printf("section: %s, relocs: %u\n", sect_hdr->name, sect_hdr->num_relocs);
+		if (!(sect_hdr->flags & VALID_PAYLOAD)) {
+			sect_hdr++;
+			continue;
+		}
+		/* data_addr is relative to the whole file */
+		src = file_buf + sect_hdr->data_addr;
+		dst = (char *)(sect_hdr->virtual_address + load_addr);
+		memcpy(dst, src, sect_hdr->raw_data_size);
+		printf("virtual_address: 0x%u, src: %u, dst: %u\n", sect_hdr->virtual_address, src, dst);
+		/*
+		 * The SizeOfRawData is rounded but the VirtualSize is not, hence
+		 * the former can be greater than latter.
+		 */
+		if (sect_hdr->virtual_size > sect_hdr->raw_data_size)
+			memset(dst + sect_hdr->raw_data_size, 0, sect_hdr->virtual_size - sect_hdr->raw_data_size);
+		sect_hdr++;
+	}
+
+	/* If there are relocs */
+	if (pe_hdr->opt_hdr_size >
+	    (offsetof(struct data_directory, base_relocations) + sizeof(struct pe32plus_opt_hdr))) {
+		dir = (void *)pe_hdr + sizeof(struct pe_hdr) + sizeof(struct pe32plus_opt_hdr);
+		dirent = &dir->base_relocations;
+		base_reloc_table = dirent->virtual_address + load_addr;
+		sz = dirent->size;
+		pe_image_handle_base_relocation(base_reloc_table, sz, load_addr, delta);
+	}
+
+	/* Since gcc adheres to ABI, using the current SP is fine for new image instance */
+
+	inst->entry = (uefi_pe_entry)(opt_hdr->entry_point + load_addr);
+	inst->image_base = load_addr;
+	inst->image_size = opt_hdr->image_size;
+
+	printf("entry_point:0x%lx, delta:0x%lx, final inst's entry at:0x%lx\n",
+		opt_hdr->entry_point, delta, inst->entry);
+	return 0;
+}
+
+static int parse_kernel_pe(struct efi_pe_instance *inst)
+{
+	char *buf = (char *)inst->image_file_buf;
+	u32 pe_hdr_offset;
+
+	pe_hdr_offset = *((u32 *)(buf + 0x3c));
+	buf += pe_hdr_offset;
+	if (!!memcmp(buf, "PE\0\0", 4)) {
+		printf("Not a PE file\n");
+		return -1;
+	}
+
+	load_pe((char *)inst->image_file_buf, inst->image_file_size,
+			pe_hdr_offset, inst);
+
+	return 0;
+}
+
+void load_kernel_pe(struct efi_pe_instance *inst, efi_system_table_t *systabs)
+{
+	int ret;
+
+	ret = parse_kernel_pe(inst);
+	if (ret < 0)
+		return;
+	(*(inst->entry))(inst->handle, systabs);
+
+}
diff --git a/drivers/firmware/efi/efi_emulator/printf.c b/drivers/firmware/efi/efi_emulator/printf.c
new file mode 100644
index 0000000000000..4d8daf91b426b
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/printf.c
@@ -0,0 +1,373 @@
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
+static char *ucs2_to_ascii(char *ascii_str, efi_char16_t *ucs2_str)
+{
+	size_t len = 0;
+
+	while (ucs2_str[len] != 0) {
+		len++;
+	}
+
+	/* Convert each UCS-2 character to ASCII */
+	for (size_t i = 0; i < len; i++) {
+		if (ucs2_str[i] <= 127) {
+			/* Character is in ASCII range */
+			ascii_str[i] = (char)ucs2_str[i];
+		} else {
+			/* Character is outside ASCII range */
+			ascii_str[i] = '?';
+		}
+	}
+	/* Enforce a null-terminate the ASCII string */
+	ascii_str[len] = '\0';
+
+	return ascii_str;
+}
+
+
+/* Convert the UCS-2 string to a ascii string */
+void print_ucs2_string(efi_char16_t *ucs2_str)
+{
+	char ascii_str[1024];
+	char* p = ascii_str;
+
+	ucs2_to_ascii(p, ucs2_str);
+	/* Print the ascii string */
+	printf("%s\n", ascii_str);
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
diff --git a/drivers/firmware/efi/efi_emulator/protocol_device_path.c b/drivers/firmware/efi/efi_emulator/protocol_device_path.c
new file mode 100644
index 0000000000000..c31dcb8d0016b
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/protocol_device_path.c
@@ -0,0 +1,75 @@
+//SPDX-License-Identifier: GPL-2.0
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "emulator.h"
+
+static inline bool is_end_node(efi_device_path_protocol_t *node)
+{
+	return node->type == EFI_DEV_END_PATH &&
+		node->sub_type == EFI_DEV_END_ENTIRE;
+}
+
+static inline efi_device_path_protocol_t *
+	next_device_path_node(efi_device_path_protocol_t *node)
+{
+    return (efi_device_path_protocol_t *)((u8 *)node + node->length);
+}
+
+/*
+ * efi_device_path_compare - Compare two EFI device paths
+ *
+ * Return: 0 if equal, otherwise non-zero
+ */
+int efi_device_path_compare(efi_device_path_protocol_t *path1,
+		efi_device_path_protocol_t *path2)
+{
+	efi_device_path_protocol_t *node1 = path1;
+	efi_device_path_protocol_t *node2 = path2;
+
+	while (!is_end_node(node1) && !is_end_node(node2)) {
+		if (node1->type != node2->type ||
+		    node1->sub_type != node2->sub_type ||
+		    node1->length != node2->length)
+			return 1;
+
+		node1 = next_device_path_node(node1);
+		node2 = next_device_path_node(node2);
+	}
+
+	/* Check if both reached the end */
+	if (is_end_node(node1) && is_end_node(node2))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * efi_device_path_size - Calculate the total size of an EFI device path
+ * @path: Pointer to the first EFI_DEVICE_PATH structure
+ *
+ * Return: Total size of the EFI device path
+ */
+size_t efi_device_path_size(efi_device_path_protocol_t *path)
+{
+	efi_device_path_protocol_t *node = path;
+	size_t total_size = 0;
+
+	while (!is_end_node(node)) {
+		total_size += node->length;
+		node = next_device_path_node(node);
+	}
+
+	/* Include the size of the end node */
+	total_size += node->length;
+
+	return total_size;
+}
+
+int efi_device_path_clone(efi_device_path_protocol_t *dst,
+		efi_device_path_protocol_t *dp)
+{
+	size_t sz = efi_device_path_size(dp);
+
+	memcpy((void *)dst, (void *)dp, sz);
+	return 0;
+}
diff --git a/drivers/firmware/efi/efi_emulator/protocol_simple_text_output.c b/drivers/firmware/efi/efi_emulator/protocol_simple_text_output.c
new file mode 100644
index 0000000000000..6544bfc7f43dc
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/protocol_simple_text_output.c
@@ -0,0 +1,50 @@
+//SPDX-License-Identifier: GPL-2.0
+
+#include "emulator.h"
+
+/* UCS-2 (Universal Coded Character Set) */
+static efi_status_t __efiapi output_string(efi_simple_text_output_protocol_t *simple,
+						       efi_char16_t *str)
+{
+	if (print_enabled)
+		print_ucs2_string(str);
+	return EFI_SUCCESS;
+}
+
+struct simple_text_output_mode {
+	int32_t	max_mode;
+	int32_t	mode;
+	int32_t	attribute;
+	int32_t	cursor_column;
+	int32_t	cursor_row;
+	bool	cursor_visible;
+};
+
+struct simple_text_output_mode output_mode;
+
+static efi_status_t __efiapi  text_reset(
+		efi_simple_text_output_protocol_t *this,
+		bool extended_verification)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t __efiapi text_set_attribute(
+		efi_simple_text_output_protocol_t *this,
+		unsigned int attribute)
+{
+	return EFI_UNSUPPORTED;
+}
+
+efi_simple_text_output_protocol_t text_out = {
+	
+	.reset = text_reset,
+	.output_string = output_string,
+	.query_mode = NULL,
+	.set_mode = NULL,
+	.set_attribute = text_set_attribute,
+	.clean_screen = NULL,
+	.set_cursor_pos = NULL,
+	.enable_cursor = NULL,
+	.mode	= &output_mode,
+};
diff --git a/include/linux/efi_emulator.h b/include/linux/efi_emulator.h
new file mode 100644
index 0000000000000..ef235861f3a85
--- /dev/null
+++ b/include/linux/efi_emulator.h
@@ -0,0 +1,46 @@
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
+	/* The last struct */
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


