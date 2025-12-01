Return-Path: <linux-efi+bounces-5729-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B245C96ACF
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 11:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C724D3A3121
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 10:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0B30215C;
	Mon,  1 Dec 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="G9YcgJiO"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B40240611
	for <linux-efi@vger.kernel.org>; Mon,  1 Dec 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585206; cv=none; b=iQkveCQP8qElkVrMyOiuUh81tN9zBYw3ZSkKd7z8X8k9611g2kD12v7v/eRDBQaEiw1fVkfKNjVNJ2CULiBauw5JXzYCuXkb/iB3OEi/qKsGtgbupjLajMNhT/PCs2edlzLc0Ij4yWKgEzDtwYvlBX1r6sQrzlExZMD03f+9/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585206; c=relaxed/simple;
	bh=EtUN8VC0p9D75T7lZpFVXCdRpQRs5Zo8VQc2GyZQ2pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBeAM+hqJuabOt9cYcKRWN12WD+fT8Iq4OJ+OEPF0AYu0uxyAXkxEraKQGd1mc3ZHFApN1vXcr3jd3WDv9zWbXFD8rTNbs08lvC8XOvde/u1tES/7b63UOwurVELtwnZpfJ51XAy+FIr7o7b2LEjUYf4XwgeO1AEtvaJe6rFA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=G9YcgJiO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1UxRayKjfGmLzV11R6yiUvXi/gnqWdPw/R5Q/5Mgx3E=; b=G9YcgJiOoMdTQWx3HSu9I8osiK
	Q6UKaTUHkB2Kz7i2ssfb/xMvukhhiFxOq1MGXerwoiQQVdO4p0OrVEQ+rCAd0CsEvJQeWlD5s95yD
	4Jmls/MsMXcNg8swhe40zEvu5prQ5SGVPNy/MNCltv2EH33LevWIYrqbu94OpTGn8+ibvwYez/PO+
	xF1yCq3qBTb6hLSv1PTC1B5+WDf43iLGqpGI1lGchi5rAjCqPuMOGiG7uUbKGdedBoSOwUPDzg/H6
	wRVMIaa28IhERHRNhsUuwfyl8/qwHV9ERPerynrRC1TElhZAaNbd0iLiTCxLNRUkcpmxALo8ER/i/
	KVXfY/Mw==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vQ1DV-007L7I-G2; Mon, 01 Dec 2025 11:33:13 +0100
Message-ID: <07212b84-fc2a-4efe-a39b-5b536b6dd602@igalia.com>
Date: Mon, 1 Dec 2025 10:33:12 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFX] efi: sysfb_efi: Fix simpledrmfb on Steam Deck
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Javier Martinez Canillas <javierm@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-efi@vger.kernel.org
References: <20251128150403.11567-1-tvrtko.ursulin@igalia.com>
 <ce41c2d1-c659-4632-8469-761762202800@suse.de>
 <660c5469-086f-40b4-99f1-72c1bc613ece@igalia.com>
 <1df5a480-2510-43b9-9d79-51d842518036@suse.de>
 <b146fb1b-80e9-403c-acd1-b50ef1aaa646@igalia.com>
 <1b73df5b-5f47-4ce4-abd4-83d550cc0dea@suse.de>
 <e7c4a76e-5cef-4a75-847f-59c53a554327@igalia.com>
 <CAMj1kXFOS9jAzhh2Z_4rarEGd+kGPyNCu9PFoMhFbBVEF8NwJw@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CAMj1kXFOS9jAzhh2Z_4rarEGd+kGPyNCu9PFoMhFbBVEF8NwJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 01/12/2025 10:18, Ard Biesheuvel wrote:
> On Mon, 1 Dec 2025 at 11:03, Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>
>>
>> On 01/12/2025 09:39, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 01.12.25 um 10:20 schrieb Tvrtko Ursulin:
>>>>
>>>> On 01/12/2025 07:32, Thomas Zimmermann wrote:
>>>>> Hi
>>>>>
>>>>> Am 29.11.25 um 11:44 schrieb Tvrtko Ursulin:
>>>>>>
>>>>>> On 28/11/2025 17:07, Thomas Zimmermann wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> thanks for the bug report
>>>>>>>
>>>>>>> Am 28.11.25 um 16:04 schrieb Tvrtko Ursulin:
>>>>>>>> I am not sure how is simpledrmfb on top of EFI supposed to work,
>>>>>>>> but at
>>>>>>>> least at the moment it appears there is a missing link in the
>>>>>>>> "discovery"
>>>>>>>> of frame buffer parameters.
>>>>>>>>
>>>>>>>> What I can see is that EFI GOP reads some parameters from the
>>>>>>>> firmware and
>>>>>>>> infers the other, such as in this case problematic pitch, or stride.
>>>>>>>
>>>>>>> The pitch/stride value comes from the firmware via
>>>>>>> pixels_per_scanline [1].
>>>>>>>
>>>>>>> Can you verify that this value is really 800 instead of 832 (eq
>>>>>>> 3328 bytes) ?
>>>>>>>
>>>>>>> [1] https://elixir.bootlin.com/linux/v6.17.9/source/drivers/
>>>>>>> firmware/ efi/libstub/gop.c#L493
>>>>>>
>>>>>> I actually got confused a bit in following the flow so thank you for
>>>>>> asking me to double check.
>>>>>>
>>>>>> GOP actually reports 1280x800 with a stride of 5120. So it kind of
>>>>>> reports a rotated view already, kind of.
>>>>>
>>>>> These are correct values.
>>>>>
>>>>> But the stream deck is this device: [1], right? It uses landscape-
>>>>> mode orientation. Why does it require rotation at all?
>>>>>
>>>>> [1] https://de.wikipedia.org/wiki/Steam_Deck#/media/
>>>>> Datei:Steam_Deck_(front).png
>>>>
>>>> That's the device yes. For the user the screen is landscape, but the
>>>> actual panel is 800x1280 portrait. Left edge is top of the display.
>>>> (Hence the pre-existing entry in drm_get_panel_orientation_quirk.)
>>>
>>> I see. So the EFI display settings are configured as if this was a
>>> landscape panel.
>>>
>>> What happens if you leave the EFI settings as-is and simply remove the
>>> panel-orientation quirk?
>>
>> That would create effectively the same situation as without my patch
>> because the panel-orientation quirk does not trigger unless detected
>> screen is 800x1280. Result is corrupted console since fbcon thinks it is
>> a landscape 1280x800 screen.
>>>>>> Only when the rotation quirk from efifb_dmi_swap_width_height
>>>>>> triggers the stride gets incorrectly recalculated:
>>>>>>
>>>>>>          u16 temp = screen_info.lfb_width;
>>>>>>
>>>>>>          screen_info.lfb_width = screen_info.lfb_height;
>>>>>>          screen_info.lfb_height = temp;
>>>>>>          screen_info.lfb_linelength = 4 * screen_info.lfb_width;
>>>>>>
>>>>>> So this is where things go wrong, well, they actually go wrong a
>>>>>> little bit even earlier, in gop.c:
>>>>>>
>>>>>>      si->lfb_size = si->lfb_linelength * si->lfb_height;
>>>>>>
>>>>>> Which potentially underestimates the fb size. If GOP was forward
>>>>>> looking enough to give us the size we could derive the pitch based
>>>>>> on size..
>>>>>>
>>>>>> Anyway, as it stands it looks a quirk in sysfb_apply_efi_quirks
>>>>>> looks it is required to fix it all up.
>>>>>>
>>>>>> I am a bit uneasy about declaring the fb size larger than what was
>>>>>> implied by firmware provided pitch * height * depth but limited to a
>>>>>> specific DMI match and if it looks visually okay I think it is a
>>>>>> safe assumption the quirked size is actually correct and safe.
>>>>>
>>>>> Yeah, we better not do that.
>>>> You mean declare it a firmware bug and live with the corrupt console
>>>> until the final fb driver takes over?
>>>
>>> I only mean that we should not use more video memory than provided by EFI.
>>
>> Right, but that information is not available in the GOP, right? Ie. as I
>> wrote above it appears assumed:
>>
>>      si->lfb_size = si->lfb_linelength * si->lfb_height;
>>
>> Do we have any other options apart from corruption or assume firmware
>> configured GOP screen info incorrectly?
>>
> 
> How does it make sense to recalculate the line length? Those invisible
> pixels at the end of the scanline are not going to be transposed to
> the other dimension, right?

Not sure what you meant here. The line above is from gop.c and the 
context is that GOP screen info appears to not carry the frame buffer 
size in bytes so it is implied.

Elsewhere in the patch I quirk the pitch to the correct value so rotated 
rendering is correct.

But the corrected pitch also means that in principle we need to adjust 
the frame buffer size, since it is larger than the size implied with the 
incorrect pitch.

Regards,

Tvrtko


