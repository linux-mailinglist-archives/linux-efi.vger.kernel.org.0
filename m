Return-Path: <linux-efi+bounces-5127-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF1C0628E
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 718924E067F
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E8F313526;
	Fri, 24 Oct 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lt+VWgRG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zvgfz6nf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lt+VWgRG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zvgfz6nf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9D313523
	for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307571; cv=none; b=fW5nj3wgpJTr2AHlBgfcJvVDHdtsq7KNdM3lrHB0WNQbYUiLrDwb1aPYimAc8xDWXQL/ubbcgmXzXmY1Bw/Dc1pHtr2QaOcA/ypObo2XtQcfRGCBi2hcWi29fwjePiHrtAI8QpZi9WQvkdBdl7mjSXiVAcwEnUF/R4f4YSzbubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307571; c=relaxed/simple;
	bh=DFD9s2MCqee1UAxPaqjlBBhb6Mqm3R0fE1aD5fH92AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRb5EuCiWTqkCKe511tTAqhcGU/HBElPFq0onHFW4+QG/LX+vsyMn9jsck0ejdsroDFMGsG9Gp7xQHQ2voS9y2m+3ml5wOUdGzzZqgBWfLTPmlmvnUPCzWe7r1beS6b6pl+PUxjLZXNVEPL4qe4XR+2YnsszFGvkng2Yp8/V8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lt+VWgRG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zvgfz6nf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lt+VWgRG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zvgfz6nf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 346751F441;
	Fri, 24 Oct 2025 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761307567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7+vc5jHXZ/zQy/xm/Cmay7F3lM867jDyJ86O92DRNwo=;
	b=lt+VWgRGkX493FfmEwo7k/LP/UbAM0Kwyos2BZCtjJt+eo/cz8/YuLfPWNPLAy9Jnqddg2
	p8xgiWjRtfYkXp7qRYmlNODOJeFIfbRSayX/cNizXMzjswLrKC2vn4ZW3Q/Hq1s3kVAwgm
	grxYYNhHqR1MbqQcGzduhuiUkHLkWiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761307567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7+vc5jHXZ/zQy/xm/Cmay7F3lM867jDyJ86O92DRNwo=;
	b=zvgfz6nfm0BmqnP9fdcFNNM1XLyTIE294DgEyP1kjAtL6jj0PRS7SwIP07sjbMRKqP+q5T
	P1kyVzSs9f+v1cDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761307567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7+vc5jHXZ/zQy/xm/Cmay7F3lM867jDyJ86O92DRNwo=;
	b=lt+VWgRGkX493FfmEwo7k/LP/UbAM0Kwyos2BZCtjJt+eo/cz8/YuLfPWNPLAy9Jnqddg2
	p8xgiWjRtfYkXp7qRYmlNODOJeFIfbRSayX/cNizXMzjswLrKC2vn4ZW3Q/Hq1s3kVAwgm
	grxYYNhHqR1MbqQcGzduhuiUkHLkWiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761307567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7+vc5jHXZ/zQy/xm/Cmay7F3lM867jDyJ86O92DRNwo=;
	b=zvgfz6nfm0BmqnP9fdcFNNM1XLyTIE294DgEyP1kjAtL6jj0PRS7SwIP07sjbMRKqP+q5T
	P1kyVzSs9f+v1cDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE006132C2;
	Fri, 24 Oct 2025 12:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H1aoOK5r+2ieMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 24 Oct 2025 12:06:06 +0000
Message-ID: <acadd898-73a0-41fc-8b3b-ce2d0438a173@suse.de>
Date: Fri, 24 Oct 2025 14:06:06 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] efi/libstub: gop: Find GOP handle instead of GOP data
To: Javier Martinez Canillas <javierm@redhat.com>, ardb@kernel.org,
 jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-3-tzimmermann@suse.de>
 <87wm4k8wcz.fsf@ocarina.mail-host-address-is-not-set>
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
In-Reply-To: <87wm4k8wcz.fsf@ocarina.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi Javier,

thanks for reviewing.

Am 24.10.25 um 11:47 schrieb Javier Martinez Canillas:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
>> The device handle of the GOP device is required to retrieve the
>> correct EDID data. Find the handle instead of the GOP data. Still
>> return the GOP data in the function arguments, as we already looked
>> it up.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/firmware/efi/libstub/gop.c | 27 +++++++++++++++++----------
>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
>> index 3785fb4986b4..fd32be8dd146 100644
>> --- a/drivers/firmware/efi/libstub/gop.c
>> +++ b/drivers/firmware/efi/libstub/gop.c
>> @@ -402,12 +402,13 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
>>   	}
>>   }
>>   
>> -static efi_graphics_output_protocol_t *find_gop(unsigned long num,
>> -						const efi_handle_t handles[])
>> +static efi_handle_t find_handle_with_primary_gop(unsigned long num, const efi_handle_t handles[],
>> +						 efi_graphics_output_protocol_t **found_gop)
>>   {
>>   	efi_graphics_output_protocol_t *first_gop;
>> -	efi_handle_t h;
>> +	efi_handle_t h, first_gop_handle;
>>   
>> +	first_gop_handle = NULL;
>>   	first_gop = NULL;
>>
> I think the logic of this function could be simplified if you remove some
> of the variables. For example, I don't think you need a fist_gop variable
> anymore now that you are passing a found_gop variable as a function param.
>
>>   	for_each_efi_handle(h, handles, num) {
>> @@ -442,19 +443,25 @@ static efi_graphics_output_protocol_t *find_gop(unsigned long num,
>>   		 */
>>   		status = efi_bs_call(handle_protocol, h,
>>   				     &EFI_CONSOLE_OUT_DEVICE_GUID, &dummy);
>> -		if (status == EFI_SUCCESS)
>> -			return gop;
>> -
>> -		if (!first_gop)
>> +		if (status == EFI_SUCCESS) {
>> +			if (found_gop)
>> +				*found_gop = gop;
>> +			return h;
>> +		} else if (!first_gop_handle) {
>> +			first_gop_handle = h;
>>   			first_gop = gop;
> You can just assign *found_gop = gop here...
>
>> +		}
>>   	}
>>   
>> -	return first_gop;
>> +	if (found_gop)
>> +		*found_gop = first_gop;
> ...and then this assignment won't be needed anynmore.

TBH I choose that style on purpose. It's easily parseable by the eye. 
found_gop is allowed be NULL and we'd have to test within the loop. I 
found this uneasy to read. And assigning *found_gop early leaks state to 
the outside before it's ready. That's probably not a problem here, but I 
find that questionable.

>
>> +	return first_gop_handle;
> Also, given that you are calling first_gop_handle to the variable to
> store the first gop handle, I would for consistency name the parameter
> fist_gop and just drop the local variable with the same name.

The found_gop is not necessarily the first_gop. We want to return the 
primary device's handle and GOP state. The first one is only returned if 
there's no clear primary one. See [1] as for how the primary is being 
detected.

[1] 
https://elixir.bootlin.com/linux/v6.17.4/source/drivers/firmware/efi/libstub/gop.c#L433

Best regards
Thomas

>
> But I agree with the general logic of the patch, so regardless of what
> you prefer to do:
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



