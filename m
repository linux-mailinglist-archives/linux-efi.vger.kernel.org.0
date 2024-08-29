Return-Path: <linux-efi+bounces-1622-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD979638D3
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 05:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262FB1C21E40
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B233D55D;
	Thu, 29 Aug 2024 03:34:39 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1099200CB;
	Thu, 29 Aug 2024 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.126.240.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902479; cv=none; b=IPIiJt5q8CP4xkKUUhQilQClBFDXSvkZ5IfrwVyplrSa2NGhH2zotVdReW7glQCOxqCfvnxcYaOohuAcdJWoIpCKLGnzgJKI9PwTkoAK32C8XeJ+AzQsMF3mCtHUuqRiEXO39TkpYgLQZcm1zawBZxMUW9K+xTIiDp/QLj+gcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902479; c=relaxed/simple;
	bh=qHdRA0U04mt92W2CO9LLoiFZR6iRhXsbHyIqb5u5k2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz7bO5/MxuWbMeYjw/UMvlayDSnLWKkOF8xDWFA4IE8cR68v539ePbox/uv6X1hqDruPAxi9mMPiaubkj93eCjwGxVXtOq7/cq1hdf56DowOrQwP0zyj52VDoAwAZgcxmV7rSXnBnfztOLvCWUqhZAlj/nahQOrElChE48CAh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=codon.org.uk; arc=none smtp.client-ip=176.126.240.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 1FEBF407E6; Thu, 29 Aug 2024 04:25:26 +0100 (BST)
Date: Thu, 29 Aug 2024 04:25:26 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <Zs/qJsKu3StL3Wzt@srcf.ucam.org>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>

On Wed, Aug 28, 2024 at 08:17:05PM -0700, Andy Lutomirski wrote:

> Ross et al, can you confirm that your code actually, at least by
> default and with a monstrous warning to anyone who tries to change the
> default, caps SHA1 PCRs if SHA256 is available?  And then can we maybe
> all stop hassling the people trying to develop this series about the
> fact that they're doing their best with the obnoxious system that the
> TPM designers gave them?

Presumably this would be dependent upon non-SHA1 banks being enabled?

