Return-Path: <linux-efi+bounces-5750-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E6DC9A759
	for <lists+linux-efi@lfdr.de>; Tue, 02 Dec 2025 08:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564AC3A5D52
	for <lists+linux-efi@lfdr.de>; Tue,  2 Dec 2025 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E028A23AE62;
	Tue,  2 Dec 2025 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aYkwdS2+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BU6hSf6a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eo8KI2e6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OPGhBN0F"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFFD254B18
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660868; cv=none; b=sSjTELV1biNqiNfo4N87DhpyAGVAXdFfAAQJEqP3U46RRDh7pHuvDxqdZstPfPZFVO0zXnm1sPl47pQTgotan+NCuv/LExKtGr2QQGHkZoC7RxXdHkPRptQF40RCjkzotY7fiD0YHY79gILLYz8z09WdQPsxvsZrRSvPjS7xgHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660868; c=relaxed/simple;
	bh=FZce/ghp7bOkqVe4vxRDBCLtv2Sk2QLJnGmb3j7jerQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUB97ZMf9CQ8qlne8lU6Ga2HFbLZT8zmNLK5aLQwj1/F4oq2tpmHZAgV6DdHL0CLc3Vb5G3zOoe5R5CVfLul8U6aG78N0RZA46aECnBI+x3NBCKm28JZmk4Qtazu0GEag+CvxSTDjjR6Ym/FV+IsCvZX/TnzP6Dpz4Jre8L6Az8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aYkwdS2+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BU6hSf6a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eo8KI2e6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OPGhBN0F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ABC9336A5;
	Tue,  2 Dec 2025 07:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764660857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A/yTTBF5VOprXxxci9xgTbcFEzEJ7KqfWjDqZ7WnPq0=;
	b=aYkwdS2+5bht5Zq42Su5MCb4puTV6DUhON7FvFcHOCFBQVgS4cUzF2KLmuL3P0hYzziT1C
	WE2xI+UjURwXYmNpHDvf2BQc6TglY4SlLiUX4WXiARWLC649qAAef63owYUBFypqvFHvMe
	TvX36RvnG/Zz3/YV2zfyS2ozLSAE0t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764660857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A/yTTBF5VOprXxxci9xgTbcFEzEJ7KqfWjDqZ7WnPq0=;
	b=BU6hSf6a02M1WbjOuTiMK6mb5ZosMwgBqGWL8EKU1SeoU0uuqAgi225fmL9a8B7DpYCy6Y
	tHVUDJHZ1/UsAdAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eo8KI2e6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OPGhBN0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764660855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A/yTTBF5VOprXxxci9xgTbcFEzEJ7KqfWjDqZ7WnPq0=;
	b=eo8KI2e6mP3fPfD4pI82lx5QaXztyPbR4lEzs1iLjIVXQidZSfkL2+45w7aYMekGvGF98x
	T0In91dwSPjFlmwgzHcmuYmHy3Ma15dSoRT2FmkXFfSWDlHnemfzz9cNoD11nvNdROFISe
	j/025ZcFlz4HQiQLoZu7b1hb03ge1/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764660855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A/yTTBF5VOprXxxci9xgTbcFEzEJ7KqfWjDqZ7WnPq0=;
	b=OPGhBN0FYmesOTdiW0FJTWd2EUohb79cb0whwK5AzK09SV286eRMH+W03WHDUMzZGpRt/h
	QtEgLuaw6YM/L+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3DF83EA63;
	Tue,  2 Dec 2025 07:34:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1TmLLnaWLmnidwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 02 Dec 2025 07:34:14 +0000
Message-ID: <f4dfd1b4-76c0-4b88-aefb-f0536e706f96@suse.de>
Date: Tue, 2 Dec 2025 08:34:14 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFX] efi: sysfb_efi: Fix simpledrmfb on Steam Deck
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-efi@vger.kernel.org
References: <20251128150403.11567-1-tvrtko.ursulin@igalia.com>
 <ce41c2d1-c659-4632-8469-761762202800@suse.de>
 <660c5469-086f-40b4-99f1-72c1bc613ece@igalia.com>
 <1df5a480-2510-43b9-9d79-51d842518036@suse.de>
 <b146fb1b-80e9-403c-acd1-b50ef1aaa646@igalia.com>
 <1b73df5b-5f47-4ce4-abd4-83d550cc0dea@suse.de>
 <e7c4a76e-5cef-4a75-847f-59c53a554327@igalia.com>
 <CAMj1kXFOS9jAzhh2Z_4rarEGd+kGPyNCu9PFoMhFbBVEF8NwJw@mail.gmail.com>
 <07212b84-fc2a-4efe-a39b-5b536b6dd602@igalia.com>
 <CAMj1kXH3FyhNinT3-_FqROB53p_574ft6hsoF6aGYeYkhLd+TQ@mail.gmail.com>
 <086cf4fd-6401-46ce-a55f-ea2fd96a73d1@igalia.com>
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
In-Reply-To: <086cf4fd-6401-46ce-a55f-ea2fd96a73d1@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,suse.de:dkim,suse.de:mid,wikipedia.org:url,bootlin.com:url,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 1ABC9336A5
X-Spam-Flag: NO
X-Spam-Score: -4.51

