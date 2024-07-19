Return-Path: <linux-efi+bounces-1469-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A1937960
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jul 2024 16:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AEB1F21762
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jul 2024 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470CD1F949;
	Fri, 19 Jul 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxbSBXRF"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FCB660
	for <linux-efi@vger.kernel.org>; Fri, 19 Jul 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400909; cv=none; b=JbEa+a1Dqgf7zWebjov6dcM/yN+eqlPh5zZODftwpQkEE/M/v8cMeLKNqJbPOigRH7LktZ14Kuu35hAIZurz1+zH9TckRDek5kodTr1ebaxAfafo+RlYTuEPvh9f2Ryq3KAOilXmipK4oGrv56dPPRsfiExZa9CrpSpb27baM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400909; c=relaxed/simple;
	bh=NFdIzXZbhXOJYl4v10RP1PqYx2aMgVG8TLNpwxoq3xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeQ4cyfDS2DhnZXeUUqkhewWyLb03iWHPFD/8vzYQ4Hr7bHybEckoJyUXkYB0XHkf191M8rLM/4E4qpyi92XFte4TCjmZl2Gw/xgwsZEWlwzIP5HSNqegBGTixb3Y0yeyfl0PzogxbAuHsekazhqQcAhQMuKQZvnxPWOktPmNsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxbSBXRF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721400904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CM08iTLqrVAwuUWWIDydzE60/9HanT9jyQeipF/di4I=;
	b=IxbSBXRFZII5ZnMz7yUegyNF1cuqy8DXhbYoUrG2faj5gDS3w7g9Q+UNbNUWKo3HbJJW8J
	OSI5ZJo3aHDZfFupj4qWUgQP8Gy0h+oS3fOTx7YEOpFlDl+aWKOnrDBRShAPdhHTvqJcjv
	ao4zB33mqCDgfSYljU2Ae0dZpGhA/Pg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-aBu8-2VtMdaPIC6SfJ-HFg-1; Fri, 19 Jul 2024 10:55:02 -0400
X-MC-Unique: aBu8-2VtMdaPIC6SfJ-HFg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b79409b763so30917576d6.3
        for <linux-efi@vger.kernel.org>; Fri, 19 Jul 2024 07:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721400901; x=1722005701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CM08iTLqrVAwuUWWIDydzE60/9HanT9jyQeipF/di4I=;
        b=lY/K0r7yzP+D19EWmi5pGzf8nccy17Laz3RiG0NBm9G2gc5qSqmiH16cw8dxUXakMM
         R9vz180Hj4FXIuufHJF9b7VNswMDpQkmGjF6wPZ/HwhwZtv1qsrHEupVlAqRsmCeX3IV
         WAYZTCXVulLmKNkZ9PP9uFuSjQ5lJ+bE9Suc4OzkY1XgIJszfVtbvAVToYjm/4+Z3GJi
         dKSVkJgTN1TtpmTKt8+ArXTskzuWkg8wdzX38QTQehCboa1FpptZ2tKa1kM33qrG3oRd
         8S6/F9Leu0ieOlqK11SOo/RM4ueiRValH6HaoWb+tXOLBkP7BKm7v4VN0KNP3Jxvcg4F
         VQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy16UXEYINAdAOkDBldufSvqnTvTI8AR7LGg2rT5alAiswRJxfZTw8d8P++0MJZW0cw3SVYxxolDIwO8pl2RIDKi86OlLMq+sm
X-Gm-Message-State: AOJu0YzYn+Pnt1GkHmKhkMrbAqJxBfaucL0ZdkTZ3HzdqM4bE74eleQT
	K1oVAOPb8+Vk356NIHrjFpy+HIZ2DPktpYjlWC1IDvceBbQdcp4fGEHrMLgdRoTNDfFNafzY307
	PloI2abVAmRbK/qMkAOO6c6k91Ws7s4i8DlvlHda/oyHQtRH4f+PPZbPs8fX0K9C+R4FVUJkmds
	6xzWVLQngqOa5wsgeEskq/Nzj3FChRp59c
X-Received: by 2002:a05:6214:20a1:b0:6b0:6d7c:da02 with SMTP id 6a1803df08f44-6b94efde4b7mr2558846d6.11.1721400901371;
        Fri, 19 Jul 2024 07:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPaN/ReEChs2xA+6fB3TApVIWMyHQrKe5vz3bHp8vj2IG/RjISmvNiSP4JOnqHtjCwKfqwhLqqxd/tX6qI7cc=
X-Received: by 2002:a05:6214:20a1:b0:6b0:6d7c:da02 with SMTP id
 6a1803df08f44-6b94efde4b7mr2558386d6.11.1721400900807; Fri, 19 Jul 2024
 07:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718085759.13247-1-piliu@redhat.com> <20240718085759.13247-4-piliu@redhat.com>
In-Reply-To: <20240718085759.13247-4-piliu@redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 19 Jul 2024 22:54:49 +0800
Message-ID: <CAF+s44T9DgKRRfP4oPS7GnxNOHOsQ1NX9zhVq3VvmNiXfRf+Cg@mail.gmail.com>
Subject: Re: [RFC 3/7] efi/emulator: Initial rountines to emulate EFI boot
 time service
To: linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen <jarkko@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:58=E2=80=AFPM Pingfan Liu <piliu@redhat.com> wrot=
e:
>
> From: Pingfan Liu <kernelfans@gmail.com>
>
> efi emulator aims to serve the kexec if the kernel wrapped by efistub.
> It is paired with efistub, so only implements the minimus set of EFI boot
> service which merely enough boots up efistub.
>
> To simplify the code, the task such as the building of page table etc is
> shift to the first kernel as more as possible. (This part is implement
> in the later patch in this series)
>
> To do:
> -1. a simple memory allocator
> -2. a few extra efi boot service.
>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> To: linux-arm-kernel@lists.infradead.org
> To: kexec@lists.infradead.org
> To: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/Makefile                 |   1 +
>  drivers/firmware/efi/efi_emulator/Makefile    |  98 +++++
>  .../firmware/efi/efi_emulator/amba-pl011.c    |  80 ++++
>  .../efi_emulator/arm64_emulator_service.lds   |  45 ++
>  .../firmware/efi/efi_emulator/config_table.c  |  23 ++
>  drivers/firmware/efi/efi_emulator/core.c      | 211 ++++++++++
>  drivers/firmware/efi/efi_emulator/earlycon.h  |  19 +
>  .../firmware/efi/efi_emulator/efi_emulator.S  |  12 +
>  drivers/firmware/efi/efi_emulator/emulator.h  |  66 +++
>  drivers/firmware/efi/efi_emulator/entry.c     |  57 +++
>  drivers/firmware/efi/efi_emulator/head.S      |  10 +
>  drivers/firmware/efi/efi_emulator/initrd.c    |  15 +
>  drivers/firmware/efi/efi_emulator/lib.c       |  73 ++++
>  drivers/firmware/efi/efi_emulator/memory.c    |  27 ++
>  .../firmware/efi/efi_emulator/memory_api.c    |  73 ++++
>  drivers/firmware/efi/efi_emulator/misc.c      |  76 ++++
>  drivers/firmware/efi/efi_emulator/pe_loader.c | 124 ++++++
>  drivers/firmware/efi/efi_emulator/printf.c    | 389 ++++++++++++++++++
>  .../efi/efi_emulator/runtime_service.c        |  28 ++
>  include/linux/efi_emulator.h                  |  45 ++
>  include/linux/kexec.h                         |   2 +
>  21 files changed, 1474 insertions(+)
>  create mode 100644 drivers/firmware/efi/efi_emulator/Makefile
>  create mode 100644 drivers/firmware/efi/efi_emulator/amba-pl011.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/arm64_emulator_serv=
ice.lds
>  create mode 100644 drivers/firmware/efi/efi_emulator/config_table.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/core.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/earlycon.h
>  create mode 100644 drivers/firmware/efi/efi_emulator/efi_emulator.S
>  create mode 100644 drivers/firmware/efi/efi_emulator/emulator.h
>  create mode 100644 drivers/firmware/efi/efi_emulator/entry.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/head.S
>  create mode 100644 drivers/firmware/efi/efi_emulator/initrd.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/lib.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/memory.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/memory_api.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/misc.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/pe_loader.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/printf.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/runtime_service.c
>  create mode 100644 include/linux/efi_emulator.h
>
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefil=
e
> index a2d0009560d0f..eb2a5d864f416 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)         +=3D efi-pstore.o
>  obj-$(CONFIG_UEFI_CPER)                        +=3D cper.o cper_cxl.o
>  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     +=3D runtime-wrappers.o
>  subdir-$(CONFIG_EFI_STUB)              +=3D libstub
> +obj-y                                  +=3D efi_emulator/
>  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   +=3D efibc.o
>  obj-$(CONFIG_EFI_TEST)                 +=3D test/
>  obj-$(CONFIG_EFI_DEV_PATH_PARSER)      +=3D dev-path-parser.o
> diff --git a/drivers/firmware/efi/efi_emulator/Makefile b/drivers/firmwar=
e/efi/efi_emulator/Makefile
> new file mode 100644
> index 0000000000000..e37472004a2b5
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/Makefile
> @@ -0,0 +1,98 @@
> +# non-x86 reuses KBUILD_CFLAGS, x86 does not
> +cflags-y                       :=3D $(KBUILD_CFLAGS)
> +
> +cflags-$(CONFIG_X86_32)                :=3D -march=3Di386
> +cflags-$(CONFIG_X86_64)                :=3D -mcmodel=3Dsmall
> +cflags-$(CONFIG_X86)           +=3D -m$(BITS) -D__KERNEL__ \
> +                                  -fno-strict-aliasing -mno-red-zone \
> +                                  -mno-mmx -mno-sse -fshort-wchar \
> +                                  -Wno-pointer-sign \
> +                                  $(call cc-disable-warning, address-of-=
packed-member) \
> +                                  $(call cc-disable-warning, gnu) \
> +                                  -fno-asynchronous-unwind-tables \
> +                                  $(CLANG_FLAGS)
> +
> +# arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> +# disable the stackleak plugin
> +cflags-$(CONFIG_ARM64)         +=3D $(DISABLE_STACKLEAK_PLUGIN) \
> +                                  -fno-unwind-tables -fno-asynchronous-u=
nwind-tables
> +cflags-$(CONFIG_ARM)           +=3D -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN=
 \
