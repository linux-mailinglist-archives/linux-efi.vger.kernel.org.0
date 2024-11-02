Return-Path: <linux-efi+bounces-2116-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A69BA0A6
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 15:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0042D1C20C6D
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556FC189F5A;
	Sat,  2 Nov 2024 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL76AlXp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875319BBA;
	Sat,  2 Nov 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730556180; cv=none; b=WAAS8aovbuX5ddBoqQ/rWDAj6D19i4v7eMq85PiIS0ubaAqZu5B6Tt49inE8mwq0fRBkq+WNcQAk2zHR/ODb5Q4oHPvAgGLyOgmxerdjaDFGsdkelbZ9KvWQVLQv/oLWYajBQ/+WaSYHaNm5eTRS5OTTalVZLlaNrTZclIjaB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730556180; c=relaxed/simple;
	bh=ZLS8k2hCcSrDj/7M9xiZ525QVQIkvt4SYg63pY+uces=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=T6LqYzncQmRx7OcW05btAyeatT/ZkXbkkxEctd3Y6IwxaQktujKvEZy4NPy1n+ua8Gt6dH0JZuN0Ioeqh2lbMfEXoWEIPJWhh1bcD8xvJPx0aG3/4bfNZNFW6Rvkc838DAOGuvSMKxkcY799Kr9FkV5YtoEU01wJUkMq1LnDSK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL76AlXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F357BC4CEC3;
	Sat,  2 Nov 2024 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730556179;
	bh=ZLS8k2hCcSrDj/7M9xiZ525QVQIkvt4SYg63pY+uces=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=OL76AlXppOEgaPLRvOdzPtX1KYy7U2H6tK9emSQRGpBH4CwmwnLeWOf6ww3LIxQVJ
	 9uvAptu3mlOSnkkJaDa4S8mFBUjj526MSluXQHiHpoAVtT35/1w90Z+jpfbGQtWW6i
	 ug9Rmz/4odjf7FZjByk8xIr/59oKhBkhK45heHo9vpneXu5IE3H1QzPkwTQEuFXogk
	 ZI54GIf88ujwbVT7tF7vome8H5biZjIJsZvkS8Vj6VoyngXiRPeS1BYrhFwotXFr9q
	 Vf1d9YyaQx8qhS97yUHqqP1RyS9ZuWiDCQs2O4/GrSKhx+5nURvSiLMeulEWXvYu4g
	 AbH2S0NN5vpGA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 16:02:55 +0200
Message-Id: <D5BQYRP5BCGN.27P7RQRRUIYSS@kernel.org>
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
Subject: Re: [PATCH v11 15/20] tpm: Ensure tpm is in known state at startup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-16-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-16-ross.philipson@oracle.com>

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> When tis_tis_core initializes, it assumes all localities are closed. Ther=
e
> are cases when this may not be the case. This commit addresses this by
> ensuring all localities are closed before initializing begins.

Replace with:

"tpm_tis: Close all localities to ensure D-RTM compatibility

There are environments, for example, those that comply with the TCG D-RTM
specification that requires the TPM to be left in locality 2. Prepare
kernel for such environments by closing all the localities."

Please don't do anything to the code change (despite my one random
earlier comment).

BR, Jarkko

