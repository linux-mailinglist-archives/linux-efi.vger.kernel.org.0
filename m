Return-Path: <linux-efi+bounces-5620-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4088C72C24
	for <lists+linux-efi@lfdr.de>; Thu, 20 Nov 2025 09:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 804674E3203
	for <lists+linux-efi@lfdr.de>; Thu, 20 Nov 2025 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3D1309F0B;
	Thu, 20 Nov 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BcNFFl+V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nxzk1dON";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BcNFFl+V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nxzk1dON"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD62F7AA3
	for <linux-efi@vger.kernel.org>; Thu, 20 Nov 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626792; cv=none; b=LQmMrMYcVaNjghxdbG1LPKZ5qSjLgp4kTUAszGA/EKVAeIOU6kMdal+6+HgOQ9nUKcPnEKfclqOqk0JdX8R3HJVTwo3aHEM4c9FQuACLycvADQiKToy8oWHilPCzadSgZ/vjT8g8vGc8bIecp6yzbdcry5jQvJf4g6Xb53OR/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626792; c=relaxed/simple;
	bh=V27PedPAMQqAc4wirU25/ejOHY/gjfD/RIOsVZCaKRI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NfcKyaWDOHkk1dKreauu9VlFhJsqN9QjpMNnMOE4olcBFOSAN7/PoHtk/dvupdN2ndpeManmiP1yc9/9SKk0uYjc9th8efg4WTKrmvjUwVoCY3Eo31O+CmrP5DVyNgC77HkFVu6+VdAqRxVM69mDSJUfRFTgpLPfSom0lOxTS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BcNFFl+V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nxzk1dON; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BcNFFl+V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nxzk1dON; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FD17218B1;
	Thu, 20 Nov 2025 08:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763626783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G7qcTq4JVDIrYtpM3ZcBrl4tbBEgyAasvnXEi8W0oXU=;
	b=BcNFFl+VTLxmW7b/bmLWQW2/aQvWg6SvviahidS8nzKKez7paqvZAyoHtIbcM9aAXrHL7j
	zT5vT6LIysLOte4Nl6sbhzrqIqKkhAGUqIdjGowCaQQeouGIddfyeeHwNlukW2xs9qnIo3
	5+kSy0sJLzuR9e2L6lECacsk9r1K4PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763626783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G7qcTq4JVDIrYtpM3ZcBrl4tbBEgyAasvnXEi8W0oXU=;
	b=nxzk1dONld9/p8m3m8vyxAx+YbgsljzYECczQBJ0bl1xsI2+1SADvpmT+UFwNCFyWnKSiB
	o/Wiyd9nHJO8pqBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BcNFFl+V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nxzk1dON
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763626783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G7qcTq4JVDIrYtpM3ZcBrl4tbBEgyAasvnXEi8W0oXU=;
	b=BcNFFl+VTLxmW7b/bmLWQW2/aQvWg6SvviahidS8nzKKez7paqvZAyoHtIbcM9aAXrHL7j
	zT5vT6LIysLOte4Nl6sbhzrqIqKkhAGUqIdjGowCaQQeouGIddfyeeHwNlukW2xs9qnIo3
	5+kSy0sJLzuR9e2L6lECacsk9r1K4PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763626783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G7qcTq4JVDIrYtpM3ZcBrl4tbBEgyAasvnXEi8W0oXU=;
	b=nxzk1dONld9/p8m3m8vyxAx+YbgsljzYECczQBJ0bl1xsI2+1SADvpmT+UFwNCFyWnKSiB
	o/Wiyd9nHJO8pqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCD243EA61;
	Thu, 20 Nov 2025 08:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d2S1NB7PHmlvXQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 20 Nov 2025 08:19:42 +0000
Message-ID: <3bae83d1-bb88-49d3-94a3-3aa56da93bf9@suse.de>
Date: Thu, 20 Nov 2025 09:19:42 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] video/efi: Support FIRMWARE_EDID on non-x86
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>
References: <20251119123011.1187249-5-ardb+git@google.com>
 <4ca283ad-c549-4da4-93f9-e3cf17ab45a4@suse.de>
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
In-Reply-To: <4ca283ad-c549-4da4-93f9-e3cf17ab45a4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0FD17218B1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[git];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,lists.freedesktop.org:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01



Am 20.11.25 um 08:56 schrieb Thomas Zimmermann:
> Hi,
>
> thanks for addressing the remaining EDID support.
>
> First of all, you need to cc dri-devel@lists.freedesktop.org  on any 
> further revisions.
>
> Am 19.11.25 um 13:30 schrieb Ard Biesheuvel:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> Refactor the screen_info handling so non-x86 platforms booting via the
>> EFI stub also have access to the EDID data exposed by the EFI boot
>> services.
>
> I don't like how this series complicates everything to make non-x86 
> easier. But the general idea of using efi_screen_info goes into the 
> right direction. It's just not generic enough.
>
> The sysfb code transfers struct screen_info as device parameter [1]. 
> Drivers later fetch it on probe [2].  The direct ref to the global 
> edid_info [3] only exists because we have no means of transferring it 
> as device data.
>
> So instead of using efi_screen_info, let's declare struct 
> sysfb_display with screen_info and edid_info.  The header would be 
> linux/sysfb.h.  We transfer this to all related drivers.  The generic 
> EFI code would set it up like efi_screen_info and the x86 code would 
> decalre it at [4]; replacing the existing state.

If this proposal works for EFI, I could do the changes in graphics 
drivers and then resubmit the EDID series with an additional patch for 
generic EFI.

>
> Best regards
> Thomas
>
> [1] 
> https://elixir.bootlin.com/linux/v6.17.8/source/drivers/firmware/sysfb.c#L205
> [2] 
> https://elixir.bootlin.com/linux/v6.17.8/source/drivers/gpu/drm/sysfb/efidrm.c#L162
> [3] 
> https://elixir.bootlin.com/linux/v6.17.8/source/drivers/gpu/drm/sysfb/efidrm.c#L206
> [4] 
> https://elixir.bootlin.com/linux/v6.17.8/source/arch/x86/kernel/setup.c#L214
>
>
>>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>>
>> Ard Biesheuvel (3):
>>    efi: Wrap screen_info in efi_screen_info so edid_info can be added
>>      later
>>    video/edid: Use getter function for edid_info
>>    efi: Add FIRMWARE_EDID support
>>
>>   arch/x86/kernel/setup.c                       |  8 ++++++--
>>   drivers/firmware/efi/earlycon.c               |  1 -
>>   drivers/firmware/efi/efi-init.c               | 19 ++++++++++++++-----
>>   drivers/firmware/efi/libstub/efi-stub-entry.c |  3 +--
>>   drivers/firmware/efi/libstub/efi-stub.c       | 16 ++++++++++------
>>   drivers/firmware/efi/libstub/efistub.h        |  9 +++------
>>   drivers/firmware/efi/libstub/gop.c            |  1 -
>>   drivers/firmware/efi/libstub/screen_info.c    |  7 +++----
>>   drivers/firmware/efi/libstub/zboot.c          |  2 +-
>>   drivers/firmware/efi/sysfb_efi.c              |  1 -
>>   drivers/gpu/drm/sysfb/efidrm.c                |  4 ++--
>>   drivers/gpu/drm/sysfb/vesadrm.c               |  4 ++--
>>   drivers/video/Kconfig                         |  2 +-
>>   drivers/video/fbdev/core/fbmon.c              |  4 ++--
>>   include/linux/efi.h                           | 10 +++++++++-
>>   include/video/edid.h                          |  2 +-
>>   16 files changed, 55 insertions(+), 38 deletions(-)
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



