Return-Path: <linux-efi+bounces-5723-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA0C96048
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 08:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2103A2246
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9CC276058;
	Mon,  1 Dec 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="meQoP+8Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zhbGEvbS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R1CYER3Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6QN6q2C1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8E1E868
	for <linux-efi@vger.kernel.org>; Mon,  1 Dec 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764574395; cv=none; b=lLqXPnWr3ZQssZBSd3rx7FPT59Q0br0iNqlVbiBWdpU4Vnr1fEMbHuxSwWWcvyLiXP/U9XSzrjmRsVvP2947xJ95Ho2KQgFxt0Ow3Y+xIF/0z6t4FRpRtLdlm8izyewEAT008sgm1C0431TRp3kr8VGKfeuD3BSkILIStpH8UJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764574395; c=relaxed/simple;
	bh=N9rDOTLfsPwxQVpZ7hAMySjN9+Zrp+jjUXPjYVJO5Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsHKozx8gSIndmBZghlc8sZhqdO7yxiUflfLzzE4HA9nizNtxf5O1CRJuZO6sUclJqDl6VX4eLw3A75opqdL43/jR7V5EG7fd49pzMOxFYERMc14Fe3tXFqdosviPczhwEDwHEm2LvNrLqbEdWHzQ+dUIFianXZeeTsNZFMJMOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=meQoP+8Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zhbGEvbS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R1CYER3Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6QN6q2C1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4837933788;
	Mon,  1 Dec 2025 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764574381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MBHBK7zyFxwqid6EiZAFHHRW+M5020NulbSo3ca74hQ=;
	b=meQoP+8ZHJxVn+1M7Cii2yWpWF7lnjhZfddfC4wy0s8e/BslVS7Zt/1TjP1CVuM6fE5I/t
	bCvqmBmL4ECtHuRW+KO4FcVEti1M8lsIkCkG9aVPtDxWplYvmXndMyPLumSts+eSyD/ykn
	mD7NnafokPXF8/RmVV4QDqswKEOKMRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764574381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MBHBK7zyFxwqid6EiZAFHHRW+M5020NulbSo3ca74hQ=;
	b=zhbGEvbSuT3lzSGEdm6qPEJ1D4d3sJAPAyvc77ZJL9tRkkyS4GDNjYWjJVR5+0Nytj8ICZ
	w4n1dlQ5nbLIjHDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R1CYER3Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6QN6q2C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764574380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MBHBK7zyFxwqid6EiZAFHHRW+M5020NulbSo3ca74hQ=;
	b=R1CYER3Qfcj7sRJqhyZgfZVdr7QNs0uTmD4t5EwEnGgrsNg6ckT3Qqx1aTLAEavuXCxVbN
	q2NV56GOuXgm0jYqWE5u7l2l6Oz/Xae3fxNiGXNIhyq51GzeOSbCItZe1XeN81dTvm8+vI
	OROtkEycszEcqJf28Z+8gR9P5xPrzh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764574380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MBHBK7zyFxwqid6EiZAFHHRW+M5020NulbSo3ca74hQ=;
	b=6QN6q2C1rUCiVwdSXO5ikljOhKoNVWyO58dkucBDJM/+8XEXQ+gW7BvoDaVrAct1Kc24K7
	7k257zxbuH/bCTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE5AA3EA63;
	Mon,  1 Dec 2025 07:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MKF0MqtELWlbbwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Dec 2025 07:32:59 +0000
Message-ID: <1df5a480-2510-43b9-9d79-51d842518036@suse.de>
Date: Mon, 1 Dec 2025 08:32:59 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFX] efi: sysfb_efi: Fix simpledrmfb on Steam Deck
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Javier Martinez Canillas <javierm@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-efi@vger.kernel.org
References: <20251128150403.11567-1-tvrtko.ursulin@igalia.com>
 <ce41c2d1-c659-4632-8469-761762202800@suse.de>
 <660c5469-086f-40b4-99f1-72c1bc613ece@igalia.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <660c5469-086f-40b4-99f1-72c1bc613ece@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,wikipedia.org:url,amd.com:email,bootlin.com:url,suse.de:mid,suse.de:dkim,suse.de:email,igalia.com:email];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4837933788
