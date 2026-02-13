Return-Path: <linux-efi+bounces-6138-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJrYNr9qj2l5QwEAu9opvQ
	(envelope-from <linux-efi+bounces-6138-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 19:17:35 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44480138DFC
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 19:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3044301FD74
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A0925783A;
	Fri, 13 Feb 2026 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pkmyF74k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0xe0QYIE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pkmyF74k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0xe0QYIE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB801A5B90
	for <linux-efi@vger.kernel.org>; Fri, 13 Feb 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006652; cv=none; b=D5Y7Lrsx3XnsrwjML8f5GPNRuKq992yekzzwPcAFpgnqTd/yDCiMcPu34fghyhbR/6xe10h4RPlGmEOe/LsJY2IjUjmNXf7t3c1IWb1eEYCThSBlR0rGwnBDU5HjjbUgm5XJhkqzZz8YjPScbIS/s8y4IBKjK4FpYF5EfzwQe/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006652; c=relaxed/simple;
	bh=dwfptf3YzF7ZFa3rXQuWt4gQifOsE2bHpgfbYH3q+cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKgZMjb604pmTU7FxvHb+hF1cxR9l0Tn/37vjkYC8bB/zv30UBM9RRuuIpaQPL/uAiXXaY+j2PsTZT5hyazKzSBETHjPK8Z1pQeTSGu0Lv8rZei9hgn8GV5xV8VJlgCSTACgldc2Fj2vyoXpkhHCpyiiELNHR56CwFZsh9Ybx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pkmyF74k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0xe0QYIE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pkmyF74k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0xe0QYIE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B35FA5BCDD;
	Fri, 13 Feb 2026 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771006649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TdJjxQqP+j9deDx5QcIKhxrpHUiTPE2P4Ztkg451fyc=;
	b=pkmyF74k53fM2AizTXUoouDUHWvAvUgbldfMC3KeHuzk/ARPYwqx/EAdEQHlOhLs5qM5Mv
	C0g0JT7nX5ML4HKilBj02BFBj9ZQuYRmtbs3JZDbQA3NKFT+7UM5szgzw8okZz7YNTO2HN
	w7fu/y28jBeBlxpuC5uvl9maohlGZ/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771006649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TdJjxQqP+j9deDx5QcIKhxrpHUiTPE2P4Ztkg451fyc=;
	b=0xe0QYIEjvpgGU6R5BdFc/YhIyad1lPsLkqe/jgXj34tsr0k5S1WnqN2XnXi958sj/FPfH
	o+yH2mBOlVT1vGAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pkmyF74k;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0xe0QYIE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771006649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TdJjxQqP+j9deDx5QcIKhxrpHUiTPE2P4Ztkg451fyc=;
	b=pkmyF74k53fM2AizTXUoouDUHWvAvUgbldfMC3KeHuzk/ARPYwqx/EAdEQHlOhLs5qM5Mv
	C0g0JT7nX5ML4HKilBj02BFBj9ZQuYRmtbs3JZDbQA3NKFT+7UM5szgzw8okZz7YNTO2HN
	w7fu/y28jBeBlxpuC5uvl9maohlGZ/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771006649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TdJjxQqP+j9deDx5QcIKhxrpHUiTPE2P4Ztkg451fyc=;
	b=0xe0QYIEjvpgGU6R5BdFc/YhIyad1lPsLkqe/jgXj34tsr0k5S1WnqN2XnXi958sj/FPfH
	o+yH2mBOlVT1vGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A2C53EA62;
	Fri, 13 Feb 2026 18:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EoF1GLlqj2k3dgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 13 Feb 2026 18:17:29 +0000
Message-ID: <80fd8ea2-bca0-4a8c-a442-77beefc06105@suse.de>
Date: Fri, 13 Feb 2026 19:17:28 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: export sysfb_primary_display for EDID
To: Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>,
 Evangelos Petrongonas <epetron@amazon.de>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260213165158.1327846-1-arnd@kernel.org>
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
In-Reply-To: <20260213165158.1327846-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-6138-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-efi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,intel.com:email,arndb.de:email]
X-Rspamd-Queue-Id: 44480138DFC
X-Rspamd-Action: no action



Am 13.02.26 um 17:51 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The sysfb_primary_display structure is now part of efi-init.c but
> conditionally defined. One of the users is missing in the condition:
>
> aarch64-linux-ld: drivers/video/fbdev/core/fbmon.o: in function `fb_firmware_edid':
> fbmon.c:(.text.fb_firmware_edid+0x3c): undefined reference to `sysfb_primary_display'
>
> Export it whenever CONFIG_FIRMWARE_EDID is set, so the fbdev core
> code can use it.
>
> Fixes: 4fcae6358871 ("sysfb: Move edid_info into sysfb_primary_display")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602111543.Do4nkY5l-lkp@intel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for the fix.

> ---
> Sorry for missing this earlier, I had a local fixup in my randconfig
> tree but never sent it out until I stumbled over it today. The
> broken commit is now merged in mainline for 7.0, and I think this one
> is needed as a regression fix.
> ---
>   drivers/firmware/efi/efi-init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index 9fc501fbc870..850f85f04520 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -61,7 +61,7 @@ extern __weak const efi_config_table_type_t efi_arch_tables[];
>    * x86 defines its own instance of sysfb_primary_display and uses
>    * it even without EFI, everything else can get them from here.
>    */
> -#if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON))
> +#if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)) || defined(CONFIG_FIRMWARE_EDID)
>   struct sysfb_display_info sysfb_primary_display __section(".data");
>   EXPORT_SYMBOL_GPL(sysfb_primary_display);
>   #endif

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



