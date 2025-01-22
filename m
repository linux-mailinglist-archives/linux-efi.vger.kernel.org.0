Return-Path: <linux-efi+bounces-2711-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F8A193C2
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 15:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A503A206F
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0826212FA9;
	Wed, 22 Jan 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iCH1gfwL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A2A17C220;
	Wed, 22 Jan 2025 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555567; cv=none; b=r5u6pRrkd0L4P034OavFKzfNHHCM0bbmG5AXL5JyV3Lid8wPOYy1uoM6y7ijeB71CZ1VHfZ7cCXoC1AUUi01S2Go4kBMYf+cTq+hI4kRD9hvYIPhFHJVpC3PuCPOk3Do7ZWGLruTu7DIFiWUll8FN+3Nj5BABvSUKhPDgGCHJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555567; c=relaxed/simple;
	bh=liFDVM1/hnLOrPc7r6N4pLRAcHTQur9ssLrlhsn1avM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myKPQ1hhwRMmWrFnYe3cjYNza3UG+2CconkX+UGRb92kcg9IQhmo/M4YUGXayusbcGn1nfQX0hZEMKAyQa3pyNKYlnWxa99eVCr/g0jtWEGuFi1RyKY2tqoI3gAUJh3FdrGzyNDxqv4OGeYwTd2DeYKpjQ9jxBr+zry4WWOwJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iCH1gfwL; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YdR5v6XMMz9smk;
	Wed, 22 Jan 2025 15:19:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1737555556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6f9o4LPfjrqrl8uwE+TVp3TKA4Y3zQRjeziTU334OLU=;
	b=iCH1gfwLWuF3WGrKbjJXntBFRDXcGNpndJy0GJ0nGdO1Zrez5xpFsuQ38lcVund4a95v0Z
	yk1ua+Fmb1Tesp9RoK22gAZLYhnGqdQEmbwSwzGXdcdO9Q8OiL9mT+3X8cMUeCuaSwCqAf
	CyeJvkJNEmGlvleIEmQpR7m8IMLziOjmsyD0+hJs2P5yTVirMf4JGHIIPrVm9hhzgQLHqM
	VuRa7rUhzI8FE4K1A1xBC85fL1tURovIuxgG0k3yRT15myywAWMo3VWi8xI1GJ1MX9BnxK
	0JyNgmnHj/V7Nxz2Yv5lwoQYLzJYw0uSJMJxvWia6AYVlyakPnG7aTHxhYh5Tg==
Message-ID: <39417993-9fec-4ff0-aac2-6bb2c5a96b3b@mailbox.org>
Date: Wed, 22 Jan 2025 15:19:03 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] x86: Add CONFIG_KERNEL_UNCOMPRESSED support
Content-Language: en-US
To: Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-efi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121-kernel-compress-fast-v1-1-fa693b6167d4@google.com>
 <CAMj1kXF-GSB9Ty7X1h4u1uA6qhO1Y1UvVrNF=R+hk3PENRz7WA@mail.gmail.com>
 <CAG48ez2hVHk-C4XAGW2GieHZ9JAF0RrFfpZF7XhYc80pznMwbA@mail.gmail.com>
From: Tor Vic <torvic9@mailbox.org>
In-Reply-To: <CAG48ez2hVHk-C4XAGW2GieHZ9JAF0RrFfpZF7XhYc80pznMwbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 85b36bdf085660727a5
X-MBO-RS-META: u9hb1k4ftoy9ofjbf4wda91nzbirekew



