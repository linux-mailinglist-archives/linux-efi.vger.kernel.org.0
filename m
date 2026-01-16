Return-Path: <linux-efi+bounces-6004-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19422D2D541
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 08:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FB803035311
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F42ED84C;
	Fri, 16 Jan 2026 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jw7e/ex2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MJtkUgZv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SmrxYqfV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hmXNtqMR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73B2D94B4
	for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549203; cv=none; b=X2wL12JdRlw9Z10ugXUmXl64P1JRNY4gZsNmPts5FiHJ9JdWiwpBZzGJ0QYV4000kjDwjiSakwmd8/51tL4S44ewBxv7vcXO6+KdOBBss10XS9qR2o4bt8gnmBAsnjytLTA86XLrP+exgu56Espn8v9aCWLwNryspVhKoMa7Nck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549203; c=relaxed/simple;
	bh=ZWO7ipSut2nHBbZxNGfNJfOFZdEXMj8+fyvaJM0SqoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snKSGYhG4mlBIoH8ySahcnqHol2Oh7AhhNFf2Za/EfaMA3sLQuTu0AST/n2x/dYbbMhh0AeBnFp0+ODt48NrJ7i5nL61NW0rsZlVITDzhukKUCiho0fZO4/FdfTTGoF9qPUeDpqk8ESGIjDFjuKVaAhWe2t9z3bWurwluDVn/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jw7e/ex2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MJtkUgZv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SmrxYqfV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hmXNtqMR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D48555BCC6;
	Fri, 16 Jan 2026 07:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768549200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=doC+gr/uKXnBI9fa1D1ITWlyxb9ov7FKbR1ka90ESNE=;
	b=jw7e/ex2X389f3AFhyAZnl2hvMJU508Bex8N7VeZX0CgSEvy+WJOgiZe1hpnYHuw9dU6pz
	XGUL1L7UAjAeqVnO0c1kXceKw9QD9mcvCTeIBHEbxaDf1cijwITwT29u6J00f4qfi0iNG8
	MEvZip3NY/altH/tBwCeubV3L4Vt9AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768549200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=doC+gr/uKXnBI9fa1D1ITWlyxb9ov7FKbR1ka90ESNE=;
	b=MJtkUgZv2krE16xoEQrTym0crZeD7+/Qb7fHCWOYzx0iZn0sRwUZ75tk8XMfCSOSpOLBbp
	JuKYj155nHWlpSBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SmrxYqfV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hmXNtqMR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768549199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=doC+gr/uKXnBI9fa1D1ITWlyxb9ov7FKbR1ka90ESNE=;
	b=SmrxYqfVEJuy9QvBr5Of2Dj5QRAjsQ44DVAbry90cElHS2cFSe5XZyOnp5kf8dy879wYSE
	u2uZB0mNlbDM+MZEbu7MebiLGkoyWMmfvRWfNjLnCa6sAz7svLv9e6GKUteIRUhgcyCNR3
	RP3IqqTFHGnpVGmoDEy+tb8XVlzaS/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768549199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=doC+gr/uKXnBI9fa1D1ITWlyxb9ov7FKbR1ka90ESNE=;
	b=hmXNtqMR8Zq9Cj2K4bcjV8kVCy3TmC831+rvpW2syEmQSZx0DR9IkouSjTbqYLOrzKGxFG
	jmAmCsW2MZK4eEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4FA23EA63;
	Fri, 16 Jan 2026 07:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id slDoKk7raWmoUwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 16 Jan 2026 07:39:58 +0000
Message-ID: <72e8c696-8cd7-4bf3-a1e8-d367f3addfe0@suse.de>
Date: Fri, 16 Jan 2026 08:39:58 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Deepak Rawat <drawat.floss@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans de Goede <hansg@kernel.org>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Helge Deller <deller@gmx.de>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Lijo Lazar <lijo.lazar@amd.com>, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>,
 Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 spice-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
 <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
 <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
 <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
 <9058636d-cc18-4c8f-92cf-782fd8f771af@amd.com> <aWkDYO1o9T1BhvXj@intel.com>
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
In-Reply-To: <aWkDYO1o9T1BhvXj@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[44];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,lists.freedesktop.org,amd.com,kernel.org,gmail.com,redhat.com,collabora.com,chromium.org,gmx.de,linux.intel.com,vger.kernel.org,intel.com,ffwll.ch,ursulin.net,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RL516un6i87yts6oyas1exgued)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,suse.com:url]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D48555BCC6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi

