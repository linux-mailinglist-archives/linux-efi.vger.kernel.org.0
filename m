Return-Path: <linux-efi+bounces-3923-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD8AE4CB1
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 20:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2162188AA31
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD502D028A;
	Mon, 23 Jun 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="i1Z1mr4R"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964729CB39;
	Mon, 23 Jun 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702788; cv=none; b=OJgK/Prn5ztHn6Z++3pmU6/3o5K9l9AtsY3dxej++919/JtywKOVYmA2448Xk5QFDoJmZZSZ92YEOZ7fgI6JHK6Qh0EuHkPnybjedz4JxmNCLusqA1oqBUGXu1c8mErmbngLiMjrPwx4aEOuqpjxLnmeYx38E9kU54v1hd9/MLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702788; c=relaxed/simple;
	bh=ESf+LmadPkuTIyz4p6caha2CR4G2QyEwoMSgk144nGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grroFXK2Pcssz/fIA+zr9ePAo2wgxJh4oh7hmPpr77JWY+4H8t3102W9fxE0wZQy1qdub3Om132OUp9I1EMkrysPAfTd42cYK0JSggQXoVCLIHeRa8X4j4YYmsR0tpq/ffLVYGT5hIGTnf4wkpq9Y7o0ujk0ltx9Liy3hNw7g4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=i1Z1mr4R; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9482:eb50:9bbc:f4fe:cc43] ([IPv6:2601:646:8081:9482:eb50:9bbc:f4fe:cc43])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55NIJGD81039127
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 23 Jun 2025 11:19:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55NIJGD81039127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750702759;
	bh=GiAXLdNp3nC3MavPq2unzj2t9vG7BnSpq1GDijjcQag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i1Z1mr4RnE/r6kjX+XxW5qkUpy/IvwDlsZ6mfEbVtg2BWUoThKbOq++bUIt2VB7aK
	 2WEmr6DpBGumss8s4LBiupLAhey4HG4h/LgHh6SxBv81tb76MyfOpWkpNPv+4K/okr
	 +6gZntfXXT6b2hkwbJ5c7nD0cOd+UNM1Hzwn+1A8dIp+rJXFNvyMOiuQx2Ulx5dixd
	 bnvIMD0641zDsPxh3mWiDLdbA0bUd0JyjxAZkofqZffOnRcsOhEG7zR3ort9EYx7KW
	 qkwjst0yMz3plYG0XWyGM0NjkCNuCdnq1zarQlduM8t6LJiaK2tk3f6w2E+jdBdyne
	 ddtK71QhG5sWQ==
Message-ID: <860684c8-a985-47bc-af30-3370f203e80d@zytor.com>
Date: Mon, 23 Jun 2025 11:19:11 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] x86/boot: Supply boot_param in rdi instead of rsi
 from startup_64()
To: Khalid Ali <khaliidcaliy@gmail.com>, brgerst@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        ubizjak@gmail.com
Cc: x86@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623162935.681-1-khaliidcaliy@gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250623162935.681-1-khaliidcaliy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-23 09:29, Khalid Ali wrote:
>> This was never intended to conform to the C ABI, why is it necessary
>> to change it?
> 
> Technically speaking, you are right, however that doesn't mean we can put something where
> ever we like. We came from C code which is bootloader and we end up to C code, so we should
> comply the ABI here too.
> 

This is also invoked by some external bootloaders that boot the ELF 
image directly, even though this is strongly discouraged.

Therefore this patchset is NAKed with extreme prejudice.

	-hpa


