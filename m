Return-Path: <linux-efi+bounces-1726-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBFC977E47
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBF81F26FF3
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6711D86C3;
	Fri, 13 Sep 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTmx4zmm"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A91D47BF
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226032; cv=none; b=UyCeTyQ03Z32xWRh2BdM7ogsbOe1x7g1vZXwpi5Wawdgydpuue2CeqY/ON95CKC5kFPNXTobpKTB9BWbWwy0bIjTmFDq27TNNKP4uGEc6BP7FVudzDUbLR2pfBNHWNAq8MSEh4HcU2XjyLdBS+z1uRdmntS7WJzoh1CB8/apSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226032; c=relaxed/simple;
	bh=qviUKxj2ShBNT1+2oFVXBp5YaTG7MqEK1RKmcyVIQp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEMenasSMH5f1JVYAac21qZ2OHBEOXjBDKnHKk8AU1yTU2+e4jCi84ewH6Z3VNS1XrfJv2E7TyG5N+MYSG1ZiqrEMLPkm9R1IAVELMWY7BgyIepakMT4hC8Xhu/QLBt/yMorgBxuyHWiM8oOJ0H9lM8IOGpxHkErovUeafG2PuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTmx4zmm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726226030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MASR/9GQZ3+JJGeE8AwFTJhS8+TAiNPcAVjIePuGwyw=;
	b=UTmx4zmm4Jx0MaQnczsa4bLv6ZW2jbxn3veFpIUgP2lIBQrozBAZiuDfFm2HpJ+QoiqwpR
	GNn/5M2Q7M8r1hM1lQ4HQEdmwnBwFz/K0ZyJJd/Nky9p/TmTpCI/ENpgnFOEyrH6Gzep/J
	gA4vX+4I+WFda+zzNK+bnxfIamPitRc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-OmKslHRxOZ6DTAh06SqO1w-1; Fri, 13 Sep 2024 07:13:49 -0400
X-MC-Unique: OmKslHRxOZ6DTAh06SqO1w-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ce2629e40so222652139f.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 04:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726226028; x=1726830828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MASR/9GQZ3+JJGeE8AwFTJhS8+TAiNPcAVjIePuGwyw=;
        b=BE61x6uf40+l6W+If15RqHt05uQVC6nvNaUtriEoRPXHgarf/k5hIkXXEY3GN+pbAG
         NAnCvRGOsXqYx27W2gtEoLyRT11tTi1IW9qRkolC5CG27ihg97+knyo6dc4WcC79V7+m
         bYJy3ywzghlplXqAQararBYw6by3sZWgZgQ8xt9UACGcakptVv6VJRP1ALuyN7TK/Oif
         b63+tvpbSrrd0ZalhRjw2Sjui8dz9FeOssYWVsbYVU+/PEGfFIOVVvDdhr7tlh2LixYJ
         yTUSL6HoUhUzouTDtg9U7XFPR9TbSDYmfIXuSWvae6hNPeaT7dlUchd+IM/pHpHBGnPt
         xEkg==
X-Forwarded-Encrypted: i=1; AJvYcCU50HXa2RLHAAKThKcO4tvgo2N3PqSu2vXX0aT4/JsUoaHjQ2hfCERtsyrmBQujhqrpqxOHYw6ru2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5zBrgQHZ37kUXAFfk+fTWt8Da8FckjrA98Fb3RDx4i6vJVYR
	fjfKntwek/VLfaxz/5owSpdENFqe24L4cv+I3nG0Vx5PJ0JxJ+peemDZeK8UE3FwIXMcP+rfvFk
	pi0IjcJzPctAWp/WY6o2WySXlfkxVmGw2zZpU4cpHqLN6rPHztaAHZ5mvi6uBPhXuM1AtQYJVz3
	HrkwC+tHasn4oTS+RMgODTMakdthiZVqUL
X-Received: by 2002:a92:b706:0:b0:3a0:8c8f:99ec with SMTP id e9e14a558f8ab-3a08c8f9aa5mr8882525ab.13.1726226028404;
        Fri, 13 Sep 2024 04:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsWFNdjlLRYC7/y0fJaPtKleRTR1PQe/Z3y/C8TCNPCol5vlzUbHhhMuwMbrDKD5nzJW0Xw4zuyyUIzT7g0uI=
X-Received: by 2002:a92:b706:0:b0:3a0:8c8f:99ec with SMTP id
 e9e14a558f8ab-3a08c8f9aa5mr8882345ab.13.1726226028010; Fri, 13 Sep 2024
 04:13:48 -0700 (PDT)
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
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com> <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
In-Reply-To: <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 19:13:57 +0800
Message-ID: <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 19:07, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 13/09/2024 11:56, Dave Young wrote:
> > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> (cc Dave)
> >
> > Thanks for ccing me.
> >
> >>
> >> Full thread here:
> >> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> >>
> >> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>
> >>> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 12/09/2024 14:10, Ard Biesheuvel wrote:
> >>>>> Does the below help at all?
> >>>>>
> >>>>> --- a/drivers/firmware/efi/tpm.c
> >>>>> +++ b/drivers/firmware/efi/tpm.c
> >>>>> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> >>>>>         }
> >>>>>
> >>>>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> >>>>> -       memblock_reserve(efi.tpm_log, tbl_size);
> >>>>> +       efi_mem_reserve(efi.tpm_log, tbl_size);
> >>>>>
> >>>>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> >>>>>                 pr_info("TPM Final Events table not present\n");
> >>>>
> >>>> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> >>>> which is e820_table_firmware.
> >>>>
> >>>> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> >>>> its end, just with e820_table_firmware instead of e820_table.
> >>>> i.e. efi_mem_reserve does:
> >>>>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >>>>         e820__update_table(e820_table);
> >>>>
> >>>> while arch_update_firmware_area does:
> >>>>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >>>>         e820__update_table(e820_table_firmware);
> >>>>
> >>>
> >>> Shame.
> >>>
> >>> Using efi_mem_reserve() is appropriate here in any case, but I guess
> >>> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> >>> table, and 3 (!) versions of the E820 table in the correct way
> >>> (e820_table, e820_table_kexec and e820_table_firmware)
> >>>
> >>> Perhaps we can put this additional logic in x86's implementation of
> >>> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> >>> with configuration tables produced by the firmware that may not be
> >>> reserved correctly if kexec looks at e820_table_firmware[] only.
> >>
> >
> > I have not read all the conversations,  let me have a look and response later.
> >
> > The first glance about the patch is that I think the kexec_file_load
> > syscall (default of latest kexec-tools) will not use
> > e820_table_firmware AFAIK.  it will only use e820_table_kexec.
>
> I initially thought that as well. But it looks like kexec just reads /sys/firmware/memmap
>
> https://github.com/horms/kexec-tools/blob/main/kexec/firmware_memmap.h#L29
>
> which is e820_table_firmware.

That piece of code is only used by kexec_load

>
> The patch that Ard sent in https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
> is the right approach to it I believe, and I dont see the issue anymore after applying that patch.
>
> >
> > Usama, can you confirm how you tested this?
> > kexec -c -l  will use kexec_load syscall
>
> I am currently testing in my VM setup with kexec_load. But production is running
> kexec_file_load and has the same issue.

Ok, I mean efi_mem_reserve should be able to work if you retest with
kexec_file_load.

>
> Thanks,
> Usama
>
> > kexec [-s] -l will use kexec_file_load syscall
> >
> > Thanks
> > Dave
> >
>