> +                                  -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
> +                                  -DEFI_HAVE_STRCMP -fno-builtin  \
> +                                  $(call cc-option,-mno-single-pic-base)
> +cflags-$(CONFIG_RISCV)         +=3D -DNO_ALTERNATIVE -mno-relax
> +cflags-$(CONFIG_LOONGARCH)     +=3D
> +
> +cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)   +=3D -I$(srctree)/scripts/dtc/lib=
fdt
> +
> +cflags-y       +=3D -I drivers/firmware/efi/libstub
> +
> +KBUILD_CFLAGS                  :=3D $(subst $(CC_FLAGS_FTRACE),,$(cflags=
-y)) \
> +                                  -Os -DDISABLE_BRANCH_PROFILING \
> +                                  -D__NO_FORTIFY \
> +                                  -ffreestanding \
> +                                  -fno-stack-protector \
> +                                  $(call cc-option,-fno-addrsig) \
> +                                  -D__DISABLE_EXPORTS
> +
> +#
> +# struct randomization only makes sense for Linux internal types, which =
the EFI
> +# stub code never touches, so let's turn off struct randomization for th=
e stub
> +# altogether
> +#
> +KBUILD_CFLAGS :=3D $(filter-out $(RANDSTRUCT_CFLAGS), $(KBUILD_CFLAGS))
> +
> +# remove SCS flags from all objects in this directory
> +KBUILD_CFLAGS :=3D $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
> +# disable CFI
> +KBUILD_CFLAGS :=3D $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
> +# disable LTO
> +KBUILD_CFLAGS :=3D $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
> +
> +GCOV_PROFILE                   :=3D n
> +# Sanitizer runtimes are unavailable and cannot be linked here.
> +KASAN_SANITIZE                 :=3D n
> +KCSAN_SANITIZE                 :=3D n
> +KMSAN_SANITIZE                 :=3D n
> +UBSAN_SANITIZE                 :=3D n
> +OBJECT_FILES_NON_STANDARD      :=3D y
> +
> +# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
> +KCOV_INSTRUMENT                        :=3D n
> +
> +OBJECT_FILES_NON_STANDARD      :=3D y
> +emulator-y                     :=3D head.o entry.o \
> +                                  core.o pe_loader.o misc.o memory.o mem=
ory_api.o runtime_service.o config_table.o \
> +                                  lib.o printf.o \
> +                                  amba-pl011.o
> +obj-y                          :=3D efi_emulator.o
> +
> +
> +EMULATOR_OBJS =3D $(addprefix $(obj)/,$(emulator-y))
> +
> +quiet_cmd_ar_emulator =3D PAD     $@
> +      cmd_ar_emulator =3D $(AR) rcSTP $@ $^
> +
> +$(obj)/emulator.a: $(EMULATOR_OBJS)
> +       $(call if_changed,ar_emulator)
> +
> +
> +quiet_cmd_link_emulator =3D PAD     $@
> +      cmd_link_emulator =3D ld -z norelro -z noexecstack -shared --no-un=
defined -X -Bsymbolic -z notext --emit-relocs --no-apply-dynamic-relocs  \
> +                               -T $(srctree)/drivers/firmware/efi/efi_em=
ulator/arm64_emulator_service.lds \
> +                                --whole-archive $< --no-whole-archive -o=
 $@
> +
> +
> +$(obj)/emulator.ro: $(obj)/emulator.a FORCE
> +       $(call if_changed,link_emulator)
> +
> +
> +$(obj)/emulator.raw: $(obj)/emulator.ro FORCE
> +       objcopy  -O binary -R .note -R .note.gnu.build-id -R .comment -g =
$< $@
> +
> +$(obj)/efi_emulator.o: $(obj)/emulator.raw
> +
> +
> +targets                                +=3D $(emulator-y)
> +
> +
> diff --git a/drivers/firmware/efi/efi_emulator/amba-pl011.c b/drivers/fir=
mware/efi/efi_emulator/amba-pl011.c
> new file mode 100644
> index 0000000000000..334b25e177081
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/amba-pl011.c
> @@ -0,0 +1,80 @@
> +
> +#include <linux/stdarg.h>
> +#include <linux/amba/serial.h>
> +#include "earlycon.h"
> +
> +#define SERIAL_IO_MEM32 3
> +#define UPIO_MEM32 SERIAL_IO_MEM32
> +
> +struct uart_port {
> +       unsigned long           iobase;                 /* in/out[bwl] */
> +       unsigned char __iomem   *membase;               /* read/write[bwl=
] */
> +       unsigned char           iotype;                 /* io access styl=
e */
> +};
> +
> +static struct uart_port pl011_port;
> +
> +static void pl011_putc(struct uart_port *port, unsigned char c)
> +{
> +       while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
> +               cpu_relax();
> +       if (port->iotype =3D=3D UPIO_MEM32)
> +               writel(c, port->membase + UART01x_DR);
> +       else
> +               writeb(c, port->membase + UART01x_DR);
> +       while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
> +               cpu_relax();
> +}
> +
> +static int pl011_put_str(const char *str, void *data)
> +{
> +       char *p =3D (char *)str;
> +       struct uart_port *port =3D (struct uart_port *)data;
> +
> +       for (; *p !=3D '\0'; p++)
> +               pl011_putc(port, *p);
> +
> +       return (p - str);
> +}
> +
> +static void pl011_write(struct uart_port *port, unsigned int reg, unsign=
ed int val)
> +{
> +       void __iomem *addr =3D port->membase + reg;
> +
> +       if (port->iotype =3D=3D UPIO_MEM32)
> +               writel_relaxed(val, addr);
> +       else
> +               writew_relaxed(val, addr);
> +}
> +
> +static bool pl011_match(struct efi_emulator_param *param, const char *na=
me)
> +{
> +       struct uart_port *port =3D &pl011_port;
> +
> +       if (strcmp(param->earlycon_name, name))
> +               return false;
> +
> +       port->iotype =3D UPIO_MEM32;
> +       port->membase =3D (unsigned char *)param->earlycon_reg_base;
> +       return true;
> +}
> +
> +static void pl011_reset(void *data)
> +{
> +       struct uart_port *port =3D data;
> +
> +       /* disable DMA */
> +       pl011_write(port, UART011_DMACR, 0);
> +       /* disable interrupt */
> +       pl011_write(port, UART011_IMSC, 0);
> +       /* Skip: set clk rate */
> +       /* Now, pl011 can be used in poll mode */
> +}
> +
> +struct earlycon pl011 =3D {
> +       .match =3D pl011_match,
> +       .reset =3D pl011_reset,
> +       .put_str =3D pl011_put_str,
> +       .data =3D &pl011_port,
> +       .name =3D "amba-pl011",
> +};
> diff --git a/drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds=
 b/drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds
