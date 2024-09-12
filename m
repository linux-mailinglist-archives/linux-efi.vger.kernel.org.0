Return-Path: <linux-efi+bounces-1710-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB8976B8A
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 16:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422231C208F1
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E3F1AD253;
	Thu, 12 Sep 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knqMA+wh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666001AD24D;
	Thu, 12 Sep 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149964; cv=none; b=ZRX9j72idRUI3sK8jRf9Rqt7q5eAMMecCvQFCnyiW7SfeWrSgbToq9n30ZSz+2b2AYikdA5gaqQhHUzxdILexVDgkes5p2xaoDCIWsCmUEx7gy50ic7EkFFq24086z7EeJRApVYO7cjYhQrKOnsTpFExqe0ms9Pv5YoG0wFKLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149964; c=relaxed/simple;
	bh=WoTZyIHrJjlfxGW93PZ+yOu/QfOQLw3D21hwcUP9KdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huBkm+WSBmlLjeIJX5WWtY9L6nTHe61scXOedkWSJF4KHmEJCJyysLcVRT90kvOnLyZUYe3/Ku9V3vU4jOLZZI2CfT2xXp86SYAZGqYB0G78Z20n77ftLBDyhklbsBFrQvOmww3v4UbGoUIZ5VOteyXVAl7/zbWhdMhSRW3RYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knqMA+wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C16C4CEC3;
	Thu, 12 Sep 2024 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726149964;
	bh=WoTZyIHrJjlfxGW93PZ+yOu/QfOQLw3D21hwcUP9KdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=knqMA+whITnJ+OH4n2sjAeO2q+FI48jPuDOf5+REuybUD8XzVNW3f1xQ8KvzOpQ9j
	 CWo2cD5U+1QW7gCfxga5syXpWVxvp+2eOg++Inxj93lHRaVZf95vYOh997syTNdqZI
	 rPkJZa4BgR8QjTZ/XoioRdlHYQotW4a/8oQl18zwociSmYceqVefOQgw2XidX9UOGB
	 TH4Uecwm5VWBDiCfFr4RtGHUTjuocFZtQ/+Oo4F6JdPJMfZsf8KjixDZd5jmgTj3Go
	 cLtTXB8pUk2mYB4m3q0UerAfUDx9vH9/e7xFKxW8Zz54/Z/VyY9+oiaM15N6WIsKpq
	 YV+vXeyfyvjtg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7528f4658so9862191fa.3;
        Thu, 12 Sep 2024 07:06:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIaf3ZTQokCYL9JwXJJ6dnJRzkkJQVw6ys0PD2O93N8j6swYtYvZzGslrAI66MSC6g2TcMCspOJ+M=@vger.kernel.org, AJvYcCXIhvfg++8jA6G8vJTMK+FA7ceqcYuGw4pyIYTe59o/1I/+ydXSevSs0oeG2ytOaH8SfvQhLQaZucz2OYd3@vger.kernel.org
X-Gm-Message-State: AOJu0YzB54cfWL04yaLu9E8TDGlqZlnqF61GZr62kWFYblWhxhwY88Pz
	e+UW3R+jzKrKgH8QYIU2RvvUkxXi/1YkyDOdlyl3wLKcUD2pQxrDPADYtg1hDyviBy/Hbv0BrhG
	frl2GvjswyKlprnKlU/+tCU4HWrE=
X-Google-Smtp-Source: AGHT+IFMsEZDeFz4sbFkQuhnyEESr6pin/nTPXVyorAnmtEnZ4xszs/8JjoTuGO1Mj8SPV0ZXY9LFKY9RcSzFUchjws=
X-Received: by 2002:a2e:4e02:0:b0:2f3:f111:9bc4 with SMTP id
 38308e7fff4ca-2f787f4f44bmr13758301fa.43.1726149961641; Thu, 12 Sep 2024
 07:06:01 -0700 (PDT)
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
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com>
In-Reply-To: <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 16:05:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
Message-ID: <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > Does the below help at all?
> >
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> >         }
> >
> >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > -       memblock_reserve(efi.tpm_log, tbl_size);
> > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> >
> >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> >                 pr_info("TPM Final Events table not present\n");
>
> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> which is e820_table_firmware.
>
> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> its end, just with e820_table_firmware instead of e820_table.
> i.e. efi_mem_reserve does:
>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>         e820__update_table(e820_table);
>
> while arch_update_firmware_area does:
>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>         e820__update_table(e820_table_firmware);
>

Shame.

Using efi_mem_reserve() is appropriate here in any case, but I guess
kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
table, and 3 (!) versions of the E820 table in the correct way
(e820_table, e820_table_kexec and e820_table_firmware)

Perhaps we can put this additional logic in x86's implementation of
efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
with configuration tables produced by the firmware that may not be
reserved correctly if kexec looks at e820_table_firmware[] only.

