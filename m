Return-Path: <linux-efi+bounces-1135-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2638A8FBB79
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77AA1F22B39
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF5914A4CC;
	Tue,  4 Jun 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlKrpZmU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FF149018;
	Tue,  4 Jun 2024 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525454; cv=none; b=swx8Te28PJ7oe7liqTVSUuQhr6l50SZtBo0WGja3cdAA8CFtCzRZ5wQTezH00crcmiYlxRIJSze5kXTuSdUIQAqGPv51nRZZG/BTmKeCrIpgGt4rteyXc8eHwCykcgMGQXyu4QFyuznQPV8ttlBeaC8wB4NEmy7Q3q7mFe1iS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525454; c=relaxed/simple;
	bh=VwUOXbZRxI9BWxExmfgOYucKxmw9bFwS5Qo+Bc+I8H4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=JcJjUHWeHZMdsqDxdHJvdnOmxrkN9zXAYcZcrX/roiTewUKJGjf864n30Va4uWcJn/trNow+bYogkA/Rem5ugkQuhiZbgWijhLj43WVSPjbzZQ5MzKH2Da90ojss679+CiFMV6skfSLH+O2larc1ylO/0MSkUueWacB0dXsRMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlKrpZmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF41C2BBFC;
	Tue,  4 Jun 2024 18:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717525453;
	bh=VwUOXbZRxI9BWxExmfgOYucKxmw9bFwS5Qo+Bc+I8H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlKrpZmUw+kVT4ed8YSALOTQvbRQh2EP2pyPJQtmFWLFR05bPTDlaP4lOVIstkWm1
	 Zd6mM0xEmCvk1lIdMxyA4y++mwV+UpF63FxEZ6boEwQnA+mVtE/fl+tkDcA4WFtzkR
	 mY5PjqxdSTsTDpJGZ3/IPaw8A3ncSLV7a/IB+jPz63JeLN8Z/+shBU7tyAFh6RhEyz
	 +Dxy0m4diGMU78Cn3CNZJLnhVw4XXujyadBJJGrmxG4GmY5xx1kqJU8mwOqXA+UtTf
	 HBvkJVDri5fE/Do7SKF0IKmJkRUGo27OJodu3rAYiQHty9DqYlKDkOBXHllmHixl49
	 /WzK7S5N4uElg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 21:24:05 +0300
Message-Id: <D1RFYH41E4ZN.2D7LJBAZP71CB@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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
Subject: Re: [PATCH v9 05/19] x86: Secure Launch main header file
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-6-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-6-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> Introduce the main Secure Launch header file used in the early SL stub
> and the early setup code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Right and anything AMD specific should also have legit references. I
actually always compare to the spec when I review, so not just
nitpicking really.

I'm actually bit confused, is this usable both Intel and AMD in the
current state? Might be just that have not had time follow this for some
time.

BR, Jarkko

