Return-Path: <linux-efi+bounces-5644-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C00C5C7AC84
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 17:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEEFE344AAC
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18C63563EA;
	Fri, 21 Nov 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VYk3CIpZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cNwt4uiJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WVgwDCAu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DFkkUfmI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C2350A28
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741389; cv=none; b=h98lE8h9qVsW9cZEVIGov2tR31fdV6sSDUGxr5B10aHhM6FmVUUDQnFTwRbTY2VUoTeDKUGdd/SOCM2fGJ7Lk5EU7cR5WMoBnChufO7uuTWbtVKCqSa26C+4QytcQ2QjE84BYlc1TKSRUbQ6NElxC8CgES+/ABi4Kw09ERMo9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741389; c=relaxed/simple;
	bh=WCYRG8WBcKi1xSHRHR9sL9xknkxGCt3iF4d5u0mkLLE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fX9/4R9e0VUe7QgMM4ITIPdzsTbsItR96oB3c7SOvPljelGA1MOIM1z4fd/ErC6kbto679yROw3V3WPMxFgOo1CfzvSegMi/polkHN+AIq4IiXbmCuqNEmkUn0S4Ijchy+qiRyZ61RFawQwGe3hCvYzmaiTRybSImVcenTBmk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VYk3CIpZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cNwt4uiJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WVgwDCAu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DFkkUfmI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D08F4219AE;
	Fri, 21 Nov 2025 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763741385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YWF5Gqatpe7uXgDZfnlzgBYpZAL3G71iq33Vz3XKzbk=;
	b=VYk3CIpZTuX3vC5TLhYm7CYkRrmnrSCwY8lrHsDWQ4LPmIlsI44hqqxjELFq0r+hpW8EPQ
	sMstgqzW05MRPZCaNMu+1IBShDsRVLPLdVWNi78Y9Ee2twWwpac4OgGIJYngt7Zj3qVaKe
	eRzMnyK1Qfnq/sOsnIQo6hw6OvVkRFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763741385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YWF5Gqatpe7uXgDZfnlzgBYpZAL3G71iq33Vz3XKzbk=;
	b=cNwt4uiJyZBwJoZYAwuqnBfkFXTvQzVZ6uOUWIJRS0CNcypP11CVK9xOLYIkJUUgi9pl1S
	71F/bY5Xp7+WykAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WVgwDCAu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DFkkUfmI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763741384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YWF5Gqatpe7uXgDZfnlzgBYpZAL3G71iq33Vz3XKzbk=;
	b=WVgwDCAulE/giH64FnewbOfb7fwtv1PZeOWZ6FGNhUoYWSp0oodMAp/vUWZzUUmpXqdzNv
	qc+L0PJV28pPXHs/3w/mV0rsm6qgy6xH71zcgys9R3b5D0Hxz9ZC65Thn2JL4B/t16Q/9O
	YdzaNJWmjlbjEU3WygBUd1ydujN37gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763741384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YWF5Gqatpe7uXgDZfnlzgBYpZAL3G71iq33Vz3XKzbk=;
	b=DFkkUfmI85+frvQ3XZvNYr5FZLZo6nTmEI8OjOWa1xDFKlwd0Zasc/ZVcqCiFIPv2mCu2F
	pVq66XnyZa/uG4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B3A73EA61;
	Fri, 21 Nov 2025 16:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oC3CHMiOIGlneAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Nov 2025 16:09:44 +0000
Message-ID: <6dff8e7e-c99b-443d-a1d8-22650ca0b595@suse.de>
Date: Fri, 21 Nov 2025 17:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] arch, sysfb: Move screen and edid info into single
 place
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Javier Martinez Canillas <javierm@redhat.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20251121135624.494768-1-tzimmermann@suse.de>
 <96a8d591-29d5-4764-94f9-6042252e53ff@app.fastmail.com>
 <CAMj1kXF1Dh0RbuqYc0fhAPf-CM0mdYh8BhenM8-ugKVHfwnhBg@mail.gmail.com>
 <199e7538-5b4a-483b-8976-84e4a8a0f2fd@suse.de>
 <CAMj1kXE+mS1Sm5GaROU0P97J2w1pew0P_To4sKiw8h1iOMuLcg@mail.gmail.com>
 <d080729c-6586-4b9c-b234-470977849d3d@suse.de>
Content-Language: en-US
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
In-Reply-To: <d080729c-6586-4b9c-b234-470977849d3d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D08F4219AE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,arndb.de:email,suse.de:email,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 



Am 21.11.25 um 17:08 schrieb Thomas Zimmermann:
> Hi
>
> Am 21.11.25 um 16:56 schrieb Ard Biesheuvel:
>> On Fri, 21 Nov 2025 at 16:53, Thomas Zimmermann <tzimmermann@suse.de> 
>> wrote:
>>> Hi
>>>
>>> Am 21.11.25 um 16:16 schrieb Ard Biesheuvel:
>>>> On Fri, 21 Nov 2025 at 16:10, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>> On Fri, Nov 21, 2025, at 14:36, Thomas Zimmermann wrote:
>>>>>> Replace screen_info and edid_info with sysfb_primary_device of type
>>>>>> struct sysfb_display_info. Update all users.
>>>>>>
>>>>>> Sysfb DRM drivers currently fetch the global edid_info directly, 
>>>>>> when
>>>>>> they should get that information together with the screen_info 
>>>>>> from their
>>>>>> device. Wrapping screen_info and edid_info in 
>>>>>> sysfb_primary_display and
>>>>>> passing this to drivers enables this.
>>>>>>
>>>>>> Replacing both with sysfb_primary_display has been motivate by 
>>>>>> the EFI
>>>>>> stub. EFI wants to transfer EDID via config table in a single entry.
>>>>>> Using struct sysfb_display_info this will become easily possible. 
>>>>>> Hence
>>>>>> accept some churn in architecture code for the long-term 
>>>>>> improvements.
>>>>> This all looks good to me,
>>>>>
>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>> Thanks
>>>
>>>>> It should also bring us one step closer to eventually
>>>>> disconnecting the x86 boot ABI from the kernel-internal
>>>>> sysfb_primary_display.
>>>>>
>>>> Agreed
>>>>
>>>> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>>> Thanks
>>>
>>>> I can take patches 1-2 right away, if that helps during the next 
>>>> cycle.
>>>   From my sysfb-focused POV, these patches would ideally all go through
>>> the same tree, say efi or generic arch, or whatever fits best. Most of
>>> the other code is only renames anyway.
>>>
>> I don't mind queueing all of it, but I did get a conflict on
>> drivers/pci/vgaarb.c
>
> Probably from a78835b86a44 ("PCI/VGA: Select SCREEN_INFO on X86")

https://lore.kernel.org/all/20251013220829.1536292-1-superm1@kernel.org/


>  that I have in my tree. You can fix it by replacing screen_info with 
> sysfb_primary_display.screen. The later merge conflict seems manageable.
>
> Best regards
> Thomas
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



