Return-Path: <linux-efi+bounces-2913-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2561A56161
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 08:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFC918970E6
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 07:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3B19E7E2;
	Fri,  7 Mar 2025 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPSDzGD7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8638382;
	Fri,  7 Mar 2025 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330967; cv=none; b=VX6g27gShWZxa587GZGrrgcKxSs4mlctSmvKUehMt6PB53VL0fCaOCEipp+QRDA4P8FWVCsdL9gERn3bipQ+8CFr9S3BUt7cZTLAyl7dzFvjMXR8+i/eMtKqu8uaJZsohpjDqEP2HlxYJT7Fsss1kc7ZumPxhkl3dv0K11sQDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330967; c=relaxed/simple;
	bh=s0Xv8Pqr7o4l7Qibu9DKl61p8Xb8wiCce4s4Bg4r9FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL9eEeIZEkoj9lWA98HS94CdxK7xFzkuxwK8sNzMYWLsZJMqVPDvRxh8xaa5uEd/iY831JYOxVOqrfCTK5LlefqnMYFwNa4y8HNhBGa8GfP+lI2fGlRtphccUOiEcWhNDRbmRitNUblObAr5Dl+SCIiqGT8Umu1YdfigO38HclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPSDzGD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA20DC4CED1;
	Fri,  7 Mar 2025 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741330966;
	bh=s0Xv8Pqr7o4l7Qibu9DKl61p8Xb8wiCce4s4Bg4r9FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPSDzGD7e91W0D6L4Tgfev4YR5SWUrgerBvMAn7tOupWyz2kAf4MCvmp56Xh9hzQV
	 1pLDmmHhaU46Gq9bCNhUmmkDcyygILzhV6njDp51w2eziuPgLWl9WlYVyUEGpHeiH4
	 73e3/h5x2ME8DQz1wGETGpTu3kc2+e0jozf26h2uE7aMbYiXKZig5fQRJr4xuR9uM9
	 SnkoqolMUxLyyH++9gxmNZNmns/AIZjzSNq37GElrC4eWYTXfFTBrK9/Buh33gvQET
	 e+z7BZWeRUtFVTPYQEeiTxSgSt9QbQuPNUaDIcnEoqxyDE+oF29T9Haya1UerubN0w
	 O5T6knCM5r4Ww==
Date: Fri, 7 Mar 2025 09:02:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
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
Subject: Re: [PATCH v12 10/19] x86: Secure Launch kernel late boot stub
Message-ID: <Z8qaEdBD8wZLo-yb@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-11-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-11-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:07AM -0800, Ross Philipson wrote:
> The routine slaunch_setup is called out of the x86 specific setup_arch()
> routine during early kernel boot. After determining what platform is
> present, various operations specific to that platform occur. This
> includes finalizing setting for the platform late launch and verifying
> that memory protections are in place.
> 
> Intel VT-d/IOMMU hardware provides special registers called Protected
> Memory Regions (PMRs) that allow all memory to be protected from
> DMA during a TXT DRTM launch. This coverage is validated during the

Hair cutting again. Check through patch set:

1. D-RTM
2. DRTM

Pick one and use it consistently. Small details like this in the end
make the overall thing less exhausting to read.


BR, Jarkko

