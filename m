Return-Path: <linux-efi+bounces-5526-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD80AC62C41
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 08:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F269C35E803
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E8319609;
	Mon, 17 Nov 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RiEccO7Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eo6o23Qp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RiEccO7Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eo6o23Qp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38A319852
	for <linux-efi@vger.kernel.org>; Mon, 17 Nov 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365030; cv=none; b=umThQ4xhsJ1rr+ize33vb/krNHSaO82FWf8KQFFDPY+7VQd4fOYoeXvBUkxyGt9Rh8m6nKIr5mwT862Vx+RM61RWezKS7JY+DucoifYWflThc29em+30/HuHDmCUUR+qRyWTlSv4lELXSdQbQvm/Tpr1XnhLiJVSvGdnKQyz908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365030; c=relaxed/simple;
	bh=m155ph/C5oG4bO3+voP4hgHueDUOHEaqK376p51AkiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=al0PTB0T94EWCHL6PtutqrgdCZaj1vR4gRQ1fCoqfY0lXLnG0qIuf1bIlQ4OOvbvJa/fSrvcPnmZ+Mx4Q2P5vpb1cgLiGLUTriNWRp5qqY535EEDGizsio/TwaCZ1Tn1LPnO/7faZcTfGmFxa/qBqVzZDfb8x6u5t8DXCsOpelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RiEccO7Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eo6o23Qp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RiEccO7Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eo6o23Qp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B77B211FF;
	Mon, 17 Nov 2025 07:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763365026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5NLvbYnT3faBz30Rv5ipLxXZHc4UFIvTCRa6lyTuc4E=;
	b=RiEccO7ZfYAdZgkyQ0KbBrkZp4VPOFnJbZmq03mKwQWP5XP8zgMs5n9ttqDGh4nUMHxq8/
	iyqInoF9XwkmK93gsbYSHzli2DEul4wuRwMGD3IeRxImVOM1phWlPoDBzHS9Lbu60oHTuq
	nLZILwMBox6eRQBl2PxHUwEhsFA29ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763365026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5NLvbYnT3faBz30Rv5ipLxXZHc4UFIvTCRa6lyTuc4E=;
	b=Eo6o23Qp3MlVaOOnCxwZYRUdvEcs1ZTW9SABX8AxviDxs5XGQPy9w6gcJuLoWab+pCCue8
	Iw2sCNWSdCI4o/AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763365026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5NLvbYnT3faBz30Rv5ipLxXZHc4UFIvTCRa6lyTuc4E=;
	b=RiEccO7ZfYAdZgkyQ0KbBrkZp4VPOFnJbZmq03mKwQWP5XP8zgMs5n9ttqDGh4nUMHxq8/
	iyqInoF9XwkmK93gsbYSHzli2DEul4wuRwMGD3IeRxImVOM1phWlPoDBzHS9Lbu60oHTuq
	nLZILwMBox6eRQBl2PxHUwEhsFA29ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763365026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5NLvbYnT3faBz30Rv5ipLxXZHc4UFIvTCRa6lyTuc4E=;
	b=Eo6o23Qp3MlVaOOnCxwZYRUdvEcs1ZTW9SABX8AxviDxs5XGQPy9w6gcJuLoWab+pCCue8
	Iw2sCNWSdCI4o/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D97C3EA61;
	Mon, 17 Nov 2025 07:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eDGhFaLQGmlHJwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Nov 2025 07:37:06 +0000
Message-ID: <40165201-80b7-4fa4-9812-6a8fcbee4a42@suse.de>
Date: Mon, 17 Nov 2025 08:37:05 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] efi/libstub: gop: Initialize screen_info in helper
 function
To: Javier Martinez Canillas <javierm@redhat.com>, ardb@kernel.org,
 jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-4-tzimmermann@suse.de>
 <87tszo8w2q.fsf@ocarina.mail-host-address-is-not-set>
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
In-Reply-To: <87tszo8w2q.fsf@ocarina.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.com:url,bootlin.com:url]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi

Am 24.10.25 um 11:53 schrieb Javier Martinez Canillas:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
>> Move initialization of screen_info into a single helper function.
>> Frees up space in the main setup helper for adding EDID support.
>> No functional changes.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/firmware/efi/libstub/gop.c | 76 +++++++++++++-----------------
>>   1 file changed, 33 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
>> index fd32be8dd146..02459ef0f18c 100644
>> --- a/drivers/firmware/efi/libstub/gop.c
>> +++ b/drivers/firmware/efi/libstub/gop.c
>> @@ -367,24 +367,31 @@ static void find_bits(u32 mask, u8 *pos, u8 *size)
>>   	*size = __fls(mask) - *pos + 1;
>>   }
>>   
>> -static void
>> -setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
>> -		 efi_pixel_bitmask_t pixel_info, int pixel_format)
>> +static void setup_screen_info(struct screen_info *si, const efi_graphics_output_protocol_t *gop)
>>   {
>> -	if (pixel_format == PIXEL_BIT_MASK) {
>> -		find_bits(pixel_info.red_mask,
>> -			  &si->red_pos, &si->red_size);
>> -		find_bits(pixel_info.green_mask,
>> -			  &si->green_pos, &si->green_size);
>> -		find_bits(pixel_info.blue_mask,
>> -			  &si->blue_pos, &si->blue_size);
>> -		find_bits(pixel_info.reserved_mask,
>> -			  &si->rsvd_pos, &si->rsvd_size);
>> -		si->lfb_depth = si->red_size + si->green_size +
>> -			si->blue_size + si->rsvd_size;
>> -		si->lfb_linelength = (pixels_per_scan_line * si->lfb_depth) / 8;
>> +	const efi_graphics_output_protocol_mode_t *mode = efi_table_attr(gop, mode);
>> +	const efi_graphics_output_mode_info_t *info = efi_table_attr(mode, info);
>> +
>> +	si->orig_video_isVGA = VIDEO_TYPE_EFI;
>> +
> Not related with your patch but I dislike so much the name of this field,
> since it started as a "is VGA?" bool and ended being an enum afterwards.
>
> But I beleve we discussed this already and decided that it would be too
> much churn to change it at this point.

That's why we need helpers for decoding, such as [1]. The kernel only 
initializes screen_info to VGAC, EFI and VLFB. We could add initializer 
functions for these cases.

[1] 
https://elixir.bootlin.com/linux/v6.17.8/source/include/linux/screen_info.h#L92

Best regards
Thomas

>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



