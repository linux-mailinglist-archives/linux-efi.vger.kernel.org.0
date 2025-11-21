Return-Path: <linux-efi+bounces-5646-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9BC7AD42
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 17:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C8C3A1B45
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC43BB5A;
	Fri, 21 Nov 2025 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e3xa/MVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6iaW69cV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VV/AperT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+DorV6SI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E681ACEDF
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742369; cv=none; b=Xb+TFbFvTqf8fnoKrJmwPvKkqWpGTv5hbzActFtEOQek3O9n7Zl630ciFUf9KiSAmy6kQ0vLAh00Mcn9ZNmo2GOBNWOQQxm+71ljszyWuON6WNlHjSgjiH8QowuVETQanXKU0eF2povEyLTnvEX8+D3AcJdjA1rzr9RcgoR3gUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742369; c=relaxed/simple;
	bh=wfKCScMOnSIwC4cB3cLBfu7TetMDG4K17te7qh71/0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gi+16SGXLFkoP+4mJ36K2sexzrTz16LjRpvrbbiGVddsQ24kEhkXZuKWwQwhiX6kM3OIpBbR2xJZhuKzdC0+T57jyyke4E+eR9Ezb2KSN1W7z+d7MuxajoSOVowEE8WcbXkQzW2UaP/UU60m582nkm/M+v4de4dseEybDjOMsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e3xa/MVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6iaW69cV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VV/AperT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+DorV6SI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 787425BCC3;
	Fri, 21 Nov 2025 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763742366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2EbQbMBVh+wtPe2xKxStWSFqDMGQxv4HinVXPej2xOg=;
	b=e3xa/MVuw2mTa15pphIIiW3Fo7ayZEAeOTwDRCYR+LSYpJRosugF3q8BfYZsKiIeylcIKN
	YIYoyBuposxE+4Rr1Ce+L4ACEOKq+vf77cEx7yYM/ws7Z+bMZl0KxfmusjiCcEWmaVBZcz
	20pSRFRcmE31f9WhvQ7MpDYL7bY2Snw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763742366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2EbQbMBVh+wtPe2xKxStWSFqDMGQxv4HinVXPej2xOg=;
	b=6iaW69cVy6XAOoi/21AmFXwZp5jxrwUMBQUI59lgt1PS9XOI1mtWjrvhU9z5hhbcc+K3tV
	/iuFckSa5kxqfoDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763742365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2EbQbMBVh+wtPe2xKxStWSFqDMGQxv4HinVXPej2xOg=;
	b=VV/AperTpowj2cQmB95YfLGIhbpQrsQdRUpH6FBgAa1qYMuAS6fMKFCPCqOaoIKYR5pSB4
	s6yuV4YEVNYreBx6rSo410SJITGRhO777f9G+Ep18SefHIXYGhrp2EVLCJPMUAQB58tYIt
	0Jx4ZrMAj5vAxEIoUWzrP4mvhqCnn1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763742365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2EbQbMBVh+wtPe2xKxStWSFqDMGQxv4HinVXPej2xOg=;
	b=+DorV6SINtIaTNa/HgRma0Y9SsO2x1mw1lziFfqwcAn1sqMO59qo7Cirv+ZBnP7ohtLy2P
	CM9XZ8kP0TEKzvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B7E63EA61;
	Fri, 21 Nov 2025 16:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0FlbBZ2SIGnICQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Nov 2025 16:26:05 +0000
Message-ID: <8d0bc096-e346-462b-a274-f0cc1456eea3@suse.de>
Date: Fri, 21 Nov 2025 17:26:04 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] arch, sysfb: Move screen and edid info into single
 place
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
 <6dff8e7e-c99b-443d-a1d8-22650ca0b595@suse.de>
 <CAMj1kXGpC_162bFL65kQw=7qVP7ezYw77Q76y217dDs8pqHogw@mail.gmail.com>
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
In-Reply-To: <CAMj1kXGpC_162bFL65kQw=7qVP7ezYw77Q76y217dDs8pqHogw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,arndb.de:email,suse.com:url,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi

Am 21.11.25 um 17:19 schrieb Ard Biesheuvel:
> On Fri, 21 Nov 2025 at 17:09, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>>
>> Am 21.11.25 um 17:08 schrieb Thomas Zimmermann:
>>> Hi
>>>
>>> Am 21.11.25 um 16:56 schrieb Ard Biesheuvel:
>>>> On Fri, 21 Nov 2025 at 16:53, Thomas Zimmermann <tzimmermann@suse.de>
>>>> wrote:
>>>>> Hi
>>>>>
>>>>> Am 21.11.25 um 16:16 schrieb Ard Biesheuvel:
>>>>>> On Fri, 21 Nov 2025 at 16:10, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>>> On Fri, Nov 21, 2025, at 14:36, Thomas Zimmermann wrote:
>>>>>>>> Replace screen_info and edid_info with sysfb_primary_device of type
>>>>>>>> struct sysfb_display_info. Update all users.
>>>>>>>>
>>>>>>>> Sysfb DRM drivers currently fetch the global edid_info directly,
>>>>>>>> when
>>>>>>>> they should get that information together with the screen_info
>>>>>>>> from their
>>>>>>>> device. Wrapping screen_info and edid_info in
>>>>>>>> sysfb_primary_display and
>>>>>>>> passing this to drivers enables this.
>>>>>>>>
>>>>>>>> Replacing both with sysfb_primary_display has been motivate by
>>>>>>>> the EFI
>>>>>>>> stub. EFI wants to transfer EDID via config table in a single entry.
>>>>>>>> Using struct sysfb_display_info this will become easily possible.
>>>>>>>> Hence
>>>>>>>> accept some churn in architecture code for the long-term
>>>>>>>> improvements.
>>>>>>> This all looks good to me,
>>>>>>>
>>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>>> Thanks
>>>>>
>>>>>>> It should also bring us one step closer to eventually
>>>>>>> disconnecting the x86 boot ABI from the kernel-internal
>>>>>>> sysfb_primary_display.
>>>>>>>
>>>>>> Agreed
>>>>>>
>>>>>> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>>>>> Thanks
>>>>>
>>>>>> I can take patches 1-2 right away, if that helps during the next
>>>>>> cycle.
>>>>>    From my sysfb-focused POV, these patches would ideally all go through
>>>>> the same tree, say efi or generic arch, or whatever fits best. Most of
>>>>> the other code is only renames anyway.
>>>>>
>>>> I don't mind queueing all of it, but I did get a conflict on
>>>> drivers/pci/vgaarb.c
>>> Probably from a78835b86a44 ("PCI/VGA: Select SCREEN_INFO on X86")
>> https://lore.kernel.org/all/20251013220829.1536292-1-superm1@kernel.org/
>>
> Yes, if I merge back -rc2 first, I can apply patches 1-5 onto my
> efi/next tree. But then I hit
>
> Applying: sysfb: Move edid_info into sysfb_primary_display
> error: sha1 information is lacking or useless (drivers/gpu/drm/sysfb/efidrm.c).
> error: could not build fake ancestor
> Patch failed at 0006 sysfb: Move edid_info into sysfb_primary_display
>
> If you prefer, you can take the whole lot via the sysfb tree instead,
> assuming it does not depend on the EDID changes I already queued up?

Sure, I can also add it to the drm-misc tree. ETA in upstream would be 
v6.20-rc1.

Best regards
Thomas


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



