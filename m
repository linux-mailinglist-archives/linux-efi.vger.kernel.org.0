Return-Path: <linux-efi+bounces-6078-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBT9BdnXf2kIygIAu9opvQ
	(envelope-from <linux-efi+bounces-6078-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sun, 01 Feb 2026 23:46:49 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B4C7706
	for <lists+linux-efi@lfdr.de>; Sun, 01 Feb 2026 23:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E24B30011A6
	for <lists+linux-efi@lfdr.de>; Sun,  1 Feb 2026 22:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7501D2DC774;
	Sun,  1 Feb 2026 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="demddUI3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE131E1024;
	Sun,  1 Feb 2026 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986003; cv=none; b=Yeck7ivCkhSzKkpqKko2Y+upEy7DQre0XNKA5Y7RKBYyyKi2pryn2BumtLw9G7DOSAoN3ku2aJM/KBZFu/9fLVLPFJ1ogd//+U6+OEmkovbSwWZWrUpSSOVD6gMiFnTkefVBQjlmUx0gUlNyXzGEhVll6knBHg+z3uOCg5GroIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986003; c=relaxed/simple;
	bh=FCYpJl8EOX8GMWf4gm75QpFvBDwzIFIO8cA6R9Ty+Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJIVd+RVJ3T9mmRVTUPpEdogViVmzT4omayqcJI+fFdwZft7K89fzXd4MsFggS1h6P4i7EODw9Av/NYVzvkFLvsvm6HfWSB/d/FUwD7pl+37WOUPoUYs5EPQYUFMlkAKyYcPc1vqde1lEPxbXs+5I+j/YeNSeabJwk28CJlBBbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=demddUI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9944FC4CEF7;
	Sun,  1 Feb 2026 22:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769986003;
	bh=FCYpJl8EOX8GMWf4gm75QpFvBDwzIFIO8cA6R9Ty+Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=demddUI3kI/QRadXK8U7OSeKMbsdkhKJqfLguBHAca+Trk4VXSu0sJZCszhFvMfeF
	 QBhh4DkygaGFZjcREzGN+Gg3DGSZf4C9/aCNsy9ixHnDgHtnTp34sz+GtxNQ7YEfMx
	 uTogeujSiWcnvxxf/yJJ3NRK0/IJ2TBa4ES8Gre9M/GYhHOloTrh686VAzyxHSNW9+
	 azvzULdZsop3ti7N1x4mnbaRHfu4ahXro61ihGNaHMZVmrkqeHLxo6kSE7TEkw4xJq
	 G1VieqSHaz92qAYAL2qzNdThPFf0+IsKjI1kqbXL6ENmRTt0F3PXmIR+kMkQaJw9Wm
	 e2I9O5NDkD9Ww==
Date: Mon, 2 Feb 2026 00:46:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 01/28] tpm: Initial step to reorganize TPM public
 headers
Message-ID: <aX_Xz3ERMEb7GwK8@kernel.org>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-2-ross.philipson@oracle.com>
 <aW7A-4xJSzln1HtH@kernel.org>
 <b94815dc-fc4d-4073-bfd6-31ab99a6b85b@apertussolutions.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94815dc-fc4d-4073-bfd6-31ab99a6b85b@apertussolutions.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-6078-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apertussolutions.com:email]
X-Rspamd-Queue-Id: 297B4C7706
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 11:20:20AM -0500, Daniel P. Smith wrote:
> On 1/19/26 18:40, Jarkko Sakkinen wrote:
> > On Mon, Dec 15, 2025 at 03:32:49PM -0800, Ross Philipson wrote:
> > > Replace the existing public header tpm_command.h with the first two
> > > new public headers tpm1.h and tpm_common.h. In addition, related
> > > definitions in tpm1_cmd.c were moved to the new tpm1.h.
> > > 
> > > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > > ---
> > >   drivers/char/tpm/tpm-buf.c                |  3 +-
> > >   drivers/char/tpm/tpm1-cmd.c               | 13 +-----
> > >   include/keys/trusted_tpm.h                |  1 -
> > >   include/linux/tpm.h                       |  3 ++
> > >   include/linux/tpm1.h                      | 55 +++++++++++++++++++++++
> > >   include/linux/tpm_command.h               | 30 -------------
> > 
> > Removing tpm_command.h causes unnecessary noise.
> > 
> > It would be better to retain tpm_command.h, and simply supplement
> > it with TPM2 constants.
> > 
> > Also, what is the reason to not have both TPM1 and TPM2 in tpm.h?
> > 
> > To put the question in other words: is there something in tpm.h that
> > would be incompatible with early boot code?
> > 
> > I'd rather tweak that than have more files...
> 
> Every #include in tpm.h will break in the early boot code. I don't see any
> way to avoid having one header that is the device driver header that
> integrates with mainline features and at least one header that holds the
> general TPM definitions.
> 
> We will move everything that was broken out into tpm_command.h, making it
> the header with the general definitions. I would raise the question of
> whether tpm_command.h would be the best name of the file after definition
> reloactions

tpm_command.h conforms with lowest common denominator in the sense that
it in its current state it is compatible with early boot code.

I'd consolidate TPM1 and TPM2 definitions that can be shared to that
header. I guess rename is fine as long as protocol definitions are
not scattered to two headers.

BR, Jarkko

