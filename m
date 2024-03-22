Return-Path: <linux-efi+bounces-851-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382E5886E5E
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 15:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DAE1C219F7
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7547A66;
	Fri, 22 Mar 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZETGE8z3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677F47A40;
	Fri, 22 Mar 2024 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117230; cv=none; b=IacdUQx7ES+57nRtm/z9neZiz/c7rSG2bb7B22vsxsezqV31n3E6CLu8FyWGRtZ+XSwB0VOz3aLjRCqxvonFBb5J8voaMbRwiE81Li+FhlhZ8HJMmOjydMDiPNym2ze/64bMRhZKAA+AbCR3R0omuPxNfEo1vGmsUTDctNgRhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117230; c=relaxed/simple;
	bh=aB18poa/nAuHxUYgK7CDuG4N2UPsaq85ox+8DKB04kM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZJ+2ARzZvPrEJtKp42hi9o199C43WE5O3bG38jAkRnDy38hxBtXyT1G3Okb89VUUhit58kcvUHSgPbcPMiIjZ1VxyYTUl85XM0eA5EY5WJmWeiQaG0gHS1NtWpIrHWDwAuGY+ZPR2tkDmOpyHaIBLx+74MtgkbmjFSK6uJhMr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ZETGE8z3; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42MEJ2ZV3496390
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 22 Mar 2024 07:19:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42MEJ2ZV3496390
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1711117149;
	bh=aB18poa/nAuHxUYgK7CDuG4N2UPsaq85ox+8DKB04kM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZETGE8z3u9I9yJvR5e/CQUJ9GmkJb4wq8snvbhDmH/87Lzwf+k/ZGo1AYaXFYl9nd
	 uETOnzCevSP6x3/Jys4AjBwWIYxjN9AYiGaZOvlyuMh07rolz2MUbUQq4v4IpcmfbH
	 XaZ2kjkRbA92EYSzRvO14ZBO4HfRYvjEeGadQEOmjwCnKNtbWI9V4I8BadIyN7/QVt
	 DeVXQnWkfk815Zq/7e7UNEjKO+YrQ5XnPO0G5EbeTFGaD7lwA438bf/x93wt39mE9f
	 IPdJFoxWZE023tvibiGtBG/M2k5vMMP30t9IEatLMPA/6G+NKk1Qm1CeXy3mgZtMya
	 5XnVwvHOIMJMQ==
Date: Fri, 22 Mar 2024 07:18:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
User-Agent: K-9 Mail for Android
In-Reply-To: <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-2-ross.philipson@oracle.com> <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com> <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
Message-ID: <32FDA47A-C87F-406F-A0B9-3AA1BB2EBAFB@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 21, 2024 6:45:48 AM PDT, "Daniel P=2E Smith" <dpsmith@apertussolut=
ions=2Ecom> wrote:
>Hi Ard!
>
>On 2/15/24 02:56, Ard Biesheuvel wrote:
>> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross=2Ephilipson@oracle=
=2Ecom> wrote:
>>>=20
>>> From: Arvind Sankar <nivedita@alum=2Emit=2Eedu>
>>>=20
>>> There are use cases for storing the offset of a symbol in kernel_info=
=2E
>>> For example, the trenchboot series [0] needs to store the offset of th=
e
>>> Measured Launch Environment header in kernel_info=2E
>>>=20
>>=20
>> Why? Is this information consumed by the bootloader?
>
>Yes, the bootloader needs a standardized means to find the offset of the =
MLE header, which communicates a set of meta-data needed by the DCE in orde=
r to set up for and start the loaded kernel=2E Arm will also need to provid=
e a similar metadata structure and alternative entry point (or a complete r=
ewrite of the existing entry point), as the current Arm entry point is in d=
irect conflict with Arm DRTM specification=2E
>
>> I'd like to get away from x86 specific hacks for boot code and boot
>> images, so I would like to explore if we can avoid kernel_info, or at
>> least expose it in a generic way=2E We might just add a 32-bit offset
>> somewhere in the first 64 bytes of the bootable image: this could
>> co-exist with EFI bootable images, and can be implemented on arm64,
>> RISC-V and LoongArch as well=2E
>
>With all due respect, I would not refer to boot params and the kern_info =
extension designed by the x86 maintainers as a hack=2E It is the well-defin=
ed boot protocol for x86, just as Arm has its own boot protocol around Devi=
ce Tree=2E
>
>We would gladly adopt a cross arch/cross image type, zImage and bzImage, =
means to embedded meta-data about the kernel that can be discovered by a bo=
otloader=2E Otherwise, we are relegated to doing a per arch/per image type =
discovery mechanism=2E If you have any suggestions that are cross arch/cros=
s image type that we could explore, we would be grateful and willing to inv=
estigate how to adopt such a method=2E
>
>V/r,
>Daniel

To be fair, the way things are going UEFI, i=2Ee=2E PE/COFF, is becoming t=
he new standard format=2E Yes, ELF would have been better, but=2E=2E=2E

