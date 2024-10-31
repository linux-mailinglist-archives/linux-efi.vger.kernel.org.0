Return-Path: <linux-efi+bounces-2075-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6319B769F
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 09:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF89EB21721
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF68A1552EE;
	Thu, 31 Oct 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQKkET2I"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565ED517;
	Thu, 31 Oct 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363934; cv=none; b=qUxX6MWxPniMun52Y3PTGtNGLimLSNjsPlQeG+h/HtTHvLXU+ehrEdAekqwJGF/pZmIqrlHuDeYsI8UOgxzik5uXCCj+W/XYBLqLF9ezBjl5XtMT4P8OziHtnTI6/lHlS6bv92vi8NR7DyG3EweKutHoC3mJAvhygWKb4JzKFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363934; c=relaxed/simple;
	bh=cm/v1kzbIezMQxmU5NpIlNL1u/w90ZyIbDSAkvOdDC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBcVRYEddU9Wg8o9CAPJyDmu7a5GzeZ49O4Q3OiYH+JPBarhmTNaXMAgAlHK0wEuleTo9GBNV8AFAuClOk8Pqmp+5oVsdO0gkmX1qe722rFXECF3yE1XLiMf5Xqz+8Qf9fWqLkOWawapLt9k3qVHXvwVXoMfAAZqEjVGjzeqZlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQKkET2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8399C4CEC3;
	Thu, 31 Oct 2024 08:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730363934;
	bh=cm/v1kzbIezMQxmU5NpIlNL1u/w90ZyIbDSAkvOdDC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WQKkET2IeoBIjonqHvhocH8LPa1CeOUIM5L+xtOLiJHr8Hdoh8tqVXWUs7GiR4DcY
	 G/Ot7AqKQD0vTC6EgbiuOmKjh9si/ozjjcvLZ9gW/fULTUGzs3ownelJDK6V5PLICC
	 b3/IMSZqKKw9ONYe15SyrN5MiftOEBLPoUgQHFNfGD+OWZb3kz+c0zmVmKF27Mzu7L
	 D40/RLSJZKX38gbIcndeQSCgalASSAec3SzrvILd9A8RGoGB/NESB3ZMNyqP1DAbjf
	 +sVtxqBAkE3JhGix/4zJqiUTx+X8MFw32rZoAr4zmhDgieQBkGfqvS9cKCmP2UT4Ai
	 e0Nc/c8N1DOCg==
Message-ID: <309cfc74-62f5-45e6-96a9-c9cd085d9fee@kernel.org>
Date: Thu, 31 Oct 2024 09:38:50 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
To: Usama Arif <usamaarif642@gmail.com>, Gregory Price <gourry@gourry.net>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>
References: <20240912155159.1951792-2-ardb+git@google.com>
 <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
 <58da4824-523c-4368-9da1-05984693c811@kernel.org>
 <899f209b-d4ec-4903-a3e6-88b570805499@gmail.com>
 <b7501b2c-d85f-40aa-9be5-f9e5c9608ae4@kernel.org>
 <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com>
 <ZyJ0r_zZ5UD8pvzX@PC2K9PVX.TheFacebook.com>
 <30899696-def7-4f1e-a54b-65fc6901a998@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <30899696-def7-4f1e-a54b-65fc6901a998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30. 10. 24, 19:24, Usama Arif wrote:
> This is a good point. I think if we suspect this patch, it would be good to compare
> dmesg of kernel cold boot with this patch vs the commit just before this patch, rather
> than comparing with 6.12.

Here it goes then:

dmesg for 2e6871a632a99d9 (bad -- patch applied):
https://bugzilla.suse.com/attachment.cgi?id=878297

dmesg for bc2846c7ab029f0 (good -- before the patch, i.e. 2e6871a632a99d9^):
https://bugzilla.suse.com/attachment.cgi?id=878298

(6.11-stable SHAs ^^^)

$ wdiff -n good bad |colordiff
BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
BIOS-e820: [mem 0x0000000000059000-0x000000000009efff] usable
BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
BIOS-e820: [mem [-0x0000000000100000-0x000000006a5acfff]-] 
{+0x0000000000100000-0x0000000066a17fff] usable+}
{+BIOS-e820: [mem 0x0000000066a18000-0x0000000066a27fff] ACPI data+}
{+BIOS-e820: [mem 0x0000000066a28000-0x000000006a5acfff]+} usable
BIOS-e820: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
BIOS-e820: [mem 0x000000006a5ae000-0x000000006a5aefff] reserved
BIOS-e820: [mem 0x000000006a5af000-0x0000000079e83fff] usable
BIOS-e820: [mem 0x0000000079e84000-0x000000007a246fff] reserved
BIOS-e820: [mem 0x000000007a247000-0x000000007a28efff] ACPI data
BIOS-e820: [mem 0x000000007a28f000-0x000000007abf0fff] ACPI NVS
BIOS-e820: [mem 0x000000007abf1000-0x000000007b5fefff] reserved
BIOS-e820: [mem 0x000000007b5ff000-0x000000007b5fffff] usable
BIOS-e820: [mem 0x000000007b600000-0x000000007f7fffff] reserved
BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000087e7fffff] usable
NX (Execute Disable) protection: active
APIC: Static calls initialized
e820: update [mem 0x66a07018-0x66a17457] usable ==> usable
extended physical RAM map:
reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
reserve setup_data: [mem 0x0000000000059000-0x000000000009efff] usable
reserve setup_data: [mem 0x000000000009f000-0x00000000000fffff] reserved
reserve setup_data: [mem 0x0000000000100000-0x0000000066a07017] usable
reserve setup_data: [mem 0x0000000066a07018-0x0000000066a17457] usable
reserve setup_data: [mem [-0x0000000066a17458-0x000000006a5acfff]-] 
{+0x0000000066a17458-0x0000000066a17fff] usable+}
{+reserve setup_data: [mem 0x0000000066a18000-0x0000000066a27fff] ACPI 
data+}
{+reserve setup_data: [mem 0x0000000066a28000-0x000000006a5acfff]+} usable
reserve setup_data: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
reserve setup_data: [mem 0x000000006a5ae000-0x000000006a5aefff] reserved
reserve setup_data: [mem 0x000000006a5af000-0x0000000079e83fff] usable
reserve setup_data: [mem 0x0000000079e84000-0x000000007a246fff] reserved
reserve setup_data: [mem 0x000000007a247000-0x000000007a28efff] ACPI data
reserve setup_data: [mem 0x000000007a28f000-0x000000007abf0fff] ACPI NVS
reserve setup_data: [mem 0x000000007abf1000-0x000000007b5fefff] reserved
reserve setup_data: [mem 0x000000007b5ff000-0x000000007b5fffff] usable
reserve setup_data: [mem 0x000000007b600000-0x000000007f7fffff] reserved
reserve setup_data: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
reserve setup_data: [mem 0x0000000100000000-0x000000087e7fffff] usable
efi: EFI v2.6 by American Megatrends
efi: ACPI=0x7a255000 ACPI 2.0=0x7a255000 SMBIOS=0x7b140000 SMBIOS 
3.0=0x7b13f000 TPMFinalLog=0x7a892000 ESRT=0x7b0deb18 
[-MEMATTR=0x77536298-] {+MEMATTR=0x7752f018+} MOKvar=0x7b13e000 
RNG=0x7a254018 TPMEventLog=0x66a18018

thanks,
-- 
js
suse labs