X-Rspamd-Action: no action
X-Spam-Flag: NO

Hi

Am 29.11.25 um 11:44 schrieb Tvrtko Ursulin:
>
> On 28/11/2025 17:07, Thomas Zimmermann wrote:
>> Hi,
>>
>> thanks for the bug report
>>
>> Am 28.11.25 um 16:04 schrieb Tvrtko Ursulin:
>>> I am not sure how is simpledrmfb on top of EFI supposed to work, but at
>>> least at the moment it appears there is a missing link in the 
>>> "discovery"
>>> of frame buffer parameters.
>>>
>>> What I can see is that EFI GOP reads some parameters from the 
>>> firmware and
>>> infers the other, such as in this case problematic pitch, or stride.
>>
>> The pitch/stride value comes from the firmware via 
>> pixels_per_scanline [1].
>>
>> Can you verify that this value is really 800 instead of 832 (eq 3328 
>> bytes) ?
>>
>> [1] https://elixir.bootlin.com/linux/v6.17.9/source/drivers/firmware/ 
>> efi/libstub/gop.c#L493
>
> I actually got confused a bit in following the flow so thank you for 
> asking me to double check.
>
> GOP actually reports 1280x800 with a stride of 5120. So it kind of 
> reports a rotated view already, kind of.

These are correct values.

But the stream deck is this device: [1], right? It uses landscape-mode 
orientation. Why does it require rotation at all?

[1] 
https://de.wikipedia.org/wiki/Steam_Deck#/media/Datei:Steam_Deck_(front).png

>
> Only when the rotation quirk from efifb_dmi_swap_width_height triggers 
> the stride gets incorrectly recalculated:
>
>         u16 temp = screen_info.lfb_width;
>
>         screen_info.lfb_width = screen_info.lfb_height;
>         screen_info.lfb_height = temp;
>         screen_info.lfb_linelength = 4 * screen_info.lfb_width;
>
> So this is where things go wrong, well, they actually go wrong a 
> little bit even earlier, in gop.c:
>
>     si->lfb_size = si->lfb_linelength * si->lfb_height;
>
> Which potentially underestimates the fb size. If GOP was forward 
> looking enough to give us the size we could derive the pitch based on 
> size..
>
> Anyway, as it stands it looks a quirk in sysfb_apply_efi_quirks looks 
> it is required to fix it all up.
>
> I am a bit uneasy about declaring the fb size larger than what was 
> implied by firmware provided pitch * height * depth but limited to a 
> specific DMI match and if it looks visually okay I think it is a safe 
> assumption the quirked size is actually correct and safe.

Yeah, we better not do that.

Best regards
Thomas

