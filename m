Return-Path: <linux-efi+bounces-5527-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1081C62C5C
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 08:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69AC33411CD
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD3319609;
	Mon, 17 Nov 2025 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gO/EMq7T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0cXYD4tS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gO/EMq7T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0cXYD4tS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C583168F1
	for <linux-efi@vger.kernel.org>; Mon, 17 Nov 2025 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365242; cv=none; b=CBcqEuBrX/jVJ4JGZ9QAxferWNiDihHgtZT6CLPcS1njzC7czOYZerR+tJxkmbzMC0/uBcS05GVBxFkjMB37ownIf+tgRDkfOXkxY7TGjMddWRFn8H+TCS5SxOAaHERtSjFmzXhzLZH7r4cUJ4rBEebyav9LeDPHNPs2IZTnXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365242; c=relaxed/simple;
	bh=zuSv0ijACyIzpzDTInbw59LsJtUvEWIvaq1AYDDQlDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw1HQdUKoJ9F4WncSQVBtSXalWKRDJPk35cALKsGHpmBc7JB3Cjn7yWzSGSWnsJWZ+1ucvwLPSbThcl/dNRGiTCbU3OkQllg0//3ajQjP69mCjKFYuAYrdFb9VhYYgN6RSvlrE9LbhjViY1BBt3n0Wr3w+jp2lCFisMtpL54y6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gO/EMq7T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0cXYD4tS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gO/EMq7T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0cXYD4tS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2540C2120E;
	Mon, 17 Nov 2025 07:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763365239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SyrdeImVaAmWweVRNISv7nc7l+eNeBZch4YQOYAa5iw=;
	b=gO/EMq7T56divsdvPtgvpRic77/iLjKExyhY3+vbD0pDkRf4Wq+Vgc5UWR4UeD5RwvPTr3
	Tq9/Oh0wfYRpIXjT3C3DDF0CT4OHQm4pl/UFz//ROjKhYAGkK3hoUYMQ8RqMNrbUGrx9j2
	NttsPeDrTsvlP7rBgXjXgnqgVHLD0pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763365239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SyrdeImVaAmWweVRNISv7nc7l+eNeBZch4YQOYAa5iw=;
	b=0cXYD4tSvpFrNUBcFLkyCHJXMFpNtkzTvnbg0d8zMBAR8vz+MO7rZouL1Hya8teIO8okuv
	gMOoWn+pqkzxxYCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763365239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SyrdeImVaAmWweVRNISv7nc7l+eNeBZch4YQOYAa5iw=;
	b=gO/EMq7T56divsdvPtgvpRic77/iLjKExyhY3+vbD0pDkRf4Wq+Vgc5UWR4UeD5RwvPTr3
	Tq9/Oh0wfYRpIXjT3C3DDF0CT4OHQm4pl/UFz//ROjKhYAGkK3hoUYMQ8RqMNrbUGrx9j2
	NttsPeDrTsvlP7rBgXjXgnqgVHLD0pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763365239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SyrdeImVaAmWweVRNISv7nc7l+eNeBZch4YQOYAa5iw=;
	b=0cXYD4tSvpFrNUBcFLkyCHJXMFpNtkzTvnbg0d8zMBAR8vz+MO7rZouL1Hya8teIO8okuv
	gMOoWn+pqkzxxYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA6843EA61;
	Mon, 17 Nov 2025 07:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMPGN3bRGmkXKgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Nov 2025 07:40:38 +0000
Message-ID: <4b1172e5-514e-4509-84e0-66818db4adb4@suse.de>
Date: Mon, 17 Nov 2025 08:40:38 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] efi/libstub: gop: Add support for reading EDID
To: Javier Martinez Canillas <javierm@redhat.com>, ardb@kernel.org,
 jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-5-tzimmermann@suse.de>
 <87qzus8vxl.fsf@ocarina.mail-host-address-is-not-set>
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
In-Reply-To: <87qzus8vxl.fsf@ocarina.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi Javier

Am 24.10.25 um 11:56 schrieb Javier Martinez Canillas:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
>> Add support for EFI_EDID_DISCOVERED_PROTOCOL and EFI_EDID_ACTIVE_PROTOCOL
>> as defined in UEFI 2.8, sec 12.9. Define GUIDs and data structures in the
>> rsp header files.
>>
>> In the GOP setup function, read the EDID of the primary GOP device. First
>> try EFI_EDID_ACTIVE_PROTOCOL, which supports user-specified EDID data. Or
>> else try EFI_EDID_DISCOVERED_PROTOCOL, which returns the display device's
>> native EDID. If no EDID could be retrieved, clear the storage.
>>
>> Rename efi_setup_gop() to efi_setup_graphics() to reflect the changes
>> Let callers pass an optional instance of struct edid_data, if they are
>> interested.
>>
>> While screen_info and edid_info come from the same device handle, they
>> should be considered indendent data. The former refers to the graphics
> independent
>
>> mode, the latter refers to the display device. GOP devices might not
>> provide both.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
> [...]
>
>> +static void setup_edid_info(struct edid_info *edid, u32 gop_size_of_edid, u8 *gop_edid)
>> +{
>> +	if (!gop_edid || gop_size_of_edid < 128)
> Can you define a constant for 128 instead of having a magic number ?

Of course. FYI the number comes from the UEFI spec 2.8, sec 12.9. It 
says that the minimum EDID size is 128 bytes.

Best regards
Thomas

>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



