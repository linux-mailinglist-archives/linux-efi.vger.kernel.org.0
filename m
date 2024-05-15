Return-Path: <linux-efi+bounces-1039-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA98C6C26
	for <lists+linux-efi@lfdr.de>; Wed, 15 May 2024 20:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C42283392
	for <lists+linux-efi@lfdr.de>; Wed, 15 May 2024 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2137D158DC6;
	Wed, 15 May 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGG8OjSI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716A40858;
	Wed, 15 May 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797807; cv=none; b=qc5Z8XZfsPKziWKm939+ktqu3jGTcNOnmJtNBz+krmhKXG7kEwDQkVMRqRqcQEOP0XiiPz+AzZH0B69bhlCLsMDTRio+3DRxebvN2SoxZeWZ8a38a6TvwENIbieGRrzgEyAi6jIGOxQHbrLBi9IBTt5AyajKYdxWv3wYG2kcnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797807; c=relaxed/simple;
	bh=1H4ESRp4n7R82qzwLK63TMRqXzG39WJ6h6WdXq5tn0s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jMGATuMuxe7H+Ef7KFJSoFBNBJf2iZoD7HgXEJUfcBH/VTQYEwIuduj1C5ny5VQ0ysNj0OBm8R4zCEEAes/3uKmkinu3HOKQAbrcIcGc9/F/oFOrYePAw85917gyfbgT/vMjMjgf3O9DbmxjtD9V10Y6sLB79ZH9Cfp4zmx+oI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGG8OjSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E794C116B1;
	Wed, 15 May 2024 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715797806;
	bh=1H4ESRp4n7R82qzwLK63TMRqXzG39WJ6h6WdXq5tn0s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=vGG8OjSIeW781V5I1Mq1XjN20oayTbfZUcvX7gFmSBIIuMekeMdERoqa1JMDoOIgE
	 xrftDrj7q8wQI5PJ6WPuR7cQ0BEYYhG2d1NgrIBgTLFYLnMCsyGjc76CjoWgbbsP2T
	 aPD2hmz3zViJSH2iwzvzuYtAvB7j/9BaH3xYsrgqtAdT+jn8iBzXx7DdEXgcrw8KWR
	 ykTrGGn6/oOtyOAR8Mm+QB5zQ2U07ttTk5Y4FJoj9ZwyqJAAWtAmGXSIsRXjxNKfum
	 9naBJ+n07qxnNyK/y3DGPwI5aDiLGKwQjySQoaYYTdKR2eK97QjUnEaEtndpfNqyln
	 xFM+cuR17Cm9Q==
Date: Wed, 15 May 2024 11:30:06 -0700
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>, "Chaney, Ben" <bchaney@akamai.com>,
 Kees Cook <keescook@chromium.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Galaxy, Michael" <mgalaxy@akamai.com>
Subject: Re: Regression in 6.1.81: Missing memory in pmem device
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXE2ZvaKout=nSfv08Hn5yvf8SRGhQeTikZcUeQOmyDgnw@mail.gmail.com>
References: <FA5F6719-8824-4B04-803E-82990E65E627@akamai.com> <CAMj1kXE2ZvaKout=nSfv08Hn5yvf8SRGhQeTikZcUeQOmyDgnw@mail.gmail.com>
Message-ID: <742E72A5-4792-4B72-B556-22929BBB1AD9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 15, 2024 10:42:49 AM PDT, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>(cc Kees)
>
>On Wed, 15 May 2024 at 19:32, Chaney, Ben <bchaney@akamai=2Ecom> wrote:
>>
>> Hello,
>>                 I encountered an issue when upgrading to 6=2E1=2E89 fro=
m 6=2E1=2E77=2E This upgrade caused a breakage in emulated persistent memor=
y=2E Significant amounts of memory are missing from a pmem device:
>>
>> fdisk -l /dev/pmem*
>> Disk /dev/pmem0: 355=2E9 GiB, 382117871616 bytes, 746323968 sectors
>> Units: sectors of 1 * 512 =3D 512 bytes
>> Sector size (logical/physical): 512 bytes / 4096 bytes
>> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>>
>> Disk /dev/pmem1: 25=2E38 GiB, 27246198784 bytes, 53215232 sectors
>> Units: sectors of 1 * 512 =3D 512 bytes
>> Sector size (logical/physical): 512 bytes / 4096 bytes
>> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>>
>>         The memmap parameter that created these pmem devices is =E2=80=
=9Cmemmap=3D364416M!28672M,367488M!419840M=E2=80=9D, which should cause a m=
uch larger amount of memory to be allocated to /dev/pmem1=2E The amount of =
missing memory and the device it is missing from is randomized on each rebo=
ot=2E There is some amount of memory missing in almost all cases, but not 1=
00% of the time=2E Notably, the memory that is missing from these devices i=
s not reclaimed by the system for general use=2E This system in question ha=
s 768GB of memory split evenly across two NUMA nodes=2E
>>
>>         When the error occurs, there are also the following error messa=
ges showing up in dmesg:
>>
>> [    5=2E318317] nd_pmem namespace1=2E0: [mem 0x5c2042c000-0x5ff7ffffff=
 flags 0x200] misaligned, unable to map
>> [    5=2E335073] nd_pmem: probe of namespace1=2E0 failed with error -95
>>
>>         Bisection implicates 2dfaeac3f38e4e550d215204eedd97a061fdc118 a=
s the patch that first caused the issue=2E I believe the cause of the issue=
 is that the EFI stub is randomizing the location of the decompressed kerne=
l without accounting for the memory map, and it is clobbering some of the m=
emory that has been reserved for pmem=2E
>>
>
>Does using 'nokaslr' on the kernel command line work around this?
>
>I think in this particular case, we could just disable physical KASLR
>(but retain virtual KASLR) if memmap=3D appears on the kernel command
>line, on the basis that emulated persistent memory is somewhat of a
>niche use case, and physical KASLR is not as important as virtual
>KASLR (which shouldn't be implicated in this)=2E

Yeah, that seems reasonable to me=2E As long as we put a notice to dmesg t=
hat physical ASLR was disabled due to memmap's physical reservation=2E If t=
his usage becomes more common, we should find a better way, though=2E=20

This reminds me a bit of the work Steve has been exploring:
https://lore=2Ekernel=2Eorg/all/20240509163310=2E2aa0b2e1@rorschach=2Eloca=
l=2Ehome/



--=20
Kees Cook

