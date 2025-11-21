Return-Path: <linux-efi+bounces-5636-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1BC7A0FB
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E82E2380A1D
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D3D347FCD;
	Fri, 21 Nov 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TYsvY1Rq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qHQr4mBN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CSHK7RfB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sb43Opdc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305433446A0
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733805; cv=none; b=ULiYhFIqxm7LJ/sT2pZOmgRuHl3/0yRXXbUgCOxNc5porE9dpS+ceHlFyA4SadFMFqUO7A3C3IveI+zC7zY8xLQ/rfP74CyQqctweKKE/+YUiixCFILtRmvVemqhbqE82bdgQO6/C7DH8UWiQN060f6b874X5rbuY/mxS4+SXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733805; c=relaxed/simple;
	bh=/Yqi+AKegBqL3Fe6+p+DK0qhkh+WXXT9IjhEQSy9YEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g29lw6IgUUYkIrwEtSOC//3Z/UNkfw9yd6ZsRXI6kBGkY8/VccsUY9WtDmLJY9pVpy/Jkvt26oQRHXU8qUNRUHeA+XKuaaQA97CXAMb8uEVXs5Q02mDilIJxf4eLbml10o655EaLxV9wsFnSh7LdIaNwxOgoOtcFk6iCMUEuA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TYsvY1Rq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qHQr4mBN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CSHK7RfB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sb43Opdc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA9B42102C;
	Fri, 21 Nov 2025 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A1vUSfHBft0HA4VmbV90wooswdc0wRorCkJJltSFaWI=;
	b=TYsvY1Rq/OTDGgZU0ZbHMqjAbrHMCMI7mzItccKCf0bRaOR2p3/WU5Hv/rB0LPehlhiTPm
	Y/Rtvz+EoKK/PraR+PuGgfofNNrrTuAOfnwevkLB5FBG19uAS1sl1g8wkim5zj+O4aV7II
	KkipU9ViAz6+ffXEIJsgIyjlLy/FUwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A1vUSfHBft0HA4VmbV90wooswdc0wRorCkJJltSFaWI=;
	b=qHQr4mBNMRzEe8dMC+3lX5ORp7+hsOUwZaUfePnim6k0zrSjxaJOhgdw3QhBBmit6/u4E3
	xGYnd+hRFZ8jqNAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A1vUSfHBft0HA4VmbV90wooswdc0wRorCkJJltSFaWI=;
	b=CSHK7RfBZrZinT5mZ6tKBZtVB7cFhcdOCEui2XDNfFRmLxAppEU4SquNnG891Inggz8ABz
	T5ZUAfIRdMfHi0o+eWCoLRHvrQcqbuYIo0gm1y1LUNjijQIhDToEn2nbBQpDVgCnrJ+GRy
	QfrEtfwLhWqhAgyWiMj91w5EWxH7dbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A1vUSfHBft0HA4VmbV90wooswdc0wRorCkJJltSFaWI=;
	b=Sb43OpdcSJKrR6EwdN/M8vWe8bEvUvsXgVhhSaFPjOvjidAQpsJymuMmKLUsqpM4CSksUZ
	muQaHXoj21ySNTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B63A03EA61;
	Fri, 21 Nov 2025 14:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mm8MKyZxIGn8ewAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Nov 2025 14:03:18 +0000
Message-ID: <b10b1022-7e3e-4cba-904a-a7adff1c5bd4@suse.de>
Date: Fri, 21 Nov 2025 15:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] video/efi: Support FIRMWARE_EDID on non-x86
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
References: <20251119123011.1187249-5-ardb+git@google.com>
 <4ca283ad-c549-4da4-93f9-e3cf17ab45a4@suse.de>
 <3bae83d1-bb88-49d3-94a3-3aa56da93bf9@suse.de>
 <CAMj1kXFk=EvC7CW42gko3Wve_6vFgKUm8HXvLNXEnTLuZqxXng@mail.gmail.com>
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
In-Reply-To: <CAMj1kXFk=EvC7CW42gko3Wve_6vFgKUm8HXvLNXEnTLuZqxXng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[git];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi

Am 20.11.25 um 09:25 schrieb Ard Biesheuvel:
> On Thu, 20 Nov 2025 at 09:19, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>>
>> Am 20.11.25 um 08:56 schrieb Thomas Zimmermann:
>>> Hi,
>>>
>>> thanks for addressing the remaining EDID support.
>>>
>>> First of all, you need to cc dri-devel@lists.freedesktop.org  on any
>>> further revisions.
>>>
>>> Am 19.11.25 um 13:30 schrieb Ard Biesheuvel:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> Refactor the screen_info handling so non-x86 platforms booting via the
>>>> EFI stub also have access to the EDID data exposed by the EFI boot
>>>> services.
>>> I don't like how this series complicates everything to make non-x86
>>> easier. But the general idea of using efi_screen_info goes into the
>>> right direction. It's just not generic enough.
>>>
>>> The sysfb code transfers struct screen_info as device parameter [1].
>>> Drivers later fetch it on probe [2].  The direct ref to the global
>>> edid_info [3] only exists because we have no means of transferring it
>>> as device data.
>>>
>>> So instead of using efi_screen_info, let's declare struct
>>> sysfb_display with screen_info and edid_info.  The header would be
>>> linux/sysfb.h.  We transfer this to all related drivers.  The generic
>>> EFI code would set it up like efi_screen_info and the x86 code would
>>> decalre it at [4]; replacing the existing state.
>> If this proposal works for EFI, I could do the changes in graphics
>> drivers and then resubmit the EDID series with an additional patch for
>> generic EFI.
>>
> That sounds great, thanks.

Series is out at 
https://lore.kernel.org/dri-devel/20251121135624.494768-1-tzimmermann@suse.de/ 
Once/if merged, we can implement EDID support on top of it for all of EFI.

Best regards
Thomas


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



