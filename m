Return-Path: <linux-efi+bounces-1467-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455D937817
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jul 2024 15:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38DC1F21D60
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jul 2024 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B4A8002A;
	Fri, 19 Jul 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2K+uzWJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B75811A
	for <linux-efi@vger.kernel.org>; Fri, 19 Jul 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721394156; cv=none; b=gH0iV3RvEG81kmIqiytROM8V0TCesVjPfJk9zdpD96rAnbcOUiZQmYNW0gzCXmtxYQCeq8LvUQlb+6gYt8KF3fDcsAfC0VgyS7RXvbNOPdgB3zhT6BWKwe4IO0rFRAS16gcEn5ah4V9hemPoY9ZmNtm2Ibe72m9zBmVOrWs1a+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721394156; c=relaxed/simple;
	bh=YMc9F5GJ1jmfZwtAQe118DzxGr4j9VE9IQa2AlxL1pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3+5ZuEkOY4UWrJsdF/nDjmgO92bGOOiKX2T03Tt52OzFqWr7E6KxgReGv1S2o+OCX8nG92elj785zpViyTXWaZ9ElJeEmdDxLe5rcW5ijTshO9m0aUcC9hg0p7f3/n/QEXae5n6AZKs+/3ztoSn9gZci5Dj+699XzPZEPoA9uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2K+uzWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721394153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07XmD72O//EoVvaLOugv78d6PdONeUTU9jEP0NkoIWo=;
	b=K2K+uzWJhxojuMJfOsxJKmXy6xWF5y2bH95Bl0fHSE93yFjZTccTaPDuioNZ0jF+b/dj5A
	wRMcPHC5i3Monxc1jlnv2hDgLrrSmdRyU0qVZsoTXcFuFd1Y0lEvxIRseE466rn0J2+1Nw
	hSWQd/ejFWY0KuTPpYX5EgnipzoIVNM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-v7k3QepVMJ27iexGN3liig-1; Fri, 19 Jul 2024 09:02:30 -0400
X-MC-Unique: v7k3QepVMJ27iexGN3liig-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79f04b04fa7so221948485a.0
        for <linux-efi@vger.kernel.org>; Fri, 19 Jul 2024 06:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721394150; x=1721998950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07XmD72O//EoVvaLOugv78d6PdONeUTU9jEP0NkoIWo=;
        b=rmXO56BRZtX+Y2RrjHJEh7v9QDQndXGvEGt1zEWdjHQMKNE/1teI6haN8wgKNx6Sj6
         oB8uz9WaXJTFnK/TYwew4RNKuFRwR8SrvatkLHClzEQjbZvB8iqV2w9dSs2yzmLQRe5K
         Pu1SCV2Li26UIekJsB5alDMPmc8j8CsbuR7W7vrCaEfeVSqcClB/Eu+TmmHC1coCyL/p
         TPr+GyM+HKp7x+dasxxel2VaSe2iPYfEUUIiaiDNQ/hxrOEc7hisNau01YEP0RFSbCCK
         Qgdvxf0CbNUVz8EO51h2oUdL5dY2c1U/m0aXkDZommOY7D0abhS9ytoEjcDGLwGkNe/6
         aGCw==
X-Forwarded-Encrypted: i=1; AJvYcCVRe7yymCkFp/rwj7XbwdYqAZr2LsPUMdvLDKxE0/wsxR3YdjvJXz1eS3GXzbOMQb0qUFHxPx/NbHB0MwspQ8f6qUoPPqeOV7lP
X-Gm-Message-State: AOJu0Yxh88cOZ0nN+5Ew6W6EZTF6oReBhHKTxzQ9zmga8KN98E4DibmW
	OFVBS61JB/KGWXZoSJA0DRRX5VCfIyA9jLuQLWyXHZ0w5y/6qWD4mohwrGRoxOgVML/aOcHecaR
	0ZJXj2tWN/pUg8N7tabZ2fx5YUb/lgA7oePP0RKkWkLeVYofs72SQgyvgvVbEU+olzwms5ssJ+q
	HPF77BoTHXJd1dgSwWTEX8exD2P0aHtqMc
X-Received: by 2002:ad4:5c6b:0:b0:6b4:fbf8:d652 with SMTP id 6a1803df08f44-6b7ac7b4154mr29449866d6.1.1721394149901;
        Fri, 19 Jul 2024 06:02:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnqBlBHYzfxUucMPSLYt9m/BlfVzImFcBb3pdO9rfvpPuTxOS+NffrbjlBM6S+HbkUzQ8C3rsRC0JfXCBJT8g=
X-Received: by 2002:ad4:5c6b:0:b0:6b4:fbf8:d652 with SMTP id
 6a1803df08f44-6b7ac7b4154mr29449246d6.1.1721394149542; Fri, 19 Jul 2024
 06:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718085759.13247-1-piliu@redhat.com>
In-Reply-To: <20240718085759.13247-1-piliu@redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 19 Jul 2024 21:02:18 +0800
Message-ID: <CAF+s44QKQtJ4bRiw0FE6to_L1yXU+7_U8GV3prMz8eLf1EjTng@mail.gmail.com>
Subject: Re: [RFC 0/7] UEFI emulator for kexec
To: linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen <jarkko@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:58=E2=80=AFPM Pingfan Liu <piliu@redhat.com> wrot=
e:
>
>
> *** Background ***
>
> As more PE format kernel images are introduced, it post challenge to kexe=
c to
> cope with the new format.
>
> In my attempt to add support for arm64 zboot image in the kernel [1],
> Ard suggested using an emulator to tackle this issue.  Last year, when
> Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
> emulator approach again [3]
>
> After discussion, Ard's approach seems to be a more promising solution
> to handle PE format kernels once and for all.  This series follows that
> approach and implements an emulator to emulate EFI boot time services,
> allowing the efistub kernel to self-extract and boot.
>
>
>
> *** Overview of implement ***
> The whole model consits of three parts:
>
> -1. The emulator
> It is a self-relocatable PIC code, which is finally linked into kernel, b=
ut not
> export any internal symbol to kernel.  It mainly contains: a PE file pars=
er,
> which loads PE format kernel, a group of functions to emulate efi boot se=
rvice.
>
> -2. inside kernel, PE-format loader
> Its main task is to set up two extra kexec_segment, one for emulator, the=
 other