Hi

Am 01.12.25 um 16:43 schrieb Tvrtko Ursulin:
>
> On 01/12/2025 15:00, Ard Biesheuvel wrote:
>> On Mon, 1 Dec 2025 at 11:33, Tvrtko Ursulin 
>> <tvrtko.ursulin@igalia.com> wrote:
>>>
>>>
>>> On 01/12/2025 10:18, Ard Biesheuvel wrote:
>>>> On Mon, 1 Dec 2025 at 11:03, Tvrtko Ursulin 
>>>> <tvrtko.ursulin@igalia.com> wrote:
>>>>>
>>>>>
>>>>> On 01/12/2025 09:39, Thomas Zimmermann wrote:
>>>>>> Hi
>>>>>>
>>>>>> Am 01.12.25 um 10:20 schrieb Tvrtko Ursulin:
>>>>>>>
>>>>>>> On 01/12/2025 07:32, Thomas Zimmermann wrote:
>>>>>>>> Hi
>>>>>>>>
>>>>>>>> Am 29.11.25 um 11:44 schrieb Tvrtko Ursulin:
>>>>>>>>>
>>>>>>>>> On 28/11/2025 17:07, Thomas Zimmermann wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> thanks for the bug report
>>>>>>>>>>
>>>>>>>>>> Am 28.11.25 um 16:04 schrieb Tvrtko Ursulin:
>>>>>>>>>>> I am not sure how is simpledrmfb on top of EFI supposed to 
>>>>>>>>>>> work,
>>>>>>>>>>> but at
>>>>>>>>>>> least at the moment it appears there is a missing link in the
>>>>>>>>>>> "discovery"
>>>>>>>>>>> of frame buffer parameters.
>>>>>>>>>>>
>>>>>>>>>>> What I can see is that EFI GOP reads some parameters from the
>>>>>>>>>>> firmware and
>>>>>>>>>>> infers the other, such as in this case problematic pitch, or 
>>>>>>>>>>> stride.
>>>>>>>>>>
>>>>>>>>>> The pitch/stride value comes from the firmware via
>>>>>>>>>> pixels_per_scanline [1].
>>>>>>>>>>
>>>>>>>>>> Can you verify that this value is really 800 instead of 832 (eq
>>>>>>>>>> 3328 bytes) ?
>>>>>>>>>>
>>>>>>>>>> [1] https://elixir.bootlin.com/linux/v6.17.9/source/drivers/
>>>>>>>>>> firmware/ efi/libstub/gop.c#L493
>>>>>>>>>
>>>>>>>>> I actually got confused a bit in following the flow so thank 
>>>>>>>>> you for
>>>>>>>>> asking me to double check.
>>>>>>>>>
>>>>>>>>> GOP actually reports 1280x800 with a stride of 5120. So it 
>>>>>>>>> kind of
>>>>>>>>> reports a rotated view already, kind of.
>>>>>>>>
>>>>>>>> These are correct values.
>>>>>>>>
>>>>>>>> But the stream deck is this device: [1], right? It uses landscape-
>>>>>>>> mode orientation. Why does it require rotation at all?
>>>>>>>>
>>>>>>>> [1] https://de.wikipedia.org/wiki/Steam_Deck#/media/
>>>>>>>> Datei:Steam_Deck_(front).png
>>>>>>>
>>>>>>> That's the device yes. For the user the screen is landscape, but 
>>>>>>> the
>>>>>>> actual panel is 800x1280 portrait. Left edge is top of the display.
>>>>>>> (Hence the pre-existing entry in drm_get_panel_orientation_quirk.)
>>>>>>
>>>>>> I see. So the EFI display settings are configured as if this was a
>>>>>> landscape panel.
>>>>>>
>>>>>> What happens if you leave the EFI settings as-is and simply 
>>>>>> remove the
>>>>>> panel-orientation quirk?
>>>>>
>>>>> That would create effectively the same situation as without my patch
>>>>> because the panel-orientation quirk does not trigger unless detected
>>>>> screen is 800x1280. Result is corrupted console since fbcon thinks 
>>>>> it is
>>>>> a landscape 1280x800 screen.
>>>>>>>>> Only when the rotation quirk from efifb_dmi_swap_width_height
>>>>>>>>> triggers the stride gets incorrectly recalculated:
>>>>>>>>>
>>>>>>>>>           u16 temp = screen_info.lfb_width;
>>>>>>>>>
>>>>>>>>>           screen_info.lfb_width = screen_info.lfb_height;
>>>>>>>>>           screen_info.lfb_height = temp;
>>>>>>>>>           screen_info.lfb_linelength = 4 * screen_info.lfb_width;
>>>>>>>>>
>>>>>>>>> So this is where things go wrong, well, they actually go wrong a
>>>>>>>>> little bit even earlier, in gop.c:
>>>>>>>>>
>>>>>>>>>       si->lfb_size = si->lfb_linelength * si->lfb_height;
>>>>>>>>>
>>>>>>>>> Which potentially underestimates the fb size. If GOP was forward
>>>>>>>>> looking enough to give us the size we could derive the pitch 
>>>>>>>>> based
>>>>>>>>> on size..
>>>>>>>>>
>>>>>>>>> Anyway, as it stands it looks a quirk in sysfb_apply_efi_quirks
>>>>>>>>> looks it is required to fix it all up.
>>>>>>>>>
>>>>>>>>> I am a bit uneasy about declaring the fb size larger than what 
>>>>>>>>> was
>>>>>>>>> implied by firmware provided pitch * height * depth but 
>>>>>>>>> limited to a
>>>>>>>>> specific DMI match and if it looks visually okay I think it is a
>>>>>>>>> safe assumption the quirked size is actually correct and safe.
>>>>>>>>
>>>>>>>> Yeah, we better not do that.
>>>>>>> You mean declare it a firmware bug and live with the corrupt 
>>>>>>> console
>>>>>>> until the final fb driver takes over?
>>>>>>
>>>>>> I only mean that we should not use more video memory than 
>>>>>> provided by EFI.
>>>>>
>>>>> Right, but that information is not available in the GOP, right? 
>>>>> Ie. as I
>>>>> wrote above it appears assumed:
>>>>>
>>>>>       si->lfb_size = si->lfb_linelength * si->lfb_height;
>>>>>
>>>>> Do we have any other options apart from corruption or assume firmware
>>>>> configured GOP screen info incorrectly?
>>>>>
>>>>
>>>> How does it make sense to recalculate the line length? Those invisible
>>>> pixels at the end of the scanline are not going to be transposed to
>>>> the other dimension, right?
>>>
>>> Not sure what you meant here. The line above is from gop.c and the
>>> context is that GOP screen info appears to not carry the frame buffer
>>> size in bytes so it is implied.
>>>
>>> Elsewhere in the patch I quirk the pitch to the correct value so 
>>> rotated
>>> rendering is correct.
>>>
>>> But the corrected pitch also means that in principle we need to adjust
>>> the frame buffer size, since it is larger than the size implied with 
>>> the
>>> incorrect pitch.
>>>
>>
>> OK, so if I understand all of the above correctly, you have a 800x1280
>> panel with 832 pixels per scanline, right? And the 5120 pitch is
>> simply bogus, but needed to maintain the fiction that the panel is
>> 1280 pixels wide, and so the resulting lfb_size is bogus too?
>>
>> Since we know that the PixelsPerScanline value is incorrect, I don't
>> think there is any point in attempting to cross reference this against
>> other firmware provided data. But it would make sense imho to apply
>> the quirk only if the exact combination of incorrect values (i.e.,
>> 1280x800/5120) is encountered.
>
> Right, the whole 1280x800 mode I *think* could be "bogus", that is, 
> some kind of a software rotated mode implemented by the firmware.
>
> Default mode is 800x1280 (pitch 832), while this second native 
> resolution mode is 1280x800 (pitch 1280).
>
> If default mode is left then both simpledrmfb and efidrmfb work fine. 
> The existing panel orientation quirk will trigger on 800x1280 and tell 
> fbcon to rotate.
>
> But if someone, like for example grub2, changed the mode to this 
> software rotated one then the existing DRM quirk will not work.

