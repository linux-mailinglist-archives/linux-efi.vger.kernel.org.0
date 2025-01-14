Return-Path: <linux-efi+bounces-2615-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFA7A0FD5F
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 01:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC48E3A0730
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 00:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6466E629;
	Tue, 14 Jan 2025 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVC9bs6r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04BB625
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736814667; cv=none; b=F7g8PYSU1a/fQEGMaHrdBAQ9xbmSwHJvgcmRKOOd+waL5fz03C5N5rXQr9azRq4+NU/nF8scKwcwS4qkfEWAJjQUVGC0WVb6sagFCYfQuKV29IjdL1jIPQboMzHdeBWeMssPpFz1I07gvjR0gA23CvaZGqHcX7FWCB/HbjQBH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736814667; c=relaxed/simple;
	bh=lGCnG3nxsb5i4g/tqGsDEKtbb5MMSOB5hvisl1U9wUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kab1slxxa9Lb379dN1KVfx/WwdXfWj/nJNwY/uaK3rKlLRrigNeeWsJXwoQDWuKy1w96un8s9kDQ8vd899xOv9GEDGgOby8spWxP/hkvU2i7d6L6IUM95aCzaAbYKkzfb5wHEUUdRtb6eNUiMx2fNUb8BcYp/SvKKEwgicP0ROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVC9bs6r; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21649a7bcdcso83394655ad.1
        for <linux-efi@vger.kernel.org>; Mon, 13 Jan 2025 16:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736814665; x=1737419465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZVnyOAOBWDLwQQHfj0z0zvOwRKGCRAxDVXEAYPyKqg=;
        b=PVC9bs6r7ShAZe5GllKQ0MolthfZtL4PPiuZc/Kludc9S1FJV7AesGlzNGp2Ba5lfc
         5GCJAZHfg1OgqdakwtYAI4aYYG4OIyQ9x/e3y7NED5RpfCtv8ZvU0XQy3xbv7rXG/JpN
         WWXq5saArymzUnmAQkuOJJQ4gFNdfSRGbHQ+P4j/wHXvi0mCfJHe1zJ755+KkbcJbyY/
         5t66Hhr9i0BGmdACwSWJV3wcuHZAa4LWXsMQjiin9JF/fUDikWNsKmo4S3JQ8eB5NoWW
         jLpA0Rl62SjwkTk2yA1Nte7hgvvG7AJ2XbEROXKjUY9B1es6xHsh0d26eaBhIJkV6WRb
         8ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736814665; x=1737419465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZVnyOAOBWDLwQQHfj0z0zvOwRKGCRAxDVXEAYPyKqg=;
        b=RV/VWyMF7N30XGVuTyBRvKJPt/3p0WkOnspsLkUNcwqW2HqGXTKEAPi7ikrxcUylYL
         Lcua3f7ZuuvDxXYGMvArS10IYi6ANUo72p/HUBWlhyHSLNKbyNdy7QO//GNHVCtCeDys
         9QvFD09Mn4FYT3r6xFiVSMWdVcPQCJYP0hYzwottDxymAkNEuHC2jJmi7FbXMC5JzoHT
         PdghZjY14MeYgv2PXix2FFgZbdlKc6JFc8rwuIBjfvCeAnJOkWOkSxU/nYw9p+4RX5HM
         y0vobFjVcNqsn1xwRDfHk8NmZp4UOhUv8k0cx7pcTS4CSK4c6mEVEbpZLG/sEzV2gNj3
         Xr7g==
X-Gm-Message-State: AOJu0YzraKd1WZ4TYAbg5aGpTEAxIOMPO9dLrV7/wL2DygOjXut9o1aP
	LCuHO+irPZVOxqIEnIKRc4ZVvPd//CVIMObDLkMnhCJW6dW/YW8Sdgn49A==
X-Gm-Gg: ASbGncsej2jFxc9HposKl8KQADpaVjY5v3liVe1iG2hed00+kvewQHXVxPxnplR+kv5
	+85McapNz16Rz4v0xbrmaNbzMM2RGkcNPsBVFbxp3XxG6ICocKy4dU0opwRgedbca08LEJ7175Z
	ck/OxgAQLkx1i8tcXvbTgszkJy32AQ4huLmVg9lDlUJMnJWT7fzy9jkXlMrrItoR+jVJUmLTCtK
	uUGo+tZogpNeAZXgwhcQRAy9Nx+REovyIEYD0Ys7+bjHqIaytoSKSXA1zbNaemFMKvvlA==
