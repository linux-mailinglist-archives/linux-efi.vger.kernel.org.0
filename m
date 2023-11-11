Return-Path: <linux-efi+bounces-43-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D27E8C9A
	for <lists+linux-efi@lfdr.de>; Sat, 11 Nov 2023 21:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A659E280E03
	for <lists+linux-efi@lfdr.de>; Sat, 11 Nov 2023 20:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23606FCA;
	Sat, 11 Nov 2023 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="WTKYSRyG";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="WTKYSRyG"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2626FBE;
	Sat, 11 Nov 2023 20:36:37 +0000 (UTC)
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26EFD72;
	Sat, 11 Nov 2023 12:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1699734993;
	bh=ON6trIcp7+DuqniQpmZTvh3ZoJcgh3VkSs5gIMRrdsU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=WTKYSRyGsv4eOSdLugUtX+cv+QbiPhjvvPrjnW6sMArcM4T1WD6UeH9iTOwjh3jSy
	 iDmBEDpKUiUTUzOc+RxDoRUhRi+yd4bObhI4YYIWNXPtmKxefuQmnf3XHKNGuj24PY
	 3sDecx94xUTHeTf5WpLpoRx7VMq4BuZeD5vV7GLA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3BB58128609B;
	Sat, 11 Nov 2023 15:36:33 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id z2rW164A0x_h; Sat, 11 Nov 2023 15:36:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1699734993;
	bh=ON6trIcp7+DuqniQpmZTvh3ZoJcgh3VkSs5gIMRrdsU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=WTKYSRyGsv4eOSdLugUtX+cv+QbiPhjvvPrjnW6sMArcM4T1WD6UeH9iTOwjh3jSy
	 iDmBEDpKUiUTUzOc+RxDoRUhRi+yd4bObhI4YYIWNXPtmKxefuQmnf3XHKNGuj24PY
	 3sDecx94xUTHeTf5WpLpoRx7VMq4BuZeD5vV7GLA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 33B2B1286097;
	Sat, 11 Nov 2023 15:36:31 -0500 (EST)
Message-ID: <87f56530b85ea894036a74be1824d6f2716f70de.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 06/13] x86: Add early SHA support for Secure Launch
 early measurements
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Eric Biggers
	 <ebiggers@kernel.org>, Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org, 
 kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de,  hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 luto@amacapital.net,  nivedita@alum.mit.edu, kanth.ghatraju@oracle.com, 
 trenchboot-devel@googlegroups.com
Date: Sat, 11 Nov 2023 15:36:29 -0500
In-Reply-To: <a16d44c5-2e1a-4e9a-8ca1-c7ca564f61cd@citrix.com>
References: <20231110222751.219836-1-ross.philipson@oracle.com>
	 <20231110222751.219836-7-ross.philipson@oracle.com>
	 <20231111174435.GA998@sol.localdomain>
	 <a16d44c5-2e1a-4e9a-8ca1-c7ca564f61cd@citrix.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2023-11-11 at 18:19 +0000, Andrew Cooper wrote:
> On 11/11/2023 5:44 pm, Eric Biggers wrote:
> > On Fri, Nov 10, 2023 at 05:27:44PM -0500, Ross Philipson wrote:
> > >  arch/x86/boot/compressed/early_sha1.c   | 12 ++++
> > >  lib/crypto/sha1.c                       | 81
> > > +++++++++++++++++++++++++
> > It's surprising to still see this new use of SHA-1 after so many
> > people objected to it in the v6 patchset.  It's also frustrating
> > that the SHA-1 support is still being obfuscated by being combined
> > in one patch with SHA-2 support, perhaps in an attempt to conflate
> > the two algorithms and avoid having to give a rationale for the
> > inclusion of SHA-1.  Finally, new functions should not be added to
> > lib/crypto/sha1.c unless those functions have multiple users.
> 
> The rational was given.  Let me reiterate it.
> 
> There are real TPMs in the world that can't use SHA-2.  The use of
> SHA-1 is necessary to support DRTM on such systems, and there are
> real users of such configurations.

Given that TPM 2.0 has been shipping in bulk since Windows 10 (2015)
and is required for Windows 11 (2021), are there really such huge
numbers of TPM 1.2 systems involved in security functions?

> DRTM with SHA-1-only is a damnsight better than no DTRM, even if SHA-
> 1 is getting a little long in the tooth.

That's not the problem.  The problem is that sha1 is seen as a
compromised algorithm by NIST which began deprecating it in 2011 and is
now requiring it to be removed from all systems supplied to the US
government by 2030

https://www.nist.gov/news-events/news/2022/12/nist-retires-sha-1-cryptographic-algorithm

That means we have to control all uses of sha1 in the kernel and have
an option to build without it.  FIPS has an even tighter timetable: it
requires sha1 to be out by 2025.

> So unless you have a credible plan to upgrade every non-SHA-2 TPM in
> the world, you are deliberately breaking part of the usecase paying
> for the effort of trying to upstream DRTM support into Linux.

Given that most CSOs follow NIST and FIPS it seems a little strange
that there would be a huge demand for such an intricate security
protocol as Dynamic Launch on a system that can't be FIPS 140-3
certified.

James


