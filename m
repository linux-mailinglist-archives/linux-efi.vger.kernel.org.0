Return-Path: <linux-efi+bounces-2912-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C94EA56152
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 08:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D22B18960A0
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 07:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA1191461;
	Fri,  7 Mar 2025 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJcamyGR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619738382;
	Fri,  7 Mar 2025 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330846; cv=none; b=uvf0RfKq7U/+9+ahSlO4Zhpp30U5kXfzWQMgM9HGnnIvOK1dxPX4wcz/0uhf6DYXQpypjxAR9RkJKuBjdjLpNIYHidHwx0eQxB48u6FRTnwra9MuPdKmtCiuyaWk5DBncJvDHPZLwt8Io203Ycc7S2t5VYoBd7WCAUH1mZc6pIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330846; c=relaxed/simple;
	bh=LonDAILnsW0FisfkrmXT+YWTMRZbfLb6bNdSOs+YmcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inCVRe4alSU5eQbpSzlqTULrG4dlYvVP69ZjTQd+4M/Ja/9fAjn7RY1o1ADI8VaDj0Fca0jltkBew7sVHpuFPDXKWoBxjX9DBHr8EvpqS1ag7rWPo/P6a1LijVKlfoYbMdzx2kzM6T+FbprJIavhIZc/CgCdtH++DERpK/rEIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJcamyGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255A1C4CED1;
	Fri,  7 Mar 2025 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741330846;
	bh=LonDAILnsW0FisfkrmXT+YWTMRZbfLb6bNdSOs+YmcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJcamyGRemF0nmD8ymN/7Y76ADOIlDMzFsQvf/RbLxCFkNDBbwzLL7gwQSzQYhz/b
	 DuH0/iIzKBIk6ldssluyh22o9Bb7ULvWEeRIVSIV8wNcAjSrNCabfw1LD4fcDs/F+4
	 gP1lDV4rmDl2fxdGD8+FpVL8ZdzEVHV6qLkfZVRtTaFc7+AIR59RTTYyuEO0ia1yWV
	 n1FhoeoRAS976Ien+z3ar3FBpDMz1SZLtXbf+L1BxwI6oEbFp07NmTP5kimS/7JwUI
	 AZDvPvRvpWX2K6SPkp5ah1aDgdrGthBUgPOhCgIQeo8krlHtZZn/VJG59ONJceYdL6
	 NnLoSgYOr+vMA==
Date: Fri, 7 Mar 2025 09:00:41 +0200
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
Subject: Re: [PATCH v12 09/19] x86: Secure Launch kernel early boot stub
Message-ID: <Z8qZmWhSdxCCU_Fm@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-10-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-10-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:06AM -0800, Ross Philipson wrote:
> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> later AMD SKINIT) to vector to during the late launch. The symbol

Does "to vector to" translate into to jump into during late launch? :-)

Given the complicated topic in the first place I'd use as down to
earth language as I possibly could where it can be used.



> sl_stub_entry is that entry point and its offset into the kernel is
> conveyed to the launching code using the MLE (Measured Launch
> Environment) header in the structure named mle_header. The offset of the
> MLE header is set in the kernel_info. The routine sl_stub contains the
> very early late launch setup code responsible for setting up the basic
> environment to allow the normal kernel startup_32 code to proceed. It is
> also responsible for properly waking and handling the APs on Intel
> platforms. The routine sl_main which runs after entering 64b mode is
> responsible for measuring configuration and module information before
> it is used like the boot params, the kernel command line, the TXT heap,
> an external initramfs, etc.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Otherwise this is looking somewhat decent!

BR, Jarkko

