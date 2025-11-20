Return-Path: <linux-efi+bounces-5619-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E74C72ACD
	for <lists+linux-efi@lfdr.de>; Thu, 20 Nov 2025 08:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 9D7EB28B19
	for <lists+linux-efi@lfdr.de>; Thu, 20 Nov 2025 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566E1607A4;
	Thu, 20 Nov 2025 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XmX3f4d7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mi4R3gmm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bX2CWIAi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BJ/ESCgB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E4184E
	for <linux-efi@vger.kernel.org>; Thu, 20 Nov 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625376; cv=none; b=h+bTPOgK5qzs4KYj3zVCdmZ5vWVQstO38GXZ/g/wrigHVR7toZW3W/cvxRPGRMmwC0n8d+XjNGX+QMdLgi0m9SJXqe7017yqSF63j4gU1KihT2xB7dRsXUsvQb84bPlG2H3sA/grvogfuDXlbWgAU64HgY1zo6YngMJF2mtJN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625376; c=relaxed/simple;
	bh=9gWHJTn6qb0jSS1Zm9TXZyf29O9w10iNS24HK5/abCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIVOyx4YyEE2ALdafpV0v2yWqnnK8yHa7f9EVMCK2AT0qux3iwNT47TuuhniXfpD959qBrCfzHYoWzd6Jf/hl7q9jxnJlEZH/kEKyHRVh8FaFgRo6n831G7FFxZR6Wh2PjwEvze65c2v8tt/xH24Ek2imxw3VPJpPC4fEvr02CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XmX3f4d7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mi4R3gmm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bX2CWIAi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BJ/ESCgB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAAB3208F7;
	Thu, 20 Nov 2025 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763625372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zYQ52dIGW5fTFtH8uZzVMg0CFUQSPtB5jQaBC4A1+uw=;
	b=XmX3f4d7LOyo7eo8EX04dyiVh7uXkixy/AWBE/1qhUiNzaRjx4K7FhZm9tMfE3VV28b3Qa
	Y2cGZ57JF5lf1bTGg0byxCFPngAtzKx+iON06zGF5z+1iJH2xaQiF85TSNQRjZWadn/9ds
	hXiqYPzjx9xbkKzi8XNFDBf5Ob33fiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763625372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zYQ52dIGW5fTFtH8uZzVMg0CFUQSPtB5jQaBC4A1+uw=;
	b=Mi4R3gmmBwC6OElUaXfPA+3SlNLPX8HrvchrudO1h1tjpWRpmjUsIiN5jB7d/xUU3uNYTN
	3CmCEV42GIvnqNCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bX2CWIAi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="BJ/ESCgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763625370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zYQ52dIGW5fTFtH8uZzVMg0CFUQSPtB5jQaBC4A1+uw=;
	b=bX2CWIAiyj54pqxoLqnTj0xcZ3nu/FmHrqfdOeC0d5aBeI0f1SzojYv91VyItHGAGaIYhF
	7sYQHqJ0/QlncW/2PYpd/NyA37Oyi7EcSRUr/j4M8sNjtSADzd0m7k6MvqSWj+Ql7a8cuz
	lCoExeEvLTXVshbvS7s0ttvbvy5LO5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763625370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zYQ52dIGW5fTFtH8uZzVMg0CFUQSPtB5jQaBC4A1+uw=;
	b=BJ/ESCgByaciQKvw0l75KBY2cg/LnnzEY9RvI2UKusaVGoIiziCN5Wju2CY92MvnpDk5So
	XfPyf2IZE0/BKPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0CF23EA61;
	Thu, 20 Nov 2025 07:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bQW5KZrJHmkMRwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 20 Nov 2025 07:56:10 +0000
Message-ID: <4ca283ad-c549-4da4-93f9-e3cf17ab45a4@suse.de>
Date: Thu, 20 Nov 2025 08:56:10 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] video/efi: Support FIRMWARE_EDID on non-x86
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>
References: <20251119123011.1187249-5-ardb+git@google.com>
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
In-Reply-To: <20251119123011.1187249-5-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DAAB3208F7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[git];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,suse.de:email,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Hi,

thanks for addressing the remaining EDID support.

First of all, you need to cc dri-devel@lists.freedesktop.org  on any 
further revisions.

Am 19.11.25 um 13:30 schrieb Ard Biesheuvel:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Refactor the screen_info handling so non-x86 platforms booting via the
> EFI stub also have access to the EDID data exposed by the EFI boot
> services.

I don't like how this series complicates everything to make non-x86 
easier. But the general idea of using efi_screen_info goes into the 
right direction. It's just not generic enough.

The sysfb code transfers struct screen_info as device parameter [1]. 
Drivers later fetch it on probe [2].  The direct ref to the global 
edid_info [3] only exists because we have no means of transferring it as 
device data.

So instead of using efi_screen_info, let's declare struct sysfb_display 
with screen_info and edid_info.  The header would be linux/sysfb.h.  We 
transfer this to all related drivers.  The generic EFI code would set it 
up like efi_screen_info and the x86 code would decalre it at [4]; 
replacing the existing state.

Best regards
Thomas

[1] 
https://elixir.bootlin.com/linux/v6.17.8/source/drivers/firmware/sysfb.c#L205
[2] 
https://elixir.bootlin.com/linux/v6.17.8/source/drivers/gpu/drm/sysfb/efidrm.c#L162
[3] 
https://elixir.bootlin.com/linux/v6.17.8/source/drivers/gpu/drm/sysfb/efidrm.c#L206
[4] 
https://elixir.bootlin.com/linux/v6.17.8/source/arch/x86/kernel/setup.c#L214


>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
>
> Ard Biesheuvel (3):
>    efi: Wrap screen_info in efi_screen_info so edid_info can be added
>      later
>    video/edid: Use getter function for edid_info
>    efi: Add FIRMWARE_EDID support
>
>   arch/x86/kernel/setup.c                       |  8 ++++++--
>   drivers/firmware/efi/earlycon.c               |  1 -
>   drivers/firmware/efi/efi-init.c               | 19 ++++++++++++++-----
>   drivers/firmware/efi/libstub/efi-stub-entry.c |  3 +--
>   drivers/firmware/efi/libstub/efi-stub.c       | 16 ++++++++++------
>   drivers/firmware/efi/libstub/efistub.h        |  9 +++------
>   drivers/firmware/efi/libstub/gop.c            |  1 -
>   drivers/firmware/efi/libstub/screen_info.c    |  7 +++----
>   drivers/firmware/efi/libstub/zboot.c          |  2 +-
>   drivers/firmware/efi/sysfb_efi.c              |  1 -
>   drivers/gpu/drm/sysfb/efidrm.c                |  4 ++--
>   drivers/gpu/drm/sysfb/vesadrm.c               |  4 ++--
>   drivers/video/Kconfig                         |  2 +-
>   drivers/video/fbdev/core/fbmon.c              |  4 ++--
>   include/linux/efi.h                           | 10 +++++++++-
>   include/video/edid.h                          |  2 +-
>   16 files changed, 55 insertions(+), 38 deletions(-)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



