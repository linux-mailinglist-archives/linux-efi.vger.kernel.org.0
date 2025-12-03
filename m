Return-Path: <linux-efi+bounces-5782-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3ADC9EBA8
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 11:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FD694E02CB
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2252E1EE0;
	Wed,  3 Dec 2025 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IYnkZBxi"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B232EDD57
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758088; cv=none; b=SOwUERESKD3SaS07rJYj0gB0MdCUyyrRME1tOGqPQC6tK8eujpIeNIJ869WOnJC2I+EM6EcJ9HUgrM6t33N0phgor1+WVXc6lAkBcQpPIB3UkWLsLxrHsTmr4Ca+gD9nMKLct212MxUd6JTzzdLyzYt3goNj3bPOafCuYyk84zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758088; c=relaxed/simple;
	bh=uM9ct+2gRKamethOLOfGaVdzg1ZMjfI67x/EDmGkijM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9BdlI89mPnv14yOgkE/8EX4Wd9AYCFbde3H+pF8jEhH82ncn3oepdEOtzm3l8hjbJIXN9YjVFBUabLdrB8u2DQNheow5NW5MthcmcqW6xBLnU5dQHM/xAO2qZBTQfi8xxJXneeo2Ea8G50GFsG77K89UebOykfz6kwPRr2FRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IYnkZBxi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PpUfdJHwdojNrfkXdTCuNur4bUbvxmOOvLtJ5J61PEQ=; b=IYnkZBxibqVbt89a0LmY6ikYLW
	iDSzwUx6vpM+1PV0Mr7OnQlgwTa80zvbGBZuO+ba/J6kY8sDfNnWPSBc4yybrtLd4nygF0wFSSlqM
	0GfP5dX/D8kcRTFy+qpSa2Qgk3LhG3cr/a7IuP9J0k+YuOFOPE6hFCG1aOXAsTD1M8TxpBpMY8mNC
	UwtxC6jF0ooVUkxPCEsWXl94cKeEj91gq0bxa7UyowMCQIKb5HHpfxn1bbbGFcoXedvt+5AeQWhe6
	SKplobogoN3NIa0xGs3X1vtQ/yhyUvBBBxgSN6nqSaeUIt9v09qY5UaQyBF7jwcGbzFqsQirF2QW/
	qbtuO/PQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vQkBu-008E8N-Bg; Wed, 03 Dec 2025 11:34:34 +0100
Message-ID: <caaf2e08-0770-4808-8872-e432e2ff5ec4@igalia.com>
Date: Wed, 3 Dec 2025 10:34:33 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] efi: sysfb_efi: Fix efidrmfb and simpledrmfb on
 Valve Steam Deck
To: Thomas Zimmermann <tzimmermann@suse.de>, Ard Biesheuvel <ardb@kernel.org>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Melissa Wen <mwen@igalia.com>, linux-efi@vger.kernel.org
References: <20251203090706.53778-1-tvrtko.ursulin@igalia.com>
 <20251203090706.53778-5-tvrtko.ursulin@igalia.com>
 <5ecc23ed-929f-4e60-a7a1-d4bd759e9af2@suse.de>
 <CAMj1kXEVq65rBQraKn8kcCiA6wU7tPfCCbf2Bma4F3p0As3ToQ@mail.gmail.com>
 <e5acaa09-a92f-48d1-b2af-64a120242de9@suse.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <e5acaa09-a92f-48d1-b2af-64a120242de9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/12/2025 10:29, Thomas Zimmermann wrote:
> Hi
> 
> Am 03.12.25 um 11:13 schrieb Ard Biesheuvel:
>> On Wed, 3 Dec 2025 at 11:05, Thomas Zimmermann <tzimmermann@suse.de> 
>> wrote:
>>> Hi
>>>
>>> Am 03.12.25 um 10:07 schrieb Tvrtko Ursulin:
>>>> Valve Steam Deck has a 800x1280 portrait screen installed in a 
>>>> landscape
>>>> orientation. The firmware offers a software rotated 1280x800 mode which
>>>> GRUB can be made to switch to when displaying a boot menu. If this mode
>>>> was selected frame buffer drivers will see this fake mode and fbcon
>>>> rendering will be corrupted.
>>>>
>>>> Lets therefore add a selective quirk inside the current "swap with and
>>>> height" handling, which will detect this exact mode and fix it up 
>>>> back to
>>>> the native one.
>>>>
>>>> This will allow the DRM based frame buffer drivers to detect the 
>>>> correct
>>>> mode and, apply the existing panel orientation quirk, and render the
>>>> console in landscape mode with no corruption.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>> Cc: Melissa Wen <mwen@igalia.com>
>>>> Cc: linux-efi@vger.kernel.org
>>>> ---
>>>>    drivers/firmware/efi/sysfb_efi.c | 56 +++++++++++++++++++++++++++ 
>>>> ++---
>>>>    1 file changed, 51 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/ 
>>>> efi/sysfb_efi.c
>>>> index eacf9a50eab2..566492e67798 100644
>>>> --- a/drivers/firmware/efi/sysfb_efi.c
>>>> +++ b/drivers/firmware/efi/sysfb_efi.c
>>>> @@ -231,16 +231,42 @@ static const struct dmi_system_id 
>>>> efifb_dmi_system_table[] __initconst = {
>>>>        {},
>>>>    };
>>>>
>>>> +struct efifb_mode_fixup {
>>>> +     unsigned int width;
>>>> +     unsigned int height;
>>>> +     unsigned int linelength;
>>>> +};
>>>> +
>>>>    static int __init efifb_swap_width_height(const struct 
>>>> dmi_system_id *id)
>>> It's something different now. Can this please become a separate list
>>> with a separate callback?
>>>
>> Why? That means we have to introduce another dmi_check_system() call,
>> and manually implement the logic to ensure that it is not called
>> redundantly, i.e., after the first one already found a match.
> 
> If the separate list isn't feasible, let's at least have a separate 
> callback.

Ard asked for that already so in v3 it is already separate.

I have also locally changed 2/4 to use 
__screen_info_lfb_bits_per_pixel() and if now everyone is happy I can 
send out a v4 with that?

Regards,

Tvrtko