> new file mode 100644
> index 0000000000000..82d7659346af5
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +ENTRY(emulator_entry)
> +EMULATOR_BASE_ADDR =3D 0x0;
> +
> +SECTIONS
> +{
> +       . =3D EMULATOR_BASE_ADDR;
> +       .head : ALIGN(4096) {
> +               *(.head.text)
> +       }
> +
> +       .text : {
> +               *(.text* .init.text*)
> +       }
> +
> +       .rodata : ALIGN(8) {
> +               *(.rodata* .init.rodata* .srodata*)
> +
> +               _etext =3D ALIGN(4096);
> +               . =3D _etext;
> +       }
> +
> +       .rela.dyn : ALIGN(4096) {
> +               _rela_start =3D .;
> +               *(.rela .rela*)
> +               _rela_end =3D .;
> +       }
> +
> +       .data : ALIGN(4096) {
> +               *(.data* .init.data*)
> +               _edata =3D ALIGN(512);
> +               . =3D _edata;
> +       }
> +
> +       .bss : {
> +               *(.bss* .init.bss*)
> +               _end =3D ALIGN(512);
> +               . =3D _end;
> +       }
> +
> +       /DISCARD/ : {
> +               *(.modinfo .init.modinfo)
> +       }
> +}
> diff --git a/drivers/firmware/efi/efi_emulator/config_table.c b/drivers/f=
irmware/efi/efi_emulator/config_table.c
> new file mode 100644
> index 0000000000000..3efe76cbd86fd
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/config_table.c
> @@ -0,0 +1,23 @@
> +
> +#include "emulator.h"
> +
> +
> +static efi_status_t conjoin_memreserve_table(void *table, efi_config_tab=
le_t *t)
> +{
> +       struct linux_efi_memreserve *prev, *next;
> +
> +       prev =3D (struct linux_efi_memreserve *)t->table;
> +       next =3D (struct linux_efi_memreserve *)table;
> +
> +       prev->next =3D (phys_addr_t)next;
> +       next->next =3D 0;
> +       return EFI_SUCCESS;
> +}
> +
> +efi_status_t conjoin_table(efi_guid_t *uuid, void *table, efi_config_tab=
le_t *t)
> +{
> +       if (!efi_guidcmp(t->guid, LINUX_EFI_MEMRESERVE_TABLE_GUID))
> +               return conjoin_memreserve_table(table, t);
> +
> +       return EFI_OUT_OF_RESOURCES;
> +}
> diff --git a/drivers/firmware/efi/efi_emulator/core.c b/drivers/firmware/=
efi/efi_emulator/core.c
> new file mode 100644
> index 0000000000000..29f3671a2db26
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/core.c
> @@ -0,0 +1,211 @@
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +
> +#include "emulator.h"
> +
> +int emulator_initialize(void);
> +
> +struct efi_emulator_param *emulator_param;
> +
> +static efi_loaded_image_t loaded_image;
> +static bool print_enabled;
> +
> +/* The 1st kernel convert cmdline to utf16 and pass to emulator */
> +static efi_status_t handle_protocol_loaded_image(efi_handle_t h, void **=
data)
> +{
> +       loaded_image.load_options =3D emulator_param->cmdline;
> +       loaded_image.load_options_size =3D emulator_param->sz_in_byte;
> +       /* loaded address */
> +       loaded_image.image_base =3D 0x0;

Here, image_base should point to the PE file loaded address. So the
pe_memory_locate_sections() in systemd-stub can locate the in-memory
UKI image and parse each section.

And in the emulator, all things connect with UEFI, it does not
perceive the UKI image internal layout.

Thanks,

Pingfan
> +
> +       *data =3D &loaded_image;
> +       return EFI_SUCCESS;
> +
> +}
> +
> +
> +static efi_status_t __efiapi emulator_handle_protocol(efi_handle_t h,
> +                               efi_guid_t *uuid, void **data)
> +{
> +       if (!efi_guidcmp(*uuid, LOADED_IMAGE_PROTOCOL_GUID))
> +               return handle_protocol_loaded_image(h, data);
> +
> +       return EFI_UNSUPPORTED;
> +}
> +
> +//The LocateProtocol() function finds the first device handle that suppo=
rt Protocol, and returns a
> +// pointer to the protocol interface from that handle in Interface. If n=
o protocol instances are found, then Interface is set to NULL.
> +static efi_status_t __efiapi emulator_locate_protocol(efi_guid_t *uuid,
> +                               void *registration, void **interface)
> +{
> +       if (!efi_guidcmp(*uuid, EFI_TCG2_PROTOCOL_GUID)) {
> +               *interface =3D &emulator_tcg2;
> +               return EFI_SUCCESS;
> +       } else if (!efi_guidcmp(*uuid, EFI_CC_MEASUREMENT_PROTOCOL_GUID))=
 {
> +               *interface =3D &emulator_cc;
> +               return EFI_SUCCESS;
> +       } else if (!efi_guidcmp(*uuid, EFI_RNG_PROTOCOL_GUID)) {
> +               *interface =3D &emulator_rng;
> +               return EFI_SUCCESS;
> +       }
> +
> +       return EFI_UNSUPPORTED;
> +}
> +
> +// 2do
> +static efi_status_t __efiapi emulator_allocate_pages(int alloc_type, int=
 mem_type,
> +                       unsigned long nr_pages, efi_physical_addr_t *addr=
)
> +{
> +       return __emulator_allocate_pages(alloc_type, mem_type, nr_pages, =
addr);
> +}
> +
> +// 2do
> +static efi_status_t __efiapi emulator_free_pages(efi_physical_addr_t add=
r,
> +                       unsigned long nr_4KB)
> +{
> +       return EFI_SUCCESS;
> +
> +}
> +
> +static efi_status_t __efiapi emulator_allocate_pool(int mem_type, unsign=
ed long sz,
> +                                      void **pool)
> +{
> +       return __emulator_allocate_pool(mem_type, sz, pool);
> +
> +}
> +
> +static efi_status_t __efiapi emulator_free_pool(void *pool)
> +{
> +       return EFI_SUCCESS;
> +
> +}
> +
> +/* memmove() alias as memcpy() */
> +static void __efiapi emulator_copy_mem(void *dest, const void *src, unsi=
gned long count)
> +{
> +       char *tmp;
> +       const char *s;
> +
> +       if (dest <=3D src) {
> +               tmp =3D dest;
> +               s =3D src;
> +               while (count--)
> +                       *tmp++ =3D *s++;
> +       } else {
> +               tmp =3D dest;
> +               tmp +=3D count;
> +               s =3D src;
> +               s +=3D count;
> +               while (count--)
> +                       *--tmp =3D *--s;
> +       }
> +
> +}
> +
> +static void __efiapi emulator_set_mem(void *dst, unsigned long cnt, unsi=
gned char val)
> +{
> +       unsigned char *dst_ptr =3D (char *)dst;
> +       unsigned long i;
> +
> +       for (i =3D 0; i < cnt; i++)
> +               dst_ptr[i] =3D val;
> +}
> +
> +static efi_status_t __efiapi emulator_install_configuration_table(efi_gu=
id_t *uuid,
> +                                                                    void=
 *table)
> +{
> +       efi_config_table_t *t =3D (efi_config_table_t *)systabs.tables;
> +       int i;
> +
> +       for (i =3D 0; i < systabs.nr_tables; i++, t++) {
> +               if (!efi_guidcmp(t->guid, *uuid))
> +                       return conjoin_table(uuid, table, t);
> +       }
> +       t->guid =3D *uuid;
> +       t->table =3D table;
> +       systabs.nr_tables++;
> +
> +       return EFI_SUCCESS;
> +}
> +
> +/*
> + * As the final stage, destroy the boottime context, e.g. release the me=
mory
> + * occupied by some data struct.
> + */
> +static efi_status_t __efiapi emulator_exit_boot_services(efi_handle_t ha=
ndle,
> +                                                           unsigned long=
 map_key)
