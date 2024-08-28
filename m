Return-Path: <linux-efi+bounces-1620-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D9696353D
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 01:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF6D1F2285B
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 23:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78681AD3F9;
	Wed, 28 Aug 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igkl3X+Y"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C000161914;
	Wed, 28 Aug 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886832; cv=none; b=HiiMJTWdFAmtaYL3wIt4QuN563m+6ZFD45TNdHe3xFe3Hz+Da+cjTH2cqCRwTOW+jnlzJv+USSD+InRkbhyyITPToH6D+/hh4bQuXb3DtG28zMkQrd5GRBsozag4BiyTcQdGzKY98t9ypT0rY0mO22XsDn5W7sOdYjEf6k61n0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886832; c=relaxed/simple;
	bh=QISJ42Va0eYxqFWZBmZo3tT+XOt9YziD/pQSoZRbBg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gurYLTzf0WrdidDXhR8LkD/MvzAH7mXyfA7ajNbQbfyiGf++QZJyjB8132t9c+SJymq930WtwmsheeEtaH+lrtxptwzGTfNB5U+3o+zdqH9CC/O/VjJUaubHvyQH4NJqvXe1xevIlJMvnjBnM86OdqfP3MmEVdOqB2b3gJ2dd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igkl3X+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E93BC4CEC0;
	Wed, 28 Aug 2024 23:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724886832;
	bh=QISJ42Va0eYxqFWZBmZo3tT+XOt9YziD/pQSoZRbBg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Igkl3X+YtPWt9lCblaUZzraFSdFxa54F4n2l+ehwjXqByzx1N8EEiLXby+Z8CfzZ8
	 7kzVqzb8dj1SXhUoZnGtY8B83J9xdiCwbXKuUdpBcevOBu7zDAdlF4il1Q5fte9o71
	 nmxNhsqDLPd36IPd35D5ImzYQ31N8WkReq8dF8zlJnD6n22lEPcHNNR/bxWxOYjj1Z
	 aFUyNy3WDAmPeW76D+8frUPREHFpIB07PDD9tNSXHzZMg6/+XpabrzvlGz742UtqW1
	 lM7HQIRrpnau/LYc6CLvEiTOSvR5JXx5Y5SdAfIwROoUCfXVwWxwhqEPETSQsl/I1G
	 qxqrLyHNPkFGA==
Date: Wed, 28 Aug 2024 23:13:50 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: ross.philipson@oracle.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <20240828231350.GA558903@google.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <20240827181426.GC2049@sol.localdomain>
 <601646a2-46ac-47a0-a8b7-1d45a09172ab@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <601646a2-46ac-47a0-a8b7-1d45a09172ab@oracle.com>

On Wed, Aug 28, 2024 at 01:14:45PM -0700, ross.philipson@oracle.com wrote:
> On 8/27/24 11:14 AM, 'Eric Biggers' via trenchboot-devel wrote:
> > On Thu, May 30, 2024 at 07:16:56PM -0700, Eric Biggers wrote:
> > > On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
> > > > From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> > > > 
> > > > For better or worse, Secure Launch needs SHA-1 and SHA-256. The
> > > > choice of hashes used lie with the platform firmware, not with
> > > > software, and is often outside of the users control.
> > > > 
> > > > Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> > > > with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> > > > the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> > > > to safely use SHA-256 for everything else.
> > > > 
> > > > The SHA-1 code here has its origins in the code from the main kernel:
> > > > 
> > > > commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> > > > 
> > > > A modified version of this code was introduced to the lib/crypto/sha1.c
> > > > to bring it in line with the SHA-256 code and allow it to be pulled into the
> > > > setup kernel in the same manner as SHA-256 is.
> > > > 
> > > > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > > 
> > > Thanks.  This explanation doesn't seem to have made it into the actual code or
> > > documentation.  Can you please get it into a more permanent location?
> > 
> > I see that a new version of the patchset was sent out but this suggestion was
> > not taken.  Are you planning to address it?
> 
> Sorry we sort of overlooked that part of the request. We will take the
> latest commit message, clean it up a little and put it in
> boot/compressed/sha1.c file as a comment. I believe that is what you would
> like us to do.
> 

Do users of this feature need to make a decision about SHA-1?  If so there needs
to be guidance in Documentation/.  A comment in a .c file is not user facing.

- Eric

