Return-Path: <linux-efi+bounces-2625-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892AFA10A56
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 16:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973E6165D77
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C416146A79;
	Tue, 14 Jan 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfQs0C4o"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9FC23244D
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867314; cv=none; b=cqQxQxGJ7gMMAWGHpsPFhUGZCCROoUD+I/sVP+9Cg/Flr3hxUQy4UuaZU2B1vRX3jVENbz7wBDmH0bmQ5tuCWa+Q5/jsc0DAQQJftpBW32j3UWQXw3MvQqkmmB6Sf+isXQNZ7UI1fJWXiZaxyreAejEKZVeUVUGCV0COqzMK3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867314; c=relaxed/simple;
	bh=W+9dAUOXTbY836Vh2YsPzS2Pv+u98OBeJ7EiX+i9+nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHzynTancQF8tiMJzS/sS7LDweqjW9gtzpBSxLpwikKjZouKXoYJt3svgo+Ca6EcdD1tiq3grLufb9oBGAWT80uL9YOyqzhcjc4yWQo7qymJoibEmeeVj+PIwvMWGzLirsx0o9zsg8w0byxuC6DGlCciOkp0j6J3RbEOnU1f3+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfQs0C4o; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163dc5155fso102689275ad.0
        for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 07:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736867312; x=1737472112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2qA60FIrIFlMeUy7oOa4demL4tHTb47KHuqZMJWzO2M=;
        b=TfQs0C4oe8cmYpAFDqzYid9AC6kYtp24/PJfHYQhhImanem1ETObmH9S2Oo4ZFwI4u
         MjLH/A7fWDZivHe0okzNjN+L0Zfy/kLiuOn3MJ3xdeRsCrBXgXDpcujQj0cNJoU4LsNd
         rRgsfeX2Dw3L0j+1CPnufSlz7PGljd3NSizJg29UiXsrRiz21SLMWjTgcVCtfYLWFget
         pY9/Lge5GtRnSN0n+m01ZoErCOQPe3uwF066lBB+wdmh1ejFOzNzOOcFfzpzbsAt2xHf
         da8EOI/9EJICDjQwYwvrjcw6WXNeyxl5K4BLfjExGSu8/x3V+dG7HUG7+SdZi/n6sE7M
         DV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736867312; x=1737472112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qA60FIrIFlMeUy7oOa4demL4tHTb47KHuqZMJWzO2M=;
        b=wONT8ChnfL9z6dcy9CLhtVHEzlQC0eNHcIYv4tmYk3Ote79a7fLt66z7NW0rjvMCQx
         2+UDloRxDkzizCmJ0urArNP4IoZXoRxfS1fqKQcqNg839HMWByDXcioOrKIwUCS1AR6A
         BbqxPxuOR0+py6OB8AsJABiEhc1eAjSog0pfbqtfGAtpNRoigENLtn6lyS75o4pwOa4S
         23M9Uy+3cgmwR5lXoYyDTti0WNfERXFy6WWmJ/18LVAjBQwe3BXgXz5CLHMkRSxAI74y
         OMuXjksHMZQ9bpkkd8gdnfkQNLJpJvTWkW2ycmvxIZUiaoJ9F13oJKTlecjeKDUXc+q+
         3kUg==
X-Forwarded-Encrypted: i=1; AJvYcCVpS6O1Uo2UOELbEdJ8DqBZL6uZSMe459P3pEdIPGf+XnfkFakYGwqdIL66RuYJl98D+T6GnzQlFyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+fC1X6qRAl+20Soz5uCNYgLhvko9wkHJfHqjEl0NOiMLpTmw
	PUvWm4r2jEQ6o/A1ZWF1yLHbyfOiIOOWRt8HpeGaxr+1ISmj9fk7uvZMWw==
