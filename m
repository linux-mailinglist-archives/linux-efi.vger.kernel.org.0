Return-Path: <linux-efi+bounces-5721-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7BCC92C54
	for <lists+linux-efi@lfdr.de>; Fri, 28 Nov 2025 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3611E3A2BDC
	for <lists+linux-efi@lfdr.de>; Fri, 28 Nov 2025 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1D2C21FA;
	Fri, 28 Nov 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JBMw5AMm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E/NFC69e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z1v8pc+B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cAkRiWt3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406F2C08AC
	for <linux-efi@vger.kernel.org>; Fri, 28 Nov 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349638; cv=none; b=hK/41rrtMIzwf/IBuFs8HHst7K3KVyvyIXNNrSzQQjnzB73tzAZaFVJB8su+40MaNvPVJJx6zNsndMYgtHF7qiClJoNJZ+ouph1ff4yRkfv5l9r2IsQ/ZwQsjRQvOEvQadh49SBhxdcIuUrwXjxff0YviGBbkho2db9WzExLAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349638; c=relaxed/simple;
	bh=9xxEayX3pO52b8n3kc2cn5eeBDJlStCwiqLSkaQFp2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BO9GxZgcivGiaZL0NNcLwVBZZ3X8Rrw5CTEUC1jOt7Uw9bN7FvjXqZbWvUIQemJcDnkL5hEps9ktBEDPjemnwBIAcohWOb0AjvmkOB1w/LaCfYXi/AW6G/rKk0U0KE3/JvSwU4b/ZQsFs+6j8NkQw6r19GCXVcAz0tmj3RWm928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JBMw5AMm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E/NFC69e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z1v8pc+B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cAkRiWt3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D767533760;
	Fri, 28 Nov 2025 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764349632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gopkBB4juWqX6kr8yDS3M71XNy3SxQrFtSPIlODOjic=;
	b=JBMw5AMmJ5ZRqYImBdR297KhQS+xBxjrzlgoXB9Rlc08LThnXCxBuhd54zCRE+kihDhl/3
	TN5tU60vnhXkR+qiHllGzC/spYnmFfHfnmD3dKDF6WHiFX4pEOOlMVABQXrCIoTh3bl9aP
	zFzxT5vmgPHmomYu8IO5IeszQ0mLKBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764349632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gopkBB4juWqX6kr8yDS3M71XNy3SxQrFtSPIlODOjic=;
	b=E/NFC69elMkjdc5UP7yIv3INrZ4lhTPuggpfRZvgueiD+TxWijHn6X99lji8uxM1bG0Hd2
	uQPsknkPuXBiOjDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z1v8pc+B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cAkRiWt3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764349630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gopkBB4juWqX6kr8yDS3M71XNy3SxQrFtSPIlODOjic=;
	b=z1v8pc+BNy5gP0JoKsWorashnTbsD2xCU7L+Sd1jPDcuP8D5+6XrilcEnWZIxh9qifL1Ty
	7E1lTBz76lV6xd/NHhuPBlUXqhfiJwTfQ8FtDpxp3G1e76R9DfvUPXdYtM9FdNENAhlO9U
	4BHkl7Von6v7IrAjFk5toWCcYyKsns4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764349630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gopkBB4juWqX6kr8yDS3M71XNy3SxQrFtSPIlODOjic=;
	b=cAkRiWt38bAFocEqjxV+0ZdBRZS0EBiOZR6+lDz3i2yJS63eDdXtYgE5lDTMMQOGE37DiS
	h/Pyk9mrLkKsgMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B1DA3EA63;
	Fri, 28 Nov 2025 17:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id noaEIL7WKWmScwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 28 Nov 2025 17:07:10 +0000
Message-ID: <ce41c2d1-c659-4632-8469-761762202800@suse.de>
Date: Fri, 28 Nov 2025 18:07:09 +0100
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
In-Reply-To: <20251128150403.11567-1-tvrtko.ursulin@igalia.com>
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.com:url,amd.com:email,suse.de:mid,suse.de:dkim,suse.de:email,igalia.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D767533760
X-Rspamd-Action: no action
X-Spam-Flag: NO

Hi,

thanks for the bug report

Am 28.11.25 um 16:04 schrieb Tvrtko Ursulin:
> I am not sure how is simpledrmfb on top of EFI supposed to work, but at
> least at the moment it appears there is a missing link in the "discovery"
> of frame buffer parameters.
>
> What I can see is that EFI GOP reads some parameters from the firmware and
> infers the other, such as in this case problematic pitch, or stride.

