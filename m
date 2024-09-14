Return-Path: <linux-efi+bounces-1781-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A28978F74
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121A41F23905
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844A14D290;
	Sat, 14 Sep 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJj/+qrc"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B213B7A3
	for <linux-efi@vger.kernel.org>; Sat, 14 Sep 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305838; cv=none; b=Nrll73qlSxdxFEcdV3fOny6h+mm5Glxk2LOPsividknDM2UaubALexxLVjF+ZrPhhOQNOG8qmaa5gx3LDGRiU5ohU5vMt8b5rgw5zvkxbY3Tszhs3mHCw1WQH5VyhuSXJbmMjdummKkYa79vxi7K0WCb9QUJDI2FtSR6HTndVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305838; c=relaxed/simple;
	bh=IlQt7P6JVzN+TnjCNHu/EtD8MX8AGNKfKRMDFgmVvug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9yFxV5SH1P8WyCgz5eSg2J7zg0E884+qHIQaOoVFITvOEEDT5cy6kBlmyKkNFyGPcFWaROHh9KX6EdDh1Z4X8VFPUy5RtkX8sOc7eAB8wqV8kiHi4P+wZNKT+8C0WLEmbsoibJkBJRuAWpJwKWGkoFiMi8qik8SvjpGhDMEnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJj/+qrc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726305835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+awoBYbz+fiOegQ6mOk8qScgUrhW8r4PWwqAdqhz0MQ=;
	b=HJj/+qrcFvMOVYGnO+XhN6cFbOw3/D5SHJWWNfC6RnP1l5eWJYryBQRUee6ubvH5mgsluu
	Au+gLitmLEeePhU6OSHZtVmqAcNmpvCkmw9MbACiUNWfQH/Q50jIDmi/3p8s1f28X2m6zM
	tcLHj+FfYd4VUAWIXWIorJnxNrC3Q7w=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-lGGov8iUMY2pCrYS8Zk8zw-1; Sat, 14 Sep 2024 05:23:54 -0400
X-MC-Unique: lGGov8iUMY2pCrYS8Zk8zw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a08c7d4273so48583225ab.1
        for <linux-efi@vger.kernel.org>; Sat, 14 Sep 2024 02:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726305833; x=1726910633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+awoBYbz+fiOegQ6mOk8qScgUrhW8r4PWwqAdqhz0MQ=;
        b=vYWMY+Qe0h8Q8M/NDpUx8yaKMZczrCK25JxLzNVznRrpbjckNR7yPbO4mvODLYRTzd
         vDK0ZjRyQ3Jy13H9qGKXPdMscgwFUOHmREkAFwXtr+Yxs7jMqkeP0SpXk/2OyqcXwuMj
         4Gn4A1jXALWmOnvFCFnNgnuBzH+xoE1zJ+nbcUY9RjHEUFb6VDWjHDrE8EEesQIyldrV
         8t32XZYmoZZNduN0CQaQVyGudiR12aQttLA0gPox/AraP7Mv0zMXlTX4RA6I4fo1bxgw
         rndqUWemriU2DcQHiS1EIrgDW6lQaDLF7H/muOSaVSaIctsh/NTsNcU5rbgVApBlP26/
         vMsg==
X-Forwarded-Encrypted: i=1; AJvYcCVHS88+Sql1/QsyIsX0Y8M3vm2+QCVwC4W6QYmW4TVUqx0E9/qW2XokMYUoWjQEu6zkAKlZON2jGpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq60kiTI9vmcpgoQtsz3Ck4TNUuYNAfa51tcEaf8Z/ShD+FsZA
	g+/HB7pe1GqGx0urZg/jIKQ9+PavKTsUXZENMp/mBixuVm2kYcaKCSPJ+i6rHEPom8ZVphrUCwZ
	+c0f66ZQgtMQk7la8acu0JdjiHAdK07yqODqAbU/fa6dQZQubSWUaZZaBKwIr8ga/F1o0iBhlhn
	swuQzcYoFZpcaj0FiG3upC3hE/pn2KVpsX
