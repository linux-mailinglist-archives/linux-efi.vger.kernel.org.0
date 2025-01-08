Return-Path: <linux-efi+bounces-2530-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD06A054FE
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 09:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2571165785
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C91B0420;
	Wed,  8 Jan 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qAmhoAOn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dG7UV5I9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qAmhoAOn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dG7UV5I9"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840271AA781;
	Wed,  8 Jan 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323696; cv=none; b=ZR1A5holZ+AX9pueLKcSZtEZHb37VkEq2cmXmQsTvr2xA5UsmAwpTiKwIsQ/sAy7ueLybnbggmldrc1BkBfH8LbmwYkYraPLquOaw8VuTxgaqKUd7v71VPau0cN+Bg8PX0lQ4tUjolWQoH4/06MYUTqsyq952YX5u676hCb30+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323696; c=relaxed/simple;
	bh=f8QGizgyLFPdZcY55UYNHLpecumNSt052q/9eVuBE4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhGK/9TR2iRaG55TW4seEm1zuDy/qmAhRB0ZwBVj1Rexv8b3E173dpb1yvkN8LVxml9AB+yVmOfe3qqH5aKymXUbQzbcRpEGHP+69OwqrU0I9shTn2wLMS6+GuozQzWVPxiAAH7/A4cuFGUwfTmXrpIUy+quFleGtESfabXw3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qAmhoAOn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dG7UV5I9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qAmhoAOn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dG7UV5I9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86A8C1F385;
	Wed,  8 Jan 2025 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736323692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hPgF46OqIu6D02ASQbPXtP5sj7PYHM6U2N7KMiv2rVk=;
	b=qAmhoAOnHLkmE7Y9mlI68lNYkOrEu/FfLdJHO/dG1+rk100PM3SFEGXSRZPoAgU8lvVDWx
	NkR8K6bZ5wnQ7/8l7AKXxepvmyiHwzJez/UTMdRj88a+oL723OW8f9Fd+2+++k55hWhyFz
	MrNnVb+bDfY5zAISu6UYq0Z6S6+fpW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736323692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hPgF46OqIu6D02ASQbPXtP5sj7PYHM6U2N7KMiv2rVk=;
	b=dG7UV5I9zIZRrqZ/9n10lBtLQ+BmKkH69AM+AVwAeoY2jyc+1sV3AkuSOaoLKX/2h3+ZDT
	YtlXnBptlHJ1xADw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736323692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hPgF46OqIu6D02ASQbPXtP5sj7PYHM6U2N7KMiv2rVk=;
	b=qAmhoAOnHLkmE7Y9mlI68lNYkOrEu/FfLdJHO/dG1+rk100PM3SFEGXSRZPoAgU8lvVDWx
	NkR8K6bZ5wnQ7/8l7AKXxepvmyiHwzJez/UTMdRj88a+oL723OW8f9Fd+2+++k55hWhyFz
	MrNnVb+bDfY5zAISu6UYq0Z6S6+fpW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736323692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hPgF46OqIu6D02ASQbPXtP5sj7PYHM6U2N7KMiv2rVk=;
	b=dG7UV5I9zIZRrqZ/9n10lBtLQ+BmKkH69AM+AVwAeoY2jyc+1sV3AkuSOaoLKX/2h3+ZDT
	YtlXnBptlHJ1xADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3613E1351A;
	Wed,  8 Jan 2025 08:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CghoC2wyfmeDTQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 08 Jan 2025 08:08:12 +0000
Message-ID: <a11e4bdc-51a3-4768-95a0-30251923f914@suse.de>
Date: Wed, 8 Jan 2025 09:08:11 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: sysfb_efi: fix W=1 warnings when EFI is not set
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, David Rheinsberg <david@readahead.eu>,
 Hans de Goede <hdegoede@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Peter Jones <pjones@redhat.com>, Simona Vetter <simona@ffwll.ch>,
 linux-fbdev@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org
References: <20250107235312.236247-1-rdunlap@infradead.org>
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
In-Reply-To: <20250107235312.236247-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 




Am 08.01.25 um 00:53 schrieb Randy Dunlap:
> A build with W=1 fails because there are code and data that are not
> needed or used when CONFIG_EFI is not set. Move the "#ifdef CONFIG_EFI"
> block to earlier in the source file so that the unused code/data are
> not built.
>
> drivers/firmware/efi/sysfb_efi.c:345:39: warning: ‘efifb_fwnode_ops’ defined but not used [-Wunused-const-variable=]
>    345 | static const struct fwnode_operations efifb_fwnode_ops = {
>        |                                       ^~~~~~~~~~~~~~~~
> drivers/firmware/efi/sysfb_efi.c:238:35: warning: ‘efifb_dmi_swap_width_height’ defined but not used [-Wunused-const-variable=]
>    238 | static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>        |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/firmware/efi/sysfb_efi.c:188:35: warning: ‘efifb_dmi_system_table’ defined but not used [-Wunused-const-variable=]
>    188 | static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>        |                                   ^~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 15d27b15de96 ("efi: sysfb_efi: fix build when EFI is not set")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501071933.20nlmJJt-lkp@intel.com/
> Cc: David Rheinsberg <david@readahead.eu>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/firmware/efi/sysfb_efi.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20250106.orig/drivers/firmware/efi/sysfb_efi.c
> +++ linux-next-20250106/drivers/firmware/efi/sysfb_efi.c
> @@ -91,6 +91,7 @@ void efifb_setup_from_dmi(struct screen_
>   		_ret_;						\
>   	})
>   
> +#ifdef CONFIG_EFI
>   static int __init efifb_set_system(const struct dmi_system_id *id)
>   {
>   	struct efifb_dmi_info *info = id->driver_data;
> @@ -346,7 +347,6 @@ static const struct fwnode_operations ef
>   	.add_links = efifb_add_links,
>   };
>   
> -#ifdef CONFIG_EFI
>   static struct fwnode_handle efifb_fwnode;
>   
>   __init void sysfb_apply_efi_quirks(void)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


