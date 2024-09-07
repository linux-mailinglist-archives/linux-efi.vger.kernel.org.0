Return-Path: <linux-efi+bounces-1678-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CB59701F2
	for <lists+linux-efi@lfdr.de>; Sat,  7 Sep 2024 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF22DB2165B
	for <lists+linux-efi@lfdr.de>; Sat,  7 Sep 2024 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E13158A3C;
	Sat,  7 Sep 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv4JhscT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC7158A12;
	Sat,  7 Sep 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725708707; cv=none; b=FGCpBAbqCHsXKDvg+/inojaNTm8ziFtR2RF9PEIs7EdaeCp5Q0ws5CYUm7R6G5ftWpTd3nLERrR2H9JAB5dv51LyM99xkJ+FzuPX7u2jW8Mjn5TR0Rq3/RWL6wr6VaLu4iicXqmpyOiHsJZMVnMBU8hRLWVCJCs4OLXnemhiqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725708707; c=relaxed/simple;
	bh=efk1JOla+fXnaGRV8mAv/M39xrggt3sD41Iy3FnCrpk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k3uYPRtGS09rJYKqN+HKC4jLuAXHluNiR+88LSbZ2WurojblFcIAwcUwIllooQYl3Ux8UySb9Bs5OzLLlhYHACzPCOcZDZxtYXsGS4lQl0nXgiM6RLXR+CiqCkCKAJLxINjC2PDEL7aZoNf7hXGZvnCrLnexfgNCoWZZfW7UKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv4JhscT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02483C4CEC2;
	Sat,  7 Sep 2024 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725708706;
	bh=efk1JOla+fXnaGRV8mAv/M39xrggt3sD41Iy3FnCrpk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Sv4JhscTcVihP0i6jCXpUm2sov6FUqr1PCfWWuw6lRkZpIw9wxglUmH/2GaXtKYZF
	 ydqPWeeIKO8qxVNmO8yS42UggxhewJnGioNkZtbe74GkSeqnylctbvllZPdVCQlJqH
	 8Ilqcr23mP8Zb0irRhg8SoMcwszBhLam2zileDI8ukpXuiK1CofNP58jAzfYQqSRCt
	 yMBOIlOw6NcvuLd6owhTqXgkTUiEMnoCBCCClpOin3ZJbpFP6LKwYRqgyjNrOzfiOB
	 YDAGy50fLKeeMFQYJ0+rKDEqwrZTTmMrLUeUxDpYXSMN5LaNZX2lT9R1Gxwfwjr1b+
	 YKTLFtbr4oQTQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Sep 2024 14:31:42 +0300
Message-Id: <D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>
Cc: "Pingfan Liu" <piliu@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
 "Lennart Poettering" <mzxreary@0pointer.de>, "Eric Biederman"
 <ebiederm@xmission.com>, "Baoquan He" <bhe@redhat.com>, "Dave Young"
 <dyoung@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon"
 <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Philipp Rudo"
 <prudo@redhat.com>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <D400L4YN4K7K.264IDL4O8374F@kernel.org>
In-Reply-To: <D400L4YN4K7K.264IDL4O8374F@kernel.org>

On Sat Sep 7, 2024 at 2:27 PM EEST, Jarkko Sakkinen wrote:
> On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote:
> > Let me throw an other wild idea in the ring. Instead of implementing
> > a EFI runtime we could also include a eBPF version of the stub into the
> > images. kexec could then extract the eBPF program and let it run just
> > like any other eBPF program with all the pros (and cons) that come with
> > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > simply kexec any OS installer. On the other hand it would make it
> > easier to port UKIs et al. to non-EFI systems. What do you think?
>
> BPF would have some guarantees that are favorable such as programs
> always end, even faulty ones. It always has implicit "ExitBootServices".
>
> Just a remark.

Some days ago I was thinking could some of the kernel functionality be
eBPF at least like in formal theory because most of it is amortized,
i.e. does a fixed chunk of work. Not going into that rabbit hole but
I really like this idea and could be good experimentation ground for
such innovation.

BR, Jarkko

