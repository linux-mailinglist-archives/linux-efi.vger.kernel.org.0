Return-Path: <linux-efi+bounces-3234-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C0A7FEC8
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 13:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE383BD5AE
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877F0268C72;
	Tue,  8 Apr 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k5GkgZwa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RtsMsxM1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kUz9e/Yh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+128Al+6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6EA268691
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110225; cv=none; b=TVHgih1WC36/dcNsIr0KBNnMgySzGkLbvoqzJGHpDgA0UpwXHOI6zb0BAYFfdJOs4n/mHd2BxnIzS4znu7CmwBKOSHZgJSuBxcu3IuFJnlapijiwuGh/cDxq0beIsHtooVVvDOX78bbcItvCD++TmIQwyG9mc+WZJTORpCnlb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110225; c=relaxed/simple;
	bh=A/syrqPnu7xZwW1K5ah6xrJQQLPn7vnOZcMflIeMOP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRNpDDKscJw6tElbkdFsPOZpL7B5YtOPwBGXlA4Hpv4UmKDlqvfnV5fu3YaWrFOOiUe8eblP2poqwy8sAqTmu2HUGjhYWknrppzyLTuGLsF4rMq0g54u0n1k3YNWiQpzd2ePWyHm4hw0N0cBckNoZQV9dR22eT7JBONnrHsjl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k5GkgZwa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RtsMsxM1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kUz9e/Yh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+128Al+6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF6E71F38E;
	Tue,  8 Apr 2025 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744110219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sjYu9rJyDmdLvjS1+LeZSLANqGQA15QRYWZSJyC8qSw=;
	b=k5GkgZwaOJBpklXC6B+zwvydU9fnB2efxtVK8riIptFBTqgPoHGSDhmpYXVCP2HQ5exTvO
	YcBP+C+mV1tQ/fVm0Rx1XGyVo2qm5LzL02use4FIt8zHwG6aomh6Q0/eOWqWY9up835ANH
	JDc7iFvS/r6BwryIG/TQtNANJvn7VoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744110219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sjYu9rJyDmdLvjS1+LeZSLANqGQA15QRYWZSJyC8qSw=;
	b=RtsMsxM1ksMFsAHWEgnZ4K4oSfQac+EiX3xZXgplqPpwqdOzM0oLRhHXjTMH9B1cN/HE3W
	bQPIIA9OcV+NM/CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744110218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sjYu9rJyDmdLvjS1+LeZSLANqGQA15QRYWZSJyC8qSw=;
	b=kUz9e/YhFp0GYsS6MoaxAfd4G8iFvKN8xlypfuGDcG+X2JOXsTJOL0FhB4ZvH8/C62cfmT
	Mw8zhxunFbFTYBiWq7fjgggq7rqwimk93lbheYwX3Jn83S4hyU1CIxi4i1YOCZuz/BD1JC
	h4/1ElSTPCIibgIrPPGWYB31fyQaAlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744110218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sjYu9rJyDmdLvjS1+LeZSLANqGQA15QRYWZSJyC8qSw=;
	b=+128Al+6dKT+giJMuyMuR5txAGUN5OagwmhswkPcaAU7osH7TJla2WSTGHpv7YtXPwhPNB
	SkYND5invsuGfgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC13613691;
	Tue,  8 Apr 2025 11:03:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bc50MIoC9WcLAwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 08 Apr 2025 11:03:38 +0000
Message-ID: <b97853f6-681a-4be2-b244-83ce0d26060b@suse.de>
Date: Tue, 8 Apr 2025 13:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi: Export symbol efi_mem_desc_lookup
To: Ard Biesheuvel <ardb@kernel.org>
Cc: javierm@redhat.com, linux-efi@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250408091837.407401-1-tzimmermann@suse.de>
 <20250408091837.407401-2-tzimmermann@suse.de>
 <CAMj1kXFTrY=8njYkbY3_skK8oJOY7-Y4wEdAPV6vUvi7hT2F7A@mail.gmail.com>
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
In-Reply-To: <CAMj1kXFTrY=8njYkbY3_skK8oJOY7-Y4wEdAPV6vUvi7hT2F7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 



Am 08.04.25 um 11:40 schrieb Ard Biesheuvel:
> On Tue, 8 Apr 2025 at 11:22, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Building efidrm as module requires efi_mem_desc_lookup(). Export
>> the symbol.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/firmware/efi/efi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks a lot.

>
> Feel free to take this via a DRM tree.

I'll do that.

Best regards
Thomas

>
>
>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>> index 7309394b8fc98..e57bff702b5f4 100644
>> --- a/drivers/firmware/efi/efi.c
>> +++ b/drivers/firmware/efi/efi.c
>> @@ -558,6 +558,7 @@ int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
>>
>>   extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
>>          __weak __alias(__efi_mem_desc_lookup);
>> +EXPORT_SYMBOL_GPL(efi_mem_desc_lookup);
>>
>>   /*
>>    * Calculate the highest address of an efi memory descriptor.
>> --
>> 2.49.0
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


