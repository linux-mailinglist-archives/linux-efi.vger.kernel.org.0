Return-Path: <linux-efi+bounces-2095-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358599B8E9E
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 11:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EB2B22939
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27AA165F1D;
	Fri,  1 Nov 2024 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlaL8xIA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F414F9F8;
	Fri,  1 Nov 2024 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455603; cv=none; b=H5OSpgaEXLiCe2PmAIw9q+YAEgCstmwXeAuL0hqPqo+tYzJxgC6N9qA1wEDPu293hUZ9LgQIVfrXJicbS7brJoqEHOfU2kVMAIFO2Jf1Vp/03MImThaU/hmAFlIHs8euip3lG8Ag71b9R+H3lAnmy6/5angsRHgk93dqjyHaR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455603; c=relaxed/simple;
	bh=j7rq1zckz0jJJuh+oXSHsEBtqOr5Q1izk3adIndgVqA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TZUoZrGyucLPWSc4hvkS+yBpIs3irEypXpxm8pukUagDAq1RNqn2JDRdhV1Y0T/MC7x6HWPdiS59XJcLP8utWB/pqYenYZUYtz6CDDClGD14HtyIph/FPwApMDS1p5+sBuZEZTI2sSw0jgXXe195FVgzRDd9lRuN48FOMy/DRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlaL8xIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7494C4CECF;
	Fri,  1 Nov 2024 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730455603;
	bh=j7rq1zckz0jJJuh+oXSHsEBtqOr5Q1izk3adIndgVqA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=GlaL8xIAQtARK/uThgcYxUBBAZrNlqE0XT2UPbieKeJaPjS2CWn0J1JIVx+jFSYJV
	 TD5knnHxU5Jl+JEjgc9RBTSbxbC4eXuEcB+8F0k/zByVRZRZ0j5ZYF+ZNVWcV+Q7K9
	 rW5+7uQgBGas2ZKTSRrZQxBkpA0wOMTJd99FzYE8lpTne6RkQG4ZqEp7WOzuLkccOZ
	 m+Qq3e/5QXptVHJ60VpFGyeJmqUIp0ibwCCr2qslBuSt/ohTiZvQ891TOSNRhmgSlt
	 +J4hyJMzNNO5SmmNdieN24oiW0GaPZzW3O93bwZ4hNlJDHdzoJss7CrE9lDkdLYnH3
	 gSE6hvYJgDu1g==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 12:06:39 +0200
Message-Id: <D5ARBBZU61YW.2SQ35HTOJ85F7@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 18/20] tpm: Add sysfs interface to allow setting and
 querying the default locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-19-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-19-ross.philipson@oracle.com>

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> Expose a sysfs interface to allow user mode to set and query the default
> locality set for the TPM chip.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Must be read-only. Should be decided per power cycle.

BR, Jarkko