> +{
> +       return EFI_SUCCESS;
> +}
> +
> +static efi_boot_services_t bt_services =3D {
> +       .handle_protocol =3D emulator_handle_protocol,
> +       .locate_protocol =3D emulator_locate_protocol,
> +       .allocate_pool =3D emulator_allocate_pool,
> +       .free_pool =3D emulator_free_pool,
> +       .allocate_pages =3D emulator_allocate_pages,
> +       .free_pages =3D emulator_free_pages,
> +       .copy_mem =3D emulator_copy_mem,
> +       .set_mem =3D emulator_set_mem,
> +       .get_memory_map =3D emulator_get_memory_map,
> +       .install_configuration_table =3D emulator_install_configuration_t=
able,
> +       .exit_boot_services =3D emulator_exit_boot_services,
> +};
> +
> +/* UCS-2 (Universal Coded Character Set) */
> +static efi_status_t __efiapi output_string(efi_simple_text_output_protoc=
ol_t * simple,
> +                                                      efi_char16_t *str)
> +{
> +       if (print_enabled)
> +               print_ucs2_string(str);
> +       return EFI_SUCCESS;
> +}
> +
> +static efi_simple_text_output_protocol_t text_out =3D {
> +       .output_string =3D output_string,
> +};
> +
> +efi_system_table_t systabs =3D {
> +       .hdr =3D {
> +               .signature =3D EFI_SYSTEM_TABLE_SIGNATURE,
> +       },
> +
> +       .con_out =3D &text_out,
> +       .runtime =3D NULL,
> +       .boottime =3D &bt_services,
> +       .nr_tables =3D 0,
> +       .tables =3D 0,
> +
> +};
> +
> +static efi_rt_properties_table_t rt_support =3D {
> +       .runtime_services_supported =3D 0,
> +};
> +
> +int initialize_emulator_service(struct efi_emulator_param *param)
> +{
> +
> +       efi_config_table_t *tables;
> +       unsigned int i;
> +
> +       printf("initialize_emulator_service, dtb=3D0x%lx, mempool_start=
=3D0x%lx, end:0x%lx\n",
> +                       param->dtb, param->mempool_start, param->mempool_=
start + param->mempool_sz);
> +       emulator_param =3D param;
> +       print_enabled =3D param->print_enabled;
> +       i =3D param->rt_info.systab_nr_tables;
> +       systabs.tables =3D (unsigned long)&param->rt_info.systab_tables;
> +       tables =3D param->rt_info.systab_tables;
> +       tables[i].guid =3D DEVICE_TREE_GUID;
> +       tables[i].table =3D (void *)param->dtb;
> +       i++;
> +       if (!param->noefi_boot) {
> +               rt_support.runtime_services_supported =3D param->rt_info.=
runtime_supported_mask;
> +       }
> +       tables[i].guid =3D EFI_RT_PROPERTIES_TABLE_GUID;
> +       tables[i].table =3D (void *)&rt_support;
> +       i++;
> +       systabs.nr_tables =3D i;
> +
> +       systabs.runtime =3D (efi_runtime_services_t *)param->rt_info.runt=
ime;
> +       return 0;
> +}
> diff --git a/drivers/firmware/efi/efi_emulator/earlycon.h b/drivers/firmw=
are/efi/efi_emulator/earlycon.h
> new file mode 100644
> index 0000000000000..189af549d5af2
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/earlycon.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/efi_emulator.h>
> +#include <asm/processor.h>
> +#include <asm/io.h>
> +#include <asm-generic/io.h>
> +
> +struct earlycon {
> +       bool (*match)(struct efi_emulator_param *param, const char *name)=
;
> +       int (*put_str)(const char *str, void *data);
> +       void (*reset)(void *data);
> +       void *data;
> +       const char *name;
> +};
> +
> +extern struct earlycon pl011;
> +
> +extern int pl011_puts(const char *str);
> +void setup_earlycon(struct efi_emulator_param *param);
> diff --git a/drivers/firmware/efi/efi_emulator/efi_emulator.S b/drivers/f=
irmware/efi/efi_emulator/efi_emulator.S
> new file mode 100644
> index 0000000000000..fb52593ba3b2e
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/efi_emulator.S
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +       .section .rodata, "a"
> +
> +       .align  8
> +_efi_emulator_start:
> +       .globl  _efi_emulator_start
> +       .incbin "drivers/firmware/efi/efi_emulator/emulator.raw"
> +
> +       .align  8
> +_efi_emulator_end:
> +       .globl  _efi_emulator_end
> diff --git a/drivers/firmware/efi/efi_emulator/emulator.h b/drivers/firmw=
are/efi/efi_emulator/emulator.h
> new file mode 100644
> index 0000000000000..e524cbd92180c
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/emulator.h
> @@ -0,0 +1,66 @@
> +#include <linux/nls.h>
> +#include <linux/efi_emulator.h>
> +
> +/* Included from drivers/firmware/efi/libstub */
> +#include <efistub.h>
> +
> +#define EMULATOR_BASE_ADDR 0
> +
> +typedef union efi_rng_protocol efi_rng_protocol_t;
> +
> +union efi_rng_protocol {
> +       struct {
> +               efi_status_t (__efiapi *get_info)(efi_rng_protocol_t *,
> +                                                 unsigned long *,
> +                                                 efi_guid_t *);
> +               efi_status_t (__efiapi *get_rng)(efi_rng_protocol_t *,
> +                                                efi_guid_t *, unsigned l=
ong,
> +                                                u8 *out);
> +       };
> +       struct {
> +               u32 get_info;
> +               u32 get_rng;
> +       } mixed_mode;
> +};
> +
> +struct uki_info {
> +       unsigned long initrd_base;
> +       unsigned long initrd_sz;
> +       unsigned long cmdline_base;
> +       unsigned long cmdline_sz;
> +};
> +
> +extern struct efi_emulator_param *emulator_param;
> +extern efi_tcg2_protocol_t emulator_tcg2;
> +extern efi_cc_protocol_t emulator_cc;
> +extern efi_rng_protocol_t emulator_rng;
> +extern efi_system_table_t systabs;
> +extern efi_runtime_services_t rt_services;
> +extern char *heap_start, *heap_end, *heap_cur;
> +
> +void *aligned_alloc(size_t alignment, size_t size);
> +void *memcpy(void *dest, const void *src, size_t n);
> +void *memset(void *s, int c, size_t n);
> +int strcmp(const char *cs, const char *ct);
> +size_t wcslen(const wchar_t *str);
> +int wcscmp(const wchar_t *s1, const wchar_t *s2);
> +int printf(const char *format, ...);
> +void print_ucs2_string(efi_char16_t* ucs2_str);
> +
> +efi_status_t __emulator_allocate_pages(int alloc_type, int mem_type,
> +                       unsigned long nr_pages, efi_physical_addr_t *addr=
);
> +efi_status_t __emulator_allocate_pool(int mem_type, unsigned long sz,
> +                                      void **pool);
> +efi_status_t emulator_get_memory_map(unsigned long *map_sz,
> +       void *memmap, unsigned long *map_key, unsigned long *desc_sz,
> +       unsigned int *desc_version);
> +
> +efi_status_t conjoin_table(efi_guid_t *uuid, void *table, efi_config_tab=
le_t *t);
> +
> +int initialize_emulator_service(struct efi_emulator_param *param);
> +void initialize_heap(struct efi_emulator_param *param);
> +void load_kernel_pe(char *kern_buf, unsigned long sz, efi_system_table_t=
 *systabs);
