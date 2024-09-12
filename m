Return-Path: <linux-efi+bounces-1711-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86F4976BBC
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 16:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF1B286362
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C19D1B12C2;
	Thu, 12 Sep 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCu4fUiz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F79188A01;
	Thu, 12 Sep 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150497; cv=none; b=rcdnblucuPUmZapuCOFw4WT7kICRo/AU28aWRkrcJxoXdPIZP1YiHYn6mQH1TcgbYAkAXD9HWV1qndoQLBY29yrpE0ZfHai0ZU8mroXC2iI+Vq2k5LjN2P4JY8N3zzv5KLqDHpzxu0joFMKjnVY79c28y1uqSiB3fKTfnagALB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150497; c=relaxed/simple;
	bh=VGZRJzmCN+Wam8xXW+P57As3xaf2eURuf7X7kqSVP/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnBOm9t3Qu5j0I49rP8nykZ17+meSKarg9qimVw8IM+FnVAWF0DSIAfVsSvcEPcTVJEEmvXkih+zgZUwsge0DpcUjF8b2Gz48iz7itkEJWWrgIG6izseqbY3mxFWyjjTiL5q2Y4BG1xp9ByOtPInb1YBVm4mziAfke14Engng20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCu4fUiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DA9C4CED1;
	Thu, 12 Sep 2024 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726150497;
	bh=VGZRJzmCN+Wam8xXW+P57As3xaf2eURuf7X7kqSVP/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UCu4fUizGzE/dzDYc6CuCz/qavF3YbiQyMrJzGo/5YZsGrD+qM5sopYjrApGcg/VV
	 es6Dwq7BMu6suX1JkIfpGnAXCt0FU7SW2zkAFHYhhQIDbj5hoGd+TrZ9IsBrHhjKr7
	 +OQ9CieoiZUesGyHUZZwAJucay1togj7ylsiSJMtU4dxEIALi9gPfWxfZWoKGCvHDk
	 ULLDsGQBNtHuNgqct0Gbe8QZTXN6gKWUKrFjP38ezSDlMAQ5I0MGRKdL2+Slt5GI5R
	 UERtzmrTLRPsZK6yvgm3F72GGvERC9s66IR+5AA0p6IYViJuOTa/PRin5wZCk6tCdW
	 Uj2nOqtepDcQw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75f116d11so13281321fa.1;
        Thu, 12 Sep 2024 07:14:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaDEuLOedB2HZHOOQvYsIrIVTvnJV5KG/JLiCvLCwd3aTiiU++9vjGcNREZ7Rzql0bFLDu1ZBtbkHjojQc@vger.kernel.org, AJvYcCXHnhCsDN5rmnulmUuvQJTfMmjriHSing6uQmG27Trt3SL2RAScojJj+1AHj/pTpIN0ox+SCVE87pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywN6/TH1UEmaTwzu3h0pw6HqmtbSQa+P9Bte/8Iprnhwc3QHHq
	BduDTaArwpyNCV/UQJfx5ko3Uz/Ynypx3lWv8DN8zRf/ZeiufhEjsr+Qe2gNCcAM8S3OY2kgs1Z
	5vZrzW/FIpBBCYI6aT4HFfxfrtb4=
X-Google-Smtp-Source: AGHT+IGyYLLbdVpehbHj2Oyt04OkcFENJP/n0YHbA9nWypu5M9+GnU0Kn53CEAQm2eO+JUyPpMVSPBaYRfKVMrIyfhM=
X-Received: by 2002:a2e:a7c1:0:b0:2f7:543a:3b1a with SMTP id
 38308e7fff4ca-2f787d9e337mr19645771fa.7.1726150495442; Thu, 12 Sep 2024
 07:14:55 -0700 (PDT)
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
In-Reply-To: <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 16:14:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
Message-ID: <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>, Dave Young <dyoung@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

(cc Dave)

Full thread here:
https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u

On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> >
> >
> >
> > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > Does the below help at all?
> > >
> > > --- a/drivers/firmware/efi/tpm.c
> > > +++ b/drivers/firmware/efi/tpm.c
> > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > >         }
> > >
> > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > >
> > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > >                 pr_info("TPM Final Events table not present\n");
> >
> > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > which is e820_table_firmware.
> >
> > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > its end, just with e820_table_firmware instead of e820_table.
> > i.e. efi_mem_reserve does:
> >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >         e820__update_table(e820_table);
> >
> > while arch_update_firmware_area does:
> >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >         e820__update_table(e820_table_firmware);
> >
>
> Shame.
>
> Using efi_mem_reserve() is appropriate here in any case, but I guess
> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> table, and 3 (!) versions of the E820 table in the correct way
> (e820_table, e820_table_kexec and e820_table_firmware)
>
> Perhaps we can put this additional logic in x86's implementation of
> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> with configuration tables produced by the firmware that may not be
> reserved correctly if kexec looks at e820_table_firmware[] only.