X-Google-Smtp-Source: AGHT+IEIAF08KuY9FgU7IYq+ZDHGWcXDSVAEn8yf9lul9zTSCcabcq7Mv0m39WT1UIN9cTFbe80+VQ==
X-Received: by 2002:a05:6a20:c88b:b0:1e1:a693:d5fd with SMTP id adf61e73a8af0-1e88d128f5dmr36279667637.25.1736814664832;
        Mon, 13 Jan 2025 16:31:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31902b137bsm7362261a12.35.2025.01.13.16.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:31:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 Jan 2025 16:31:02 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [RFC PATCH 1/4] efi/libstub: Avoid legacy decompressor zlib/zstd
 wrappers
Message-ID: <3d6f2bb7-3c23-4df7-a787-034bb30bff19@roeck-us.net>
References: <20241218150316.1583806-6-ardb+git@google.com>
 <20241218150316.1583806-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218150316.1583806-7-ardb+git@google.com>

Hi,

On Wed, Dec 18, 2024 at 04:03:17PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Remove the dependency on the decompression wrappers used by the legacy
> decompressor, which do some odd things like providing a barebones
> malloc() implementation. Instead, implement GZIP deflate and ZSTD
> decompression in terms of the underlying libraries.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

With this patch in linux-next, my loongarch boot tests with qemu
no longer boot. Log message is:

qemu log:
EFI stub: Decompressing Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable
EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
EFI stub: Exiting boot services

... and then there is nothing until I abort the emulation.

Reverting this patch results in a build failure, so I awas not able to
test it. Bisect results are atatched for reference.

Guenter

---
# bad: [37136bf5c3a6f6b686d74f41837a6406bec6b7bc] Add linux-next specific files for 20250113
# good: [9d89551994a430b50c4fffcb1e617a057fa76e20] Linux 6.13-rc6
git bisect start 'next-20250113' 'v6.13-rc6'
# good: [25dcaaf9b3bdaa117b8eb722ebde76ec9ed30038] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 25dcaaf9b3bdaa117b8eb722ebde76ec9ed30038
# good: [c6ab5ee56509953c3ee6647ac9f266a7c628f082] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
git bisect good c6ab5ee56509953c3ee6647ac9f266a7c628f082
# good: [37b72ff92ef30c021dca27cc5673d8c4bad49f8b] Merge branch 'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
git bisect good 37b72ff92ef30c021dca27cc5673d8c4bad49f8b
# good: [be5db029f3b05a02234a4b1530c0b3cdaf974718] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect good be5db029f3b05a02234a4b1530c0b3cdaf974718
# good: [6071064d2ffec442f437277f7d411839b4898a77] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
git bisect good 6071064d2ffec442f437277f7d411839b4898a77
# bad: [7a7dd09ee43911c0c1f4cc65bcef2aa6482f0e91] Merge branch 'rust-next' of https://github.com/Rust-for-Linux/linux.git
git bisect bad 7a7dd09ee43911c0c1f4cc65bcef2aa6482f0e91
# good: [f97b043bb40f86c715a50ba415d7fcdbed926b78] Merge branch 'zstd-next' of https://github.com/terrelln/linux.git
git bisect good f97b043bb40f86c715a50ba415d7fcdbed926b78
# bad: [dd60abee3f85689f8a6b5c817ed7f7dcc56ef822] Merge branch 'slab/for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
git bisect bad dd60abee3f85689f8a6b5c817ed7f7dcc56ef822
# bad: [6f18bb40970790b176a7aede3f1054fa7b9aa718] efi: sysfb_efi: fix W=1 warnings when EFI is not set
git bisect bad 6f18bb40970790b176a7aede3f1054fa7b9aa718
# bad: [9e45f9e16bc4d8fa963399808463d0f478e01911] efi/libstub: Simplify GOP handling code
git bisect bad 9e45f9e16bc4d8fa963399808463d0f478e01911
# bad: [7f0158f3ee12403c26e815c9df4f00d41ee3bb41] efi/libstub: Avoid legacy decompressor zlib/zstd wrappers
git bisect bad 7f0158f3ee12403c26e815c9df4f00d41ee3bb41
# good: [ec4696925da6b9baec38345184403ce9e29a2e48] efi/libstub: Bump up EFI_MMAP_NR_SLACK_SLOTS to 32
git bisect good ec4696925da6b9baec38345184403ce9e29a2e48
# first bad commit: [7f0158f3ee12403c26e815c9df4f00d41ee3bb41] efi/libstub: Avoid legacy decompressor zlib/zstd wrappers