The pitch/stride value comes from the firmware via pixels_per_scanline [1].

Can you verify that this value is really 800 instead of 832 (eq 3328 
bytes) ?

[1] 
https://elixir.bootlin.com/linux/v6.17.9/source/drivers/firmware/efi/libstub/gop.c#L493

>
> One could be easily excused in thinking that pitch cannot be reliably
> inferred, since different display hardware has differing alignment
> requirements, so it is unclear how is hardware agnostic solution supposed
> to work.
>
> In the specific case of the Steam Deck hardware we have a 800x1280 native
> panel which is also installed rotated 90 degrees counter clockwise.
>
> Firmware appears to set up the pitch as 3328, while GOP assumes 3200,
> based of a width * bpp calculation.

832 is a multiple of 64, while 800 is not. I've seen this 
over-allocation in other context as well.

>
> When this incorrect pitch propagates through (rather complicated) fbcon
> and DRM call paths, the end result is corrupted rendering all until the
> amdgpu takes over the fbdev.
>
> Simplistic solution in this patch is to add a DMI quirk to the EFI
> frame buffer setup code.
>
> Apart from the incorrect pitch, the quirk also does the swapping of the
> width and height. Apart from setting the correct fbcon dimensions this
> one also allows the quirk from drm_get_panel_orientation_quirk() to
> report the correct orientation.

Nice

>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: linux-efi@vger.kernel.org
> ---
>   drivers/firmware/efi/sysfb_efi.c | 48 ++++++++++++++++++++++++++++++--
>   1 file changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 1e509595ac03..84d9049bb2cb 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -231,6 +231,18 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>   	{},
>   };
>   
> +struct efifb_mode_fixup {
> +	unsigned int width;
> +	unsigned int height;
> +	unsigned int pitch;
> +};
> +
> +static const struct efifb_mode_fixup efifb_steamdeck_mode_fixup = {
> +	.width = 1280,
> +	.height = 800,
> +	.pitch = 3328,
> +};
> +
>   /*
>    * Some devices have a portrait LCD but advertise a landscape resolution (and
>    * pitch). We simply swap width and height for these devices so that we can
> @@ -281,6 +293,24 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
>   		},
>   	},
> +	{
> +		/* Valve Steam Deck (Jupiter) */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
> +		},
> +		.driver_data = (void *)&efifb_steamdeck_mode_fixup,
> +	},
> +	{
> +		/* Valve Steam Deck (Galileo) */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
> +		},
> +		.driver_data = (void *)&efifb_steamdeck_mode_fixup,
> +	},
>   	{},
>   };
>   
> @@ -351,17 +381,31 @@ static struct fwnode_handle efifb_fwnode;
>   
>   __init void sysfb_apply_efi_quirks(void)
>   {
> +	const struct dmi_system_id *match;
> +
>   	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
>   	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
>   		dmi_check_system(efifb_dmi_system_table);
>   
> -	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
> -	    dmi_check_system(efifb_dmi_swap_width_height)) {

Could we keep swap_width_height a separate list?

The for loop would then be a full override-display list.

> +	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> +		return;
> +
> +	for (match = dmi_first_match(efifb_dmi_swap_width_height);
> +	     match;
> +	     match = dmi_first_match(match + 1)) {
> +		const struct efifb_mode_fixup *data = match->driver_data;
>   		u16 temp = screen_info.lfb_width;
>   
>   		screen_info.lfb_width = screen_info.lfb_height;
>   		screen_info.lfb_height = temp;
>   		screen_info.lfb_linelength = 4 * screen_info.lfb_width;

FTR: This calculation has always been wrong. We need to take the 
lfb_depth into account. No need to fix this here; just so you know.



> +
> +		if (data && data->pitch &&
> +		   data->width == screen_info.lfb_height &&
> +		   data->height == screen_info.lfb_width) {
> +			screen_info.lfb_linelength = data->pitch;
> +			screen_info.lfb_size = data->pitch * data->width;
> +		}

If we have a separate fix-up list, we can make this much nicer:

if (data->width)
    // assign data->width
if (data->height)
    // assign data->width
if (data->data)
    // assign data->pitch

and then recompute linelength and size

Best regards
Thomas

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



