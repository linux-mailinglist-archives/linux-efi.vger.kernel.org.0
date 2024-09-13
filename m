Return-Path: <linux-efi+bounces-1727-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11D977ED6
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31D62813F4
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AE51C2DCE;
	Fri, 13 Sep 2024 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnvdftAa"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AEE6BFB0
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228144; cv=none; b=V3lTYSkqg2/KevXYR8WbzQOWfCOtu08NKuPGlxuXJzW+Id7p8hDExvVoKfj9+M67B19X5vfiYNYGXV79atQ2GuHba4h5OPw06tP0gCuT+ueQpTam9I5hQzrmxW32eFzIC5SZMB3Kw+eSC2QJUFUnskPYBJR3jLLTdnmBaM2f8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228144; c=relaxed/simple;
	bh=xxQ0aXG09rXJKVCMGSHHz3LbN7OPgJPQ5BAuRWnB/TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r68dqJ+/RUP+3fyyvmo4Yvz9vUcYKIu0Ey+uRnlnI8y41amXAJQ6OOPEIskVJwIPukOWIE5xteGeXZ7VOIoAFDKXiBR7iDHjBNwEUq+PhU/qu417FZtanKWBckXvm4vmMXHps36q0ZEUsT6UHAL3DeouRdIYFFZXHkdFDA++iwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnvdftAa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726228141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLsgKJWlbStQF29sk2kzl+359xJBMr9YOTKXz/rvjuY=;
	b=FnvdftAaixVHmXDcBhtnHGpx7+KBdOT9abkZfVSySjuAG35nPwb/0IqbXFKsw9g8K8n+9y
	dsedot0vRl1GaEYBRxOy++yLScchdQT8t2pM5UvZPR3BWFEa8FwRqti2l84U2Ne7RithPr
	thfjCrBs9ovMP3ljrLQDVV+3x6dA3q0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-uuTdPGBSPGmlJBKUrq75Bg-1; Fri, 13 Sep 2024 07:49:00 -0400
X-MC-Unique: uuTdPGBSPGmlJBKUrq75Bg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a050af2717so31583365ab.0
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 04:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228140; x=1726832940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLsgKJWlbStQF29sk2kzl+359xJBMr9YOTKXz/rvjuY=;
        b=uNM/kkNfYbe00vORmsYljlx0hJgxePhCbFIKtUPV/PDYM9VaG5ZKg4XWztX+ViuOSw
         z7ihR+JxTlDDmeOtWoG5iPBD1+dBLfEnyyH4sCj135TKlAOEjA7hC5b/x6ZMRX25s5ju
         FBQaOClPQcbGBV5SCYhVAjiOoi7y0ILhZlT63XfpROkmTuo9F7pjgNrbu3bi3Wudxvfi
         vqR1RM+scH04Vd9lxsZXbp6PoJoFUWTtLBRt9xstB/9jBkKRXOnnMjk4+S1CtGxQusVf
         Gjp6OLxJ8PWOHiq6ZR4EatS3zdrX2nwJDGjGDHBAyVayt5ZGzzq2bERP6OUKalGtDBrF
         Mf6w==
X-Forwarded-Encrypted: i=1; AJvYcCWUZ0xsUyjllDaU7E20UpSsY0bdZ8wKtKu0/S3IHMgwpuXujJXev8A6CtyF+Y3GBK4i6iwTXVjUZR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuizYRbw8wqOCEvCBB/PiecicoCXK5ZfQtT6v4RS0Y5+tEuRq
	J/OU6e07rSHCdSYDJd+IjOyG6UkaQtwEhqFqZFVFvwFWJorH0arNbMl98R8bNjv8ZPSvSxDd9La
	o6ptK07TMm+PaM+7UNJK5w02TG+B3aBDgPy+0qzHrcYK+5Sqq/oLBwD8HKCwklEvIU57F0L/tOq
	7bNW+YTWn3X7H8BaVssdQVMdRJ7QylON0H
X-Received: by 2002:a05:6e02:1d05:b0:39d:2a84:86a3 with SMTP id e9e14a558f8ab-3a0848aff21mr65013415ab.4.1726228139831;
        Fri, 13 Sep 2024 04:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBxhnTVx9pazmQpewUpzYgkKmDROO9FUau+OjYRUe1cM2IP3h9TK3N1cMqOfg6YcN/9Aw7a7Ms1iOdUE4IdMo=