X-Gm-Gg: ASbGncvDBoueKEupEpwpmSDP15t02/vS9I0X3yS6AYe+jIV5Q7FEIJgFF9H1RlTLc1k
	eUDxONYW77X/YgeW/bfiIVix9IW69Ih0N7PofsFKEJfUjU49FBENvyo8oq5zsu/R76SrWVS4Z/i
	fotcihXKYrL4o0gVwLnoyZMCAfMBCzVcwGkPALlTfzEZe+kw8ZdbQnLSiAfNfaSFoUZSCmc4vom
	eRjDABP1RUAXQX8AdDvOU7JQ8FIJX89Y+uq693D7j43xsrKhc+H3YoobhldZ5bTXSGtpU8sIybr
	k6AENgmFp7M15y2z5bBkSPysWIjXkw==
X-Google-Smtp-Source: AGHT+IEZXtoZW/qTOO47s5Q7iXg9/JCp2J4N+ok7dZirsH0w5UvHFQTUF0uq/2cwv4i0BJ4mvfTcig==
X-Received: by 2002:a17:902:ccc3:b0:216:2bd7:1c27 with SMTP id d9443c01a7336-21a83f72b8cmr381551935ad.33.1736867312092;
        Tue, 14 Jan 2025 07:08:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22e591sm69170375ad.180.2025.01.14.07.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 07:08:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e5e1f492-1050-4c4c-9e61-6ff4a68c58d2@roeck-us.net>
Date: Tue, 14 Jan 2025 07:08:29 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] efi/libstub: Avoid legacy decompressor zlib/zstd
 wrappers
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
References: <20241218150316.1583806-6-ardb+git@google.com>
 <20241218150316.1583806-7-ardb+git@google.com>
 <3d6f2bb7-3c23-4df7-a787-034bb30bff19@roeck-us.net>
 <CAMj1kXGz=dazpagUsxoDGHd4-n6QkoZta90h-c0DCBZPWuc_vg@mail.gmail.com>
 <CAMj1kXEgdUS3qxGe9_uQF5jNxwnFAR2giA0dTvE-kQ=u7Bmh=Q@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMj1kXEgdUS3qxGe9_uQF5jNxwnFAR2giA0dTvE-kQ=u7Bmh=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 03:40, Ard Biesheuvel wrote:
> On Tue, 14 Jan 2025 at 08:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Tue, 14 Jan 2025 at 01:31, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> Hi,
>>>
>>> On Wed, Dec 18, 2024 at 04:03:17PM +0100, Ard Biesheuvel wrote:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> Remove the dependency on the decompression wrappers used by the legacy
>>>> decompressor, which do some odd things like providing a barebones
>>>> malloc() implementation. Instead, implement GZIP deflate and ZSTD
>>>> decompression in terms of the underlying libraries.
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> With this patch in linux-next, my loongarch boot tests with qemu
>>> no longer boot. Log message is:
>>>
>>> qemu log:
>>> EFI stub: Decompressing Linux Kernel...
>>> EFI stub: EFI_RNG_PROTOCOL unavailable
>>> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>>> EFI stub: Exiting boot services
>>>
>>> ... and then there is nothing until I abort the emulation.
>>>
>>> Reverting this patch results in a build failure, so I awas not able to
>>> test it. Bisect results are atatched for reference.
>>>
>>
>> Thanks for the report - I'll drop the patch for now, and try again next cycle.
> 
> Mind sharing your config/firmware/command line details? I'm failing to
> reproduce the issue.

qemu-system-loongarch64 -M virt -cpu \
      la464 -kernel arch/loongarch/boot/vmlinuz.efi -smp 2 \
      -no-reboot -m 4G -initrd rootfs.cpio \
      -bios QEMU_EFI-loongarch64.fd \
      --append "panic=-1 kunit.stats_enabled=2 kunit.filter=speed>slow rdinit=/sbin/init console=ttyS0,115200 earlycon=uart8250,mmio,0x1fe001e0,115200n8" \
      -nographic -serial stdio -monitor none

qemu version is 9.1. The EFI image is at
https://github.com/groeck/linux-build-test/blob/master/rootfs/firmware/QEMU_EFI-loongarch64.fd
and the initrd is at
https://github.com/groeck/linux-build-test/blob/master/rootfs/loongarch/rootfs.cpio.gz

Configuration is defconfig with various debug options enabled.

I'll be happy to make a test directory available with all information needed
if that helps. Please let me know.

Thanks,
Guenter


