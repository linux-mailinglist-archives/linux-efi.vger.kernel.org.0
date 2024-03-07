Return-Path: <linux-efi+bounces-758-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66008874CE1
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 12:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976DA1C21AA1
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A486AC8;
	Thu,  7 Mar 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O7YpNnBq"
X-Original-To: linux-efi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE31E52A
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809373; cv=none; b=BnqDpT+eLWOdzmPGdcP2lOib5XhHEEUqYnU4umQTIlbNmBLKtg8+xvAxdRWtswKq1uMRH0RAZ6LehmMJufBdxNoF3tiVmq1SsIVcbX31tx/JpJE/IaxDbUfRDcxrKfHGvUj/++DHjoq8ij0BkWU7KhxpUqZnA6j5kQAoRRMLZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809373; c=relaxed/simple;
	bh=RAYg0PWvXOhU8QkQTPAb7YvL8n+oz5F+kOgKobdRYHk=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=MQYwfCazI/8Px6D8H+rWnjf93zi4AewHcSuPaEOENLnaws+A/mYQfSyxiPzrpXUba/Uhnw8BK26EBAA8BlZ3u0++1A2sm+kYHpQ0FB7d6CBvcD0xy6hUN1IPc8Z917pgM2wBs+FEeyo4ctHYVKJJd41dJgDfc96gNgvyoNIj/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O7YpNnBq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709809370;
	bh=RAYg0PWvXOhU8QkQTPAb7YvL8n+oz5F+kOgKobdRYHk=;
	h=Date:Cc:To:From:Subject:From;
	b=O7YpNnBqA09lxGEaAhINfbSSORXZHi6uA+V26y6tNlcoG19XL4pA3RVMTJg4Y6S02
	 ohBbhsGw8FkXOJHvUUutHcoRVT2dnzSTmR8Nu5ogHHYkvh1RQEzD3InHG+TNAsBUxB
	 M7Ee+jgHSXSSi/XrS38A9UFWh26H45Mg+6bB0GDpTfxmX+OhRfqYKeWYmTOzTOCbdJ
	 GZxDA5R1pJTyuy58vCAC0yD5I/OmB320YeaL6PMlgD6XqSezdOyUo5B1Rd0V2M6y4k
	 MxReI9yWeDqlLw1o+M6tdwKW1xgayOFxE0PopOUVVaJgEyREcwX9xK5H9X3C1hhr7t
	 BisvfwQAKZuEg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C86FE378149B;
	Thu,  7 Mar 2024 11:02:48 +0000 (UTC)
Message-ID: <0229a87e-fb19-4dad-99fc-4afd7ed4099a@collabora.com>
Date: Thu, 7 Mar 2024 16:03:14 +0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-efi@vger.kernel.org
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, Ard Biesheuvel <ardb@kernel.org>,
 "Kuppuswamy Sathyanarayanan," <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [Bug Report] Bug in "efi/libstub: Add get_event_log() support for CC
 platforms"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The recent patch:
276805fb9c305: efi/libstub: Add get_event_log() support for CC platforms
has introduced
#define EFI_CC_EVENT_LOG_FORMAT_TCG_2	0x00000002

But EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 has the same numerical value:
#define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2

Thus there is dead code in efi_retrieve_tcg2_eventlog() i.e, multiple if
conditions with (version == 2) I'm unable to decide on what is wrong and
what is right here. Please have a look.

-- 
BR,
Muhammad Usama Anjum