X-Received: by 2002:a05:6e02:1d05:b0:39d:2a84:86a3 with SMTP id
 e9e14a558f8ab-3a0848aff21mr65013185ab.4.1726228139409; Fri, 13 Sep 2024
 04:48:59 -0700 (PDT)
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
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
 <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com> <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
In-Reply-To: <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 19:49:08 +0800
Message-ID: <CALu+AoSdN4Zh5gPbyTGS8gJ7wDFfOq81ANNH4wmv3z1vs-34Rw@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 19:13, Dave Young <dyoung@redhat.com> wrote:
>
> On Fri, 13 Sept 2024 at 19:07, Usama Arif <usamaarif642@gmail.com> wrote:
> >
> >
> >
> > On 13/09/2024 11:56, Dave Young wrote:
> > > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>
> > >> (cc Dave)
> > >
> > > Thanks for ccing me.
> > >
> > >>
> > >> Full thread here:
> > >> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> > >>
> > >> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>>
> > >>> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > >>>>> Does the below help at all?
> > >>>>>
> > >>>>> --- a/drivers/firmware/efi/tpm.c
> > >>>>> +++ b/drivers/firmware/efi/tpm.c
> > >>>>> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > >>>>>         }
> > >>>>>
> > >>>>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > >>>>> -       memblock_reserve(efi.tpm_log, tbl_size);
> > >>>>> +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > >>>>>
> > >>>>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > >>>>>                 pr_info("TPM Final Events table not present\n");
> > >>>>
> > >>>> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > >>>> which is e820_table_firmware.
> > >>>>
> > >>>> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > >>>> its end, just with e820_table_firmware instead of e820_table.
> > >>>> i.e. efi_mem_reserve does:
> > >>>>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > >>>>         e820__update_table(e820_table);
> > >>>>
> > >>>> while arch_update_firmware_area does:
> > >>>>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > >>>>         e820__update_table(e820_table_firmware);
> > >>>>
> > >>>
> > >>> Shame.
> > >>>
> > >>> Using efi_mem_reserve() is appropriate here in any case, but I guess
> > >>> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > >>> table, and 3 (!) versions of the E820 table in the correct way
> > >>> (e820_table, e820_table_kexec and e820_table_firmware)
> > >>>
> > >>> Perhaps we can put this additional logic in x86's implementation of
> > >>> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > >>> with configuration tables produced by the firmware that may not be
> > >>> reserved correctly if kexec looks at e820_table_firmware[] only.
> > >>
> > >
> > > I have not read all the conversations,  let me have a look and response later.
> > >
> > > The first glance about the patch is that I think the kexec_file_load
> > > syscall (default of latest kexec-tools) will not use
> > > e820_table_firmware AFAIK.  it will only use e820_table_kexec.
> >
> > I initially thought that as well. But it looks like kexec just reads /sys/firmware/memmap
> >
> > https://github.com/horms/kexec-tools/blob/main/kexec/firmware_memmap.h#L29
> >
> > which is e820_table_firmware.
>
> That piece of code is only used by kexec_load
>
> >
> > The patch that Ard sent in https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
> > is the right approach to it I believe, and I dont see the issue anymore after applying that patch.
> >
> > >
> > > Usama, can you confirm how you tested this?
> > > kexec -c -l  will use kexec_load syscall
> >
> > I am currently testing in my VM setup with kexec_load. But production is running
> > kexec_file_load and has the same issue.
>
> Ok, I mean efi_mem_reserve should be able to work if you retest with
> kexec_file_load.

Hold on,  I'm not sure about above :(

checking the efi_arch_mem_reserve(), currently it updates the e820
table, if you update the e820_table_kexec and e820_table_firmware then
I think both kexec_load and kexec_file_load will work.

Anyway I was not aware very much about the firmware e820 tables and
kexec tables when they were created.   I suspect that a cleanup and
revisit is needed.  I will have a look at that.

For Ard's fix to allocate it as ACPI memory, I think it should be good
and simpler.

>
> >
> > Thanks,
> > Usama
> >
> > > kexec [-s] -l will use kexec_file_load syscall
> > >
> > > Thanks
> > > Dave
> > >
> >


