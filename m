Return-Path: <linux-efi+bounces-5710-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95DC8D263
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 08:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4682734876F
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 07:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E331DDBB;
	Thu, 27 Nov 2025 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tHKYVma4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sSfQgU6T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tHKYVma4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sSfQgU6T"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971731A07C
	for <linux-efi@vger.kernel.org>; Thu, 27 Nov 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229407; cv=none; b=dqPvY6thT17kccJ94jr7aapyV4R6sFrGQOA5RApBiyiGuVzA93pB4n0kfc+Qip9B5Ru5O66A9P/Gepw8CgEP4QZIZvfoy/XPpWXnDIZD5Ax3ol3B9TRQ125J00xi3ZDYR8foyxrQ+2kTUm0e7hFBeB8maZXMZskttl5oJhm6ztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229407; c=relaxed/simple;
	bh=2aa7/jpUbDAxAdHmOQT5ki0TSEgpqQs/3fnTyfytNTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPg2A25jFbU70W+F1DH9owi3L1yIaAltYqofRuZ/pjNe58OUon2h2ydO5SE36DcGXtHIujZK4/5Ca3S4+xulNc0LAdxrkmoN8Jd9UTsQRZ87wDdy6ATxkAklE3OTnP6zC0h/3bdTmfyvZz8W51L9Axu07oUXzuYYVEfs6O2SKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tHKYVma4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sSfQgU6T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tHKYVma4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sSfQgU6T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CBC85BCC4;
	Thu, 27 Nov 2025 07:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764229402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WyScJv6L7nzXkZtam1LWxY9xGCwufyeEcL9m/K/r7IE=;
	b=tHKYVma4XZcx7EoM5DNtmhDH8d9dYIT1zjyPWiuzOKkrRbwdogT20g9OvB1gPa65N29ize
	4GtRmeOztqDc1JFFXCNPXnbPEn6m/rt5ROFlvRnW8gSriK+vchWuJejUle4Bf0lctpAMe0
	BsoNiayfk0hMxzZbyHAvwrSNJm15elw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764229402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WyScJv6L7nzXkZtam1LWxY9xGCwufyeEcL9m/K/r7IE=;
	b=sSfQgU6T/Yx+fCh1hUALVRAufEwp3ATFz5uXMj/P6VqdhPQInFT9HtHsc4EUhWkDPLvvYo
	oVeaJ0hOAb6l9vDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764229402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WyScJv6L7nzXkZtam1LWxY9xGCwufyeEcL9m/K/r7IE=;
	b=tHKYVma4XZcx7EoM5DNtmhDH8d9dYIT1zjyPWiuzOKkrRbwdogT20g9OvB1gPa65N29ize
	4GtRmeOztqDc1JFFXCNPXnbPEn6m/rt5ROFlvRnW8gSriK+vchWuJejUle4Bf0lctpAMe0
	BsoNiayfk0hMxzZbyHAvwrSNJm15elw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764229402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WyScJv6L7nzXkZtam1LWxY9xGCwufyeEcL9m/K/r7IE=;
	b=sSfQgU6T/Yx+fCh1hUALVRAufEwp3ATFz5uXMj/P6VqdhPQInFT9HtHsc4EUhWkDPLvvYo
	oVeaJ0hOAb6l9vDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A0413EA63;
	Thu, 27 Nov 2025 07:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DU/CABoBKGnXfAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 27 Nov 2025 07:43:22 +0000
Message-ID: <fc4ea259-3389-46e2-b860-972aa8179507@suse.de>
Date: Thu, 27 Nov 2025 08:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] arch,sysfb,efi: Support EDID on non-x86 EFI
 systems
To: Richard Lyu <richard.lyu@suse.com>, ardb@kernel.org, javierm@redhat.com,
 arnd@arndb.de, helgaas@kernel.org
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20251126160854.553077-1-tzimmermann@suse.de>
 <aSe1ZBXa3JBidhem@r1chard>
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
In-Reply-To: <aSe1ZBXa3JBidhem@r1chard>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.com:url]
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi

Am 27.11.25 um 03:20 schrieb Richard Lyu:
> Hi Thomas,
>
> I am attempting to test this patch series but encountered merge conflicts when applying it to various trees.
> Could you please clarify the specific base commit (or branch/tag) this series was generated against?

Thanks for testing.

>
> When testing on the next branch on commits 7a2ff00 and e41ef37, I hit a conflict on PATCH v3 4/9:
> patching file drivers/pci/vgaarb.c
> Hunk #2 FAILED at 557.
> 1 out of 2 hunks FAILED -- rejects in file drivers/pci/vgaarb.c
>
> When testing against 3a86608 (Linux 6.18-rc1), the following conflicts occurred:
> patching file drivers/gpu/drm/sysfb/efidrm.c
> Hunk #1 FAILED at 24.
> 1 out of 2 hunks FAILED -- rejects in file drivers/gpu/drm/sysfb/efidrm.c
> patching file drivers/gpu/drm/sysfb/vesadrm.c
> Hunk #1 FAILED at 25.
> 1 out of 2 hunks FAILED -- rejects in file drivers/gpu/drm/sysfb/vesadrm.c
>
> Please let me know the correct base, and I will retest.

