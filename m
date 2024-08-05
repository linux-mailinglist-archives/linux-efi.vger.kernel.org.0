Return-Path: <linux-efi+bounces-1529-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62226947317
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 03:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9A7280E66
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 01:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE229CEA;
	Mon,  5 Aug 2024 01:35:30 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B520B0F;
	Mon,  5 Aug 2024 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821730; cv=none; b=VGDK9F22K/AhAKGfXevq/9ho2rFfd4eJjKJ3IiEt0WqEnnBvY8+vj1w8e/pY8/ldhHhbY4VNj6VO7XFjqYgbk6vKj5Gvk64LJLbpFum9b39EE9fgSKBjIH6HJcKLitImJP3Y87SI6o9sT71Pmon/ceNAW1Hz+k41tMwhitCWbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821730; c=relaxed/simple;
	bh=5Ft2C1CrYgeGCh8XCmE/taW28pK6gRX4dv5IWvqhX2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H/OmkBsPrqhFA6DAWB6mv0/0i5H8HyRfrkSeY37GwSiY6yv5Uxaxry6toTJ3ZtRU8pU565FaioPGj3NOlAukHnmwMowOXVesF8WuXoF5b2h1M5WHZtBmkPN3puFHOR5vEGHx5xmIVnmCc2MuFenZjWFkcwaGCHD9DQs0S6cgiDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wcf5b6Lx8z2Cc9x;
	Mon,  5 Aug 2024 09:30:43 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C368F14037F;
	Mon,  5 Aug 2024 09:35:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 09:35:22 +0800
Message-ID: <46dd8990-df35-5044-7ab3-e1acb04de85f@huawei.com>
Date: Mon, 5 Aug 2024 09:35:21 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] ARM: Add support for STACKLEAK gcc plugin
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <ardb@kernel.org>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <robh@kernel.org>, <kees@kernel.org>,
	<masahiroy@kernel.org>, <palmer@rivosinc.com>, <samitolvanen@google.com>,
	<xiao.w.wang@intel.com>, <alexghiti@rivosinc.com>, <nathan@kernel.org>,
	<jan.kiszka@siemens.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20240624023612.2134144-1-ruanjinjie@huawei.com>
 <b8792d9c-c2a2-6808-f94b-e3b826232f78@huawei.com>
 <ZqzHNN27hwms0CB/@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZqzHNN27hwms0CB/@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/2 19:47, Russell King (Oracle) wrote:
> On Mon, Jul 22, 2024 at 10:53:10AM +0800, Jinjie Ruan wrote:
>> Gentle ping.
>>
>> On 2024/6/24 10:36, Jinjie Ruan wrote:
>>> Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
>>> stackleak common code: on_thread_stack(). It initialize the stack with the
>>> poison value before returning from system calls which improves the kernel
>>> security. Additionally, this disables the plugin in EFI stub code and
>>> decompress code, which are out of scope for the protection.
>>>
>>> Before the test on Qemu versatilepb board:
>>> 	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
>>> 	lkdtm: Performing direct entry STACKLEAK_ERASING
>>> 	lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)
>>>
>>> After:
>>> 	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
>>> 	lkdtm: Performing direct entry STACKLEAK_ERASING
>>> 	lkdtm: stackleak stack usage:
>>> 	  high offset: 80 bytes
>>> 	  current:     280 bytes
>>> 	  lowest:      696 bytes
>>> 	  tracked:     696 bytes
>>> 	  untracked:   192 bytes
>>> 	  poisoned:    7220 bytes
>>> 	  low offset:  4 bytes
>>> 	lkdtm: OK: the rest of the thread stack is properly erased
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Is this a feature that you have a use case for?

Yes, We have ARM32 products internally, and there is a need for security
hardening.

> 

