Return-Path: <linux-efi+bounces-2136-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123799C515F
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 10:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB28F2830EE
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588AF20B1FD;
	Tue, 12 Nov 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S7lDCzpf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5920A5EE;
	Tue, 12 Nov 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402103; cv=none; b=cIok/KEc7+Bx1WtV7WSfIl/Xam2M7/xfu7t/jRuxOaXJc0Pu0l3lqjyMgryX8ENZq36Z3xcIMkDHcR0+VcPJvsKJM9EyT9oy7PH6Kn15BLSVfDBdJpEfFXww8PdFdiMnWfD48Y6nuoxDwn+asFqvvCG0CJMdSjYA2BePul1b9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402103; c=relaxed/simple;
	bh=Kf9QBcENFdC0558aV+iViXTK6quHo0qRh+2n5w3Wd/0=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:CC:From:To:
	 References:In-Reply-To; b=NZqvWbHixvgv45Rgn/v0ryP6iUIudEj1C1s2DlXg0kLojA+5z17XbgaD3yv4R8VUB7sX5ZMKMfA3xAjJjZdD9Mkj76crQXRwqOweH9WiV03MHg8ZRH5foWFp3GvpfFAu0kLdU4mX8iBjb+ncPWP3xoJC7KxvwDRXNRGJcQjRMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=S7lDCzpf; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731402101; x=1762938101;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject;
  bh=YNfHB93p38hWBtL9KXrBb3XP+Qqcdd6TVkTOXCt0xPw=;
  b=S7lDCzpfs9HoV5l09s8Z2C36b8kA8L9mlNte9rbxwxuyXbd6Y29RxXka
   kRvvSxrllzhCiYvkVOzjR+rGc9iNP2Dq/yPG1RbMsmXnwRUAhztdluLVG
   Zes7IVCt6mtX1+49OY9V5DPTnZ5IYfshZswEq82Ud+tsYlvkgrOUTUx49
   U=;
X-IronPort-AV: E=Sophos;i="6.12,147,1728950400"; 
   d="scan'208";a="146570377"
Subject: Re: [PATCH] x86/efi: Apply EFI Memory Attributes after kexec
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:01:39 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:14515]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.184:2525] with esmtp (Farcaster)
 id 1b523b47-3879-45e8-aeb5-029609f26c22; Tue, 12 Nov 2024 09:01:38 +0000 (UTC)
X-Farcaster-Flow-ID: 1b523b47-3879-45e8-aeb5-029609f26c22
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 09:01:38 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 12 Nov 2024
 09:01:34 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Nov 2024 09:01:30 +0000
Message-ID: <D5K2TFWWW4RA.11BRVB9L59S0V@amazon.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Sai Praneeth
	<sai.praneeth.prakhya@intel.com>, Matt Fleming <matt@codeblueprint.co.uk>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stanspas@amazon.de>, <nh-open-source@amazon.com>, <stable@vger.kernel.org>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Ard Biesheuvel <ardb@kernel.org>
X-Mailer: aerc 0.18.2-87-gd0484b153aa5-dirty
References: <20241111214527.18289-1-nsaenz@amazon.com>
 <CAMj1kXH2FRxwryJ9kz4CThWG_D30nW6g-UJzxW9uRQzBAZEetA@mail.gmail.com>
In-Reply-To: <CAMj1kXH2FRxwryJ9kz4CThWG_D30nW6g-UJzxW9uRQzBAZEetA@mail.gmail.com>
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Tue Nov 12, 2024 at 7:55 AM UTC, Ard Biesheuvel wrote:
> On Mon, 11 Nov 2024 at 22:45, Nicolas Saenz Julienne <nsaenz@amazon.com> =
wrote:
>>
>> - Although care is taken to make sure the memory backing the EFI Memory
>>   Attributes table is preserved during runtime and reachable after kexec
>>   (see efi_memattr_init()). I don't see the same happening for the EFI
>>   properties table. Maybe it's just unnecessary as there's an assumption
>>   that the table will fall in memory preserved during runtime? Or for
>>   another reason? Otherwise, we'd need to make sure it isn't possible to
>>   set EFI_NX_PE_DATA on kexec.
>
> Thanks.
>
> I think we should just drop support for the EFI_PROPERTIES_TABLE - it
> was a failed, short-lived experiment that broke the boot on both Linux
> and Windows, and was replaced with the memory attributes table shortly
> after.

Isn't there a tiny posibility some platorm might be using the feature?
Otherwise I'll send a v2 right away.

Nicolas

