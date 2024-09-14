Return-Path: <linux-efi+bounces-1779-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6628978E7D
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 08:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCECB1C22413
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 06:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F811A727F;
	Sat, 14 Sep 2024 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gA/ca8XY"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD81A42C7
	for <linux-efi@vger.kernel.org>; Sat, 14 Sep 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726296364; cv=none; b=EroW/rfFmofIRGvIbCZ7SeHfDsy7pZSA8DoBKxLxyztuZwhevN0v8Jgc/O64Enirk8blDau9qCiCkwOC/Vehji0Aa725C1PLKawiagLy3e9TLSSvzU42rcP67J4qLl7VfLxSM9q/5HZC3kgGj7ktNM8sz9O3aj2r6N/RRtorIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726296364; c=relaxed/simple;
	bh=B+tUlhexzHIKFHjAPKP/mBUd1RPqfSazamtOQbN+/2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoIyg9BGtmSQKM1iZ2rGu/NEOSxJPk4ofmdxMCKRSm0bB+tqknZMp5xA0G/taSUoTa0Uf64nJpzld1AFStfpDFscXeWcjv5hPFo8na2YmOa846bzPCcgVPTMAID7yAsbvzE7wmR+qQoXJJNMaOHz4Ih0oeNh1jQO2x0YsEpqLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gA/ca8XY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726296360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eE+sUtCjdi/s3uFDNMp4FAK3ec8qOZ3QSC8oSZ6JDTs=;
	b=gA/ca8XYiBr2KFPQLV8C6Vh76njsxMtp9DBmiNHfnd9KRtsFLjDDYRw0MpCM0KGxQNjeIc
	ztrLbJuoFW9Lgtdgu3s/GN/64nzpe08AflKEXALddTJ0BV4UH1V1QT7DhQ0oFTtDcJRBul
	mzbuWs7ttlOra7qOFCevSpSlE4nIRTg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-J0mhoOiwMbunu0gIvvfcEw-1; Sat, 14 Sep 2024 02:45:58 -0400
X-MC-Unique: J0mhoOiwMbunu0gIvvfcEw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so43129485ab.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 23:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726296358; x=1726901158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE+sUtCjdi/s3uFDNMp4FAK3ec8qOZ3QSC8oSZ6JDTs=;
        b=kdE9yKNmCZ2/EC8J/KEN3myXvDGxDxtoWrS88V3O0wRT5vRObqhKVrZlHKiV6rsSaX
         cwVr2M+LRfD+Z7E3Y47EEZNbK978Lq1SL+wSVRW5cpJ09YF5c5zwh555Et0bgmBKzen3
         78uTvT1EVd2IROJuWqymTJ0GrWQCE0MT1SgJEk+Rrzmg3VcSmPxR0mC1gEpoUB8JU0eT
         te7dyXY1U86ANUA/Q2hQQokHm/VRAEFnaWkA6ZWGeJduNxCrnj+QBzZ95tXa4+WSX0k3
         fL5Yv8nxfvGywZD3wg4N534IyQlzZmHIxKHiGxf9U82jt1ZYaWm0aElqb3GQPbJVXShm
         4Naw==
X-Gm-Message-State: AOJu0Yx9JOxVn3kyMwgwODx17w90k7GF9tGNY4Ibboz7+D14hR3pbTnV
	Cxv2WF2wEx4tUmzfk5/TbpRzAr+bTzY3TGwo0h2xCFRPybLD/w7d6KsNsvTacHjYdLWUeEdNb5f
	oftJ8YXoc8GcYlSYUyArlwAMuOEGVqk9KdoAMziISe2X9e0Xr8YVSzDqtG9/1zUUQky4AySpHxI
	GdqvF0Ql/sdZjcCNN/W3IA17Yv8v+HdWsh
X-Received: by 2002:a05:6e02:20c3:b0:3a0:65a0:460a with SMTP id e9e14a558f8ab-3a08b7853d2mr56807675ab.19.1726296358185;
        Fri, 13 Sep 2024 23:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKtOV06MvITuNSFqCNIuipejGNDZMGs5HGBfR92MW39oPD8LiixfpPzOKJFy295hNSsVybcQ9a493Mk9E08Vc=
X-Received: by 2002:a05:6e02:20c3:b0:3a0:65a0:460a with SMTP id
 e9e14a558f8ab-3a08b7853d2mr56807495ab.19.1726296357859; Fri, 13 Sep 2024
 23:45:57 -0700 (PDT)
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
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com> <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
In-Reply-To: <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 14:46:07 +0800
Message-ID: <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	Breno Leitao <leitao@debian.org>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 18:56, Dave Young <dyoung@redhat.com> wrote:
>
> On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > (cc Dave)
>
> Thanks for ccing me.
>
> >
> > Full thread here:
> > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> >
> > On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > > >
> > > >
> > > >
> > > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > > Does the below help at all?
> > > > >
> > > > > --- a/drivers/firmware/efi/tpm.c
> > > > > +++ b/drivers/firmware/efi/tpm.c
> > > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > > >         }
> > > > >
> > > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > > >
> > > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > > >                 pr_info("TPM Final Events table not present\n");
> > > >
> > > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > > which is e820_table_firmware.
> > > >
> > > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > > its end, just with e820_table_firmware instead of e820_table.
> > > > i.e. efi_mem_reserve does:
> > > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > >         e820__update_table(e820_table);
> > > >
> > > > while arch_update_firmware_area does:
> > > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > >         e820__update_table(e820_table_firmware);
> > > >
> > >
> > > Shame.
> > >
> > > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > > table, and 3 (!) versions of the E820 table in the correct way
> > > (e820_table, e820_table_kexec and e820_table_firmware)
> > >
> > > Perhaps we can put this additional logic in x86's implementation of
> > > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > > with configuration tables produced by the firmware that may not be
> > > reserved correctly if kexec looks at e820_table_firmware[] only.
> >
>
> I have not read all the conversations,  let me have a look and response later.
>

I'm still confused after reading the code about why this issue can
still happen with a efi_mem_reserve.
Usama, Breno, could any of you share the exact steps on how to
reproduce this issue with a kvm guest?

Thanks
Daev


