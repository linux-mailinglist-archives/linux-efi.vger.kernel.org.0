Return-Path: <linux-efi+bounces-1478-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A393A2AC
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2024 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E691F23938
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2024 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB415442F;
	Tue, 23 Jul 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siKr+/nK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC715252E;
	Tue, 23 Jul 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744810; cv=none; b=JBrLpWi1qVX3wt36Hrv4QqeuyucPuI2oSwHYmXabe8LBYLlxaLegP30i32UV1oGhmDTRYqXrrTJc2SaVZGzp2K6n9l2/Op/9TUrf/Drbm1s5wwIwuA49+pkyyJV3OtNAe6Zg1jYAEERCvEw33xbTdL9Tzq027Lm0zqxeqybmYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744810; c=relaxed/simple;
	bh=IrWN2lsf7i9+Xfl4dD/u4GOoA9WUT+JCaejOnQjgsM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5P5LOi+x+tRKAUJwdfnSWduiiDVJwAR6Zh81k3lSv7ffPwnGYEYu8BZ6q9f0oT4c3F6VVU/S5envIC1hDlX9qpOavDLpIndcRkd4BgQQbdiz55rqOhbhoLQhaA8P1mKnjsAaeAXJ7vJOmazs7YN8yvi5RYMNKBzRaKoU6b/0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siKr+/nK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED52C4AF0E;
	Tue, 23 Jul 2024 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721744810;
	bh=IrWN2lsf7i9+Xfl4dD/u4GOoA9WUT+JCaejOnQjgsM0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=siKr+/nKtMCmePiejUdUkXWqD0Q5ozbu2xMaA7nCx4xlyIIAmjQ0lBr1LX8GEoZDf
	 ClLtJCcsogMKKbeSUX7fTLhjYzCw58m8u/JSqIY3+BXCRpRjA307XV/ya8Vz+LHeHM
	 gk5mtbLm5UPEbglmC6zr+FU3vqG7++yzF1jXbek4/L2P3htK1GTrxsKNAK+30K121b
	 9cIXzsb+5fXeuyYIhRwIDBqIcKkWR2UbMqVLLXXYyKuq2kJP4P11q+tPVEUJCjP9wi
	 Orr/ddFOFrITWmyYg/0aBc1oqbH588RFDRoVdMtaXEWSnNs6l3ptY2PJrWVAWsO4fW
	 Z9y1/HbyvW6MQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so68027391fa.3;
        Tue, 23 Jul 2024 07:26:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbhDHbFxIeJTdJUPNzu3oCYP4Y3aMj90zH8HsGHBzKTiDJlwvwG/uZXngV7SveLOLWSIdI578t9b7nXkBvrxE2t53ZPU3FsNvasxUq
X-Gm-Message-State: AOJu0Yy+QjEwHIiMuGHrwVdV18oEtNT0nbwpqFCAfIlNxlsNvbQHWlGS
	aKT5UOPMqWkUspMHCYN4Hk7jm7mxjFQ0Zx/8qYicJzLPOw/yCSUx8DCqmTYS+iLAoWRAK85SiD2
	TsBF40jQMJlNtBKAY8ib8gAYfE8M=
X-Google-Smtp-Source: AGHT+IHE6ktD3xE379LftZ+HmpngBfNV6pu6j31lW6iLRnwcVp6vzu3Iv99x6ZPH8sIDopyJjs2iDf5a1SYNeomtooU=
X-Received: by 2002:a2e:9216:0:b0:2ef:232c:6938 with SMTP id
 38308e7fff4ca-2ef232c6b4emr62336461fa.6.1721744808590; Tue, 23 Jul 2024
 07:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <DS7PR19MB5709B2A263E769B461091B0D8BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHBSNxrzbQoaDea7HFcjN9HHk5==tXg1WLHDzW61aj4cg@mail.gmail.com>
 <DS7PR19MB5709B39C90153DAA27DA122D8BAE2@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHS0rr9DfKCeD-Zz7y1Bk-3ncn2cEgVmnWE0Jq1B=+Acg@mail.gmail.com>
 <DS7PR19MB570924EC5BB1BA3F321A65B98BA82@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXFjWBpOij5V3=-9etqTW9p8guqPDCGU3DK0Yxq6zrBiBQ@mail.gmail.com> <DS7PR19MB57092B4012BEFBBA52E2C2748BA92@DS7PR19MB5709.namprd19.prod.outlook.com>
