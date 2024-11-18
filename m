Return-Path: <linux-efi+bounces-2167-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2075D9D0EFD
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2024 11:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A06E1F22188
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2024 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1AF198A1A;
	Mon, 18 Nov 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fMbqfWZb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D8194C6F;
	Mon, 18 Nov 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927190; cv=none; b=GSwqhhMe7WdZAAPYnuGKcRpjHiBtH6gssIa2YZzvUGP7VHNV5Af17fMv3VNZHCBpkBkPang6si57ivk6iOLBcgbSuQCu8TD3KBTTPQhbModksY16Dp57Vb0x3P8kYTon/oWSzqlRwfW2XjvG5+ojE/aOGLeNASoiU0bgdojS9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927190; c=relaxed/simple;
	bh=+x9gh2Y5UcQuq8aK2A9oGJ1F6zkRC9ZHYRXLcWailTY=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:CC:From:To:
	 References:In-Reply-To; b=J/y6REugz8ulayuu2stOtuTUIbvz3mYD31V9it6gcHdeIn5KOdtQ5IundRfQvWD3j/+skI0OkODRvAhsj1hG5+ipsRVvw5GVxSs/S15doay+hf12u25OH47ftNjlaWEA9Q2cQVVZSoqO8FdCC2PtOpSyIToYUnqjdmUMouuFY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fMbqfWZb; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731927189; x=1763463189;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject;
  bh=+x9gh2Y5UcQuq8aK2A9oGJ1F6zkRC9ZHYRXLcWailTY=;
  b=fMbqfWZbJeocjYY4bYz5kM0yjX4lViqld/qPJzFeoc6IkrMe0wbfzD3G
   O8dEOuaJGToPwgd1mpQla7MLD6rrD/ftRVnJrkQNJ9eTsv334vGkN1zW1
   gYpri1NStlIzwsi8gkG96d2nchHAlJodrw0gUJr6hjwelMZ4+1WHtXWCK
   w=;
X-IronPort-AV: E=Sophos;i="6.12,163,1728950400"; 
   d="scan'208";a="696016659"
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 10:53:05 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:44201]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.18.131:2525] with esmtp (Farcaster)
 id faa7a066-a7f2-435f-ad58-ea2403f89473; Mon, 18 Nov 2024 10:53:04 +0000 (UTC)
X-Farcaster-Flow-ID: faa7a066-a7f2-435f-ad58-ea2403f89473
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 18 Nov 2024 10:53:03 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 18 Nov 2024
 10:52:59 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Nov 2024 10:52:56 +0000
Message-ID: <D5P8Y0SCMRJZ.2VAI4IK2RCOAC@amazon.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Matt Fleming
	<matt@codeblueprint.co.uk>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stanspas@amazon.de>,
	<nh-open-source@amazon.com>, <stable@vger.kernel.org>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Ard Biesheuvel <ardb@kernel.org>
X-Mailer: aerc 0.18.2-87-gd0484b153aa5-dirty
References: <20241112185217.48792-1-nsaenz@amazon.com>
 <20241112185217.48792-2-nsaenz@amazon.com>
 <CAMj1kXGopsux6+xnsXW6vvQDJH9Y3_Ofq_QYvDa-SGt8AJ0nWQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGopsux6+xnsXW6vvQDJH9Y3_Ofq_QYvDa-SGt8AJ0nWQ@mail.gmail.com>
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Fri Nov 15, 2024 at 4:39 PM UTC, Ard Biesheuvel wrote:
> On Tue, 12 Nov 2024 at 19:53, Nicolas Saenz Julienne <nsaenz@amazon.com> =
wrote:
>>
>> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
>> routine, kexec_enter_virtual_mode(), which replays the mappings made by
>> the original kernel. Unfortunately, that function fails to reinstate
>> EFI's memory attributes, which would've otherwise been set after
>> entering virtual mode. Remediate this by calling
>> efi_runtime_update_mappings() within kexec's routine.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 18141e89a76c ("x86/efi: Add support for EFI_MEMORY_ATTRIBUTES_TAB=
LE")
>> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
>>
>> ---
>>
>> Notes:
>> - Tested with QEMU/OVMF.
>>
>
>
> I'll queue these up,

Thanks!

> but I am going drop the cc stable: the memory attributes table is an
> overlay of the EFI memory map with restricted permissions for EFI
> runtime services regions, which are only mapped while a EFI runtime
> call is in progress.
>
> So if the table is not taken into account after kexec, the runtime
> code and data mappings will all be RWX but I think this is a situation
> we can live with. If nothing breaks, we can always revisit this later
> if there is an actual need.

My intention was backporting the fix all the way to
'stable/linux-5.10.y'. But I'm happy to wait, or even to maintain an
internal backport. It's simple enough.

Nicolas