So this is a bug in grub? Should it supply the original mode?


Apologies for only asking dump questions here. I find this very confusing.

In the correct mode 800x1280, the first native pixel should be on the 
lower left corner. and the second pixel should be 'up form it'. And 
because it's marked as rotated CCW, fbcon adapts correctly.

If the display is in the bogus mode 1280x800, in which direction does it 
draw by default?  The framebuffer's first pixel should still be in one 
of the corners. And the second pixel is nearby. In which direction does 
it advance?


>
> The quirk in this patch therefore proposes to correct back the mode to 
> the default native.
>
> You are indeed right that the criteria needs to be tweaked. In v2 I've 
> fixed and it now looks like this:
>
> ...
>     for (match = dmi_first_match(efifb_dmi_swap_width_height);
>          match;
>          match = dmi_first_match(match + 1)) {
>         const struct efifb_mode_fixup *data = match->driver_data;
>         u16 temp = screen_info.lfb_width;
>
>         if (!data ||
>             (data->width == screen_info.lfb_width &&
>              data->height == screen_info.lfb_height)) {
>             screen_info.lfb_width = screen_info.lfb_height;
>             screen_info.lfb_height = temp;

There's a swap() macro BTW. [1]

[1] 
https://elixir.bootlin.com/linux/v6.18/source/include/linux/minmax.h#L307

Best regards
Thomas

>
>             if (data && data->pitch) {
>                 screen_info.lfb_linelength = data->pitch;
>                 screen_info.lfb_size = data->pitch * data->width;
>             } else {
>                 screen_info.lfb_linelength = 4 * screen_info.lfb_width;
>             }
>         }
>     }
> ...
>
>
> Ie. only swap width<->height for the pre-existing quirks and the new 
> quirk *if* it is in 1280x800.
>
> Regards,
>
> Tvrtko
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



