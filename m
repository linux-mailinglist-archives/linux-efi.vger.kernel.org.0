Return-Path: <linux-efi+bounces-2219-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8739DABB9
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2024 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87797B246F8
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8031FE45B;
	Wed, 27 Nov 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZnEs2k10";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZnEs2k10"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7EA200BAA;
	Wed, 27 Nov 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724647; cv=none; b=EOVDM8UraiFbMKTqzFUawrZEeT9RRJO33YpV9/diduaNZ8wiCsPwwyM9hrSMoJ+NYzLkLah8EAZgDPy7xWrd4cX2hMgRcUrg5rosvxcBH+qSmGUYW297TP1NYCJ9epjVnBD+hj4dyOfYLnsRBOU86u0ZwrHndjuiOBT6TJ1utoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724647; c=relaxed/simple;
	bh=I2wTDpQvi1jEM2W3bnEJtAgPbOoW+MQVhlA1D+Hi76M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c7wWKatWMX+NWXJB4vT4aF1M/8NmGucDZSf3aET/RNc0Og6eGRfdmKtjTemQpajvAb51fIfss8RDV3cwm4F0ed65XaP8hTxYPQZJo1Nue7yraBwHLssnd1qlw0FkwCt0qnpR1puh5f97xxU4n6oF7Ut7pnBNuZtb40MgA5DCwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZnEs2k10; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZnEs2k10; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1732724644;
	bh=I2wTDpQvi1jEM2W3bnEJtAgPbOoW+MQVhlA1D+Hi76M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZnEs2k107IERJUalfXr5ISgXvB8UL+rYk5U+oiM4Av2A74iUqzNvYB5suBpEXM04d
	 UI7vfGblnpqWJposiG/Yw8f93LZtVHYlSmE8YCDvHEna+hMx+DFv25r+rrJLUH3LQS
	 Qp2Ro/x+d7gNqR8KLm7tCSpYQdl1WxpWRtby9YZk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 788F7128799D;
	Wed, 27 Nov 2024 11:24:04 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id HWVf5V4tu0lo; Wed, 27 Nov 2024 11:24:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1732724644;
	bh=I2wTDpQvi1jEM2W3bnEJtAgPbOoW+MQVhlA1D+Hi76M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZnEs2k107IERJUalfXr5ISgXvB8UL+rYk5U+oiM4Av2A74iUqzNvYB5suBpEXM04d
	 UI7vfGblnpqWJposiG/Yw8f93LZtVHYlSmE8YCDvHEna+hMx+DFv25r+rrJLUH3LQS
	 Qp2Ro/x+d7gNqR8KLm7tCSpYQdl1WxpWRtby9YZk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7B413128799C;
	Wed, 27 Nov 2024 11:24:03 -0500 (EST)
Message-ID: <ca741d8eade72aa68c389a88d2520f4fe541a1e7.camel@HansenPartnership.com>
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jiri Slaby <jirislaby@kernel.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
Cc: Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>, Jarkko Sakkinen
	 <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"linux-efi@vger.kernel.org"
	 <linux-efi@vger.kernel.org>
Date: Wed, 27 Nov 2024 11:24:01 -0500
In-Reply-To: <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
References: 
	<CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
	 <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-11-27 at 07:46 +0100, Jiri Slaby wrote:
> Cc TPM + EFI guys.
> 
> On 17. 11. 24, 23:26, Linus Torvalds wrote:
> > But before the merge window opens, please give this a quick test to
> > make sure we didn't mess anything up. The shortlog below gives you
> > the
> > summary for the last week, and nothing really jumps out at me. A
> > number of last-minute reverts, and some random fairly small fixes
> > fairly spread out in the tree.
> 
> Hi,
> 
> there is a subtle bug in 6.12 wrt TPM (in TPM, EFI, or perhaps in 
> something else):
> https://bugzilla.suse.com/show_bug.cgi?id=1233752
> 
> Our testing (openQA) fails with 6.12:
> https://openqa.opensuse.org/tests/4657304#step/trup_smoke/26
> 
> The last good is with 6.11.7:
> https://openqa.opensuse.org/tests/4648526
> 
> In sum:
> TPM is supposed to provide a key for decrypting the root partitition,
> but fails for some reason.
> 
> It's extremely hard (so far) to reproduce outside of openQA (esp.
> when 
> trying custom kernels).
> 
> Most of the 6.12 TPM stuff already ended in (good) 6.11.7. I tried to
> revert:
>    423893fcbe7e tpm: Disable TPM on tpm2_create_primary() failure
> from 6.12 but that still fails.
> 
> We are debugging this further, this is just so you know.
> 
> Or maybe you have some immediate ideas?

Well, it looks like you eliminated the TPM changes:

https://bugzilla.suse.com/show_bug.cgi?id=1233752#c6

So it must be something in the logging or event recording code.  The
first thing to check is can you run a replay of the log to get the end
PCR values?  The binary for that is

tsseventextend -sim -v -if
/sys/kernel/security/tpm0/binary_bios_measurements

You'll have to check the values it gives against the values in 

/sys/class/tpm/tpm0/tpm-sha256

Probably also check sha1 to see if it matches.

Regards,

James


