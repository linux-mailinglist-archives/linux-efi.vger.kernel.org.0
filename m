Return-Path: <linux-efi+bounces-1298-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E1E91A0E4
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 09:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD47284000
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAE36F2F4;
	Thu, 27 Jun 2024 07:53:29 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008D73459;
	Thu, 27 Jun 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474809; cv=none; b=XVwK0M2Imt/fqCfLReXqBMtpMGFjq9l5fkMs5drMn0apP3ZmSf0qk6wpILf/2GE7xq8Nl+ESQVsHiDOzy2ghY/fU8rcRPhntjd7ubikbImBM5RbBp2q7DdJxQxW5xOQI+zjY8kCiLJaVVAqalKA7CuQadbagNku1uiki8ZKuoaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474809; c=relaxed/simple;
	bh=y27oOR7CX/FLDP+B98UBFuAeBZXX+uVPqpMt3Yy/Fjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TNJZ1+TJuvgtmG7p7FzfslhhhkNftagICn9luYeRU0dLgDOGOP5T0O+QR8Publ8UZm0V/oKbl1LYIO5Qxg+WyrXSaHGrJsB6obo+liP4O9ICzgC87ZyIoHyfA+AJxZVntO01BmOJ3rGGL3oY8tV+32NCAhF53SkvJjVCGjOAZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W8rLk6t9CzMrHB;
	Thu, 27 Jun 2024 15:49:34 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AC591403D4;
	Thu, 27 Jun 2024 15:53:16 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 15:53:15 +0800
Message-ID: <ee44c444-ab5e-b9c2-087b-5db627a72749@huawei.com>
Date: Thu, 27 Jun 2024 15:53:14 +0800
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
To: Linus Walleij <linus.walleij@linaro.org>
CC: <linux@armlinux.org.uk>, <ardb@kernel.org>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<eric.devolder@oracle.com>, <robh@kernel.org>, <kees@kernel.org>,
	<masahiroy@kernel.org>, <palmer@rivosinc.com>, <samitolvanen@google.com>,
	<xiao.w.wang@intel.com>, <alexghiti@rivosinc.com>, <nathan@kernel.org>,
	<jan.kiszka@siemens.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20240624023612.2134144-1-ruanjinjie@huawei.com>
 <CACRpkda-FZmyEyMJrKTdic4t8Zq_VSW8AVrvw6t=B25fiUZNKw@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CACRpkda-FZmyEyMJrKTdic4t8Zq_VSW8AVrvw6t=B25fiUZNKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/6/24 15:30, Linus Walleij wrote:
> On Mon, Jun 24, 2024 at 4:33 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
>> stackleak common code: on_thread_stack(). It initialize the stack with the
>> poison value before returning from system calls which improves the kernel
>> security. Additionally, this disables the plugin in EFI stub code and
>> decompress code, which are out of scope for the protection.
>>
>> Before the test on Qemu versatilepb board:
>>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
>>         lkdtm: Performing direct entry STACKLEAK_ERASING
>>         lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)
>>
>> After:
>>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
>>         lkdtm: Performing direct entry STACKLEAK_ERASING
>>         lkdtm: stackleak stack usage:
>>           high offset: 80 bytes
>>           current:     280 bytes
>>           lowest:      696 bytes
>>           tracked:     696 bytes
>>           untracked:   192 bytes
>>           poisoned:    7220 bytes
>>           low offset:  4 bytes
>>         lkdtm: OK: the rest of the thread stack is properly erased
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I was digging around to see if this would interfere with BPF
> trampolines, but the
> BPF code seems so generic that I assume it already takes stackleak into account.
> 
Thank you very much, as Kees said, can this patch go via
rmk's patch tracker now?

> Yours,
> Linus Walleij

