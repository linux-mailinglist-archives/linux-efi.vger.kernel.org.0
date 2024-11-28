Return-Path: <linux-efi+bounces-2231-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B59DBAF1
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 16:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7800B229D6
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2081BD9CF;
	Thu, 28 Nov 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TSix07Kq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779711AA1D5;
	Thu, 28 Nov 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809498; cv=none; b=sj4bCZ+s9IK0azmS5qhlpvAFg8xUn/bTLeyWPOr00WJuSXOAyelK22h5w/RGeQ3oAZ5HI/0TT92MTHdQpf5rY4iA0ZJfQDwt9FhP0pxW28p3hqaQAGpc0gjb/zqiCmiaEnGXKZHgwb6785eSdvUjPEHuy512nLr8ehFG/D7hW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809498; c=relaxed/simple;
	bh=wzhPYq6ef+ZWDFaSZXznhUC64rBsiaZOuaBa3TgCewE=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:From:To:CC:
	 References:In-Reply-To; b=hwrJ0rRQSE5wU1f8Pha+7ecgbmLSskhZtRtNjGHiE2PmrAc4cND1YmSmZNXQwSPWEJMXuDGHmcQhEYCqkSgjNPJIJ9NTxmlm94WrHInFvnT/5oF1eJ3FJ1/yVPGsKs6FyRSIJqk38E4DVZ/QGtL8FpLJLgg+8XuNqHNepl3Sk2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TSix07Kq; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732809498; x=1764345498;
  h=mime-version:content-transfer-encoding:date:message-id:
   subject:from:to:cc:references:in-reply-to;
  bh=z2xmP1cZOfYevSvzD/k3N5akpqcpBaaiEKDmAcJtr6A=;
  b=TSix07Kqv5QTzvpUjF/NtmQnTRHuTFTATf+YJ8GJhpNruxxtXoghIrPP
   N7mK0bm1FxnOEveYVXNeHo0qMu3Zb+NpN/JSZ448MZlcOgtWhd0E5VZVx
   o1ZEB56X3n5uTjshddimi83QNsKCw2TwofiFtB91wmPnzpuct6BrtZOyB
   0=;
X-IronPort-AV: E=Sophos;i="6.12,192,1728950400"; 
   d="scan'208";a="389106589"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 15:58:11 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:12251]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.116:2525] with esmtp (Farcaster)
 id aa97e48e-099c-4014-b6d4-1285e8d7c9c0; Thu, 28 Nov 2024 15:58:10 +0000 (UTC)
X-Farcaster-Flow-ID: aa97e48e-099c-4014-b6d4-1285e8d7c9c0
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 15:58:10 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Thu, 28 Nov 2024
 15:58:05 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Nov 2024 15:58:02 +0000
Message-ID: <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Dave Young <dyoung@redhat.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stanspas@amazon.de>, <nh-open-source@amazon.com>, <stable@vger.kernel.org>,
	<kexec@lists.infradead.org>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <20241112185217.48792-1-nsaenz@amazon.com>
 <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
In-Reply-To: <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Hi Dave,

On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
> On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> =
wrote:
>>
>> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
>> routine, kexec_enter_virtual_mode(), which replays the mappings made by
>> the original kernel. Unfortunately, that function fails to reinstate
>> EFI's memory attributes, which would've otherwise been set after
>> entering virtual mode. Remediate this by calling
>> efi_runtime_update_mappings() within kexec's routine.
>
> In the function __map_region(), there are playing with the flags
> similar to the efi_runtime_update_mappings though it looks a little
> different.  Is this extra callback really necessary?

EFI Memory attributes aren't tracked through
`/sys/firmware/efi/runtime-map`, and as such, whatever happens in
`__map_region()` after kexec will not honor them.

> Have you seen a real bug happened?

If lowered security posture after kexec counts as a bug, yes. The system
remains stable otherwise.

Nicolas

