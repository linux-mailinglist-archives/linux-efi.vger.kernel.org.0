Return-Path: <linux-efi+bounces-2104-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1D9B9A99
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 23:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420041C215E1
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBA1E1C32;
	Fri,  1 Nov 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rs3kktdW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oF1urBdt"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3E19B3E3;
	Fri,  1 Nov 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730498696; cv=none; b=Jf3GBZyBcyJkPsZfFoEBWle4BnQ/TkRU5NXiikK+ClZHeD0tLoi9ymw5hDYn2UGauajXJLf7JYSWrBOu9A33olzjSb9tXVA+NtjNtg1/qvZkbt4Q+8YMGatR4HxHLJug8ImOAH5UyOSasegkoooaGuiOXkwnIpLItbBMknX5kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730498696; c=relaxed/simple;
	bh=QncVU8uziTGJ31abPpC9PuvrWeZ0gbX4VP4kgoqI/Mw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DtUPBnrNW15Ka8JGP02WlxwDrp8nI/d9mRegR1YT6w2ykbFnDUzU+nSo7P0HsE4ipS5FBdi6KfVABi5uLlknAA+IlgNR7C0ZmH5sgHXcLS0EojTSOwwpeRCFGWpSSpEIl7cXrl3v8nFvGYkEV5LqvYS/9a8JYAuVCGVSVvRq6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rs3kktdW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oF1urBdt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730498692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCede5LVGfjUHXIUEvO/z1zpCc7zqLUZ75s6lun7nCY=;
	b=Rs3kktdWk1lN32PUJ7bpKRqaI11W6TOARxQ7M8IZg85h0hLj8BpU2d8RkiS45aZMUyj1SP
	g7D8XYE7FQdz0rBPLhapHRw7jAYH329IqfssC+tl5X+UAwMpLdcZ8mtwDBdWImq7YWeCHV
	E69hG/E7sMUbLpd0OwnHa/lKJMzyj29gylBqqr8mFQwSUd83ijMkNhIFqIsxXzXtHeIEeY
	WxzwNQP3iECYYKDGS9YRD5NqFBn0PXekZn98GCVyQpl/aLmgtc30iQWryd5Zr9med2khgR
	/QSNouVebLs8VzjX1uu0X7pddyTzpIsuugIxW2Ac4HVRRutyjeVneaZnhAT3cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730498692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCede5LVGfjUHXIUEvO/z1zpCc7zqLUZ75s6lun7nCY=;
	b=oF1urBdtwwN3U5Xd6xbkDqyj0L2KGcSI0vNXOshMgQsBWuRvFH9dDh2NfemcPFvzI2hSoY
	KbIRqufKcA+Se/CA==
To: Jarkko Sakkinen <jarkko@kernel.org>, Jarkko Sakkinen
 <jarkko@kernel.org>, Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
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
In-Reply-To: <D5B5MLX1C8TS.2U6YPCYBWBTYT@kernel.org>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org> <87a5eivgku.ffs@tglx>
 <D5B5I0WUU8F0.30JMZ6QHPOFRK@kernel.org>
 <D5B5MLX1C8TS.2U6YPCYBWBTYT@kernel.org>
Date: Fri, 01 Nov 2024 23:04:51 +0100
Message-ID: <87msiitxto.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 01 2024 at 23:19, Jarkko Sakkinen wrote:
> On Fri Nov 1, 2024 at 11:13 PM EET, Jarkko Sakkinen wrote:
>> I think we can sort them out independently as long as we find a
>> conclusion how to address locality change.
>
> And to be fair: there was no reaction from anyone. It is mostly x86
> patch set, meaning that I was waiting for some reaction first from that
> side.  And I did respond to that when it came.

The x86 side is mostly self contained, so the damage there is minimal,
but the TPM parts are changing the generic operations and the x86 parts
depend on them.

So let's not create a chicken and egg problem and solve the TPM parts,
which at my cursory glance are partially legitimate fixes, independent
of the actual trenchboot x86 functionality.

Thanks,

        tglx

