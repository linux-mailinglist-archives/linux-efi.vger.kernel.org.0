Return-Path: <linux-efi+bounces-2094-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E62B9B8E93
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 11:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A58280CE6
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB115886C;
	Fri,  1 Nov 2024 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNaEA83R"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2452F14F9F8;
	Fri,  1 Nov 2024 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455558; cv=none; b=P4GSUGfp/CeveleapVKwh6sGq0LoJ1uxdmo7Yl//AZlYQXthBua2WsiCG9NLa0guc0PVUitFPbHPOze1x1QE4EOOLQcCol66EcYRdLAbd5ICbUQm2sOQG0Yr5NLNBxZVvI8k+FmJ0ap7w0y+J1AtQeCWy6hc/g0w90B/HJFurms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455558; c=relaxed/simple;
	bh=234I1ZQTeGUQ7AweUIyteCig/kRhjTiW4dwUb89B+L4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bVFJXmKHCmFM/CCyi2vv81KlC/obOG05JoGRnja+VYcSHqV4Meo9bTCGbT2VaPLjtq9ynOuP9t/MNFQXeDNiaL5SH63X+6PIr3yL+p/KsYdHn5YzNOXjb6wetUf3KK8gNyTXas4siYkZxdtXqqPtVtGwDBuZsrCS+v03cP7T0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNaEA83R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FEFC4CECD;
	Fri,  1 Nov 2024 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730455557;
	bh=234I1ZQTeGUQ7AweUIyteCig/kRhjTiW4dwUb89B+L4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oNaEA83R7bQWz5ryOo6znpeaj5gIJPWSCai2b0kOxa93tMyynXXhAJRdTr73oxjSH
	 wAVUsHNXjdWZORdwnVd5ddrynIMsydVOwBO7CqzEQk+YUSAjB7/5SZz5NjG+1S9rx/
	 M3VBytEy9MeR80PdYDu37io8PvuZwf7j7zoKfRTGU5VFJdjwHmmDZJ7NDdj4KdvMWr
	 brfztEtOTssQI3WtsZZAy5XOUaXg//x6gcwqAMurzDGtSI7ChflE6J/bARtdIV5yMv
	 xUZ7yHFmp5G5JvzbYc48Xo8UGhPE6LOlqhUN51qeQJrZSi9Dm5Cd+lE/Ay+/yq8SVT
	 re1KfmRmcVpBw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 12:05:53 +0200
Message-Id: <D5ARAQRDROGW.3MEBL71LJ3GF2@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 17/20] tpm: Add ability to set the default locality
 the TPM chip uses
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-18-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-18-ross.philipson@oracle.com>

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> Curently the locality is hard coded to 0 but for DRTM support, access
> is needed to localities 1 through 4.

Why?

>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

BR, Jarkko

