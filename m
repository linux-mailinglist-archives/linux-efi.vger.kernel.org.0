Return-Path: <linux-efi+bounces-2238-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542389DEB6B
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C4CB209B4
	for <lists+linux-efi@lfdr.de>; Fri, 29 Nov 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C23146D59;
	Fri, 29 Nov 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tye4+Wyc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF292C18C;
	Fri, 29 Nov 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899810; cv=none; b=bA+oVvEprlyyoEYn5msYkd3qKHgDqcsXvIapCVew0RbUO+xQnR62FeEv3XccQBUmouKtNjgQdrOgg8W9MuA+oqpCS/QpQALiEGSLvIUWJa90M7G9pP4AndjPqPuiEtaniLdSSx/9jR0CMLbUdhJ+A7meTatgaOslmkOvu8RhMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899810; c=relaxed/simple;
	bh=aT6HpKP/0fyEHI0Q3ZmEu36cwBE9d+nL15fPzclz0aM=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:CC:From:To:
	 References:In-Reply-To; b=s7dBFj7uTnE5kSDvMf3pYBh7EGTUpxqdPndA9qzhEIFf/9ivPVwcSI+anfwgmaxMy1Wo87CNRYqjdTYIGKSlXIjfB6ViyRg9eBf6Fg7+nm8pkbPbMKQ0USP2+KtbFzOnFdITx4+4z6YLlRv4G7sV+l95lK83mGhh9MKQdk9/8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tye4+Wyc; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732899809; x=1764435809;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject;
  bh=NtnAJBiaXOZ9zNEkjDYjYXdU6aFjbbL/ZqV4zjqWvX8=;
  b=Tye4+WycvlJzScatYnPrLY4sA6FGwVgD6I8vSlWn4oln6CI3pJXpEJDV
   W1e482tN80UuqrYEyjjQoiYbEsMGvk6JNBYTi9UoaEn5WxOy2FRFiOth2
   xwt0Hcupd3BrrYlBSt0qtWDm2bc0bZuSvXwuCZFFDCshFD3lKnwZCwq3u
   A=;
X-IronPort-AV: E=Sophos;i="6.12,196,1728950400"; 
   d="scan'208";a="356747171"
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 17:03:25 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:37136]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.13:2525] with esmtp (Farcaster)
 id 47e3b7c1-6e2d-419d-82e4-56743fc7e28b; Fri, 29 Nov 2024 17:03:23 +0000 (UTC)
X-Farcaster-Flow-ID: 47e3b7c1-6e2d-419d-82e4-56743fc7e28b
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 29 Nov 2024 17:03:22 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Fri, 29 Nov 2024
 17:03:18 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Nov 2024 17:03:15 +0000
Message-ID: <D5YTPJS0CBZE.3I95FH2WL1ZJK@amazon.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stanspas@amazon.de>, <nh-open-source@amazon.com>, <stable@vger.kernel.org>,
	<kexec@lists.infradead.org>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Dave Young <dyoung@redhat.com>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <20241112185217.48792-1-nsaenz@amazon.com>
 <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
 <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
 <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
 <CALu+AoTAQ_v7SL-_c_F74TfXWmwYMNV_MRD9zWVyiHuXfa6WtA@mail.gmail.com>
In-Reply-To: <CALu+AoTAQ_v7SL-_c_F74TfXWmwYMNV_MRD9zWVyiHuXfa6WtA@mail.gmail.com>
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Fri Nov 29, 2024 at 7:31 AM UTC, Dave Young wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
>
>
>
> On Fri, 29 Nov 2024 at 15:11, Dave Young <dyoung@redhat.com> wrote:
>>
>> Hi Nicolas,
>>
>> On Thu, 28 Nov 2024 at 23:58, Nicolas Saenz Julienne <nsaenz@amazon.com>=
 wrote:
>> >
>> > Hi Dave,
>> >
>> > On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
>> > > On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.=
com> wrote:
>> > >>
>> > >> Kexec bypasses EFI's switch to virtual mode. In exchange, it has it=
s own
>> > >> routine, kexec_enter_virtual_mode(), which replays the mappings mad=
e by
>> > >> the original kernel. Unfortunately, that function fails to reinstat=
e
>> > >> EFI's memory attributes, which would've otherwise been set after
>> > >> entering virtual mode. Remediate this by calling
>> > >> efi_runtime_update_mappings() within kexec's routine.
>> > >
>> > > In the function __map_region(), there are playing with the flags
>> > > similar to the efi_runtime_update_mappings though it looks a little
>> > > different.  Is this extra callback really necessary?
>> >
>> > EFI Memory attributes aren't tracked through
>> > `/sys/firmware/efi/runtime-map`, and as such, whatever happens in
>> > `__map_region()` after kexec will not honor them.
>>
>> From the comment below the reason to do the mappings update is that
>> firmware could perform some fixups.  But for kexec case I think doing
>> the mapping correctly in the mapping code would be good enough.
>>
>>         /*
>>          * Apply more restrictive page table mapping attributes now that
>>          * SVAM() has been called and the firmware has performed all
>>          * necessary relocation fixups for the new virtual addresses.
>>          */
>>         efi_runtime_update_mappings();
>>
>> Otherwise /sys/firmware/efi/runtime-map is a copy for kexec-tools to
>> create the virtual efi memmap,  but I think the __map_region is called
>> after kexecing into the 2nd kernel, so I feel that at that time the
>> mem attr table should be usable.
>
> Another thing I'm not sure why the updated mem attr is not stored in
> the memmap md descriptor "attribute" field, if that is possible then
> the runtime-map will carry them,  anyway, the __map_region still needs
> tweaking to use the attribute.

AFAIK there isn't a technical reason we why couldn't do it through the
runtime-map, but it's annoying to do so because EFI Memory Attributes
are allowed to segment EFI memory regions into smaller sections with
distinct attributes. We'd have to carefully update the kernel's
representation of the EFI runtime memory map as we apply the attributes
(the one that's ultimately used to populate
`/sys/firmware/efi/runtime-map`).

On the other hand, the config table and memory region that holds the
attributes is already being persisted through kexec, so using it is
straightforward.

Nicolas

