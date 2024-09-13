Return-Path: <linux-efi+bounces-1724-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E75977E12
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 12:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5F284F27
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 10:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB81D86E7;
	Fri, 13 Sep 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+o06/E+"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D11D67AB
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224993; cv=none; b=RInCtL+aEGKuM56sWlzq90B+NXBt6wEWm61qkYZNrmqFJUsD4EmQ35gmJkynspOLbnAZ6TgphVIVyyEo3xWQ1grSnJS7QNP7BwHsAjebkBJEuxv9pK86pXkGJhJGnkqyhsyG8KCrXch7Xg2Uat5eK7W6Tcu9xicBfEp9sDbac08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224993; c=relaxed/simple;
	bh=tb9UBms1oXiP8NPUniXYBFRJzon3oZn/KVfHY230W3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WH5tlMq0PRg+ktMLJFobBCagg/gVaeGnuhx2QfOm6OPiCbxOZ9ux6FQJBT9+ryt8dXgY2xIUNt36uleTjQVJ8C3AZcWQGVRn9TmG3v83vYFc3oPIr7Z9JXQtodO0H06LPs+A0df65dvOByjEc7TEOroP2J6uhjRk5LM3UVmXWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+o06/E+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726224989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yWxKjHuLSpOeE8+M838/N9qMnRp66pdf3mc/hdoDmNs=;
	b=E+o06/E+UcUML+Ab4xXDvi/AMvZzsTZ8/K9aEvTCq60hJFo/oGA3E7LHEcpdEg1DLwDvmK
	cAzg9uoW7LhsBZ0JHNfNUBFC6h2QzgymtzPsojPXmH93tX4IXgVq2wEOGegRvMlv4JDrQ7
	HQK+cL1/c9n2vgl3t54fq0fNbwovhRA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-LGZKytgfMKKHZbmGI-xLFw-1; Fri, 13 Sep 2024 06:56:28 -0400
X-MC-Unique: LGZKytgfMKKHZbmGI-xLFw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82aac437083so83848939f.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 03:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726224988; x=1726829788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWxKjHuLSpOeE8+M838/N9qMnRp66pdf3mc/hdoDmNs=;
        b=pS6sercdnKorBaJmFYtcEHoFHDof+u5Oyx+QyXaoW7OLuaLyUsLftDltDlDkN1nqDS
         xSjr7dQ4JeMULlQxXv74oiNegsNPb2lNrl/vnzqpr7mRpo+HPk/j2/3b7uj5g9tQ5vVU
         sNIv/NFc9OFOW33b+kW0NgxKUeQJzILIktRmrrLSVMXiMZjyZU/e3cY/+mCVhWX3xvXP
         CkTNUA6t9MRUhpGK+jDfISaqDXPs/hGp67CK+VwAw9MPT911RD0+N3roBat9aWA0lp9H
         aWYayRoK9QSpb4/xfwzLP2WgRdorphpJbN60p91uHTETrdT2ujTiUFqpnzcWf9AfA4TN
         Y0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3e40hZ1xIP+a0NESO+VJRJRrmVwVE3Q9UoyOLKt3CPnBOaJ7OijfPQwqqr8m27Fl8O5IlUtCtiC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tHF6hZHhZJgFAxp9ruHYpgKHohC9t/l02EMQmK+yhRdCOnth
	ayj7GfIOZicj/Eqm5O7G4J4u5c6kV2qV2UzqF2SD4y2PeXVkEe2bfqvgwC0TZhvv/lY6wKJG4gB
	7bS5VEx8L3OFefKYVx7cwY7jm5rt+ZY5dFmqR3GhAvFxt+FO/2OilJXwlTE+5PKn7cFIOdvR1wn
	VowWFf+i4VAbTTQhCwpyRskHxpague1xR0
X-Received: by 2002:a05:6e02:1687:b0:39f:5d96:1fd5 with SMTP id e9e14a558f8ab-3a08b6f702dmr19005445ab.1.1726224987688;
        Fri, 13 Sep 2024 03:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEnk8QLAWeYTIvNhfvQaphtx6UllDLsrJFoYYDRbGC52xjsxLpE/GX1npjxguHhFEzJSjCfjCfRsCQoXQWWVA=
X-Received: by 2002:a05:6e02:1687:b0:39f:5d96:1fd5 with SMTP id
 e9e14a558f8ab-3a08b6f702dmr19005225ab.1.1726224987310; Fri, 13 Sep 2024
 03:56:27 -0700 (PDT)
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
In-Reply-To: <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 18:56:36 +0800
Message-ID: <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Dave)

Thanks for ccing me.

>
> Full thread here:
> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
>
> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > >
> > >
> > >
> > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > Does the below help at all?
> > > >
> > > > --- a/drivers/firmware/efi/tpm.c
> > > > +++ b/drivers/firmware/efi/tpm.c
> > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > >         }
> > > >
> > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > >
> > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > >                 pr_info("TPM Final Events table not present\n");
> > >
> > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > which is e820_table_firmware.
> > >
> > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > its end, just with e820_table_firmware instead of e820_table.
> > > i.e. efi_mem_reserve does:
> > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > >         e820__update_table(e820_table);
> > >
> > > while arch_update_firmware_area does:
> > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > >         e820__update_table(e820_table_firmware);
> > >
> >
> > Shame.
> >
> > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > table, and 3 (!) versions of the E820 table in the correct way
> > (e820_table, e820_table_kexec and e820_table_firmware)
> >
> > Perhaps we can put this additional logic in x86's implementation of
> > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > with configuration tables produced by the firmware that may not be
> > reserved correctly if kexec looks at e820_table_firmware[] only.
>

I have not read all the conversations,  let me have a look and response later.

The first glance about the patch is that I think the kexec_file_load
syscall (default of latest kexec-tools) will not use
e820_table_firmware AFAIK.  it will only use e820_table_kexec.

Usama, can you confirm how you tested this?
kexec -c -l  will use kexec_load syscall
kexec [-s] -l will use kexec_file_load syscall

Thanks
Dave


