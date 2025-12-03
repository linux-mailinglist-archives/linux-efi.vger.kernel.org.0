Return-Path: <linux-efi+bounces-5778-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BADC9EA35
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 11:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AD71348A03
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96C2E6CCD;
	Wed,  3 Dec 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jnVOT+jo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="njjI2f9L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r01JSc+R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e8O4thsg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E22E1EFD
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756330; cv=none; b=P0cPnMt8SWFUvQEe4dUDjBo2Pu3T7DY9qsHiYxiso33SrVurkDQvmU5oblhz+bg90pWejganmFQNO+om8/6B+CqeXoPswnq69wuzqSfOKzlzb3r7MCuxR68ghMj7naZ1nGXUEn8kyOYmt2oPrA36ztD9Usr9cCUg+V7ELp9qRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756330; c=relaxed/simple;
	bh=yaxDlOj2YhYSF7HWw5/h9aKAZJ7mJ5xwF3DM+ydvxhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubqYNv3BSEx5gbmejc4JGbvUPMYaQAB29CxOEoQR5s7dU05GMzCoHC60DP0/JtHKSq5mMx1ACV7gSSNynV/3R/9LcroLQ0MIjA7lLqgETN/si6tCPF/vc5S2SY97AdsxyECTDzzXVB192ZruujQ5snDaTMdAkM+RPNFjAgPmVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jnVOT+jo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=njjI2f9L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r01JSc+R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e8O4thsg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E581A5BD2A;
	Wed,  3 Dec 2025 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764756324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9HpLpl2ZV1aDZOaoROYaUGQAilkVvscwuzKjyuJYnNs=;
	b=jnVOT+jotr9pslvvDUvdfIyfT237Oer3g/Yja6rIA+jkJUcHTwBsCtSLi8FUZMQDmjbf05
	Om6eGZGnmO/dp/D4sa4a24EHAGVEy+oqUF/iwAyFTrWGfR1B37bU9GOyJ4JmQ2ea7tQUdp
	i9O35d31UQQYCu7vp3/02T3si/ZfLwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764756324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9HpLpl2ZV1aDZOaoROYaUGQAilkVvscwuzKjyuJYnNs=;
	b=njjI2f9L3uNosxuu3KudVg8GDjviujs1UIMkPyz6OsDlYK6pIf76RjXRF1/revtLreg2HE
	i2zz+9HZKVnLjTBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r01JSc+R;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e8O4thsg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764756323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9HpLpl2ZV1aDZOaoROYaUGQAilkVvscwuzKjyuJYnNs=;
	b=r01JSc+R+eWZwoEMvF1RXse1jBRvnxA376iO2MBeCKCKHt8uwLKYBFmkQIwjQDBYxwBE2w
	GMZnGE6nF815W6C5Ui6Qd22ohFKOZ2an4kgCV70jRAVwvRxgwexAnCpjGO5K1rvMZQ9DXd
	tgv7ffIRpy4P4xCoFNeuVSZWPYALzMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764756323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9HpLpl2ZV1aDZOaoROYaUGQAilkVvscwuzKjyuJYnNs=;
	b=e8O4thsgdFg3DiKOzjzj3eJ5+DswRLbOlwVTee/gl38a8Oe0xBtD6Xyl9b7K9wEXRTtFw4
	SYBwPT8bL/HoMqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABE253EA63;
	Wed,  3 Dec 2025 10:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LprNJ2MLMGklMAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Dec 2025 10:05:23 +0000
Message-ID: <5ecc23ed-929f-4e60-a7a1-d4bd759e9af2@suse.de>
Date: Wed, 3 Dec 2025 11:05:23 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] efi: sysfb_efi: Fix efidrmfb and simpledrmfb on
 Valve Steam Deck
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Ard Biesheuvel <ardb@kernel.org>,
 Melissa Wen <mwen@igalia.com>, linux-efi@vger.kernel.org
References: <20251203090706.53778-1-tvrtko.ursulin@igalia.com>
 <20251203090706.53778-5-tvrtko.ursulin@igalia.com>
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
In-Reply-To: <20251203090706.53778-5-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: E581A5BD2A
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,igalia.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

Hi

Am 03.12.25 um 10:07 schrieb Tvrtko Ursulin:
> Valve Steam Deck has a 800x1280 portrait screen installed in a landscape
> orientation. The firmware offers a software rotated 1280x800 mode which
> GRUB can be made to switch to when displaying a boot menu. If this mode
> was selected frame buffer drivers will see this fake mode and fbcon
> rendering will be corrupted.
>
> Lets therefore add a selective quirk inside the current "swap with and
> height" handling, which will detect this exact mode and fix it up back to
> the native one.
>
> This will allow the DRM based frame buffer drivers to detect the correct
> mode and, apply the existing panel orientation quirk, and render the
> console in landscape mode with no corruption.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: linux-efi@vger.kernel.org
> ---
>   drivers/firmware/efi/sysfb_efi.c | 56 +++++++++++++++++++++++++++++---
>   1 file changed, 51 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index eacf9a50eab2..566492e67798 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -231,16 +231,42 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>   	{},
>   };
>   
> +struct efifb_mode_fixup {
> +	unsigned int width;
> +	unsigned int height;
> +	unsigned int linelength;
> +};
> +
>   static int __init efifb_swap_width_height(const struct dmi_system_id *id)

It's something different now. Can this please become a separate list 
with a separate callback?

Best regards
Thomas

>   {
> -	swap(screen_info.lfb_width, screen_info.lfb_height);
> -	screen_info.lfb_linelength = (unsigned int)screen_info.lfb_depth *
> -				     screen_info.lfb_width /
> -				     BITS_PER_BYTE;
> +	const struct efifb_mode_fixup *data = id->driver_data;
>   
> -	return 1;
> +	if (!data ||
> +	    (data->width == screen_info.lfb_width &&
> +	     data->height == screen_info.lfb_height)) {
> +		swap(screen_info.lfb_width, screen_info.lfb_height);
> +
> +		if (data && data->linelength) {
> +			screen_info.lfb_linelength = data->linelength;
> +			screen_info.lfb_size = data->linelength * data->width;
> +		} else {
> +			screen_info.lfb_linelength = (unsigned int)screen_info.lfb_depth *
> +						     screen_info.lfb_width /
> +						     BITS_PER_BYTE;
> +		}
> +
> +		return 1;
> +	}
> +
> +	return 0;
>   }
>   
> +static const struct efifb_mode_fixup efifb_steamdeck_mode_fixup = {
> +	.width = 1280,
> +	.height = 800,
> +	.linelength = 3328,
> +};
> +
>   /*
>    * Some devices have a portrait LCD but advertise a landscape resolution (and
>    * pitch). We simply swap width and height for these devices so that we can
> @@ -296,6 +322,26 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>   		},
>   		.callback = efifb_swap_width_height,
>   	},
> +	{
> +		/* Valve Steam Deck (Jupiter) */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
> +		},
> +		.callback = efifb_swap_width_height,
> +		.driver_data = (void *)&efifb_steamdeck_mode_fixup,
> +	},
> +	{
> +		/* Valve Steam Deck (Galileo) */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
> +		},
> +		.callback = efifb_swap_width_height,
> +		.driver_data = (void *)&efifb_steamdeck_mode_fixup,
> +	},
>   	{},
>   };
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



