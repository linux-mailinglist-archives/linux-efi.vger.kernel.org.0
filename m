Return-Path: <linux-efi+bounces-2799-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D1A3A5A7
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2025 19:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B751894231
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2025 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92F817A2F2;
	Tue, 18 Feb 2025 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swHEmBmk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B217A2E2;
	Tue, 18 Feb 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903501; cv=none; b=sxx3okSptPOFozE9YTJ76LIwdUPjQYzDpZVhvHMvM8n3HvepBOoJb/A+81TsLo/0jD3xuK1az3ssx7QWgPpPzCpPegJsmCLG7xIpeu5OwkI3ArfGl3HCh+JTNdMhTtlQNYiN+2I+B+yY7iBfoxuAQayP2QyHRU0w0p6rlMVRvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903501; c=relaxed/simple;
	bh=D8dZnOXFuROlbQzwYeFLYukaJG+WvfuqVEkJvIIiXE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g8gyLBFOhqbTRul6NlneAIt/MNCdwxH18cJmjX5OyjLtQPt+73My+1Dj37oheTGfx+EYTIh2x8QDcxHt2zFrhQFvcNHPw38UZQYdFVal6yFJp31Y77rUHKdjpkSwq2sSH3HbYSodn5Q4HKkVQ9AqIBCv1R0AUHSTp0nQgs9oDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swHEmBmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7B9C4CEE2;
	Tue, 18 Feb 2025 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903499;
	bh=D8dZnOXFuROlbQzwYeFLYukaJG+WvfuqVEkJvIIiXE0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=swHEmBmkLDhgWpG8J9xtDug53hxv+cLGvgql5mbqbjMVdYxL171ydBGjcHgZg65vM
	 ScgU9qsNX0x+EH2MSPTX73WbmI6idcP7/P7chUgXDWCLAg0YbKxKWnPntjyKBRPyPk
	 a6TpVHWHzOhQO7MYM09GjiVGKOawqRxUYdakYLn/3Mdm4Ly42swWKkVykmjkT4gyIL
	 vnagzYQqFhuIBfWC55sOE9lrHil0TuiDAFnMt6d8UgV60AhBIA4fzahNln95FYrbCF
	 1ctSu0Eqq4myDYkci5fgeva8+JE2piB8g/tAw3ecjJeIZMDnuAyVjsPiWzguYuSb+7
	 cABMuN8Q3Vv+A==
Message-ID: <eaa0d608fb78d06caca26edc9a830cf1a02f9fb8.camel@kernel.org>
Subject: Re: [PATCH v12 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ross.philipson@oracle.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, 	jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, 	herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, 	ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, 	kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, 	trenchboot-devel@googlegroups.com
Date: Tue, 18 Feb 2025 20:31:35 +0200
In-Reply-To: <060ffc99-59e8-4b71-9e7d-daeb807332c3@oracle.com>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
	 <060ffc99-59e8-4b71-9e7d-daeb807332c3@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 10:21 -0800, ross.philipson@oracle.com wrote:=20
> Hello folks,
>=20
> We posted the v12 version of our patch set in December of 2024 and we
> have not heard anything on it from the community. We believe we have=20
> reasonably addressed the issues as has been discussed on list. I
> realize=20
> there has been a lot going on with releases etc but I just wanted to=20
> send a bump that these patches are out there if anyone has time.

I don't know what happened but to be totally honest with you I missed
that version. Maybe it was holiday rush but yeah still I did not skip
it for that reason per se, just that it could very well explain the
silence (people tend to fast-forward more at the time, and then
mistakes easily happen).

I'm right now on holiday up until end of this month, and this will
require enough time that I unfortunately have to postpone the review
up until the first full week of the next Month, in order to do this
properly.

Still, apologies for ignoring this!

> Thank you,
> Ross Philipson

BR, Jarkko

