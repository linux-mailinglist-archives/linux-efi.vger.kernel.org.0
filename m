Return-Path: <linux-efi+bounces-1162-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F78FBF40
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 00:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB007B21D43
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B914C58A;
	Tue,  4 Jun 2024 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFeyzMlR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B914B949;
	Tue,  4 Jun 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541125; cv=none; b=H8xDd5qYPsYrvjSEoV0jw1r8AEXUpM0pYkugCdLuE78UO539tzUGFNsamqJztt9ofVmYRlN27Z5hfoQzLgY5r7sY+XZUlXW+KFncUmerYH+m8LqcObDOAO+YQjJ6XN/gybzxLTiRa7tdB/TCCrTwWA5bWt1lImOlv4f7fSwGId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541125; c=relaxed/simple;
	bh=vmwgl3zb5GwugKm/0kI5Ycgx5K1eWtsRadlAFG9jCEg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cKJTfhQAONB6vNyLyVMcSdGAKQBGT1K5h/ntki32wjRKiJQ9jSAsz0EZZ2/AMqg8gl6O0g7J+xWKtT1oVKsNGy0OyTCbU3IN1k7gzgA4sCU1d0jls6zUSIvo8Olcixv526uYWuXYBxQ8QK9/dq/HN/rMymC5VENVCo7r5KUm2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFeyzMlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBA8C2BBFC;
	Tue,  4 Jun 2024 22:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717541124;
	bh=vmwgl3zb5GwugKm/0kI5Ycgx5K1eWtsRadlAFG9jCEg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JFeyzMlRXTSfz/QVeYxAWWA3ecajRWRcu2x/hCPGOjdqksy/7sxTpTcwyrWYsvf8z
	 D1kNpIdcFEy9C5HvSq0AYe0nP2OSMFiwRY5nHbePAS/1DPrlrTUsj/5bq01CYLKiAc
	 AoHFnKttwRz8T0YeX3NXPZQ+d1ADIHF+1ydqge/dIpjRgeqXTLsuv3WMlNWC0PHMBP
	 JCgzMxzkrzSjItkxQ73IG8lw1iv6nqAXAXOr4YB/cXHeYU47NhcpHkFXNmOTFJrBh3
	 3nwnW9ZNPx3Hab96uR+M0N3IEv+VxdrIgrd+Z+SLgD2WRWUksR2Gb0o23hN99W5Bgq
	 EBGFa+L/8J4cQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 01:45:17 +0300
Message-Id: <D1RLIGJ6FYTA.4JNBEUEDEY9P@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 09/19] x86: Secure Launch kernel late boot stub
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-10-ross.philipson@oracle.com>
 <D1RHYMFSVGSW.39IL7KFK8A47N@kernel.org>
 <e066d250-b657-472f-ad27-585a64a51a9f@oracle.com>
In-Reply-To: <e066d250-b657-472f-ad27-585a64a51a9f@oracle.com>

On Wed Jun 5, 2024 at 12:16 AM EEST,  wrote:
> On 6/4/24 12:58 PM, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >> The routine slaunch_setup is called out of the x86 specific setup_arch=
()
> >> routine during early kernel boot. After determining what platform is
> >> present, various operations specific to that platform occur. This
> >> includes finalizing setting for the platform late launch and verifying
> >> that memory protections are in place.
> >=20
> > "memory protections" is not too helpful tbh.
> >=20
> > Better to describe very briefly the VT-d usage.
>
> We can enhance the commit message and talk about VT-d usage and what=20
> PMRs are and do.

Yep, pointing out exact things that you're dealing with is even more
useful once the feature has landed.

After some months one tends to start forgetting things, so it is good
to use commit messages as clues and reminders of essential concepts.

BR, Jarkko

