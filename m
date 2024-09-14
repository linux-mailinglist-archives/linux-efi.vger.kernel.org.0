Return-Path: <linux-efi+bounces-1780-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FFB978F1E
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 10:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8303F1C21A98
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A680139590;
	Sat, 14 Sep 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROjz95TM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477479CC;
	Sat, 14 Sep 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726302677; cv=none; b=ejEfK25FxT75krJQf9wqjux3dNN6duY1eQioB4Zs8ZL1CpO9d4mE8HdprVMdMs+J3Y8Y8q2Nc6Psk9I8L74So1pnk50N4n3VWiYgn+NadOkwmrgQGO4lTWcUMUtIyWr2WBzUpOZRE6YdjY5sjWUhGyorsRWXQEBOOjuYS0P1pB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726302677; c=relaxed/simple;
	bh=z6OpSHyEljBBz2GYwX2VAF5oOERrd1UKlQ8BaPdqpYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IC2XU3SEZCjlK+Z4ZvVVJrz+C0iIuS8s8Jpf73/+Z3c3kcmM1lm8fOWcIyHLZh5GE8VEgZSr4HJzaL/Q1u3ZuQ4ejI62o6cFEBahJtKcTY47My0vmTiTwbMMhzpXaJQHMGeCsDDyE7ThoQYMWdjy4bM+5bLR5nRds5CxqC5ERao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROjz95TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB5CC4CED5;
	Sat, 14 Sep 2024 08:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726302676;
	bh=z6OpSHyEljBBz2GYwX2VAF5oOERrd1UKlQ8BaPdqpYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ROjz95TM7LP+Hvu6LkrpLidU65BWo2NV9yF9CwVi/S38MphX6UqDxhFyOnLGFcO1m
	 ovlE9ezlY9sD+XIVjixw3LodeTCJvIyKvQByzhFpq1pj5g4jxJ7JtoZesgxKksYDk7
	 fia86LA7hLUGry2bl+bZkmqwVi5leDXi/TH4fmOxCHyeToDHYSBCGXHpJueyCOz5XG
	 ExJ6IRtD8DGLkwTOrNyYbZEwYhIvDHq1HbQzUynQxkY2/SHgdp8iqTD90bH/TQkGJx
	 x5V7UNiNd7N8/lb3fVjtvARrqrvhj/a3i93D4T/eEB+1ugvZtGUZQFqxLphiBA4J8x
	 zmPnTsc/QCG4w==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53653ff0251so2090700e87.0;
        Sat, 14 Sep 2024 01:31:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxH3HCbh0xIpq9pw2RKo52qaUyqo1AbSROlhRCGSWBEFWsalWXwvTRbKzmIn3V3gdHBiIfy/MqYv3paHr+@vger.kernel.org, AJvYcCVBwnjimY53XDRlHjb4TkKPNBrbMYujI0C2sJRTFJ5OOjNU8hAofWRve0dmFKm3kuZeaogLb75BHhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxxvufcaeBkUuzFazB9KDti26PAY9pwj5zLQ6NGHq/ZL/kr3Ka
	YG9uwXwXDWPQRpwMQ18asiETr5JRUZ/FKuwhBSPLnFXq6alpzlbKbx9ZFv7kC6SecyJVBupdrRo
	XBVMwFSdnZlNBWjbXjO5O43pZCE0=
X-Google-Smtp-Source: AGHT+IFej30mwd0JRuY/+RDqkCSNoFipebnwEVsOZMyMFIDB2nW1hoN7F/05QIm2Cx3HgmT7MU97zNOZYAFTrGH5Y4A=
X-Received: by 2002:a05:6512:a91:b0:535:3d08:5844 with SMTP id
 2adb3069b0e04-5367feb964fmr3403400e87.6.1726302674503; Sat, 14 Sep 2024
 01:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com> <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com>
In-Reply-To: <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 14 Sep 2024 10:31:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXH2YvWtzEJEEOnTLqACsRhan3Lf9OCLYDjKf6gxDmBQ@mail.gmail.com>
Message-ID: <CAMj1kXEXH2YvWtzEJEEOnTLqACsRhan3Lf9OCLYDjKf6gxDmBQ@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Dave Young <dyoung@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Sept 2024 at 08:46, Dave Young <dyoung@redhat.com> wrote:
>
> On Fri, 13 Sept 2024 at 18:56, Dave Young <dyoung@redhat.com> wrote:
> >
> > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > (cc Dave)
> >
> > Thanks for ccing me.
> >
> > >
> > > Full thread here:
> > > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> > >
> > > On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > > > Does the below help at all?
> > > > > >
> > > > > > --- a/drivers/firmware/efi/tpm.c
> > > > > > +++ b/drivers/firmware/efi/tpm.c
> > > > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > > > >         }
> > > > > >
> > > > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > > > >
> > > > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > > > >                 pr_info("TPM Final Events table not present\n");
> > > > >
> > > > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > > > which is e820_table_firmware.
> > > > >
> > > > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > > > its end, just with e820_table_firmware instead of e820_table.
> > > > > i.e. efi_mem_reserve does:
> > > > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > >         e820__update_table(e820_table);
> > > > >
> > > > > while arch_update_firmware_area does:
> > > > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > >         e820__update_table(e820_table_firmware);
> > > > >
> > > >
> > > > Shame.
> > > >
> > > > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > > > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > > > table, and 3 (!) versions of the E820 table in the correct way
> > > > (e820_table, e820_table_kexec and e820_table_firmware)
> > > >
> > > > Perhaps we can put this additional logic in x86's implementation of
> > > > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > > > with configuration tables produced by the firmware that may not be
> > > > reserved correctly if kexec looks at e820_table_firmware[] only.
> > >
> >
> > I have not read all the conversations,  let me have a look and response later.
> >
>
> I'm still confused after reading the code about why this issue can
> still happen with a efi_mem_reserve.
> Usama, Breno, could any of you share the exact steps on how to
> reproduce this issue with a kvm guest?
>

The code does not use efi_mem_reserve() only memblock_reserve().

