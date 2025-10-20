Return-Path: <linux-efi+bounces-5073-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 587B8BEEFDF
	for <lists+linux-efi@lfdr.de>; Mon, 20 Oct 2025 03:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8E644E4017
	for <lists+linux-efi@lfdr.de>; Mon, 20 Oct 2025 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A621C8611;
	Mon, 20 Oct 2025 01:24:17 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6A19B5A7;
	Mon, 20 Oct 2025 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760923457; cv=none; b=VJEP9ji2stBAb0bsN4BeI+mOEBugeJZktAd4FnW8GYt4XlGr2kf2zE+mpP9hAnWPYiz1cYceiT6IJnNYOHLlPc8Hz8ct6ZhH9RshNtHlSHmXqWLIIE9A2mw/O2vjNKSxv161COx0mYXP0h24kycsCF6x6xmXVQpyZVBNdbDe9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760923457; c=relaxed/simple;
	bh=v7X4C2h2L+kGvezMXwy4G6A4IXMrDu2HuF/hi0zlsSI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GMrPgJDV87OQzIglZbWe7AmuQKWhRu+JlvF2kdheRRSsbaK+WB7oYxelCvGu6c/Wl0h+6p30/hVpVrzCXz0J7PxSyXgc9OHci9bfljrSh5QuIwYWElzRmVdV5m2TLAPHyc45vUlZizQkse4TIEv1ga8+tcf3mgKvfYKBOpm1o7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxidEzj_Vo0xkYAA--.52055S3;
	Mon, 20 Oct 2025 09:24:03 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOQyj_Vo+iH3AA--.20492S3;
	Mon, 20 Oct 2025 09:24:02 +0800 (CST)
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Josh Poimboeuf <jpoimboe@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
 <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
 <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
 <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
 <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
 <lgyzruqczm7uti2lfbhfhr5hyzpnm7wtvgffa2o7nigx76g6i3@wlffltvmhhez>
 <CAMj1kXFDquPxCYSBWgjikS=209pSJ_kth67M0RDeuetV9CPYAw@mail.gmail.com>
 <wlx6pt5crtfdwtop4w5vjznjfarrwitq44wdbufncjdvtsx647@tgobruak66yb>
 <CAMj1kXFfEBkcc-aiwGrRR-pKg4LBbS7weK0pEpZJsKOk5pbkuA@mail.gmail.com>
 <jxfb5a2c2qber623l2gwewirwod54bbgfnvt7t7f3jah2ea33g@2uyhy3auzmpx>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d9f3352a-1c1f-464a-a8fd-741cd96b5f8e@loongson.cn>
Date: Mon, 20 Oct 2025 09:24:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <jxfb5a2c2qber623l2gwewirwod54bbgfnvt7t7f3jah2ea33g@2uyhy3auzmpx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOQyj_Vo+iH3AA--.20492S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
	AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U8zwZ7UUUUU==

Hi Josh, Ard and Huacai,

On 2025/10/18 上午1:05, Josh Poimboeuf wrote:

...

> But IIUC, the libstub code runs *very* early, and wouldn't show up in a
> stack trace anyway, because there are no traces of it on the stack once
> it branches to head.S code (which doesn't save the link register).

Thanks for your discussions.

Are you OK with this current patch?
Or should I update this patch to remove the changes of arm64 and riscv?
Or any other suggestions?

Thanks,
Tiezhu