X-Received: by 2002:a92:c54f:0:b0:39b:2ceb:1a23 with SMTP id e9e14a558f8ab-3a08b6eaf31mr60812035ab.3.1726305833328;
        Sat, 14 Sep 2024 02:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1udwAp2hvQpffUsSCAinuqeX3gwXdqv9mYS2VXLF1QMtgx2Uyroz30Qdf3rG7X/Vc0kyHoQWKJ7b7ZwTjkmU=
X-Received: by 2002:a92:c54f:0:b0:39b:2ceb:1a23 with SMTP id
 e9e14a558f8ab-3a08b6eaf31mr60811745ab.3.1726305832959; Sat, 14 Sep 2024
 02:23:52 -0700 (PDT)
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
 <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com> <CAMj1kXEXH2YvWtzEJEEOnTLqACsRhan3Lf9OCLYDjKf6gxDmBQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEXH2YvWtzEJEEOnTLqACsRhan3Lf9OCLYDjKf6gxDmBQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 17:24:01 +0800
Message-ID: <CALu+AoSp1ZryfH_j6RYqeCCjG5mFf6JkgaF4V9UwgPp+pE+mjA@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Sept 2024 at 16:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 14 Sept 2024 at 08:46, Dave Young <dyoung@redhat.com> wrote:
> >
> > On Fri, 13 Sept 2024 at 18:56, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > (cc Dave)
> > >
> > > Thanks for ccing me.
> > >
> > > >
> > > > Full thread here:
> > > > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> > > >
> > > > On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > > > > Does the below help at all?
> > > > > > >
> > > > > > > --- a/drivers/firmware/efi/tpm.c
> > > > > > > +++ b/drivers/firmware/efi/tpm.c
> > > > > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > > > > >         }
> > > > > > >
> > > > > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > > > > >
> > > > > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > > > > >                 pr_info("TPM Final Events table not present\n");
> > > > > >
> > > > > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > > > > which is e820_table_firmware.

Updating e820_table should be good enough, it depends on where the
corruption is happening.

kexec will find a suitable memory for the kernel via searching through
the system ram resources.   So efi_mem_reserve will update e820_table,
then reserve in the resources list as E820_TYPE_RESERVED, thus it
should not be a problem.
During the 2nd kernel boot phase, it is carried as EFI_LOADER_DATA
with EFI_MEMORY_RUNTIME attribute, I think it is also fine,  and later
efi_mem_reserve will be called as what have been done in previous
kernel.

So I think no need to update the e820_table_kexec and e820_table_firmware

> > > > > >
> > > > > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > > > > its end, just with e820_table_firmware instead of e820_table.
> > > > > > i.e. efi_mem_reserve does:
> > > > > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > > >         e820__update_table(e820_table);
> > > > > >
> > > > > > while arch_update_firmware_area does:
> > > > > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > > >         e820__update_table(e820_table_firmware);
> > > > > >
> > > > >
> > > > > Shame.
> > > > >
> > > > > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > > > > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > > > > table, and 3 (!) versions of the E820 table in the correct way
> > > > > (e820_table, e820_table_kexec and e820_table_firmware)
> > > > >
> > > > > Perhaps we can put this additional logic in x86's implementation of
> > > > > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > > > > with configuration tables produced by the firmware that may not be
> > > > > reserved correctly if kexec looks at e820_table_firmware[] only.
> > > >
> > >
> > > I have not read all the conversations,  let me have a look and response later.
> > >
> >
> > I'm still confused after reading the code about why this issue can
> > still happen with a efi_mem_reserve.
> > Usama, Breno, could any of you share the exact steps on how to
> > reproduce this issue with a kvm guest?
> >
>
> The code does not use efi_mem_reserve() only memblock_reserve().

Yes, I see this, I just thought that Usama tested with changes to
efi_mem_reserve and it still did not work, this is what I'm confused
about.

But maybe Usama did not test and only checked the code and assumed
that we have to update the e820_table_kexec and e820_table_firmware.
See my reply inline above.

Thanks
Dave
>


