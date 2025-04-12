Return-Path: <linux-efi+bounces-3313-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C636CA86F3F
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 22:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588F27A5089
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 20:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84F521D5B0;
	Sat, 12 Apr 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ1u0zkh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93D21D5A7;
	Sat, 12 Apr 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744488492; cv=none; b=caqHY1TmIMKA6e415VIgiiWtk9mNtvHyRkLZUn4dOmE62oRW1vvySpH+P3jMXiUJbaIV2CjIKwu0EUREt1G2C08nWzYZDUwNRATb8DN0AuZFWE7M2TG9nBgJCRxv5fPEuDCMSMIKC/kpmhtmGO3iAM3c5RSxSeGKztQRyLaa2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744488492; c=relaxed/simple;
	bh=tmM0jIVG3GiuwYBuCj+AmNra5FiBb0wjSj9Ha0EfT2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8TZ2qofTQ9TJ+JZ3XJiHrGoNNdf11UgG+4HuL+Lcu48I98JyRUQnbjuy5rro+znDLrsKGgI9qDCu+LwNMKsAgaqFIDvmOnypJZFjGGfoXHp55av53yBx+ix1i+n9DBtqNWH1gIdp9jHYnmBxjH93ZDO/Mx4pSYE1KtazEe1Phk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ1u0zkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACDBC4CEE3;
	Sat, 12 Apr 2025 20:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744488492;
	bh=tmM0jIVG3GiuwYBuCj+AmNra5FiBb0wjSj9Ha0EfT2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJ1u0zkh5E2v/2Xu5zjuTrlQnAziiyOt9i23xpQAFTzEPc6Q3WZNIhuff+m0yH6Cu
	 jEgHZomoOr2ioAUQI1vP3P75TPtK6T5nk5Fwiwm8Rlkds619qrdjx0Upy13Iid3Pg2
	 jfLXdHjUP5sL8m/thQxmnNqEvGd4TxlcHkJ4Ndvhpm312azRdI4uN0iTh9rRFPuim5
	 b0HOLwu89P0XObVB2SAInXPMWcwkK+/uGz1Cps+OuYIeBezcb9z60A2t2QC+nVBtvk
	 wkaWQizNosXWdm0n2WzG9zE6MbZ5D3XEO9CPYvUQVpwRXwqKJJ5gt4FnjAcCVZnrPo
	 AWT+eJUDqQY2w==
Date: Sat, 12 Apr 2025 22:08:07 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v4 08/11] x86/sev: Split off startup code from core code
Message-ID: <Z_rIJx_b70rzzERV@gmail.com>
References: <20250410134117.3713574-13-ardb+git@google.com>
 <20250410134117.3713574-21-ardb+git@google.com>
 <Z_pbLAw56NIFo7yK@gmail.com>
 <Z_q1RthXIbSXY2Eq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_q1RthXIbSXY2Eq@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Ignore that, I have now read the cover letter too, with the patch 
> dependency mentioned there - as kindly pointed out by Ard in a 
> private mail. :-)

But there are other problems during the allmodconfig final link:

  vmlinux.o: warning: objtool: __sev_es_nmi_complete+0x5a: call to __asan_memset() leaves .noinstr.text section
  ld: error: unplaced orphan section `.data.rel.local' from `vmlinux.o'
  make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1

The objtool warning is caused by:

  x86/sev: Split off startup code from core code

Tte link failure by:

  x86/boot: Move SEV startup code into startup/

Thanks,

	Ingo

