Return-Path: <linux-efi+bounces-440-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF518446DB
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jan 2024 19:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA52E1C20FB2
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jan 2024 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD713D4E0;
	Wed, 31 Jan 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="xowoJAbK"
X-Original-To: linux-efi@vger.kernel.org
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347713BEBB;
	Wed, 31 Jan 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.3.6.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724590; cv=none; b=sTz0Qk0FYuSuCdG4fWYTCeXxtAIq7qlS5BUpRaI3Ez+q67QAkt4+1skVaBWj9bwdfegfDRMdj+59c2i8wkxQmWXIWMe/NZXpXN9jJQvGIPzwPRbyUm7qxx+SKWht7kOQ9ZmQjbRT+626P8lJDFUkckVxrblLRL3IWImdsBrvlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724590; c=relaxed/simple;
	bh=Jbg1khAPXAP0D0M33pUw4sbIH9nPHijOll31hgqZvY4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IScdhvBMi0TNfASjF8T6uB8VEW8zncT1C4PnGIrSoswGC81eACXbhtDyqPvZH2sVrizv8W7Wx4PW99yh3v/dgajFvjFyrNErSKXVQPrqM+uJurpDOnO/U8rxEghN5PP7AWg74Ff9cgqpIOoIigxgXxKJfWEVUqmbMvZQBqiYyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=xowoJAbK; arc=none smtp.client-ip=81.3.6.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id 8C40A1060358;
	Wed, 31 Jan 2024 18:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706724059;
	s=s1; d=bens.haus;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=Txe3rfKMnaACBeFH2ZoYxnvtSXDloicSWeBPN5RquaM=;
	b=xowoJAbKaR9TPnzwVz02oy9hFwfY4irSWY4WW3K6/3nCf36HxWOx+/f/CWb/bW/H
	TFZv2L9G5EUuIDUy7MYMFFMZ6s+taAgEoOyaP5pWuihIyQtXpy0BWQALWdGcctRceXX
	D0ivNf43ob42weic5QOUMciALY05UfcmFpKn+4umJrObl5+QaSsjzhYHcl0Kwybk+zF
	D3vLLPg819cN4nnCaKTQlilQiIvMzyYJ6/kYdHnFpo3SY9XEn9A7b4NskwDSGQjs6ea
	oihUe2/rXpI6669dZCt8RwjNE+z76GkcGz+cTmT9LDpRYXqsBwK3+ULC3fmT7xaAuWc
	uUJfys9J5w==
Date: Wed, 31 Jan 2024 19:00:59 +0100 (CET)
From: Ben Schneider <ben@bens.haus>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Regressions <regressions@lists.linux.dev>,
	Linux Efi <linux-efi@vger.kernel.org>,
	Stable <stable@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <NpVfaMj--3-9@bens.haus>
In-Reply-To: <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com>
References: <Nh-DzlX--3-9@bens.haus> <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com> <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com>
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Oct 18, 2023, 09:17 by heinrich.schuchardt@canonical.com:

> On 10/18/23 10:34, Ard Biesheuvel wrote:
>
>> (cc Heinrich)
>>
>> Hello Ben,
>>
>> Thanks for the report.
>>
>> On Wed, 18 Oct 2023 at 03:19, Ben Schneider <ben@bens.haus> wrote:
>>
>>>
>>> Hi Ard,
>>>
>>> I have an ESPRESSObin Ultra (aarch64) that uses U-Boot as its bootloader. It shipped from the manufacturer with with v5.10, and I've been trying to upgrade. U-Boot supports booting Image directly via EFI (https://u-boot.readthedocs.io/en/latest/usage/cmd/bootefi.html), and I have been using it that way to successfully boot the system up to and including v6.0.19. However, v6.1 and v6.5 kernels fail to boot.
>>>
>>> When booting successfully, the following messages are displayed:
>>>
>>> EFI stub: Booting Linux Kernel...EFI stub: ERROR: FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value
>>> EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 64k boundary
>>> EFI stub: Using DTB from configuration table
>>> EFI stub: ERROR: Failed to install memreserve config table!
>>> EFI stub: Exiting boot services...
>>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
>>>
>>> I suspect many of the above error messages are simply attributable to using U-Boot to load an EFI stub and can be safely ignored given that the system boots and runs fine.
>>>
>
> These messages are not typical for launching a kernel via the EFI stub from U-Boot. It should look like this:
>

All, I can confirm that this issue is not present using upstream U-Boot (v2024.01). That is, EFI stub booting works as expected and does not display any error messages. Thanks!

Ben

#regzbot invalid: issue is with device firmware (u-boot)