> +void load_kernel_from_mem(efi_system_table_t *systabs);
> +void emulator_main(struct efi_emulator_param *param);
> +void emulator_entry(struct efi_emulator_param *param);
> +
> diff --git a/drivers/firmware/efi/efi_emulator/entry.c b/drivers/firmware=
/efi/efi_emulator/entry.c
> new file mode 100644
> index 0000000000000..c851a9acafa77
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/entry.c
> @@ -0,0 +1,57 @@
> +//SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/efi_emulator.h>
> +#include <asm/barrier.h>
> +#include <asm/sysreg.h>
> +#include <asm/elf.h>
> +#include <uapi/linux/elf.h>
> +
> +#include "emulator.h"
> +#include "earlycon.h"
> +
> +extern void enable_sctlr_el1(unsigned long scratch_reg);
> +static void arch_handle_mmu(struct efi_emulator_param *param)
> +{
> +       if (!param->mmu_on && param->pgd_root) {
> +       }
> +}
> +
> +extern const Elf64_Rela _rela_start[], _rela_end[];
> +
> +static void noinline arch_reloc_fixup(long delta)
> +{
> +       unsigned long *apply_addr, res;
> +       Elf64_Rela *rela;
> +
> +       /* fix rela */
> +       for (rela =3D (Elf64_Rela *)_rela_start; rela < _rela_end; rela++=
) {
> +               //todo counterpart of R_AARCH64_RELATIVE on riscv
> +               if (ELF64_R_TYPE(rela->r_info) !=3D R_AARCH64_RELATIVE)
> +                       continue;
> +               apply_addr =3D (unsigned long *)(rela->r_offset + delta);
> +               res =3D rela->r_addend + delta;
> +               *apply_addr =3D res;
> +       }
> +       // todo flush cache
> +
> +}
> +
> +/*
> + * Ensure this entry and @param is in the mapping before jump to it.
> + * It should be PIC and at the beginning of emulator.
> + * It should be memory aligned
> + */
> +void emulator_main(struct efi_emulator_param *param)
> +{
> +       long delta =3D param->load_address - EMULATOR_BASE_ADDR;
> +
> +       arch_handle_mmu(param);
> +       arch_reloc_fixup(delta);
> +       setup_earlycon(param);
> +       printf("param:0x%lx, delta=3D0x%lx\n", (unsigned long)param, delt=
a);
> +       printf("kernel_img_start:0x%lx, sz:0x%lx\n", (unsigned long)param=
->kernel_img_start, (unsigned long)param->kernel_img_sz);
> +       initialize_emulator_service(param);
> +       initialize_heap(param);
> +       load_kernel_pe((char *)param->kernel_img_start, param->kernel_img=
_sz,
> +               &systabs);
> +}
> diff --git a/drivers/firmware/efi/efi_emulator/head.S b/drivers/firmware/=
efi/efi_emulator/head.S
> new file mode 100644
> index 0000000000000..8efa10f483a7c
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/head.S
> @@ -0,0 +1,10 @@
> +
> +.section        ".head.text","ax"
> +
> +/* x0 holds the physical address of emulator_param */
> +emulator_entry:
> +       ldr     x1, [x0]
> +       mov     sp, x1
> +       adrp    x2, emulator_main
> +       add     x2, x2, #:lo12:emulator_main
> +       br      x2
> diff --git a/drivers/firmware/efi/efi_emulator/initrd.c b/drivers/firmwar=
e/efi/efi_emulator/initrd.c
> new file mode 100644
> index 0000000000000..771b6f8954e33
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/initrd.c
> @@ -0,0 +1,15 @@
> +// this file is a place holder to implment EFI_LOAD_FILE2_PROTOCOL.LoadF=
ile(), not linked in yet
> +
> +static efi_status_t load_file(efi_load_file2_protocol_t *this,
> +               efi_device_path_protocol_t *dp, bool boot_policy,
> +               unsigned long buffer_sz, void *buffer)
> +{
> +
> +       struct efi_vendor_dev_path p =3D dp;
> +
> +       if (!efiguid_cmp(p->vendorguid , LINUX_EFI_INITRD_MEDIA_GUID))
> +               if (uki_info.initrd_sz) {
> +                       memcpy(buffer, uki_info.initrd_base, uki_info.ini=
trd_sz);
> +                       return;
> +               }
> +}
> diff --git a/drivers/firmware/efi/efi_emulator/lib.c b/drivers/firmware/e=
fi/efi_emulator/lib.c
> new file mode 100644
> index 0000000000000..f12aa40405650
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/lib.c
> @@ -0,0 +1,73 @@
> +//SPDX-License-Identifier: GPL-2.0
> +#include "emulator.h"
> +
> +void *memcpy(void *dest, const void *src, size_t count)
> +{
> +       char *tmp =3D dest;
> +       const char *s =3D src;
> +
> +       while (count--)
> +               *tmp++ =3D *s++;
> +       return dest;
> +}
> +
> +void *memset(void *s, int c, size_t count)
> +{
> +       char *xs =3D s;
> +
> +       while (count--)
> +               *xs++ =3D c;
> +       return s;
> +}
> +
> +int memcmp(const void *cs, const void *ct, size_t count)
> +{
> +       const unsigned char *su1, *su2;
> +       int res =3D 0;
> +
> +       for (su1 =3D cs, su2 =3D ct; 0 < count; ++su1, ++su2, count--)
> +               if ((res =3D *su1 - *su2) !=3D 0)
> +                       break;
> +       return res;
> +}
> +
> +size_t strlen(const char *s)
> +{
> +       const char *sc;
> +
> +       for (sc =3D s; *sc !=3D '\0'; ++sc)
> +               /* nothing */;
> +       return sc - s;
> +}
> +
> +int strcmp(const char *cs, const char *ct)
> +{
> +       unsigned char c1, c2;
> +
> +       while (1) {
> +               c1 =3D *cs++;
> +               c2 =3D *ct++;
> +               if (c1 !=3D c2)
> +                       return c1 < c2 ? -1 : 1;
> +               if (!c1)
> +                       break;
> +       }
> +       return 0;
> +}
> +
> +int wcscmp(const wchar_t *s1, const wchar_t *s2)
> +{
> +    while (*s1 && (*s1 =3D=3D *s2)) {
> +        s1++;
> +        s2++;
> +    }
> +    return (int)(*s1 - *s2);
> +}
> +
> +size_t wcslen(const wchar_t *str)
> +{
> +    const wchar_t *s;
> +
> +    for (s =3D str; *s; ++s);
> +    return (s - str);
> +}
> diff --git a/drivers/firmware/efi/efi_emulator/memory.c b/drivers/firmwar=
e/efi/efi_emulator/memory.c
> new file mode 100644
> index 0000000000000..518ab7f30020e
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/memory.c
> @@ -0,0 +1,27 @@
> +//SPDX-License-Identifier: GPL-2.0
> +#include "emulator.h"
> +
> +char *heap_start, *heap_end, *heap_cur;
> +
> +void initialize_heap(struct efi_emulator_param *param)
> +{
> +       heap_start =3D (char *)param->mempool_start;
> +       heap_end =3D heap_start + param->mempool_sz;
> +       heap_cur =3D heap_start;
> +}
> +
> +//2do, the memory management is more complicated since we need to distin=
guish EFI_BOOT_SERVICE, RUNTIME, LOADER memory descr
> +
> +void *aligned_alloc(size_t alignment, size_t size)
> +{
> +       char *p;
> +
> +       p =3D (char *)ALIGN((unsigned long)heap_cur, alignment);
> +       heap_cur =3D p + size;
> +
> +       //todo, update the efi_memory_desc to include this page, if it cr=
osses the PAGE boundary
> +       //as EFI_BOOT_SERVICE,
> +       return p;
> +}
> +
> +
> diff --git a/drivers/firmware/efi/efi_emulator/memory_api.c b/drivers/fir=
mware/efi/efi_emulator/memory_api.c
> new file mode 100644
> index 0000000000000..709bbddaa4679
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/memory_api.c
> @@ -0,0 +1,73 @@
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +
> +#include "emulator.h"
> +
> +/*
> + * mem_type affects the allocated chunk in efi_memory_desc_t's type. Lat=
er,
> + * kernel can know whether to reclaim them.
> + */
> +efi_status_t __emulator_allocate_pages(int alloc_type, int mem_type,
> +                       unsigned long nr_pages, efi_physical_addr_t *addr=
)
> +{
> +       efi_physical_addr_t res;
> +       efi_status_t status;
> +
> +       if (alloc_type =3D=3D EFI_ALLOCATE_ANY_PAGES) {
> +               res =3D (efi_physical_addr_t)aligned_alloc(PAGE_SIZE, nr_=
pages << PAGE_SHIFT);
> +               *addr =3D res;
> +               status =3D EFI_SUCCESS;
> +       } else if (alloc_type =3D=3D EFI_ALLOCATE_MAX_ADDRESS) {
> +               //tmp
> +               res =3D (efi_physical_addr_t)aligned_alloc(PAGE_SIZE, nr_=
pages << PAGE_SHIFT);
> +               *addr =3D res;
> +               status =3D EFI_SUCCESS;
> +       /* e.g. aarch64 kimage loaded alignment */
> +       } else if (alloc_type =3D=3D EFI_ALLOCATE_ADDRESS) {
> +               //tmp, just aligned on 2MB as aarch64 boot protocol
> +               res =3D (efi_physical_addr_t)aligned_alloc(1<<21, nr_page=
s << PAGE_SHIFT);
> +               *addr =3D res;
> +               status =3D EFI_SUCCESS;
> +       }
> +
> +       return status;
> +}
> +
> +//todo
> +efi_status_t __emulator_allocate_pool(int mem_type, unsigned long sz,
> +                                      void **pool)
> +{
> +       void *res;
> +
> +       res =3D aligned_alloc(sizeof(unsigned long), sz);
> +       *pool =3D res;
> +       return EFI_SUCCESS;
> +}
> +
> +/* @memmap: only holds efi_memory_desc */
> +efi_status_t emulator_get_memory_map(unsigned long *map_sz,
> +       void *memmap, unsigned long *map_key, unsigned long *desc_sz,
> +       unsigned int *desc_version)
> +{
> +       //todo rt_info.memmap will be accessed by kernel, so it should be=
 marked as reserved
> +       struct efi_boot_memmap *p =3D &emulator_param->rt_info.memmap;
> +       //efi_memory_desc_t *desc =3D p->map;
> +
> +       if (!map_sz || !desc_sz)
> +               return EFI_INVALID_PARAMETER;
> +       if (*map_sz < p->map_size || !memmap) {
> +               *map_sz =3D p->map_size;
> +               *desc_sz =3D p->desc_size;
> +               return EFI_BUFFER_TOO_SMALL;
> +       }
> +
> +       /* desc range size*/
> +       *map_sz =3D p->map_size;
> +       memcpy(memmap, p->map, p->map_size);
> +       if (!!desc_sz)
> +               *desc_sz =3D p->desc_size;
> +       if (!!desc_version)
> +               *desc_version =3D p->desc_ver;
> +
> +       return EFI_SUCCESS;
> +}
> diff --git a/drivers/firmware/efi/efi_emulator/misc.c b/drivers/firmware/=
efi/efi_emulator/misc.c
> new file mode 100644
> index 0000000000000..5a82adb6b193c
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/misc.c
> @@ -0,0 +1,76 @@
> +
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +
> +#include "emulator.h"
> +
> +static efi_status_t __efiapi emulator_tcg2_hash_log_extend_event(
> +               efi_tcg2_protocol_t *this, u64 flags,
> +               efi_physical_addr_t data_to_hash, u64 data_to_hash_len,
> +               const efi_tcg2_event_t *efi_td_event)
> +{
> +
> +       return EFI_SUCCESS;
> +
> +}
> +
> +efi_tcg2_protocol_t emulator_tcg2 =3D {
> +       .hash_log_extend_event =3D emulator_tcg2_hash_log_extend_event,
> +};
> +
> +static efi_status_t __efiapi emulator_cc_map_pcr_to_mr_index(efi_cc_prot=
ocol_t *this,
> +               u32 pcr_index, efi_cc_mr_index_t *mr_index)
> +{
> +       return EFI_SUCCESS;
> +}
> +
> +static efi_status_t __efiapi emulator_cc_hash_log_extend_event(
> +               efi_cc_protocol_t *this, u64 flags,
> +               efi_physical_addr_t data_to_hash, u64 data_to_hash_len,
> +               const efi_cc_event_t *efi_td_event)
> +{
> +
> +       return EFI_SUCCESS;
> +}
> +
> +efi_cc_protocol_t emulator_cc =3D {
> +       .hash_log_extend_event =3D emulator_cc_hash_log_extend_event,
> +       .map_pcr_to_mr_index =3D emulator_cc_map_pcr_to_mr_index,
> +};
> +
> +static efi_status_t __efiapi emulator_get_rng(efi_rng_protocol_t * this,
> +                                                efi_guid_t *uuid, unsign=
ed long size,
> +                                                u8 *out)
> +{
> +       //in fact, disable aslr
> +       *out =3D 0;
> +       return EFI_SUCCESS;
> +}
> +
> +efi_rng_protocol_t emulator_rng =3D {
> +       .get_rng =3D emulator_get_rng,
> +};
> +
> +static efi_status_t __efiapi emulator_get_memory_attributes(
> +       efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64 =
*)
> +{
> +       return EFI_SUCCESS;
> +}
> +
> +static efi_status_t __efiapi emulator_set_memory_attributes(
> +       efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64)
> +{
> +       return EFI_SUCCESS;
> +}
> +
> +static efi_status_t __efiapi emulator_clear_memory_attributes(
> +       efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64)
> +{
> +       return EFI_SUCCESS;
> +}
> +
> +efi_memory_attribute_protocol_t emulator_memory_attribute =3D {
> +       .get_memory_attributes =3D emulator_get_memory_attributes,
> +       .set_memory_attributes =3D emulator_set_memory_attributes,
> +       .clear_memory_attributes =3D emulator_clear_memory_attributes,
> +};
> diff --git a/drivers/firmware/efi/efi_emulator/pe_loader.c b/drivers/firm=
ware/efi/efi_emulator/pe_loader.c
> new file mode 100644
> index 0000000000000..ff921d611a287
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/pe_loader.c
> @@ -0,0 +1,124 @@
> +
> +#include <linux/pe.h>
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +#include "emulator.h"
> +
> +#define VALID_PAYLOAD (IMAGE_SCN_CNT_CODE |IMAGE_SCN_CNT_INITIALIZED_DAT=
A |IMAGE_SCN_CNT_UNINITIALIZED_DATA)
> +
> +typedef efi_status_t (*uefi_pe_entry)(efi_handle_t handle, efi_system_ta=
ble_t *systab);
> +
> +struct pe_instance {
> +       uefi_pe_entry entry;
> +       efi_handle_t handle;
> +};
> +
> +#if 0
> +static struct uki_info uki_info;
> +#endif
> +
> +static int load_pe(char *buf, unsigned long buf_sz, unsigned long pe_hdr=
_offset,
> +                       struct pe_instance *inst, efi_system_table_t *sys=
tab)
> +{
> +       unsigned long exec_sz, load_addr, delta;
> +       struct pe_hdr *pe_hdr;
> +       struct pe32plus_opt_hdr *opt_hdr;
> +       struct section_header *sect_hdr;
> +       int section_nr, i;
> +       char *src, *dst;
> +
> +       pe_hdr =3D (struct pe_hdr *)buf;
> +       section_nr =3D pe_hdr->sections;
> +       opt_hdr =3D (struct pe32plus_opt_hdr *)(buf + sizeof(struct pe_hd=
r));
> +       sect_hdr =3D (struct section_header *)((char *)opt_hdr + pe_hdr->=
opt_hdr_size);
> +       exec_sz =3D opt_hdr->image_size - opt_hdr->header_size;
> +
> +       /*
> +        * The allocated memory should meet the section aligment requirem=
ent.
> +        * The first section is loaded at load_addr.
> +        */
> +       load_addr =3D (unsigned long)aligned_alloc(opt_hdr->section_align=
, exec_sz);
> +
> +       delta =3D load_addr - sect_hdr->virtual_address;
> +       /*copy section to segment */
> +       //opt_hdr->section_align;
> +       for (i =3D 0; i < section_nr; i++) {
> +               if (!(sect_hdr->flags & VALID_PAYLOAD)) {
> +                       sect_hdr++;
> +                       continue;
> +               }
> +               /* data_addr is relative to the whole file */
> +               src =3D buf + sect_hdr->data_addr - pe_hdr_offset;
> +               dst =3D (char *)(sect_hdr->virtual_address + delta);
> +               memcpy(dst, src, sect_hdr->raw_data_size);
> +               memset(dst + sect_hdr->raw_data_size, 0, sect_hdr->virtua=
l_size - sect_hdr->raw_data_size);
> +#if 0
> +               //2do, for UKI
> +               if (strcmp(sect_hdr->name, ".initrd")) {
> +                       uki_info.initrd_base =3D dst;
> +                       uki_info.initrd_sz =3D sect_hdr->raw_data_size;
> +               }
> +               if (strcmp(sect_hdr->name, ".cmdline")) {
> +                       uki_info.cmdline_base =3D dst;
> +                       uki_info.cmdline_sz =3D sect_hdr->raw_data_size;
> +               }
> +#endif

For UKI, I have a wrong understanding, all code related with uki_info
struct should be eliminated.
And see the next comment for detail.

> +               sect_hdr++;
> +       }
> +
> +       /* no need to resolve relocation */
> +
> +       /* As for SP, using the current value */
> +
> +       inst->entry =3D (uefi_pe_entry)(opt_hdr->entry_point + delta);
> +       inst->handle =3D (efi_handle_t)load_addr;
> +
> +       printf("entry_point:0x%lx, delta:0x%lx, final inst's entry at:0x%=
lx\n",
> +               opt_hdr->entry_point, delta, inst->entry);
> +       return 0;
> +}
> +
> +static int launch_pe(char *pe_buf, u64 buf_sz, unsigned long pe_hdr_offs=
et, efi_system_table_t *systab)
> +{
> +       struct pe_instance inst;
> +
> +       load_pe(pe_buf, buf_sz, pe_hdr_offset, &inst, systab);
> +       inst.entry(inst.handle, systab);
> +       return 0;
> +}
> +
> +struct input_param_passed_by {
> +       u64 kernel_pa_start;
> +       u64 kernel_sz;
> +       u64 pgtable;
> +       u64 memory_descs;
> +};
> +
> +
> +/* see drivers/firmware/efi/libstub/zboot-header.S */
> +struct linux_pe_zboot_header {
> +       uint32_t mz_magic;
> +       uint32_t image_type;
> +       uint32_t payload_offset;
> +       uint32_t payload_size;
> +       uint32_t reserved[2];
> +       uint32_t compress_type;
> +};
> +
> +void load_kernel_pe(char *kern_buf, unsigned long sz, efi_system_table_t=
 *systabs)
