Return-Path: <linux-efi+bounces-5776-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE7EC9EA02
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 11:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90ED8347E9F
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31532E1749;
	Wed,  3 Dec 2025 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RkYidLZ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Av7TRFI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RkYidLZ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Av7TRFI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6732E22BF
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756122; cv=none; b=GGva9888/FubweVgJxO0nAs4ubouQsJXLfIDrGVx4hPSHxlJpzQCgmrJTcfCQmiwY/0GIxaB8zEIzYf06KtqjVj1u5Zw6nj5Tg1bf0FyavXQTj/GytcShoREoq3GuwxmjSn9QYuPxDK4RoLnD7TxjznkBQofe3i2PNeykTVt3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756122; c=relaxed/simple;
	bh=U9qQczuGI2uY3zWgIA7d9x8CfwyVzROMPv3tTRyeFCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6pzPG3krtregyu/ZDZkknlVGTgv5S4r1rM9TBa2WAAtLAzMhROV2P/A13heHj/Ob7wB3P1tjiX5AluDGxvX6j79GJ/Rj0WzCcomjZO+pMIdOzhdBEXG8yQ1rENt+1DGbantXudkThGcPm8gp6xwW14rpnJFykanXOi/TTNrNmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RkYidLZ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Av7TRFI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RkYidLZ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Av7TRFI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2ED215BD22;
	Wed,  3 Dec 2025 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764756119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rtkkpt63z/9iReyBF0GHUolCGFw2L5JxLRA2LRTSOPE=;
	b=RkYidLZ7F/d4McRbMALxmjr1QeIfUPhLRfAIyqgKrxh5PL9jMslwJDrjrG81qCkd9kevx9
	6mHY+HtttU6QpL4xmT7O1Wq6XHnd7KblwCvwnuguo74dRuKfQ4rsYpGUARNBGG7K2WJ5hj
	UcebrmJjxkIvobJ4IolhAkLlzr8k8XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764756119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rtkkpt63z/9iReyBF0GHUolCGFw2L5JxLRA2LRTSOPE=;
	b=3Av7TRFIoe6zHLfhDQwLj3lvH0kQiJDhE7BmWo4VJZD4SoaECWBOp22TSE64QO/QTO9jBF
	PHHGdNsvBTOBptCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764756119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rtkkpt63z/9iReyBF0GHUolCGFw2L5JxLRA2LRTSOPE=;
	b=RkYidLZ7F/d4McRbMALxmjr1QeIfUPhLRfAIyqgKrxh5PL9jMslwJDrjrG81qCkd9kevx9
	6mHY+HtttU6QpL4xmT7O1Wq6XHnd7KblwCvwnuguo74dRuKfQ4rsYpGUARNBGG7K2WJ5hj
	UcebrmJjxkIvobJ4IolhAkLlzr8k8XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764756119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rtkkpt63z/9iReyBF0GHUolCGFw2L5JxLRA2LRTSOPE=;
	b=3Av7TRFIoe6zHLfhDQwLj3lvH0kQiJDhE7BmWo4VJZD4SoaECWBOp22TSE64QO/QTO9jBF
	PHHGdNsvBTOBptCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F8623EA63;
	Wed,  3 Dec 2025 10:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGB/JZYKMGlLLQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Dec 2025 10:01:58 +0000
Message-ID: <7c5a3d5d-9aa6-4d2a-8211-1d18393c9bea@suse.de>
Date: Wed, 3 Dec 2025 11:01:57 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] efi: sysfb_efi: Fix lfb_linelength calculation
 when applying quirks
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Ard Biesheuvel <ardb@kernel.org>,
 Melissa Wen <mwen@igalia.com>, linux-efi@vger.kernel.org
References: <20251203093948.54296-1-tvrtko.ursulin@igalia.com>
 <20251203093948.54296-3-tvrtko.ursulin@igalia.com>
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
In-Reply-To: <20251203093948.54296-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.28
X-Spam-Level: 
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.889];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,bootlin.com:url,igalia.com:email,suse.de:email,suse.de:mid,suse.com:url]

Hi

Am 03.12.25 um 10:39 schrieb Tvrtko Ursulin:
> PIXEL_BIT_MASK formats can have either less or more than four bytes per
> pixel so lets fix the lfb_linelenght calculation when applying the
> swapped width and height quirks.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: linux-efi@vger.kernel.org
> ---
>   drivers/firmware/efi/sysfb_efi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 1d8b6966731c..14b61414c33a 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -358,7 +358,9 @@ __init void sysfb_apply_efi_quirks(void)
>   	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
>   	    dmi_check_system(efifb_dmi_swap_width_height)) {
>   		swap(screen_info.lfb_width, screen_info.lfb_height);
> -		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
> +		screen_info.lfb_linelength = (unsigned int)screen_info.lfb_depth *

Rather than using lfb_depth directly, call 
__screen_info_lfb_bits_per_pixel(). [1] See the lengthy comment there on 
why depth is broken.

Best regards
Thomas

[1] 
https://elixir.bootlin.com/linux/v6.18/source/drivers/video/screen_info_generic.c#L170

> +					     screen_info.lfb_width /
> +					     BITS_PER_BYTE;
>   	}
>   }
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



