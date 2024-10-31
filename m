Return-Path: <linux-efi+bounces-2084-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759EA9B86A9
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 00:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C25B210FD
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 23:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8D1E0DE5;
	Thu, 31 Oct 2024 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="se5Xgp53";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s6ZB5YV2"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8E1CDFB4;
	Thu, 31 Oct 2024 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416123; cv=none; b=GiaRLycDh9WSpKchxfwNjiZLSt3tmvukd4EyCuQhZVTSb7BwRVfnh5+QpCcZ8fE91Aag+9oVcK/KBFxgqfPlBYHHHtSgGBl2MbsudGSbvzc+rDkqkHHAMMJsZcBcn7zvX8sAramupxPzaNxwiILMXOU7kDEbfJAsvQr/JLn2T6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416123; c=relaxed/simple;
	bh=t5kudjeNUZ1aRqDlkJODNg0WxGYF3b7fXMYAj3ZS57k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jwvvumgdzqOyrqKizuv6bDy9fEy2qrWWcVFkUfeGZmfs6m/3/BHdmerNyfOxVFU3WljwVxe5K1o259gYHQSjilMwasLijIHOOoJJ6RhHgCGDeBTwo5BQxXxTC43kVzJ+If1n9AnOnQZJUG3aY9ZYuTKsS2vOzj6S1cVSgX38Ksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=se5Xgp53; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s6ZB5YV2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730416115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X43PY2/hEbcwBt7Pbr1N5jc7wEXE8dAimnVrIUPcOUE=;
	b=se5Xgp53tVB20jyRaaH2iLjXvXwdVsngVIXx9grBEo+lfKa20ugZbbEHcGZhaUpww0RoiY
	EXWxDRXyp/5faxfVpX5j/HOnWJYwef48MKnqdLSdvRM+SzcC1UZFRSJg9BI8kwdSD2BHp/
	nhk3F3EKXMN6sHSp0wCKuprK38Y4dIXmLxkF/8Q9LaxZMHrSg3gXcdsJN+btBRaSTYSPph
	5blEOt0hGuEUHTfEFiNEXw+ofxhlFgZ17QaVFDdq27ezhnrMNksI+PJWPa+WgTBVDwz/5o
	yOoLg/budsRsV6AywMk3nLc/CDR9rIfvLZDG/1VMgbwz7rZxbiTVpKZTIKOAkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730416115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X43PY2/hEbcwBt7Pbr1N5jc7wEXE8dAimnVrIUPcOUE=;
	b=s6ZB5YV2NU3xPp/8Y/vclO3GDuEX/ui6tits119rcH2YQb1nCQFRLUCWuey0wof92SceYv
	CsFSTGLmEip3OrDg==
To: Jarkko Sakkinen <jarkko@kernel.org>, Ross Philipson
 <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
In-Reply-To: <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
Date: Fri, 01 Nov 2024 00:08:34 +0100
Message-ID: <87ldy3vpjh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 01 2024 at 00:37, Jarkko Sakkinen wrote:
> On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
>> So this looks pretty reasonable to me by now and I'm inclined to take it
>> through the tip x86 tree, but that needs reviewed/acked-by's from the
>> crypto and TPM folks. EFI has been reviewed already.
>>
>> Can we make progress on this please?
>
> So TPM patches do have bunch of glitches:
>
> - 15/20: I don't get this. There is nothing to report unless tree
>   is falling. The reported-by tag literally meaningless. Maybe this
>   is something that makes sense with this feature. Explain from that
>   angle.
> - 16/20: Is this actually a bug fix? If it is should be before 15/20.
> - 17/20: the commit message could do a better job explaining how the
>   locality can vary. I'm not sure how this will be used by rest of
>   the patch set.
> - 18/20: I'm not confident we want to give privilege to set locality
>   to the user space. The commit message neither makes a case of this.
>   Has this been tested to together with bus encryption (just checking)?

Can you please explicitely voice your detailed technical concerns in
replies to the actual patches?

Thanks,

        tglx

