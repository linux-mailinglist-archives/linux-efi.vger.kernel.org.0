Return-Path: <linux-efi+bounces-1677-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8389701EE
	for <lists+linux-efi@lfdr.de>; Sat,  7 Sep 2024 13:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDAB284A58
	for <lists+linux-efi@lfdr.de>; Sat,  7 Sep 2024 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00E157A7C;
	Sat,  7 Sep 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBWcyKFZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4EA55;
	Sat,  7 Sep 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725708444; cv=none; b=BOvnWjzkolsygO8Ij7aJDS7EOpVChIMDRbULbNhSWwralfIIQZIOZR0MO5TYzyw738FzkLY3699pWqsdc0CSR7F4PgAyG3KDGH7kUWtPWvxTknG854WAcUUO7R0y1GfcjkuJ2ZJgjsAqRDso6LsWLkHkJyvjn+Xn/6AbLOgapU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725708444; c=relaxed/simple;
	bh=DzlgCZvoAslqJIa9rfeEGQCc5NjF7zvlXCe6WoEoX7I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OIgHcIURvj/ucQ7Dh0nhhYzmbSJMHe+5mB64UjV62HhyUJVG5pB0kY6Zg4EKbWP/0sjGeei17hcOX4gpRxFRymjovQ6jAGe6Lif3dGQnQajMqB7bSq4teLQiMKfth2do94h5iMM+OXe9weCGEWyqVq5u8B5pe10AUxW/YoVLxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBWcyKFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A9DC4CEC2;
	Sat,  7 Sep 2024 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725708443;
	bh=DzlgCZvoAslqJIa9rfeEGQCc5NjF7zvlXCe6WoEoX7I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RBWcyKFZe/9mOh4BaocbZV1L/fwv2mg/sbQWsUMfPaK8pCqrsjbDfX4iRVV1T69zh
	 PTDY+O3fp00QR8UNjCq6pPT0w3UjUBvLOTUF+8iO4dFu2zdraTQli68wfSOHL4D7xF
	 BZt445JRlAGbbnd6znNMZmF/XGFj3lMEKbNnnUvLOVOK6sGfpVjx0iLAvh279I2wqQ
	 hSuzSRj4CcTMoSONY7fVDlMo3bFYaLBDz6fes8sULlD9l1n+CZzrb3KqOdhA1UZ1el
	 osJbkjs6RfaTR1jOGl6IYOusIPlEs69Pp7wrcq2rNie/x1qL6JzEXuvC2s2FCYZjjj
	 fiLrmYhXP+m9A==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Sep 2024 14:27:20 +0300
Message-Id: <D400L4YN4K7K.264IDL4O8374F@kernel.org>
Cc: "Pingfan Liu" <piliu@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
 "Lennart Poettering" <mzxreary@0pointer.de>, "Eric Biederman"
 <ebiederm@xmission.com>, "Baoquan He" <bhe@redhat.com>, "Dave Young"
 <dyoung@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon"
 <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Philipp Rudo" <prudo@redhat.com>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
In-Reply-To: <20240906125438.1e54c5f6@rotkaeppchen>

On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote:
> Let me throw an other wild idea in the ring. Instead of implementing
> a EFI runtime we could also include a eBPF version of the stub into the
> images. kexec could then extract the eBPF program and let it run just
> like any other eBPF program with all the pros (and cons) that come with
> it. That won't be as generic as the EFI runtime, e.g. you couldn't
> simply kexec any OS installer. On the other hand it would make it
> easier to port UKIs et al. to non-EFI systems. What do you think?

BPF would have some guarantees that are favorable such as programs
always end, even faulty ones. It always has implicit "ExitBootServices".

Just a remark.

BR, Jarkko