In-Reply-To: <DS7PR19MB57092B4012BEFBBA52E2C2748BA92@DS7PR19MB5709.namprd19.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 23 Jul 2024 16:26:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEQXZc2Vpgh5JA3nCCw=LB0kjLgQoximQ4pZhcJ91iOnw@mail.gmail.com>
Message-ID: <CAMj1kXEQXZc2Vpgh5JA3nCCw=LB0kjLgQoximQ4pZhcJ91iOnw@mail.gmail.com>
Subject: Re: [Patch] Do not clear BSS region in x86 stub
To: "Shao, Marshall" <Marshall.Shao@dell.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"Mishra, Ashish" <Ashish.Mishra4@dell.com>, "Chia, Jia Yuan" <JiaYuan.Chia@dell.com>, 
	"Dion, Christopher" <Christopher.Dion@dell.com>, "Caisse, Joe" <Joe.Caisse@dell.com>, 
	"Mukundan, Govind" <Govind.Mukundan@dell.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 16:21, Shao, Marshall <Marshall.Shao@dell.com> wrote:
>
> Hi Ard,
>
> Many thanks for your reply.
>
> > systemd-boot does not use the EFI handover protocol. Please try to
> > determine where this confusion comes from: are you using a UKI image
> > perhaps?
>
> I can confirm that both systemd-boot and stub will be used, and you
> are correct about the stub part, because currently, the stub will lead
> the system to handover protocol and trigger the problem.
>

Can you explain why this is the case? systemd-stub should only use the
EFI handover protocol for v5.8 or older.

> > I am trying to understand *why* this particular change works around
> > the issue. Please elaborate.
>
> When I removed the memset, and booted to efi_decompress_kernel, the
> boot service crashed, and it indicated that the memory region from _bss
> to the end of boot_heap cannot be overwritten. Upon inspecting the data
> in the BSS region found one thing is that the _bss address is not fixed on
> each boot (when the MOR bit is set to 1), and it changes randomly.
>
> For example, in normal boot the _bss address is 0xffee0000, if I set MOR
> to 1, then the address shifts to 0xff990000 or 0xff991000 or
>  0xff993000. I cannot predict which will be the starting address for the
> next boot.
>
> Since the entire BSS region was not cleaned, and it contains zeros and
> other data, so I tried to increase the boot_stack size by 0x3000 to
> cover the 'fragile' part.
>

This is not a proper fix. As I indicated in my previous reply, even if
you omit the memset() of BSS, the running code will still treat it as
usable memory, whereas the memory is already allocated for something
else.

> > My preliminary conclusion here is that your implementation of the EFI
> > handover protocol (which I fail to understand where it comes from) is
> > not allocating enough memory. This should be fixed on the bootloader
> > side, as not clearing the BSS does not prevent this memory from being
> > corrupted.
>
> I understand that the handover protocol is nearing the end of its support
> and it seems I am only one experiencing the issue. However,
> from the perspective of backward compatibility, I think this patch maybe
> useful.
>

Again, this is not an issue in the implementation of the EFI handover
protocol. It is an issue in the implementation of the bootloader.

I filed an issue with systemd here:
https://github.com/systemd/systemd/issues/33816

I will not consider this patch for the kernel - please work with
systemd upstream and/or your downstream to clarify why the EFI
handover protocol is being used to begin with, and get it fixed in
your code base.