On 1/22/25 14:54, Jann Horn wrote:
> On Wed, Jan 22, 2025 at 2:31 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> Hi Jann,
>>
>> On Tue, 21 Jan 2025 at 23:16, Jann Horn <jannh@google.com> wrote:
>>>
>>> Support storing the kernel uncompressed for developers who want to quickly
>>> iterate with one-off kernel builds.
>>> Store it in the usual format with a 4-byte length suffix and keep this new
>>> codepath as close as possible to the normal path where decompression
>>> happens.
>>>
>>> The other compression methods offered by the kernel take some time;
>>> even LZ4 (which the kernel uses at compression level 9) takes ~2.8
>>> seconds to compress a 110M large vmlinux.bin on my machine.
>>>
>>> An alternate approach to this would be to offer customization of the LZ4
>>> compression level through a kconfig variable; and yet another approach
>>> would be to abuse the existing gzip decompression logic by storing the
>>> kernel as "non-compressed" DEFLATE blocks, so that the decompression code
>>> will essentially end up just doing a bunch of memcpy() calls.
>>>
>>
>> This all seems pretty complicated, and adding yet another
>> (pseudo-)compression method is not great in terms of maintenance
>> burden, especially because there are other consumers of the compressed
>> images (both for bzImage and EFI zboot)
>>
>> Did you try running gzip with -1 instead of -9? On my build machine,
>> this reduces the compression time of a defconfig bzImage build from
>> 4.3 seconds to 0.9 seconds.
> 
> I tried lz4 with -1; that is very fast (240ms wall clock time on my
> machine, and just 120ms user time):
> 
> $ ls -lh arch/x86/boot/compressed/vmlinux.bin
> -rwxr-x--- 1 [...] 110M Jan 22 00:01 arch/x86/boot/compressed/vmlinux.bin
> $ cat arch/x86/boot/compressed/vmlinux.bin | time lz4 -l -9 - - | wc -c
> 2.86user 0.04system 0:02.96elapsed 97%CPU (0avgtext+0avgdata 15756maxresident)k
> 0inputs+0outputs (0major+220minor)pagefaults 0swaps
> 46309676
> $ cat arch/x86/boot/compressed/vmlinux.bin | time lz4 -l -1 - - | wc -c
> 0.12user 0.06system 0:00.24elapsed 75%CPU (0avgtext+0avgdata 15524maxresident)k
> 0inputs+0outputs (0major+94minor)pagefaults 0swaps
> 56029608
> 
> But I wasn't sure how to wire that up in a nice way. I guess the
> nicest option would be to create a separate kconfig variable for the
> compression level to use for any cmd_lz4/cmd_lz4_with_size invocations
> in the build process; and then maybe only make this option visible if
> LZ4 is selected as kernel compression method?
> 
> Another option would be to create a new option in the "Kernel
> compression mode" choice menu with a name like "LZ4 (fast)", turn
> CONFIG_KERNEL_LZ4 into an internal flag that is selected by both LZ4
> variants shown in the choice menu, and duplicate some of the make
> rules, but that seems overly complicated.
> 

Hello,

In my opinion 'lz4 -9' doesn't make much sense.
It's terribly slow and the compression ratio is also not exactly good.

Instead, zstd seems to be a much better choice. Not quite as ultra fast 
as lz4 levels 1 to 3, but much better compression.

As an example, I compressed a kernel source tarball (zstd is 
multithreaded with 4 threads here, which are not fully used with 
small-ish files like vmlinux):

   - zstd -3: from 1.32 GB to 199 MB in 5.23 seconds
   - zstd -6:              to 173 MB in 10.77 seconds
   - zstd -10:             to 165 MB in 24.52 seconds
   - lz4 -1:               to 373 MB in 1.60 seconds
   - lz4 -3:               to 278 MB in 6.45 seconds
   - lz4 -9:               to 266 MB in 22.03 seconds

And a vmlinux from my installed kernel 6.13:

   - zstd -3: from 51.8 MB to 16.7 MB in 0.60 seconds
   - zstd -6:              to 15.8 MB in 1.39 seconds
   - zstd -10:             to 15.3 MB in 3.54 seconds
   - lz4 -1:               to 23.7 MB in 0.08 seconds
   - lz4 -3:               to 20.2 MB in 0.51 seconds
   - lz4 -9:               to 19.7 MB in 1.23 seconds

For my kernel, I use a Kconfig option to choose a zstd compression 
level. I could submit it if there is interest.

Tor