> +{
> +       struct linux_pe_zboot_header *hdr;
> +       u32 pe_hdr_offset;
> +       char *buf =3D kern_buf;
> +
> +       hdr =3D (struct linux_pe_zboot_header *)buf;
> +       /* Check mz signature */
> +       if (memcmp(&hdr->image_type, "zimg", sizeof(hdr->image_type)))
> +               return;
> +       pe_hdr_offset =3D *((u32 *)(buf + 0x3c));
> +       /* */
> +       buf +=3D pe_hdr_offset;
> +       sz -=3D pe_hdr_offset;
> +       launch_pe(buf, sz, pe_hdr_offset, systabs);
> +}
> +
> diff --git a/drivers/firmware/efi/efi_emulator/printf.c b/drivers/firmwar=
e/efi/efi_emulator/printf.c
> new file mode 100644
> index 0000000000000..367d1ede98422
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/printf.c
> @@ -0,0 +1,389 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* The most of this file is copied from arch/x86/boot/printf.c */
> +
> +#include <linux/ctype.h>
> +#include <linux/efi.h>
> +
> +#include "earlycon.h"
> +#include "emulator.h"
> +
> +static int skip_atoi(const char **s)
> +{
> +       int i =3D 0;
> +
> +       while (isdigit(**s))
> +               i =3D i * 10 + *((*s)++) - '0';
> +       return i;
> +}
> +
> +#define ZEROPAD        1               /* pad with zero */
> +#define SIGN   2               /* unsigned/signed long */
> +#define PLUS   4               /* show plus */
> +#define SPACE  8               /* space if plus */
> +#define LEFT   16              /* left justified */
> +#define SMALL  32              /* Must be 32 =3D=3D 0x20 */
> +#define SPECIAL        64              /* 0x */
> +
> +#define __do_div(n, base) ({ \
> +int __res; \
> +__res =3D ((unsigned long) n) % (unsigned) base; \
> +n =3D ((unsigned long) n) / (unsigned) base; \
> +__res; })
> +
> +static char *number(char *str, long num, int base, int size, int precisi=
on,
> +                   int type)
> +{
> +       /* we are called with base 8, 10 or 16, only, thus don't need "G.=
.."  */
> +       static const char digits[16] =3D "0123456789ABCDEF"; /* "GHIJKLMN=
OPQRSTUVWXYZ"; */
> +
> +       char tmp[66];
> +       char c, sign, locase;
> +       int i;
> +
> +       /* locase =3D 0 or 0x20. ORing digits or letters with 'locase'
> +        * produces same digits or (maybe lowercased) letters */
> +       locase =3D (type & SMALL);
> +       if (type & LEFT)
> +               type &=3D ~ZEROPAD;
> +       if (base < 2 || base > 16)
> +               return NULL;
> +       c =3D (type & ZEROPAD) ? '0' : ' ';
> +       sign =3D 0;
> +       if (type & SIGN) {
> +               if (num < 0) {
> +                       sign =3D '-';
> +                       num =3D -num;
> +                       size--;
> +               } else if (type & PLUS) {
> +                       sign =3D '+';
> +                       size--;
> +               } else if (type & SPACE) {
> +                       sign =3D ' ';
> +                       size--;
> +               }
> +       }
> +       if (type & SPECIAL) {
> +               if (base =3D=3D 16)
> +                       size -=3D 2;
> +               else if (base =3D=3D 8)
> +                       size--;
> +       }
> +       i =3D 0;
> +       if (num =3D=3D 0)
> +               tmp[i++] =3D '0';
> +       else
> +               while (num !=3D 0)
> +                       tmp[i++] =3D (digits[__do_div(num, base)] | locas=
e);
> +       if (i > precision)
> +               precision =3D i;
> +       size -=3D precision;
> +       if (!(type & (ZEROPAD + LEFT)))
> +               while (size-- > 0)
> +                       *str++ =3D ' ';
> +       if (sign)
> +               *str++ =3D sign;
> +       if (type & SPECIAL) {
> +               if (base =3D=3D 8)
> +                       *str++ =3D '0';
> +               else if (base =3D=3D 16) {
> +                       *str++ =3D '0';
> +                       *str++ =3D ('X' | locase);
> +               }
> +       }
> +       if (!(type & LEFT))
> +               while (size-- > 0)
> +                       *str++ =3D c;
> +       while (i < precision--)
> +               *str++ =3D '0';
> +       while (i-- > 0)
> +               *str++ =3D tmp[i];
> +       while (size-- > 0)
> +               *str++ =3D ' ';
> +       return str;
> +}
> +
> +size_t strnlen(const char *s, size_t count)
> +{
> +       const char *sc;
> +
> +       for (sc =3D s; count-- && *sc !=3D '\0'; ++sc)
> +               /* nothing */;
> +       return sc - s;
> +}
> +
> +int vsprintf(char *buf, const char *fmt, va_list args)
> +{
> +       int len;
> +       unsigned long num;
> +       int i, base;
> +       char *str;
> +       const char *s;
> +
> +       int flags;              /* flags to number() */
> +
> +       int field_width;        /* width of output field */
> +       int precision;          /* min. # of digits for integers; max
> +                                  number of chars for from string */
> +       int qualifier;          /* 'h', 'l', or 'L' for integer fields */
> +
> +       for (str =3D buf; *fmt; ++fmt) {
> +               if (*fmt !=3D '%') {
> +                       *str++ =3D *fmt;
> +                       continue;
> +               }
> +
> +               /* process flags */
> +               flags =3D 0;
> +             repeat:
> +               ++fmt;          /* this also skips first '%' */
> +               switch (*fmt) {
> +               case '-':
> +                       flags |=3D LEFT;
> +                       goto repeat;
> +               case '+':
> +                       flags |=3D PLUS;
> +                       goto repeat;
> +               case ' ':
> +                       flags |=3D SPACE;
> +                       goto repeat;
> +               case '#':
> +                       flags |=3D SPECIAL;
> +                       goto repeat;
> +               case '0':
> +                       flags |=3D ZEROPAD;
> +                       goto repeat;
> +               }
> +
> +               /* get field width */
> +               field_width =3D -1;
> +               if (isdigit(*fmt))
> +                       field_width =3D skip_atoi(&fmt);
> +               else if (*fmt =3D=3D '*') {
> +                       ++fmt;
> +                       /* it's the next argument */
> +                       field_width =3D va_arg(args, int);
> +                       if (field_width < 0) {
> +                               field_width =3D -field_width;
> +                               flags |=3D LEFT;
> +                       }
> +               }
> +
> +               /* get the precision */
> +               precision =3D -1;
> +               if (*fmt =3D=3D '.') {
> +                       ++fmt;
> +                       if (isdigit(*fmt))
> +                               precision =3D skip_atoi(&fmt);
> +                       else if (*fmt =3D=3D '*') {
> +                               ++fmt;
> +                               /* it's the next argument */
> +                               precision =3D va_arg(args, int);
> +                       }
> +                       if (precision < 0)
> +                               precision =3D 0;
> +               }
> +
> +               /* get the conversion qualifier */
> +               qualifier =3D -1;
> +               if (*fmt =3D=3D 'h' || *fmt =3D=3D 'l' || *fmt =3D=3D 'L'=
) {
> +                       qualifier =3D *fmt;
> +                       ++fmt;
> +               }
> +
> +               /* default base */
> +               base =3D 10;
> +
> +               switch (*fmt) {
> +               case 'c':
> +                       if (!(flags & LEFT))
> +                               while (--field_width > 0)
> +                                       *str++ =3D ' ';
> +                       *str++ =3D (unsigned char)va_arg(args, int);
> +                       while (--field_width > 0)
> +                               *str++ =3D ' ';
> +                       continue;
> +
> +               case 's':
> +                       s =3D va_arg(args, char *);
> +                       len =3D strnlen(s, precision);
> +
> +                       if (!(flags & LEFT))
> +                               while (len < field_width--)
> +                                       *str++ =3D ' ';
> +                       for (i =3D 0; i < len; ++i)
> +                               *str++ =3D *s++;
> +                       while (len < field_width--)
> +                               *str++ =3D ' ';
> +                       continue;
> +
> +               case 'p':
> +                       if (field_width =3D=3D -1) {
> +                               field_width =3D 2 * sizeof(void *);
> +                               flags |=3D ZEROPAD;
> +                       }
> +                       str =3D number(str,
> +                                    (unsigned long)va_arg(args, void *),=
 16,
> +                                    field_width, precision, flags);
> +                       continue;
> +
> +               case 'n':
> +                       if (qualifier =3D=3D 'l') {
> +                               long *ip =3D va_arg(args, long *);
> +                               *ip =3D (str - buf);
> +                       } else {
> +                               int *ip =3D va_arg(args, int *);
> +                               *ip =3D (str - buf);
> +                       }
> +                       continue;
> +
> +               case '%':
> +                       *str++ =3D '%';
> +                       continue;
> +
> +                       /* integer number formats - set up the flags and =
"break" */
> +               case 'o':
> +                       base =3D 8;
> +                       break;
> +
> +               case 'x':
> +                       flags |=3D SMALL;
> +                       fallthrough;
> +               case 'X':
> +                       base =3D 16;
> +                       break;
> +
> +               case 'd':
> +               case 'i':
> +                       flags |=3D SIGN;
> +               case 'u':
> +                       break;
> +
> +               default:
> +                       *str++ =3D '%';
> +                       if (*fmt)
> +                               *str++ =3D *fmt;
> +                       else
> +                               --fmt;
> +                       continue;
> +               }
> +               if (qualifier =3D=3D 'l')
> +                       num =3D va_arg(args, unsigned long);
> +               else if (qualifier =3D=3D 'h') {
> +                       num =3D (unsigned short)va_arg(args, int);
> +                       if (flags & SIGN)
> +                               num =3D (short)num;
> +               } else if (flags & SIGN)
> +                       num =3D va_arg(args, int);
> +               else
> +                       num =3D va_arg(args, unsigned int);
> +               str =3D number(str, num, base, field_width, precision, fl=
ags);
> +       }
> +       *str =3D '\0';
> +       return str - buf;
> +}
> +
> +int sprintf(char *buf, const char *fmt, ...)
> +{
> +       va_list args;
> +       int i;
> +
> +       va_start(args, fmt);
> +       i =3D vsprintf(buf, fmt, args);
> +       va_end(args);
> +       return i;
> +}
> +
> +static struct earlycon *con;
> +
> +static int puts(const char *s)
> +{
> +       if (con)
> +               return con->put_str(s, con->data);
> +       else
> +               return 0;
> +}
> +
> +int printf(const char *fmt, ...)
> +{
> +       char printf_buf[1024];
> +       va_list args;
> +       int printed;
> +
> +       va_start(args, fmt);
> +       printed =3D vsprintf(printf_buf, fmt, args);
> +       va_end(args);
> +
> +       puts(printf_buf);
> +
> +       return printed;
> +}
> +
> +
> +static size_t utf16_to_ascii(char *s, efi_char16_t c16)
> +{
> +       unsigned char lead;
> +       size_t len;
> +
> +       if (c16 < 0x80) {
> +               /* 1-byte sequence */
> +               if (s) *s =3D c16;
> +               len =3D 1;
> +       } else if (c16 < 0x800) {
> +               /* 2-byte sequence */
> +               lead =3D 0xC0;
> +               len =3D 2;
> +       } else {
> +               /* 3-byte sequence */
> +               lead =3D 0xE0;
> +               len =3D 3;
> +       }
> +
> +       if (s) {
> +               switch (len) {
> +                               case 3:
> +                                       s[2] =3D 0x80 | (c16 & 0x3F);
> +                                       c16 >>=3D 6;
> +                                       fallthrough;
> +                               case 2:
> +                                       s[1] =3D 0x80 | (c16 & 0x3F);
> +                                       c16 >>=3D 6;
> +                                       fallthrough;
> +                               case 1:
> +                                       s[0] =3D lead | c16;
> +               }
> +       }
> +       return len;
> +}
> +
> +/* Convert the UCS-2 string to a UTF-8 string */
> +void print_ucs2_string(efi_char16_t* ucs2_str)
> +{
> +       char utf8_str[1024];
> +       char* p =3D utf8_str;
> +
> +       while (*ucs2_str)
> +           p +=3D utf16_to_ascii(p, *ucs2_str++);
> +
> +       /* Null-terminate the UTF-8 string */
> +       *p =3D '\0';
> +       /* Print the UTF-8 string */
> +       printf("%s\n", utf8_str);
> +}
> +
> +static struct earlycon *all_con_types[] =3D { &pl011, };
> +
> +void setup_earlycon(struct efi_emulator_param *param)
> +{
> +       struct earlycon *p;
> +       int i;
> +
> +       for (i =3D 0; i < sizeof(all_con_types) / sizeof(struct earlycon =
*); i++) {
> +
> +               p =3D all_con_types[i];
> +               if (p->match(param, p->name)) {
> +                       con =3D p;
> +                       p->reset(p->data);
> +                       break;
> +               }
> +       }
> +}
> diff --git a/drivers/firmware/efi/efi_emulator/runtime_service.c b/driver=
s/firmware/efi/efi_emulator/runtime_service.c
> new file mode 100644
> index 0000000000000..87e49a8d4e2db
> --- /dev/null
> +++ b/drivers/firmware/efi/efi_emulator/runtime_service.c
> @@ -0,0 +1,28 @@
> +//SPDX-License-Identifier: GPL-2.0
> +
> +#include "emulator.h"
> +
> +static efi_status_t emulator_get_variable(efi_char16_t *name, efi_guid_t=
 *vendor,
> +               u32 *attr, unsigned long *data_size, void *data)
> +{
> +       if (!efi_guidcmp(*vendor, EFI_GLOBAL_VARIABLE_GUID)) {
> +               if (wcscmp(name, L"SecureBoot"))
> +                       return EFI_NOT_FOUND;
> +       }
> +       return EFI_NOT_FOUND;
> +}
> +
> +static efi_status_t emulator_set_virtual_address_map(unsigned long memor=
y_map_size,
> +                                               unsigned long descriptor_=
size,
> +                                               u32 descriptor_version,
> +                                               efi_memory_desc_t *virtua=
l_map)
> +{
> +       /* The first kernel has called this one-shot service */
> +       return EFI_NOT_FOUND;
> +}
> +
> +efi_runtime_services_t rt_services =3D {
> +       .set_virtual_address_map =3D emulator_set_virtual_address_map,
> +       .get_variable =3D emulator_get_variable,
> +
> +};
> diff --git a/include/linux/efi_emulator.h b/include/linux/efi_emulator.h
> new file mode 100644
> index 0000000000000..cb977539cf05f
> --- /dev/null
> +++ b/include/linux/efi_emulator.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_EFI_EMULATOR_H
> +#define _LINUX_EFI_EMULATOR_H
> +
> +#include <linux/types.h>
> +#include <linux/nls.h>
> +#include <linux/efi.h>
> +
> +//todo, arch abstraction, for x86, it is efi_info
> +struct efi_rt_info {
> +       const efi_runtime_services_t    *runtime;       /* EFI runtime se=
rvices table */
> +       unsigned int runtime_version;   /* Runtime services version */
> +       u32 runtime_supported_mask;
> +       /* Build systab tables from the following */
> +       unsigned int systab_nr_tables;
> +       efi_config_table_t systab_tables[20];
> +       struct efi_boot_memmap  memmap;
> +};
> +
> +/* 1st kernel passes information through this struct */
> +struct efi_emulator_param {
> +       unsigned long sp;
> +       /* Should be page-aligned */
> +       unsigned long load_address;
> +       unsigned int sz_in_byte;
> +       wchar_t cmdline[512];
> +       bool noefi_boot;
> +       bool print_enabled;
> +       char earlycon_name[16];
> +       phys_addr_t earlycon_reg_base;
> +       unsigned long earlycon_reg_sz;
> +
> +       bool mmu_on;
> +       /* root of pgtable */
> +       phys_addr_t pgd_root;
> +       phys_addr_t kernel_img_start;
> +       unsigned long kernel_img_sz;
> +       phys_addr_t dtb;
> +       phys_addr_t mempool_start;
> +       unsigned long mempool_sz;
> +       struct efi_rt_info rt_info;
> +};
> +
> +extern unsigned char _efi_emulator_start[], _efi_emulator_end[];
> +#endif
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3c..cff6b6869498b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -325,6 +325,7 @@ struct kimage {
>         unsigned int hotplug_support:1;
>  #endif
>
> +       bool is_pe;
>  #ifdef ARCH_HAS_KIMAGE_ARCH
>         struct kimage_arch arch;
>  #endif
> @@ -462,6 +463,7 @@ static inline int arch_kexec_post_alloc_pages(void *v=
addr, unsigned int pages, g
>  static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int p=
ages) { }
>  #endif
>
> +extern phys_addr_t arch_emulator_prepare_pgtable(struct kimage *kimage);
>  extern bool kexec_file_dbg_print;
>
>  #define kexec_dprintk(fmt, arg...) \
> --
> 2.41.0
>


