Return-Path: <linux-efi+bounces-985-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39C68B323F
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 10:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEFEB22F99
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24C813C9A0;
	Fri, 26 Apr 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQdJpHdq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E842A9B;
	Fri, 26 Apr 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119789; cv=none; b=XSuacc6BgZ0q4fzpnMDnqKkz20OKf79iVYRwdRe6SstXYLQXQaKp6nHOlzM8ZQmu1RlVOjj0dL1mcHjXcVQn0fkKw/Itk0/P36yMHjsFXI7W9HqcBKlWPiq8kWbmWmxo4EPyz2nnYp7eDkz7WdXUpkA4PAaFPA7KKDR/3YKr7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119789; c=relaxed/simple;
	bh=XksjV31GmF0RJcKDj+rdXWjazudnL5P2SWjBdN37Xxo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=CSzjQOUqGeM2gr0d5HJGZogJjHr1ZHcgItlKH+3qGV+pqXUh/RN/25l9hTV005vIcalHDUQhCO/h9shdJbZhJqddN6jESxCnlY2SAZkLpU2L8kWA17/fQmiafM6YRvh1JuVhxcI+gZsazoZdG8C1dFbnQIkmj+uZGw5FL6XwZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQdJpHdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F16C113CD;
	Fri, 26 Apr 2024 08:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714119789;
	bh=XksjV31GmF0RJcKDj+rdXWjazudnL5P2SWjBdN37Xxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQdJpHdqJHod4X9CHpGG30biB9tBc6HLmIcjritXnSMyNw7ehkNnbmMa8OCchodCV
	 LEnSeQk6b29nlWfaejFPfobfNz6fAnspDnQyBWAsEUzYYjc2t8vklAECbTd70Xb4pE
	 ZIbcb/vgsKP73RruTGiL3GgKq+bol0rcx2KENOnacpY3Nz21wrnPaSNu74Q+pcaVag
	 sdgL8ap0TQGS031h6wGwKSOmcatP7sxVe/ODv2y6FJi5Gsej1CCxpKoysnRDL7ziwH
	 qPs6wrJxJ0vYsX0ybS0j/5Rc6DvfJWbXJFp2e1cBiF0U8GZyZUh1FNVOpM/TdjEDJ/
	 bFpKRWb34cCww==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Apr 2024 11:23:03 +0300
Message-Id: <D0TWR1M8I014.1BR5Q9L4K497Z@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mikko Rapeli" <mikko.rapeli@linaro.org>
Cc: "Lennart Poettering" <mzxreary@0pointer.de>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "James
 Bottomley" <James.Bottomley@hansenpartnership.com>,
 <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
X-Mailer: aerc 0.17.0
References: <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com> <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com> <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com> <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com> <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com> <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com> <ZiopXE6-AucAB9NM@gardel-login> <D0T9BM4E1F5C.2TZMIRSHCKCQ2@kernel.org> <D0TVQWEDNZO0.PN96CXJOTN1B@kernel.org> <D0TVUC3PEG7K.1XYIAGIM2T0UQ@kernel.org> <ZitjoLvggYB7vR0O@nuoska>
In-Reply-To: <ZitjoLvggYB7vR0O@nuoska>

On Fri Apr 26, 2024 at 11:19 AM EEST, Mikko Rapeli wrote:
> Hi,
>
> On Fri, Apr 26, 2024 at 10:40:20AM +0300, Jarkko Sakkinen wrote:
> > On Fri Apr 26, 2024 at 10:35 AM EEST, Jarkko Sakkinen wrote:
> > > On Thu Apr 25, 2024 at 5:01 PM EEST, Jarkko Sakkinen wrote:
> > > > On Thu Apr 25, 2024 at 12:58 PM EEST, Lennart Poettering wrote:
> > > > > General purpose distros typically don't build all TPM drivers int=
o the
> > > > > kernel, but ship some in the initrd instead. Then, udev is respon=
sible
> > > > > for iterating all buses/devices and auto-loading the necessary
> > > > > drivers. Each loaded bus driver might make more devices available=
 for
> > > >
> > > > I've had since day 0 that I've worked with TPM driver (i.e. since 2=
013
> > >
> > > - had the opinion (typo)
> >=20
> > Tbh, I have zero idea what this discussion is about anyway because the
> > original thread *was not* CC'd to linux-integrity and I'm not subscribe=
d
> > to linux-efi. So next time put all the relevant mailing lists. I.e.
> > definitive NAK for this patch.
>
> Sorry for not including linux-integrity. I added maintainers and lists
> proposed by scripts/get_maintainers.pl for the change which did not touch
> drivers/char/tpm/ though TPM event log APIs are clearly there.
>
> The full thread starts from here:
>
> https://lore.kernel.org/all/20240422112711.362779-1-mikko.rapeli@linaro.o=
rg/T/#u

NP, just add CC to the next version.

I'll download it and check through once bandwidth.

> Cheers,
>
> -Mikko

BR, Jarkko

