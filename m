Return-Path: <linux-efi+bounces-2157-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC759CDCFE
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 11:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C742B25D6A
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F815188015;
	Fri, 15 Nov 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLuSiSwh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93C7D3F4
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667869; cv=none; b=dUZZBmcIr6K1FJreDgZHUngFPIH6ASar7NVPayP/BrJQTY6885qhaoVU06uRL7PF24gn14BrFgZxJks8aozA/lQAWw4aLaXY5KIFSh6oh9F2lGe/0dDPsgUU+Hm7ZcBACrRNvACTHI66GWAkEAD2W37nSMYQQGFRbVNPPwmdets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667869; c=relaxed/simple;
	bh=rOl0UMWJ3apTL9t5jcQt2DXami7SGKvK07tn/yG0Vkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGrsfv3tmZuwdY0whCw2NrcyxLyAHJNKhS920jnxFJYiyEUFtSp8Ge46LzXI0cIYmpB/ei26VIyLxjI/KRTNMKm9esa7r/o4iwVKL8laft4KClDOqQDTJmCEzwVv1obxQXROWY9b4avW3XNcjbitTsQn2ZJBKPzqL7LOWjaXjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLuSiSwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61935C4CECF;
	Fri, 15 Nov 2024 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731667868;
	bh=rOl0UMWJ3apTL9t5jcQt2DXami7SGKvK07tn/yG0Vkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tLuSiSwhvP2EOD0BXb+vVXsK9FxPXa2BOSyix+xg84oJjJk6YU2n9J3Yli8jcKxsD
	 cxaUPmp2X3lht4XFquoBIE4pfynI1epoybBs7t6tzZwbKJ5gxuSTTLXLfLrZ2gE4Bg
	 h5ItRL2A5/vUlYhOc9OMH2hIqQrncPsRh+kT5em2WvFWXAbOAf6KFJsYrq1aLfhj3L
	 LnyQTn/DqiEn6HRJuujqX+/g9T+OsbXYWzS0CNHNfq5fRRlW1gbiAzBL1kREnlntDN
	 SXALWKVQ84iTD85npHY2dT9r0NOtYeZFG1Ilxn3mDip7vckuXdBpTQBpVWaHJfUSi1
	 AjQ03sR2rS3WQ==
Message-ID: <0ee375db-c720-4af3-a74b-d95777212f6e@kernel.org>
Date: Fri, 15 Nov 2024 11:51:05 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi/memattr: Ignore table if the size is clearly bogus
To: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>
References: <20241031175822.2952471-2-ardb+git@google.com>
 <20241115-honored-macho-deer-dc6def@leitao>
 <CAMj1kXFjjMcHkbFAsSWJuqtzi2raJgLikx37ipxAB9f0ymXNQA@mail.gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CAMj1kXFjjMcHkbFAsSWJuqtzi2raJgLikx37ipxAB9f0ymXNQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 11. 24, 11:21, Ard Biesheuvel wrote:
> On Fri, 15 Nov 2024 at 11:10, Breno Leitao <leitao@debian.org> wrote:
>>
>> Hello Ard,
>>
>> On Thu, Oct 31, 2024 at 06:58:23PM +0100, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> There are reports [0] of cases where a corrupt EFI Memory Attributes
>>> Table leads to out of memory issues at boot because the descriptor size
>>> and entry count in the table header are still used to reserve the entire
>>> table in memory, even though the resulting region is gigabytes in size.
>>>
>>> Given that the EFI Memory Attributes Table is supposed to carry up to 3
>>> entries for each EfiRuntimeServicesCode region in the EFI memory map,
>>> and given that there is no reason for the descriptor size used in the
>>> table to exceed the one used in the EFI memory map, 3x the size of the
>>> entire EFI memory map is a reasonable upper bound for the size of this
>>> table. This means that sizes exceeding that are highly likely to be
>>> based on corrupted data, and the table should just be ignored instead.
>>
>> I haven't seen this patch landing in net-next tree yet.
>> Do you have plan to have this merged into 6.13?
>>
> 
> Nobody replied to it, so I wasn't going to.
> 
> Would you like this patch to be taken for v6.13? Does it fix the
> issues you have been observing?

For the reporter at:
   https://bugzilla.suse.com/show_bug.cgi?id=1231465#c50
definitely!

I was expected this to land in the tree too... (Without any further 
notifications to you.)

thanks,
-- 
js
suse labs

