Return-Path: <linux-efi+bounces-2931-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32436A5720F
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCDB175D13
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF5A2561B1;
	Fri,  7 Mar 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW+40b7p"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A1255E58;
	Fri,  7 Mar 2025 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376245; cv=none; b=jisMhbIrzDhJQZoOUULRl0AfTaO5f664JB/gYb7xzUHvRbKeq5R0qooSfom7VsYuxmrlarJq8AT8CuM80KGfbhsqRrmQzUF6/brgd/gUVyU8i7ZjE5tlMLhX19Z2cfPmCOoKXKupDGoYU77aKkcIB0N5vY2S9ssssDa+Ac7+hXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376245; c=relaxed/simple;
	bh=gdJJj0Y+vIMQxl2pF/V+JeYln0YLxtYpZd3GhmHEoMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmv7EP3rU6XqaRIvU7lAfguNiuPcM562VIpCm2q2SKVIqUJyDTC6yLtK4Q0EE0wl7HisCdua8J8h/y0V8Xr1bPxMf4sGftYV+R+FEQS7JWHPZRUEiwmnKlxpxqCe+owgnuNWmJLDFrbwAlqnHpa1wWT6HvfHaawTj4JqBA8qoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW+40b7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1235C4CED1;
	Fri,  7 Mar 2025 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741376244;
	bh=gdJJj0Y+vIMQxl2pF/V+JeYln0YLxtYpZd3GhmHEoMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cW+40b7p32mLKFSwQhsZH6rP9RxyzfSQuk2cWhW6r7FcrXqRf7t+1NavLAixHCDG4
	 tof9vEYVEcENkLBBLXtmlDBX+SDWmcOYBOHaDYh08VYLXBxIjXD0MkSGyY1caOWHex
	 gqYREeYkVZ4FeBdglamBrrGdm3WTfLcNxQUA2aEREznnWqs0Ig19i1yFHKsTCdaFAa
	 Md1jAQLl3quoOYRr9qd+foB2MFdHcY2uo966ZYZ+X7uYPIqbEnJH6dcAThUvU7o4nD
	 YKqmoB5xskRqBVoPlBQTpvNJ7xJ9K5SEC6vZWKt4Swc61UgoQyMO3JQWvlOKkgPxSB
	 QQv1xCH3VauFg==
Date: Fri, 7 Mar 2025 21:37:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ross.philipson@oracle.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 04/19] x86: Secure Launch main header file
Message-ID: <Z8tK704hkyoZZc7_@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-5-ross.philipson@oracle.com>
 <Z8qFdeM8YEck2j1C@kernel.org>
 <d2adb4c4-b03f-4fbd-81c2-1cd017ed2822@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2adb4c4-b03f-4fbd-81c2-1cd017ed2822@oracle.com>

On Fri, Mar 07, 2025 at 11:25:20AM -0800, ross.philipson@oracle.com wrote:
> On 3/6/25 9:34 PM, 'Jarkko Sakkinen' via trenchboot-devel wrote:
> > On Thu, Dec 19, 2024 at 11:42:01AM -0800, Ross Philipson wrote:
> > > Introduce the main Secure Launch header file used in the early SL stub
> > > and the early setup code.
> > 
> > Just would need a *short* description of what slaunch.h holds. I guess
> > it holds Intel TXT micro-arhitectural data structures? Anything else?
> 
> Later it will contain data strutures etc. to support other architectures
> like AMD and Arm64.
> 
> > 
> > This helps e.g. reviewers to skip some but still keep on track what a
> > patch contains (and return back to it when necessary).
> 
> Yes we can make it clearer what is in this header file.

As per code changes I did spend two hours reading them just to make sure
that I can understand the TPM specific code changes, and also that they
make total sense to me.

Therefore I've put a lot the nagging is around documentation and
definitions. I really could not find anything in the source code that I
could pinpoint being absolutely wrong.

This really needs just now the stamp from tip maintainers. As per TPM
changes they do have my blessing (no need for reviewed-by's as they
have SOB already). I hereby also give permission to pull TPM changes
through tip tree...

> Thanks
> Ross

BR, Jarkko