>>> One could be easily excused in thinking that pitch cannot be reliably
>>> inferred, since different display hardware has differing alignment
>>> requirements, so it is unclear how is hardware agnostic solution 
>>> supposed
>>> to work.
>>>
>>> In the specific case of the Steam Deck hardware we have a 800x1280 
>>> native
>>> panel which is also installed rotated 90 degrees counter clockwise.
>>>
>>> Firmware appears to set up the pitch as 3328, while GOP assumes 3200,
>>> based of a width * bpp calculation.
>>
>> 832 is a multiple of 64, while 800 is not. I've seen this over- 
>> allocation in other context as well.
>>
>>>
>>> When this incorrect pitch propagates through (rather complicated) fbcon
>>> and DRM call paths, the end result is corrupted rendering all until the
>>> amdgpu takes over the fbdev.
>>>
>>> Simplistic solution in this patch is to add a DMI quirk to the EFI
>>> frame buffer setup code.
>>>
>>> Apart from the incorrect pitch, the quirk also does the swapping of the
>>> width and height. Apart from setting the correct fbcon dimensions this
>>> one also allows the quirk from drm_get_panel_orientation_quirk() to
>>> report the correct orientation.
>>
>> Nice
>>
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: "Christian König" <christian.koenig@amd.com>
>>> Cc: Melissa Wen <mwen@igalia.com>
>>> Cc: Rodrigo Siqueira <siqueira@igalia.com>
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Cc: linux-efi@vger.kernel.org
>>> ---
>>>   drivers/firmware/efi/sysfb_efi.c | 48 
>>> ++++++++++++++++++++++++++++++--
>>>   1 file changed, 46 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/firmware/efi/sysfb_efi.c 
>>> b/drivers/firmware/efi/ sysfb_efi.c
>>> index 1e509595ac03..84d9049bb2cb 100644
>>> --- a/drivers/firmware/efi/sysfb_efi.c
>>> +++ b/drivers/firmware/efi/sysfb_efi.c
>>> @@ -231,6 +231,18 @@ static const struct dmi_system_id 
>>> efifb_dmi_system_table[] __initconst = {
>>>       {},
>>>   };
>>> +struct efifb_mode_fixup {
>>> +    unsigned int width;
>>> +    unsigned int height;
>>> +    unsigned int pitch;
>>> +};
>>> +
>>> +static const struct efifb_mode_fixup efifb_steamdeck_mode_fixup = {
>>> +    .width = 1280,
>>> +    .height = 800,
>>> +    .pitch = 3328,
>>> +};
>>> +
>>>   /*
>>>    * Some devices have a portrait LCD but advertise a landscape 
>>> resolution (and
>>>    * pitch). We simply swap width and height for these devices so 
>>> that we can
>>> @@ -281,6 +293,24 @@ static const struct dmi_system_id 
>>> efifb_dmi_swap_width_height[] __initconst = {
>>>               DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
>>>           },
>>>       },
>>> +    {
>>> +        /* Valve Steam Deck (Jupiter) */
>>> +        .matches = {
>>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
>>> +            DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
>>> +            DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
>>> +        },
>>> +        .driver_data = (void *)&efifb_steamdeck_mode_fixup,
>>> +    },
>>> +    {
>>> +        /* Valve Steam Deck (Galileo) */
>>> +        .matches = {
>>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
>>> +            DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
>>> +            DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
>>> +        },
>>> +        .driver_data = (void *)&efifb_steamdeck_mode_fixup,
>>> +    },
>>>       {},
>>>   };
>>> @@ -351,17 +381,31 @@ static struct fwnode_handle efifb_fwnode;
>>>   __init void sysfb_apply_efi_quirks(void)
>>>   {
>>> +    const struct dmi_system_id *match;
>>> +
>>>       if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
>>>           !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
>>>           dmi_check_system(efifb_dmi_system_table);
>>> -    if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
>>> -        dmi_check_system(efifb_dmi_swap_width_height)) {
>>
>> Could we keep swap_width_height a separate list?
>>
>> The for loop would then be a full override-display list.
>>
>>> +    if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>>> +        return;
>>> +
>>> +    for (match = dmi_first_match(efifb_dmi_swap_width_height);
>>> +         match;
>>> +         match = dmi_first_match(match + 1)) {
>>> +        const struct efifb_mode_fixup *data = match->driver_data;
>>>           u16 temp = screen_info.lfb_width;
>>>           screen_info.lfb_width = screen_info.lfb_height;
>>>           screen_info.lfb_height = temp;
>>>           screen_info.lfb_linelength = 4 * screen_info.lfb_width;
>>
>> FTR: This calculation has always been wrong. We need to take the 
>> lfb_depth into account. No need to fix this here; just so you know.
>
> I can add a patch to replace with screen_info.lfb_depth / BITS_PER_BYTE?
>
>>> +
>>> +        if (data && data->pitch &&
>>> +           data->width == screen_info.lfb_height &&
>>> +           data->height == screen_info.lfb_width) {
>>> +            screen_info.lfb_linelength = data->pitch;
>>> +            screen_info.lfb_size = data->pitch * data->width;
>>> +        }
>>
>> If we have a separate fix-up list, we can make this much nicer:
>>
>> if (data->width)
>>     // assign data->width
>> if (data->height)
>>     // assign data->width
>> if (data->data)
>>     // assign data->pitch
>>
>> and then recompute linelength and size
>
> I thought the approach of looking at the multiple parameters at the 
> same time, similar how drm_get_panel_orientation_quirk() does it, is 
> safer. Ie. we don't want to edit unless the whole mode matches the 
> expectation.
>
> Regards,
>
> Tvrtko
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



