Return-Path: <linux-efi+bounces-5775-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7427C9E9AB
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C70E94E17B7
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BB82E0B48;
	Wed,  3 Dec 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wQre8UNl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="95+RHBLr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wQre8UNl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="95+RHBLr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273CC2E041D
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755715; cv=none; b=MUx+Dbq4/AhB/axTdOCfERvGgCsqYyBRTu+lgyeizLAbvtUPbOg/BpxUA0657eeNJR8UXIeHII/xIna7aNLgYuLh/pXMHcfjkky6QU9Hh8XIenbog4k61llW6G1oTh0cDHnyH1CrIX4c47nM5jBo7lTmz+ntOoTj8N6zW81Uito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755715; c=relaxed/simple;
	bh=aNS5AEqzKmSN9xHbdIUz80guASB9/LlJzAZf6FeEUvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ7UtpaHClbiJVfzMierqHQJ2fPHdsHUXNU8+hWLD0pwwdFPjz7XG1c1XACmTtV6usTF1x3Jdxpni8kdD71WIF/8Uc5ilMLwfb53+tCeEB6RXYuXyoSFvchDXcOEr1ADvSi3sQC5vDVuJo41hlOjFjcTbvTnXtdl1Sn+OlUYI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wQre8UNl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=95+RHBLr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wQre8UNl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=95+RHBLr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1842F5BD22;
	Wed,  3 Dec 2025 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764755711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2HIOqJHZ0B14KeHAa5MsXvAbvYgzFUMIkP62XDWPxqE=;
	b=wQre8UNlgBLEoR7yJYhFr80PTmfUe9s5l7ISbNlukE/zRYTK6lIrHRRq5ZSQ+asN/qQVBF
	aqO485ZtJiTat6uDETZqYZo/8+GwPkdtf+2iyq9a1iENLIIL38LcnFw2Lpp+vP8O7MAqQW
	8mA8j4d/U+8QCb1HRO6xL7O7od0Gf7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764755711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2HIOqJHZ0B14KeHAa5MsXvAbvYgzFUMIkP62XDWPxqE=;
	b=95+RHBLr4tU65SlwYzggyZ48SL/wfpS1L6DXQyxr90Vj1bn2SVtt7qjXXDk8FfXyfmA0yT
	XKVSmEmS7OGA9xCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wQre8UNl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=95+RHBLr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764755711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2HIOqJHZ0B14KeHAa5MsXvAbvYgzFUMIkP62XDWPxqE=;
	b=wQre8UNlgBLEoR7yJYhFr80PTmfUe9s5l7ISbNlukE/zRYTK6lIrHRRq5ZSQ+asN/qQVBF
	aqO485ZtJiTat6uDETZqYZo/8+GwPkdtf+2iyq9a1iENLIIL38LcnFw2Lpp+vP8O7MAqQW
	8mA8j4d/U+8QCb1HRO6xL7O7od0Gf7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764755711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2HIOqJHZ0B14KeHAa5MsXvAbvYgzFUMIkP62XDWPxqE=;
	b=95+RHBLr4tU65SlwYzggyZ48SL/wfpS1L6DXQyxr90Vj1bn2SVtt7qjXXDk8FfXyfmA0yT
	XKVSmEmS7OGA9xCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D94D03EA63;
	Wed,  3 Dec 2025 09:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MI3hMv4IMGn3JgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Dec 2025 09:55:10 +0000
Message-ID: <644855d9-de31-434e-9af7-736a9e18ab69@suse.de>
Date: Wed, 3 Dec 2025 10:55:10 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] efi: sysfb_efi: Replace open coded swap with the
 macro
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Ard Biesheuvel <ardb@kernel.org>,
 Melissa Wen <mwen@igalia.com>, linux-efi@vger.kernel.org
References: <20251203093948.54296-1-tvrtko.ursulin@igalia.com>
 <20251203093948.54296-2-tvrtko.ursulin@igalia.com>
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
In-Reply-To: <20251203093948.54296-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 1842F5BD22
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:dkim,suse.de:email,igalia.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 



Am 03.12.25 um 10:39 schrieb Tvrtko Ursulin:
> Replace the open coded width height swap with the standard macro.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: linux-efi@vger.kernel.org

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/firmware/efi/sysfb_efi.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 1e509595ac03..1d8b6966731c 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -357,10 +357,7 @@ __init void sysfb_apply_efi_quirks(void)
>   
>   	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
>   	    dmi_check_system(efifb_dmi_swap_width_height)) {
> -		u16 temp = screen_info.lfb_width;
> -
> -		screen_info.lfb_width = screen_info.lfb_height;
> -		screen_info.lfb_height = temp;
> +		swap(screen_info.lfb_width, screen_info.lfb_height);
>   		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
>   	}
>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