It's in the cover letter: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5 The 
commit is in linux-next. The idea is that the EFI tree can pick up the 
changes easily in the next cycle. linux-next seemed like the best 
choice. Best regards Thomas
>
> Thanks,
> Richard Lyu
>
> On 2025/11/26 17:03, Thomas Zimmermann wrote:
>> Replace screen_info and edid_info with sysfb_primary_device of type
>> struct sysfb_display_info. Update all users. Then implement EDID support
>> in the kernel EFI code.
>>
>> Sysfb DRM drivers currently fetch the global edid_info directly, when
>> they should get that information together with the screen_info from their
>> device. Wrapping screen_info and edid_info in sysfb_primary_display and
>> passing this to drivers enables this.
>>
>> Replacing both with sysfb_primary_display has been motivate by the EFI
>> stub. EFI wants to transfer EDID via config table in a single entry.
>> Using struct sysfb_display_info this will become easily possible. Hence
>> accept some churn in architecture code for the long-term improvements.
>>
>> Patches 1 and 2 reduce the exposure of screen_info in EFI-related code.
>>
>> Patch 3 adds struct sysfb_display_info.
>>
>> Patch 4 replaces scren_info with sysfb_primary_display. This results in
>> several changes throught the kernel, but is really just a refactoring.
>>
>> Patch 5 updates sysfb to transfer sysfb_primary_display to the related
>> drivers.
>>
>> Patch 6 moves edid_info into sysfb_primary_display. This resolves some
>> drivers' reference to the global edid_info, but also makes the EDID data
>> available on non-x86 architectures.
>>
>> Patches 7 and 8 add support for EDID transfers on non-x86 EFI systems.
>>
>> Patch 9 cleans up the config-table allocation to be easier to understand.
>>
>> v3:
>> - replace SCREEN_INFO table entry (Ard)
>> - merge libstub patch into kernel patch
>> v2:
>> - combine v1 of the series at [1] plus changes from [2] and [3].
>>
>> [1] https://lore.kernel.org/dri-devel/20251121135624.494768-1-tzimmermann@suse.de/
>> [2] https://lore.kernel.org/dri-devel/20251015160816.525825-1-tzimmermann@suse.de/
>> [3] https://lore.kernel.org/linux-efi/20251119123011.1187249-5-ardb+git@google.com/
>>
>> Thomas Zimmermann (9):
>>    efi: earlycon: Reduce number of references to global screen_info
>>    efi: sysfb_efi: Reduce number of references to global screen_info
>>    sysfb: Add struct sysfb_display_info
>>    sysfb: Replace screen_info with sysfb_primary_display
>>    sysfb: Pass sysfb_primary_display to devices
>>    sysfb: Move edid_info into sysfb_primary_display
>>    efi: Refactor init_primary_display() helpers
>>    efi: Support EDID information
>>    efi: libstub: Simplify interfaces for primary_display
>>
>>   arch/arm64/kernel/image-vars.h                |  2 +-
>>   arch/loongarch/kernel/efi.c                   | 38 ++++-----
>>   arch/loongarch/kernel/image-vars.h            |  2 +-
>>   arch/riscv/kernel/image-vars.h                |  2 +-
>>   arch/x86/kernel/kexec-bzimage64.c             |  4 +-
>>   arch/x86/kernel/setup.c                       | 16 ++--
>>   arch/x86/video/video-common.c                 |  4 +-
>>   drivers/firmware/efi/earlycon.c               | 42 +++++-----
>>   drivers/firmware/efi/efi-init.c               | 46 ++++++-----
>>   drivers/firmware/efi/efi.c                    |  4 +-
>>   drivers/firmware/efi/libstub/Makefile         |  2 +-
>>   drivers/firmware/efi/libstub/efi-stub-entry.c | 36 +++++++--
>>   drivers/firmware/efi/libstub/efi-stub.c       | 49 +++++++----
>>   drivers/firmware/efi/libstub/efistub.h        |  7 +-
>>   .../firmware/efi/libstub/primary_display.c    | 41 ++++++++++
>>   drivers/firmware/efi/libstub/screen_info.c    | 53 ------------
>>   drivers/firmware/efi/libstub/zboot.c          |  6 +-
>>   drivers/firmware/efi/sysfb_efi.c              | 81 ++++++++++---------
>>   drivers/firmware/sysfb.c                      | 13 +--
>>   drivers/firmware/sysfb_simplefb.c             |  2 +-
>>   drivers/gpu/drm/sysfb/efidrm.c                | 14 ++--
>>   drivers/gpu/drm/sysfb/vesadrm.c               | 14 ++--
>>   drivers/hv/vmbus_drv.c                        |  6 +-
>>   drivers/pci/vgaarb.c                          |  4 +-
>>   drivers/video/Kconfig                         |  8 +-
>>   drivers/video/fbdev/core/fbmon.c              |  8 +-
>>   drivers/video/fbdev/efifb.c                   | 10 ++-
>>   drivers/video/fbdev/vesafb.c                  | 10 ++-
>>   drivers/video/fbdev/vga16fb.c                 |  8 +-
>>   drivers/video/screen_info_pci.c               |  5 +-
>>   include/linux/efi.h                           |  9 ++-
>>   include/linux/screen_info.h                   |  2 -
>>   include/linux/sysfb.h                         | 23 ++++--
>>   include/video/edid.h                          |  4 -
>>   34 files changed, 321 insertions(+), 254 deletions(-)
>>   create mode 100644 drivers/firmware/efi/libstub/primary_display.c
>>   delete mode 100644 drivers/firmware/efi/libstub/screen_info.c
>>
>>
>> base-commit: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5
>> -- 
>> 2.51.1
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