> for passing information from the first kernel to emulator.
>
> -3. set up identity mapping only for the memory used by the emulator.
> Here it relies on kimage_alloc_control_pages() to get pages, which will n=
ot
> stamped during the process of kexec relocate (cp from src to dst). And si=
nce the
> mapping only covers a small range of memory, it cost small amount memory.
>
>
> *** To do ***
>
> Currently, it only works on arm64 _zboot_ image on arm64 virt machine. Fo=
r
> arm64 UKI, I have not completed it. But it should be easy to archieve by

Not familiar with UKI, after going through the
systemd/src/boot/efi/initrd.c, I guess systemd-stub plays as a EFI
application, it calls initrd_register() to install the initrd
information. After systemd-stub transmits the control to the efistub
linux kernel, the efistub will get the initrd.  So all should spin
around the EFI_LOAD_FILE2_PROTOCOL. Am I right?



Thanks,
Pingfan

> implementing EFI_LOAD_FILE2_PROTOCOL.LoadFile(). And with a slightly
> improvement, it would work on x86.
>
> Besides that, as POC, I skip four functions in efistub: setup_graphics(),
> efi_random_get_seed() and efi_enable_reset_attack_mitigation(),
> efi_retrieve_eventlog(). Hence skipping the corresponding boot services.
>
> Also, this series does not implement a memory allocator, which I plan to
> implement with the help of bitmap.
>
> About console, currently it hard code for arm64 virt machine, later it sh=
ould
> extract the information through ACPI table.
>
> [1]: https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.user=
s.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
> [2]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/
> [3]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/=
#mc60aa591cb7616ceb39e1c98f352383f9ba6e985
>
>
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
>
> Pingfan Liu (7):
>   efi/libstub: Ask efi_random_alloc() to skip unusable memory
>   debug/libstub: cheats to step around some boot service
>   efi/emulator: Initial rountines to emulate EFI boot time service
>   efi/emulator: Turn on mmu for arm64
>   arm64: mm: Change to prototype of
>   arm64: kexec: Prepare page table for emulator
>   kexec: Introduce kexec_pe_image to parse and load PE file
>
>  arch/arm64/include/asm/kexec.h                |   3 +
>  arch/arm64/include/asm/mmu.h                  |   6 +
>  arch/arm64/kernel/Makefile                    |   2 +-
>  arch/arm64/kernel/kexec_image.c               |   1 +
>  arch/arm64/kernel/kexec_pe_image.c            | 519 ++++++++++++++++++
>  arch/arm64/kernel/machine_kexec.c             |  90 ++-
>  arch/arm64/kernel/machine_kexec_file.c        |   1 +
>  arch/arm64/mm/mmu.c                           |  67 ++-
>  drivers/firmware/efi/Makefile                 |   1 +
>  drivers/firmware/efi/efi_emulator/Makefile    |  98 ++++
>  .../firmware/efi/efi_emulator/amba-pl011.c    |  80 +++
>  .../efi_emulator/arm64_emulator_service.lds   |  45 ++
>  .../firmware/efi/efi_emulator/arm64_proc.S    | 172 ++++++
>  .../firmware/efi/efi_emulator/config_table.c  |  23 +
>  drivers/firmware/efi/efi_emulator/core.c      | 211 +++++++
>  drivers/firmware/efi/efi_emulator/earlycon.h  |  19 +
>  .../firmware/efi/efi_emulator/efi_emulator.S  |  12 +
>  drivers/firmware/efi/efi_emulator/emulator.h  |  66 +++
>  drivers/firmware/efi/efi_emulator/entry.c     |  64 +++
>  drivers/firmware/efi/efi_emulator/head.S      |  10 +
>  drivers/firmware/efi/efi_emulator/initrd.c    |  15 +
>  drivers/firmware/efi/efi_emulator/lib.c       |  73 +++
>  drivers/firmware/efi/efi_emulator/memory.c    |  27 +
>  .../firmware/efi/efi_emulator/memory_api.c    |  73 +++
>  drivers/firmware/efi/efi_emulator/misc.c      |  76 +++
>  drivers/firmware/efi/efi_emulator/pe_loader.c | 124 +++++
>  drivers/firmware/efi/efi_emulator/printf.c    | 389 +++++++++++++
>  .../efi/efi_emulator/runtime_service.c        |  28 +
>  .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
>  drivers/firmware/efi/libstub/efi-stub.c       |   2 +
>  drivers/firmware/efi/libstub/random.c         |   2 +
>  drivers/firmware/efi/libstub/randomalloc.c    |   5 +
>  drivers/firmware/efi/libstub/tpm.c            |   4 +
>  include/linux/efi_emulator.h                  |  46 ++
>  include/linux/kexec.h                         |   5 +
>  35 files changed, 2327 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm64/kernel/kexec_pe_image.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/Makefile
>  create mode 100644 drivers/firmware/efi/efi_emulator/amba-pl011.c
>  create mode 100644 drivers/firmware/efi/efi_emulator/arm64_emulator_serv=
ice.lds
>  create mode 100644 drivers/firmware/efi/efi_emulator/arm64_proc.S
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
> --
> 2.41.0
>