Am 15.01.26 um 16:10 schrieb Ville Syrjälä:
> On Thu, Jan 15, 2026 at 03:39:00PM +0100, Christian König wrote:
>> Sorry to being late, but I only now realized what you are doing here.
>>
>> On 1/15/26 12:02, Thomas Zimmermann wrote:
>>> Hi,
>>>
>>> apologies for the delay. I wanted to reply and then forgot about it.
>>>
>>> Am 10.01.26 um 05:52 schrieb Zack Rusin:
>>>> On Fri, Jan 9, 2026 at 5:34 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>>> Hi
>>>>>
>>>>> Am 29.12.25 um 22:58 schrieb Zack Rusin:
>>>>>> Almost a rite of passage for every DRM developer and most Linux users
>>>>>> is upgrading your DRM driver/updating boot flags/changing some config
>>>>>> and having DRM driver fail at probe resulting in a blank screen.
>>>>>>
>>>>>> Currently there's no way to recover from DRM driver probe failure. PCI
>>>>>> DRM driver explicitly throw out the existing sysfb to get exclusive
>>>>>> access to PCI resources so if the probe fails the system is left without
>>>>>> a functioning display driver.
>>>>>>
>>>>>> Add code to sysfb to recever system framebuffer when DRM driver's probe
>>>>>> fails. This means that a DRM driver that fails to load reloads the system
>>>>>> framebuffer driver.
>>>>>>
>>>>>> This works best with simpledrm. Without it Xorg won't recover because
>>>>>> it still tries to load the vendor specific driver which ends up usually
>>>>>> not working at all. With simpledrm the system recovers really nicely
>>>>>> ending up with a working console and not a blank screen.
>>>>>>
>>>>>> There's a caveat in that some hardware might require some special magic
>>>>>> register write to recover EFI display. I'd appreciate it a lot if
>>>>>> maintainers could introduce a temporary failure in their drivers
>>>>>> probe to validate that the sysfb recovers and they get a working console.
>>>>>> The easiest way to double check it is by adding:
>>>>>>     /* XXX: Temporary failure to test sysfb restore - REMOVE BEFORE COMMIT */
>>>>>>     dev_info(&pdev->dev, "Testing sysfb restore: forcing probe failure\n");
>>>>>>     ret = -EINVAL;
>>>>>>     goto out_error;
>>>>>> or such right after the devm_aperture_remove_conflicting_pci_devices .
>>>>> Recovering the display like that is guess work and will at best work
>>>>> with simple discrete devices where the framebuffer is always located in
>>>>> a confined graphics aperture.
>>>>>
>>>>> But the problem you're trying to solve is a real one.
>>>>>
>>>>> What we'd want to do instead is to take the initial hardware state into
>>>>> account when we do the initial mode-setting operation.
>>>>>
>>>>> The first step is to move each driver's remove_conflicting_devices call
>>>>> to the latest possible location in the probe function. We usually do it
>>>>> first, because that's easy. But on most hardware, it could happen much
>>>>> later.
>>>> Well, some drivers (vbox, vmwgfx, bochs and currus-qemu) do it because
>>>> they request pci regions which is going to fail otherwise. Because
>>>> grabbining the pci resources is in general the very first thing that
>>>> those drivers need to do to setup anything, we
>>>> remove_conflicting_devices first or at least very early.
>>> To my knowledge, requesting resources is more about correctness than a hard requirement to use an I/O or memory range. Has this changed?
>> Nope that is not correct.
>>
>> At least for AMD GPUs remove_conflicting_devices() really early is necessary because otherwise some operations just result in a spontaneous system reboot.	
>>
>> For example resizing the PCIe BAR giving access to VRAM or disabling VGA emulation (which AFAIK is used for EFI as well) is only possible when the VGA or EFI framebuffer driver is kicked out first.
>>
>> And disabling VGA emulation is among the absolutely first steps you do to take over the scanout config.
> It's similar for Intel. For us VGA emulation won't be used for
> EFI boot, but we still can't have the previous driver poking
> around in memory while the real driver is initializing. The
> entire memory layout may get completely shuffled so there's
> no telling where such memory accesses would land.

Isn't there code in display/intel_fbdev.c that reads back the old state 
from hardware before initializing fbdev? [1] How does that work then? 
Wouldn't the HW state be invalid already?

Best regards
Thomas

[1] 
https://elixir.bootlin.com/linux/v6.18.5/source/drivers/gpu/drm/i915/display/intel_fbdev.c#L356

>
> And I suppose reBAR is a concern for us as well.
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



